/***
BottomBarContainer 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月12日 00:38:55
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero{
			////
			import flash.display.*;
			import flash.events.*;
			import flash.net.*;
			import flash.utils.*;
			
			import zero.paths.path_BottomBar;
			////
			
	public class BottomBarContainer extends Sprite{
			
			////
			private var container:Sprite;
			private var loader:Loader;
			
			public var gameMainClassName:String;
			public var onShowBottomBar:Function;
			////
			
			public var wid:int;
			public var hei:int;
			
		public function BottomBarContainer(
			_gameMainClassName:String=null,
			_wid:int=0,
			_hei:int=0,
			_onShowBottomBar:Function=null
		){
			gameMainClassName=_gameMainClassName;
			if(_wid>0){
				wid=_wid;
			}else{
				wid=this.width;
			}
			if(_hei>0){
				hei=_hei;
			}else{
				hei=this.height;
			}
			onShowBottomBar=_onShowBottomBar;
			
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			////
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadBottomBarComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadBottomBarError);
			
			var so:SharedObject=SharedObject.getLocal("BottomBarContainer","/");
			var currTime:int=int(new Date().time/1000);
			var dTime:int=currTime-so.data.time;
			//trace("dTime="+dTime);
			if(dTime>0&&dTime<24*60*60){
			}else{
				so.data.time=currTime;
			}
			
			try{
				loader.load(new URLRequest(path_BottomBar+"?"+so.data.time));
				//loader.load(new URLRequest(path_BottomBar+"?"+Math.random()));trace("测试，添加随机数字");
			}catch(e:Error){}
			////
			
			this.addChild(loader);
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,removed);
			
			////
			if(loader){
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadBottomBarComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadBottomBarError);
				loader=null;
			}
			this.removeEventListener(Event.ENTER_FRAME,checkInit);
			////
		}
		private function loadBottomBarComplete(event:Event):void{
			////
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadBottomBarComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadBottomBarError);
			this.addEventListener(Event.ENTER_FRAME,checkInit);
			////
		}
		private function checkInit(event:Event):void{
			if(gameMainClassName&&this.parent&&this.root&&this.loaderInfo){
			}else{
				return;
			}
			loader.content["show"](this,GetAndSetValue,gameMainClassName,wid,hei);
			this.removeEventListener(Event.ENTER_FRAME,checkInit);
		}
		private function loadBottomBarError(event:IOErrorEvent):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadBottomBarComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadBottomBarError);
		}
	}
}

