/***
XMLLoader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月21日 09:53:21
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class XMLLoader{
		public var urlLoader:URLLoader;
		private var onLoadComplete:Function;
		private var onLoadError:Function;
		public function XMLLoader(url:String=null,_onLoadComplete:Function=null,_onLoadError:Function=null):void{
			urlLoader=new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,loadComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,loadError);
			if(url){
				load(url,_onLoadComplete,_onLoadError);
			}
		}
		public function clear():void{
			if(urlLoader){
				urlLoader.removeEventListener(Event.COMPLETE,loadComplete);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
				urlLoader=null;
			}
			onLoadComplete=null;
			onLoadError=null;
		}
		public function load(url:String,_onLoadComplete:Function=null,_onLoadError:Function=null):void{
			onLoadComplete=_onLoadComplete;
			onLoadError=_onLoadError;
			urlLoader.load(new URLRequest(url));
		}
		private function loadComplete(event:Event):void{
			var _onLoadComplete:Function=onLoadComplete;
			var _onLoadError:Function=onLoadError;
			onLoadComplete=null;
			onLoadError=null;
			if(_onLoadComplete==null){
			}else{
				_onLoadComplete();
			}
		}
		private function loadError(event:IOErrorEvent):void{
			var _onLoadComplete:Function=onLoadComplete;
			var _onLoadError:Function=onLoadError;
			onLoadComplete=null;
			onLoadError=null;
			if(_onLoadError==null){
			}else{
				_onLoadError();
			}
		}
	}
}