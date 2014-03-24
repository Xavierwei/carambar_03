/***
Recorder
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年3月1日 15:49:23
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.records{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class Recorder{
		
		private static const MARK_DEACTIVATE:String="d";
		private static const MARK_MOUSE_OVER:String="o";
		private static const MARK_MOUSE_OUT:String="O";
		private static const MARK_MOUSE_DOWN:String="m";
		private static const MARK_MOUSE_UP:String="M";
		private static const MARK_MOUSE_MOVE:String="v";
		private static const MARK_KEY_DOWN:String="k";
		private static const MARK_KEY_UP:String="K";
		private static const MARK_END:String="e";
		
		private static const STATUS_STOP:int=0;
		private static const STATUS_RECORDING:int=1;
		private static const STATUS_REPLAYING:int=2;
		private var status:int;
		
		public var dataArr:Array;//frame1,data0,data1,...datan,frame2,data0,data1,...datan,...
		
		private var frame:int;
		private var recordTempSubDataArr:Array;
		private var replayOffset:int;
		
		private var __stage:Stage;
		
		private var stageEventV:Vector.<Event>;//录像时可能在同一帧发生比如鼠标按下抬起等
		
		private var onMouseOver:Function;
		private var onMouseOut:Function;
		private var onMouseDown:Function;
		private var onMouseUp:Function;
		private var onMouseMove:Function;
		private var onKeyDown:Function;
		private var onKeyUp:Function;
		private var onStep:Function;
		
		public var getInt:Function;
		
		private var onReplayComplete:Function;
		private var onRecordComplete:Function;
		
		private var keyDownCodeV:Vector.<Boolean>;
		
		private var __pause:Boolean;
		
		public function Recorder(){
			halt();
		}
		public function halt():void{
			if(__stage){
				//__stage.removeEventListener(Event.ENTER_FRAME,record_step);
				//__stage.removeEventListener(Event.ENTER_FRAME,replay_step);
				__stage.removeEventListener(Event.DEACTIVATE,stageEvent);
				__stage.removeEventListener(MouseEvent.MOUSE_OVER,stageEvent);
				__stage.removeEventListener(MouseEvent.MOUSE_OUT,stageEvent);
				__stage.removeEventListener(MouseEvent.MOUSE_DOWN,stageEvent);
				__stage.removeEventListener(MouseEvent.MOUSE_UP,stageEvent);
				__stage.removeEventListener(MouseEvent.MOUSE_MOVE,stageEvent);
				__stage.removeEventListener(KeyboardEvent.KEY_DOWN,stageEvent);
				__stage.removeEventListener(KeyboardEvent.KEY_UP,stageEvent);
				//__stage=null;
			}
			//recordTempSubDataArr=null;//不能置空，否则最后一个 step 可能会丢失数据
			onMouseOver=null;
			onMouseOut=null;
			onMouseDown=null;
			onMouseUp=null;
			onMouseMove=null;
			onKeyDown=null;
			onKeyUp=null;
			//keyDownCodeV=null;//不能置空，否则最后一个 step 可能会报错
			onStep=null;
			getInt=null;
			//onReplayComplete=null;
			//onRecordComplete=null;//不能置空
			status=STATUS_STOP;
			//stageEventV=null;//不能置空
		}
		public function record(
			_stage:Stage,
			_onRecordComplete:Function,
			_onStep:Function,
			_onMouseOver:Function,
			_onMouseOut:Function,
			_onMouseDown:Function,
			_onMouseUp:Function,
			_onMouseMove:Function,
			_onKeyDown:Function,
			_onKeyUp:Function
		):void{
			halt();
			
			__pause=false;
			
			dataArr=new Array();
			status=STATUS_RECORDING;
			
			stageEventV=new Vector.<Event>();
			
			__stage=_stage;
			
			onRecordComplete=_onRecordComplete;
			onStep=_onStep;
			onMouseOver=_onMouseOver;
			onMouseOut=_onMouseOut;
			onMouseDown=_onMouseDown;
			onMouseUp=_onMouseUp;
			onMouseMove=_onMouseMove;
			onKeyDown=_onKeyDown;
			onKeyUp=_onKeyUp;
			
			getInt=record_getInt;
			
			__stage.addEventListener(Event.DEACTIVATE,stageEvent);
			
			if(onMouseOver==null){
			}else{
				__stage.addEventListener(MouseEvent.MOUSE_OVER,stageEvent);
			}
			if(onMouseOut==null){
			}else{
				__stage.addEventListener(MouseEvent.MOUSE_OUT,stageEvent);
			}
			if(onMouseDown==null){
			}else{
				__stage.addEventListener(MouseEvent.MOUSE_DOWN,stageEvent);
			}
			if(onMouseUp==null){
			}else{
				__stage.addEventListener(MouseEvent.MOUSE_UP,stageEvent);
			}
			if(onMouseMove==null){
			}else{
				__stage.addEventListener(MouseEvent.MOUSE_MOVE,stageEvent);
			}
			
			__stage.addEventListener(KeyboardEvent.KEY_DOWN,stageEvent);
			__stage.addEventListener(KeyboardEvent.KEY_UP,stageEvent);
			
			keyDownCodeV=new Vector.<Boolean>(256);
			keyDownCodeV.fixed=true;
			resetKeyArr();
			
			frame=0;
			__stage.addEventListener(Event.ENTER_FRAME,record_step);//一帧之后才开始第一个 record_step()
			//record_step();
			
			recordTempSubDataArr=new Array();//用于记录 record() 和 第一个 record_step() 之间的数据
		}
		public function replay(
			_stage:Stage,
			_onReplayComplete:Function,
			_onStep:Function,
			_onMouseOver:Function,
			_onMouseOut:Function,
			_onMouseDown:Function,
			_onMouseUp:Function,
			_onMouseMove:Function,
			_onKeyDown:Function,
			_onKeyUp:Function,
			_dataArr:Array
		):void{
			
			halt();
			
			__pause=false;
			
			if(_dataArr){
				dataArr=_dataArr;
			}
			
			//trace("dataArr="+dataArr);
			if(dataArr){
				status=STATUS_REPLAYING;
				
				
				__stage=_stage;
				
				onReplayComplete=_onReplayComplete;
				onStep=_onStep;
				onMouseOver=_onMouseOver;
				onMouseOut=_onMouseOut;
				onMouseDown=_onMouseDown;
				onMouseUp=_onMouseUp;
				onMouseMove=_onMouseMove;
				onKeyDown=_onKeyDown;
				onKeyUp=_onKeyUp;
				
				getInt=replay_getInt;
				
				keyDownCodeV=new Vector.<Boolean>(256);
				keyDownCodeV.fixed=true;
				resetKeyArr();
				
				frame=0;
				replayOffset=0;
				__stage.addEventListener(Event.ENTER_FRAME,replay_step);//一帧之后才开始第一个 replay_step()
				//replay_step();
			}else{
				throw new Error("dataArr="+dataArr);
			}
		}
		
		private function resetKeyArr():void{
			for(var keyCode:int=0;keyCode<256;keyCode++){
				keyDownCodeV[keyCode]=false;
			}
		}
		
		public function pause():void{
			__pause=true;
		}
		public function resume():void{
			__pause=false;
		}
		
		private function stageEvent(event:Event):void{
			
			if(__pause){
				return;
			}
			
			stageEventV.push(event);
		}
		
		public function keyIsDown(keyCode:int):Boolean{
			return keyDownCodeV[keyCode];
		}
		
		private function record_step(...args):void{
			
			if(__pause){
				return;
			}
			
			if(frame==0){
				if(recordTempSubDataArr.length){
					dataArr.push.apply(dataArr,recordTempSubDataArr);//record() 和 第一个 record_step() 之间的数据
				}
			}
			
			frame++;
			
			var subDataArr:Array=new Array();
			
			while(stageEventV.length){
				var event:Event=stageEventV.shift();
				switch(event.type){
					case Event.DEACTIVATE:
						subDataArr.push(MARK_DEACTIVATE);
						resetKeyArr();
					break;
					case MouseEvent.MOUSE_OVER:
						if(onMouseOver==null){
						}else{
							recordTempSubDataArr=new Array();
							if(onMouseOver()){
								subDataArr.push(MARK_MOUSE_OVER);
								subDataArr.push.apply(subDataArr,recordTempSubDataArr);
							}
						}
					break;
					case MouseEvent.MOUSE_OUT:
						if(onMouseOut==null){
						}else{
							recordTempSubDataArr=new Array();
							if(onMouseOut()){
								subDataArr.push(MARK_MOUSE_OUT);
								subDataArr.push.apply(subDataArr,recordTempSubDataArr);
							}
						}
					break;
					case MouseEvent.MOUSE_DOWN:
						if(onMouseDown==null){
						}else{
							recordTempSubDataArr=new Array();
							if(onMouseDown()){
								subDataArr.push(MARK_MOUSE_DOWN);
								subDataArr.push.apply(subDataArr,recordTempSubDataArr);
							}
						}
					break;
					case MouseEvent.MOUSE_UP:
						if(onMouseUp==null){
						}else{
							recordTempSubDataArr=new Array();
							if(onMouseUp()){
								subDataArr.push(MARK_MOUSE_UP);
								subDataArr.push.apply(subDataArr,recordTempSubDataArr);
							}
						}
					break;
					case MouseEvent.MOUSE_MOVE:
						if(onMouseMove==null){
						}else{
							recordTempSubDataArr=new Array();
							if(onMouseMove()){
								subDataArr.push(MARK_MOUSE_MOVE);
								subDataArr.push.apply(subDataArr,recordTempSubDataArr);
							}
						}
					break;
					case KeyboardEvent.KEY_DOWN:
						var keyCode:int=(event as KeyboardEvent).keyCode;
						keyDownCodeV[keyCode]=true;
						subDataArr.push(MARK_KEY_DOWN,keyCode);
						if(onKeyDown==null){
						}else{
							recordTempSubDataArr=new Array();
							onKeyDown(keyCode);
							subDataArr.push.apply(subDataArr,recordTempSubDataArr);
						}
					break;
					case KeyboardEvent.KEY_UP:
						keyCode=(event as KeyboardEvent).keyCode;
						keyDownCodeV[keyCode]=false;
						subDataArr.push(MARK_KEY_UP,keyCode);
						if(onKeyUp==null){
						}else{
							recordTempSubDataArr=new Array();
							onKeyUp(keyCode);
							subDataArr.push.apply(subDataArr,recordTempSubDataArr);
						}
					break;
				}
			}
			
			
			if(status==STATUS_STOP){
				subDataArr.push(MARK_END);
			}
			if(subDataArr.length){
				dataArr.push(frame);
				dataArr.push.apply(dataArr,subDataArr);
			}
			
			if(onStep==null){
			}else{
				recordTempSubDataArr=new Array();
				onStep();
				dataArr.push.apply(dataArr,recordTempSubDataArr);
			}
			
			recordTempSubDataArr=null;
			
			if(status==STATUS_STOP){
				var _onRecordComplete:Function=onRecordComplete;
				onRecordComplete=null;
				halt();
				if(_onRecordComplete==null){
				}else{
					__stage.removeEventListener(Event.ENTER_FRAME,record_step);
					__stage=null;
					_onRecordComplete();
				}
			}
		}
		private function replay_step(...args):void{
			
			if(__pause){
				return;
			}
			
			frame++;
			
			var isEnd:Boolean=false;
			
			if(status==STATUS_STOP){
				isEnd=true;
			}
			
			if(dataArr[replayOffset+1] is String){//MARK
				if(dataArr[replayOffset]==frame){
					replayOffset++;
					
					while(dataArr[replayOffset] is String){
						replayOffset++;
						switch(dataArr[replayOffset-1]){
							case MARK_DEACTIVATE:
								resetKeyArr();
							break;
							case MARK_MOUSE_OVER:
								onMouseOver();
							break;
							case MARK_MOUSE_OUT:
								onMouseOut();
							break;
							case MARK_MOUSE_DOWN:
								onMouseDown();
							break;
							case MARK_MOUSE_UP:
								onMouseUp();
							break;
							case MARK_MOUSE_MOVE:
								onMouseMove();
							break;
							case MARK_KEY_DOWN:
								var keyCode:int=dataArr[replayOffset++];
								keyDownCodeV[keyCode]=true;
								if(onKeyDown==null){
								}else{
									onKeyDown(keyCode);
								}
							break;
							case MARK_KEY_UP:
								keyCode=dataArr[replayOffset++];
								keyDownCodeV[keyCode]=false;
								if(onKeyUp==null){
								}else{
									onKeyUp(keyCode);
								}
							break;
							case MARK_END:
								isEnd=true;
							break;
						}
					}
				}
			}
			
			if(onStep==null){
			}else{
				onStep();
			}
			
			if(isEnd){
				var _onReplayComplete:Function=onReplayComplete;
				onReplayComplete=null;
				halt();
				if(_onReplayComplete==null){
				}else{
					__stage.removeEventListener(Event.ENTER_FRAME,replay_step);
					__stage=null;
					_onReplayComplete();
				}
			}
		}
		
		public function record_getInt(_int:int):int{
			recordTempSubDataArr.push(_int);
			return _int;
		}
		public function replay_getInt(_int:int):int{
			//trace("replayOffset="+replayOffset,dataArr[replayOffset]);
			return dataArr[replayOffset++];
		}
		
		public function isPause():Boolean{
			return __pause;
		}
		public function isRecording():Boolean{
			return status==STATUS_RECORDING;
		}
		public function isReplaying():Boolean{
			return status==STATUS_REPLAYING;
		}
	}
}