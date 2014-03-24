/***
OnlineURLLoaderManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月21日 23:15:08
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class OnlineURLLoaderManager extends Sprite{
		public static var ready:Boolean;
		private static var initOnlineURLLoaderFinished:Function;
		private static var OnlineURLLoaderLoader:Loader;
		public static function init(_initOnlineURLLoaderFinished:Function):void{
			ready=false;
			initOnlineURLLoaderFinished=_initOnlineURLLoaderFinished;
			OnlineURLLoaderLoader=new Loader();
			OnlineURLLoaderLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadOnlineURLLoaderComplete);
			OnlineURLLoaderLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadOnlineURLLoaderError);
			//OnlineURLLoaderLoader.load(new URLRequest("http://localhost/zero.flashwing.net/image/OnlineURLLoader.swf?"+Math.random()));
			OnlineURLLoaderLoader.load(new URLRequest("http://zero.flashwing.net/image/OnlineURLLoader.swf"));
		}
		public static function clear():void{
			initOnlineURLLoaderFinished=null;
			
			if(OnlineURLLoaderLoader){
				OnlineURLLoaderLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadOnlineURLLoaderComplete);
				OnlineURLLoaderLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadOnlineURLLoaderError);
				OnlineURLLoaderLoader=null;
			}
		}
		
		private static function loadOnlineURLLoaderComplete(event:Event):void{
			OnlineURLLoaderLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadOnlineURLLoaderComplete);
			OnlineURLLoaderLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadOnlineURLLoaderError);
			if(initOnlineURLLoaderFinished==null){
			}else{
				initOnlineURLLoaderFinished(true);
			}
			ready=true;
		}
		private static function loadOnlineURLLoaderError(event:IOErrorEvent):void{
			OnlineURLLoaderLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadOnlineURLLoaderComplete);
			OnlineURLLoaderLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadOnlineURLLoaderError);
			if(initOnlineURLLoaderFinished==null){
			}else{
				initOnlineURLLoaderFinished(false);
			}
			ready=false;
		}
		
		public static function loadData(values:Object):URLLoader{
			if(ready){
				return OnlineURLLoaderLoader.content["loadData"](values);
			}
			throw new Error("OnlineURLLoaderManager 未初始化成功");
		}
		public static function clearLoader(urlLoader:URLLoader):void{
			urlLoader["clear"]();
		}
	}
}
		