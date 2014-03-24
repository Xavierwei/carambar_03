/***
AlbumContainerManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月3日 12:59:34
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.photodiys{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	import zero.ZeroCommon;
	public class AlbumContainerManager{
		private var btn:Sprite;
		public var albumContainer:Sprite;
		private var btnX:Sprite;
		private var btnOk:Sprite;
		private var container:Sprite;
		private var bg:Sprite;
		
		private var loader:Loader;
		private static const d:int=5;
		private var onOk:Function;
		private var bmd:BitmapData;
		
		private var this2that:Function;
		public function AlbumContainerManager(
			_btn:Sprite,
			_albumContainer:Sprite,
			_btnX:Sprite,
			_btnOk:Sprite,
			_container:Sprite,
			_bg:Sprite,
			_onOk:Function
		){
			btn=_btn;
			btn.addEventListener(MouseEvent.CLICK,show);
			albumContainer=_albumContainer;
			albumContainer.visible=false;
			btnX=_btnX;
			btnOk=_btnOk;
			container=_container;
			bg=_bg;
			onOk=_onOk;
			btnX.addEventListener(MouseEvent.CLICK,hide);
			btnOk.addEventListener(MouseEvent.CLICK,ok);
		}
		public function clear():void{
			btn.removeEventListener(MouseEvent.CLICK,show);
			btn=null;
			albumContainer=null;
			btnX.removeEventListener(MouseEvent.CLICK,hide);
			btnOk.removeEventListener(MouseEvent.CLICK,ok);
			btnX=null;
			btnOk=null;
			container=null;
			bg=null;
			if(loader){
				loader.unloadAndStop();
				loader.contentLoaderInfo.removeEventListener(Event.INIT,loadAlbumInit);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadAlbumComplete);
			}
			onOk=null;
			this2that=null;
		}
		public function hide(event:MouseEvent=null):void{
			albumContainer.visible=false;
		}
		private function ok(event:MouseEvent):void{
			(onOk==null)||onOk(bmd);
			hide();
		}
		public function show(event:MouseEvent=null):void{
			if(!loader){
				btnOk.visible=false;
				loader=new Loader();
				container.addChild(loader);
				loader.load(new URLRequest(ZeroCommon.path_photodiy_album_swf_PhotoDIY_Album));
				loader.contentLoaderInfo.addEventListener(Event.INIT,loadAlbumInit);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadAlbumComplete);
			}
			albumContainer.visible=true;
		}
		private function loadAlbumInit(event:Event):void{
			///*
			var albumLoaderInfo:LoaderInfo=loader.contentLoaderInfo;
			albumLoaderInfo.removeEventListener(Event.INIT,loadAlbumInit);
			loader.x=(bg.width-albumLoaderInfo.width)/2;
			loader.y=(bg.height-albumLoaderInfo.height)/2;
			//*/
		}
		private function loadAlbumComplete(event:Event):void{
			albumContainer.addEventListener(Event.ENTER_FRAME,initAlbumDelay);
		}
		private function initAlbumDelay(event:Event):void{
			///*
			var album:*;
			try{
				album=(loader.contentLoaderInfo.applicationDomain.getDefinition("PhotoDIY_Album") as Object).album;
			}catch(e:Error){
				return;
			}
			if(album){
				albumContainer.removeEventListener(Event.ENTER_FRAME,initAlbumDelay);
				
				var values:Object={
					that2this:that2this
				};
				
				album.initByContainer(values);
				
				this2that=values.this2that;
				
				loader.x=d;
				loader.y=d;
				resize();
			}
			//*/
		}
		private function that2this(cmd:String,...args):void{
			switch(cmd){
				case "bmd":
					bmd=args[0];
					if(bmd){
						btnOk.visible=true;
					}else{
						btnOk.visible=false;
					}
				break;
			}
			trace("AlbumContainerManager.that2this cmd="+cmd,"args="+args);
		}
		public function resize():void{
			if(this2that!=null){
				this2that(
					"resize",
					bg.width-d*2,
					bg.height-d*2-30
				);
			}
		}
	}
}