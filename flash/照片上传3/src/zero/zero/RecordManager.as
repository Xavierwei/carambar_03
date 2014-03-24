/***
RecordManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年3月6日 13:46:29
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zero{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.managers.ScoreManager;
	import zero.paths.*;
	import zero.records.Recorder;
	
	public class RecordManager{
		
		private static var timeoutId:int;
		
		public static const NORMAL:int=0;
		public static const PLAY_RECORD:int=1;
		public static const PLAY_BEST:int=2;
		public static const AUTO_PLAY:int=3;
		
		public static var mode:int;
		
		private static var gameMainClassName:String;
		private static var __stage:Stage;
		
		private static var btnGame:InteractiveObject;
		private static var btnPlayRecord:InteractiveObject;
		private static var btnBestPlay:InteractiveObject;
		private static var btnStop:InteractiveObject;
		
		private static var onStartGame:Function;
		private static var onGotoMenu:Function;
		private static var recordParams:Object;
		
		private static var bestRecordLoader:URLLoader;
		private static var submiter:URLLoader;
		
		private static var bestBytes:ByteArray;
		
		private static var recorder:Recorder;
		private static var playing:Boolean;
		
		public static function init(
			_gameMainClassName:String,
			scoreManager_key:String,
			_stage:Stage,
			_btnGame:InteractiveObject,
			_btnPlayRecord:InteractiveObject,
			_btnBestPlay:InteractiveObject,
			_btnStop:InteractiveObject,
			_onStartGame:Function,_onGotoMenu:Function,_recordParams:Object
		):void{
			
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			ScoreManager.init(scoreManager_key);
			
			gameMainClassName=_gameMainClassName;
			__stage=_stage;
			btnGame=_btnGame;
			btnPlayRecord=_btnPlayRecord;
			btnBestPlay=_btnBestPlay;
			btnStop=_btnStop;
			onStartGame=_onStartGame;
			onGotoMenu=_onGotoMenu;
			recordParams=_recordParams;
			
			recorder=new Recorder();
			
			btnPlayRecord.visible=false;
			btnBestPlay.visible=false;
			btnStop.visible=false;
			
			__stage.addEventListener(MouseEvent.CLICK,click);
			
			bestRecordLoader=new URLLoader();
			bestRecordLoader.dataFormat=URLLoaderDataFormat.BINARY;
			bestRecordLoader.addEventListener(Event.COMPLETE,loadBestRecordComplete);
			bestRecordLoader.addEventListener(IOErrorEvent.IO_ERROR,loadBestRecordError);
			bestRecordLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadBestRecordError);
			bestRecordLoader.load(new URLRequest(path_getBestRecord+"?gameMainClassName="+gameMainClassName));
			
			submiter=new URLLoader();
			submiter.dataFormat=URLLoaderDataFormat.BINARY;
			submiter.addEventListener(Event.COMPLETE,submitComplete);
			submiter.addEventListener(IOErrorEvent.IO_ERROR,submitError);
			submiter.addEventListener(SecurityErrorEvent.SECURITY_ERROR,submitError);
			
			checkReplayAble();
		}
		private static function loadBestRecordComplete(...args):void{
			checkBestRecord(bestRecordLoader.data);
			bestRecordLoader.removeEventListener(Event.COMPLETE,loadBestRecordComplete);
			bestRecordLoader.removeEventListener(IOErrorEvent.IO_ERROR,loadBestRecordError);
			bestRecordLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadBestRecordError);
			bestRecordLoader=null;
			checkReplayAble();
		}
		private static function loadBestRecordError(...args):void{
			checkBestRecord(null);
			bestRecordLoader.removeEventListener(Event.COMPLETE,loadBestRecordComplete);
			bestRecordLoader.removeEventListener(IOErrorEvent.IO_ERROR,loadBestRecordError);
			bestRecordLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadBestRecordError);
			bestRecordLoader=null;
			checkReplayAble();
		}
		private static function click(event:MouseEvent):void{
			switch(event.target){
				case btnGame:
					mode=NORMAL;
					startGame();
				break;
				case btnPlayRecord:
					mode=PLAY_RECORD;
					startGame();
				break;
				case btnBestPlay:
					mode=PLAY_BEST;
					startGame();
				break;
				case btnStop:
					gotoMenu();
				break;
			}
		}
		
		public static function getInt(_int:int):int{
			//trace("getInt，_int="+_int);
			return recorder.getInt(_int);
		}
		
		private static function activate(...args):void{
			clearTimeout(timeoutId);
			timeoutId=setTimeout(autoPlay,10000);
		}
		private static function autoPlay():void{
			mode=AUTO_PLAY;
			startGame();
			
			__stage.addEventListener(MouseEvent.MOUSE_MOVE,gotoMenu);
			__stage.addEventListener(MouseEvent.MOUSE_DOWN,gotoMenu);
			__stage.addEventListener(KeyboardEvent.KEY_DOWN,gotoMenu);
		}
		
		private static function checkReplayAble():void{
			var so:SharedObject=SharedObject.getLocal(gameMainClassName,"/");
			if(so.data.recordBytes){
				btnPlayRecord.visible=true;
			}else{
				btnPlayRecord.visible=false;
			}
			
			clearTimeout(timeoutId);
			if(playing){
			}else{
				if(so.data.recordBytes||bestBytes){
					activate();
					__stage.addEventListener(MouseEvent.MOUSE_MOVE,activate);
					__stage.addEventListener(MouseEvent.MOUSE_DOWN,activate);
					__stage.addEventListener(KeyboardEvent.KEY_DOWN,activate);
				}
			}
		}
		private static function startGame():void{
			
			clearTimeout(timeoutId);
			
			__stage.removeEventListener(MouseEvent.MOUSE_MOVE,activate);
			__stage.removeEventListener(MouseEvent.MOUSE_DOWN,activate);
			__stage.removeEventListener(KeyboardEvent.KEY_DOWN,activate);
			
			ScoreManager.setValue("score",0);
			
			switch(mode){
				case NORMAL:
					btnStop.visible=false;
					recorder.record(__stage,recordParams);
					playing=true;
				break;
				case PLAY_RECORD:
				case PLAY_BEST:
				case AUTO_PLAY:
					var so:SharedObject=SharedObject.getLocal(gameMainClassName,"/");
					var recordBytes:ByteArray=new ByteArray();
					switch(mode){
						case PLAY_RECORD:
							btnStop.visible=true;
							recordBytes.writeBytes(so.data.recordBytes,0,so.data.recordBytes.length);
						break;
						case PLAY_BEST:
							btnStop.visible=true;
							recordBytes.writeBytes(bestBytes,0,bestBytes.length);
						break;
						case AUTO_PLAY:
							btnStop.visible=false;
							if(so.data.recordBytes&&bestBytes){
								if(Math.random()<0.5){
									recordBytes.writeBytes(so.data.recordBytes,0,so.data.recordBytes.length);
								}else{
									recordBytes.writeBytes(bestBytes,0,bestBytes.length);
								}
							}else if(so.data.recordBytes){
								recordBytes.writeBytes(so.data.recordBytes,0,so.data.recordBytes.length);
							}else if(bestBytes){
								recordBytes.writeBytes(bestBytes,0,bestBytes.length);
							}else{
								throw new Error("没有可回放的录像数据");
							}
						break;
					}
					recordBytes.uncompress();
					recordBytes.position=0;
					recorder.dataArr=recordBytes.readObject();
					//trace("recorder.dataArr="+recorder.dataArr);
					recorder.replay(__stage,null,recordParams);
					playing=true;
				break;
			}
			
			if(onStartGame==null){
			}else{
				onStartGame();
			}
		}
		public static function gameOver():void{
			recorder.halt();
			playing=false;
			timeoutId=setTimeout(recordAndGotoMenu,100);
		}
		private static function submitComplete(...args):void{
			//trace(submiter.data);
			if(checkBestRecord(submiter.data)){
				//trace("上传记录成功");
			}else{
				submitError();
			}
		}
		private static function submitError(...args):void{
			//trace("上传记录失败");
		}
		private static function checkBestRecord(recordBytes:ByteArray):Boolean{
			if(recordBytes&&recordBytes.length>4){
				var recordSize:int=recordBytes[0]|(recordBytes[1]<<8)|(recordBytes[2]<<16)|(recordBytes[3]<<24);
				if(recordSize==recordBytes.length-4){
					bestBytes=new ByteArray();
					bestBytes.writeBytes(recordBytes,4,recordSize);
					btnBestPlay.visible=true;
					return true;
				}
			}
			return false;
		}
		private static function recordAndGotoMenu():void{
			if(mode==NORMAL){
				//trace("recorder.dataArr="+recorder.dataArr);
				var recordBytes:ByteArray=new ByteArray();
				recordBytes.writeObject(recorder.dataArr);
				recordBytes.compress();
				var so:SharedObject=SharedObject.getLocal(gameMainClassName,"/");
				so.data.recordBytes=recordBytes;
				
				//和 php 里的 encode 比较
				var i:int;
				var str:String="zero games"+ScoreManager.getValue("score")+"@2012";
				//trace(("zero games 2012"+int.MAX_VALUE).length);//25
				
				var ran:String="";
				i=32-str.length
				while(--i>=0){
					ran+=int(Math.random()*16).toString(16);
				}
				//trace("ran="+ran);
				
				str+=ran;
				
				//trace("str="+str);
				
				i=32;
				var code:String="";
				while(--i>=0){
					code+=(
						(
							str.charCodeAt((i+ScoreManager.getValue("score"))%32)
							+
							gameMainClassName.charCodeAt((i^ScoreManager.getValue("score"))%gameMainClassName.length)
							+
							ran.charCodeAt((i*ScoreManager.getValue("score"))%ran.length)
						)
						%
						16
					).toString(16);
				}
				
				//trace("code="+code);
				var urlRequest:URLRequest=new URLRequest(
					path_getBestRecord+
					"?gameMainClassName="+gameMainClassName+
					"&score="+ScoreManager.getValue("score")+
					"&ran="+ran+
					"&code="+code
				);
				
				urlRequest.data=recordBytes;
				urlRequest.contentType="application/octet-stream";
				urlRequest.method=URLRequestMethod.POST;
				
				//try{
					submiter.load(urlRequest);
				//}catch(e:Error){
				//	submitError();
				//}
				
				//trace("正在上传记录...");
			}
			gotoMenu();
		}
		private static function gotoMenu(...args):void{
			recorder.halt();
			playing=false;
			clearTimeout(timeoutId);
			btnStop.visible=false;
			
			__stage.removeEventListener(MouseEvent.MOUSE_MOVE,gotoMenu);
			__stage.removeEventListener(MouseEvent.MOUSE_DOWN,gotoMenu);
			__stage.removeEventListener(KeyboardEvent.KEY_DOWN,gotoMenu);
			
			checkReplayAble();
			
			if(onGotoMenu==null){
			}else{
				onGotoMenu();
			}
		}
		public static function keyIsDown(keyCode:int):Boolean{
			return recorder.keyIsDown(keyCode);
		}
	}
}