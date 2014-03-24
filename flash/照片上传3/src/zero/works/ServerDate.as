/***
ServerDate
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月6日 13:19:41
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class ServerDate{
		
		private static var getTimeLoader:URLLoader;
		private static var onGetTimeComplete:Function;
		private static var startDateTime:Number;
		private static var startTime:Number;//
		
		public static function init(_onGetTimeComplete:Function):void{
			
			if(startDateTime>0){
				if(_onGetTimeComplete==null){
				}else{
					_onGetTimeComplete();
				}
				return;
			}
			
			onGetTimeComplete=_onGetTimeComplete;
			
			getTimeLoader=new URLLoader();
			getTimeLoader.addEventListener(Event.COMPLETE,getTimeLoadComplete);
			getTimeLoader.addEventListener(IOErrorEvent.IO_ERROR,getTimeLoadError);
			getTimeLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,getTimeLoadError);
			
			switch(Security.sandboxType){
				case Security.REMOTE:
					try{
						getTimeLoader.load(new URLRequest("http://event20.wanmei.com/demo/flash/systime.jsp?"+Math.random()));
					}catch(e:Error){
						getTimeComplete(new Date());
					}
				break;
				//case Security.LOCAL_WITH_FILE:
				//case Security.LOCAL_WITH_NETWORK:
				//case Security.LOCAL_TRUSTED:
				//case Security.APPLICATION:
				default:
					getTimeComplete(new Date());
				break;
			}
		}
		
		private static function getTimeLoadComplete(event:Event):void{
			if(getTimeLoader.data){
				trace("getTimeLoadComplete getTimeLoader.data="+getTimeLoader.data);
				var execResult:Array=/(\d\d\d\d)\-(\d\d)\-(\d\d) (\d\d)\:(\d\d)\:(\d\d)/.exec(getTimeLoader.data);
				if(execResult){
					getTimeComplete(new Date(
						int(execResult[1]),
						int(execResult[2])-1,
						int(execResult[3]),
						int(execResult[4]),
						int(execResult[5]),
						int(execResult[6])
					));
					return;
				}
			}
			getTimeComplete(new Date());
		}
		private static function getTimeLoadError(event:Event):void{
			trace("getTimeLoadError");
			
			getTimeLoader.removeEventListener(Event.COMPLETE,getTimeLoadComplete);
			getTimeLoader.removeEventListener(IOErrorEvent.IO_ERROR,getTimeLoadError);
			getTimeLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,getTimeLoadError);
			getTimeLoader=null;
			
			getTimeComplete(new Date());
		}
		
		private static function getTimeComplete(date:Date):void{
			
			if(getTimeLoader){
				getTimeLoader.removeEventListener(Event.COMPLETE,getTimeLoadComplete);
				getTimeLoader.removeEventListener(IOErrorEvent.IO_ERROR,getTimeLoadError);
				getTimeLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,getTimeLoadError);
				getTimeLoader=null;
			}
			
			startDateTime=date.time;
			startTime=getTimer();
			
			if(onGetTimeComplete==null){
			}else{
				onGetTimeComplete();
				onGetTimeComplete=null;
			}
		}
		
		public static function getDate():Date{
			//获取和服务器同步的 Date
			if(startDateTime>0){
				return new Date((getTimer()-startTime)+startDateTime);
			}
			throw new Error("ServerDate 尚未初始化完毕");
		}
	}
}