/***
AssetPane 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月19日 19:30:02
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.photodiys{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.net.*;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.*;
	
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	import zero.swf.funs.*;
	
	public class AssetPane extends Sprite{
		
		public var dw:int;
		public var dh:int;
		public var folderPath:String;
		
		private var w:int;
		private var listLoader:URLLoader;
		private var listXML:XML;
		private var loadId:int;
		
		private var assetDataLoader:URLLoader;
		private var assetLoader:Loader;
		
		private var onInitComplete:Function;
		private var onSelectAsset:Function;
		
		public var container:Sprite;
		public var assetV:Vector.<MovieClip>;
		public var dataV:Vector.<Array>;
		
		public var bg:Sprite;
		public var maskrect:Sprite;
		public var scrollBar:Sprite;
		private var moveThumbSpeed:int;
		
		private var assetDocClassName:String;
		
		public function AssetPane(){
		}
		public function init(_onInitComplete:Function,_onSelectAsset:Function,_assetDocClassName:String):void{
			
			onInitComplete=_onInitComplete;
			onSelectAsset=_onSelectAsset;
			assetDocClassName=_assetDocClassName;
			
			listLoader=new URLLoader();
			listLoader.addEventListener(Event.COMPLETE,loadListXMLComplete);
			listLoader.addEventListener(IOErrorEvent.IO_ERROR,loadListXMLError);
			listLoader.load(new URLRequest(folderPath+"list.xml"));
		}
		private function loadListXMLError(event:IOErrorEvent):void{
			listLoader.removeEventListener(Event.COMPLETE,loadListXMLComplete);
			listLoader.removeEventListener(IOErrorEvent.IO_ERROR,loadListXMLError);
		}
		
		private function loadListXMLComplete(event:Event):void{
			listLoader.removeEventListener(Event.COMPLETE,loadListXMLComplete);
			listLoader.removeEventListener(IOErrorEvent.IO_ERROR,loadListXMLError);
			listXML=new XML(listLoader.data);
			
			container.addEventListener(MouseEvent.MOUSE_OVER,rollOverAsset);
			container.addEventListener(MouseEvent.MOUSE_OUT,rollOutAsset);
			container.addEventListener(MouseEvent.MOUSE_DOWN,pressAsset);
			container.buttonMode=true;
			
			//container.scaleX=container.scaleY=1;
			
			assetV=new Vector.<MovieClip>();
			dataV=new Vector.<Array>();
			
			w=Math.round(maskrect.width/dw);
			if(Math.round(maskrect.height/dh)<Math.ceil(listXML.asset.length()/w)){
				scrollBar["thumb"].height=scrollBar["bar"].height*(
					Math.round(maskrect.height/dh)
					/
					Math.ceil(listXML.asset.length()/w)
				);
				scrollBar["thumb"].addEventListener(MouseEvent.MOUSE_DOWN,startDragThumb);
				scrollBar["bar"].addEventListener(MouseEvent.MOUSE_DOWN,pressBar);
				scrollBar["btnUp"].addEventListener(MouseEvent.MOUSE_DOWN,up);
				scrollBar["btnDown"].addEventListener(MouseEvent.MOUSE_DOWN,down);
				this.addEventListener(Event.ENTER_FRAME,updateContainer);
			}else{
				scrollBar.mouseEnabled=scrollBar.mouseChildren=false;
				scrollBar.alpha=0.5;
			}
			
			loadId=-1;
			loadNextAsset();
		}
		private function startDragThumb(event:MouseEvent):void{
			scrollBar["thumb"].startDrag(
				false,
				new Rectangle(
					scrollBar["bar"].x,
					scrollBar["bar"].y,
					0,
					scrollBar["bar"].height-scrollBar["thumb"].height
				)
			);
			stage.addEventListener(MouseEvent.MOUSE_UP,stopDragThumb);
		}
		private function stopDragThumb(event:MouseEvent):void{
			scrollBar["thumb"].stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopDragThumb);
		}
		private function pressBar(event:MouseEvent):void{
			scrollBar["thumb"].y=scrollBar.mouseY-scrollBar["thumb"].height/2;
			adjustThumb();
			startDragThumb(null);
		}
		private function up(event:MouseEvent):void{
			moveThumbSpeed=-5;
			this.addEventListener(Event.ENTER_FRAME,moveThumb);
			stage.addEventListener(MouseEvent.MOUSE_UP,stopMoveThumb);
		}
		private function down(event:MouseEvent):void{
			moveThumbSpeed=5;
			this.addEventListener(Event.ENTER_FRAME,moveThumb);
			stage.addEventListener(MouseEvent.MOUSE_UP,stopMoveThumb);
		}
		private function stopMoveThumb(event:MouseEvent):void{
			this.removeEventListener(Event.ENTER_FRAME,moveThumb);
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopMoveThumb);
		}
		private function moveThumb(event:Event):void{
			scrollBar["thumb"].y+=moveThumbSpeed;
			adjustThumb();
		}
		private function adjustThumb():void{
			if(scrollBar["thumb"].y<scrollBar["bar"].y){
				scrollBar["thumb"].y=scrollBar["bar"].y;
			}else if(scrollBar["thumb"].y+scrollBar["thumb"].height>scrollBar["bar"].y+scrollBar["bar"].height){
				scrollBar["thumb"].y=scrollBar["bar"].y+scrollBar["bar"].height-scrollBar["thumb"].height;
			}
		}
		private function updateContainer(event:Event):void{
			container.y+=(maskrect.y-Math.ceil(listXML.asset.length()/w)*dh*(scrollBar["thumb"].y-scrollBar["bar"].y)/scrollBar["bar"].height-container.y)*0.3;
		}
		private function loadNextAsset():void{
			if(++loadId>=listXML.asset.length()){
				if(onInitComplete==null){
				}else{
					onInitComplete();
				}
				return;
			}
			assetDataLoader=new URLLoader();
			assetDataLoader.dataFormat=URLLoaderDataFormat.BINARY;
			assetDataLoader.addEventListener(Event.COMPLETE,loadAssetDataComplete);
			assetDataLoader.addEventListener(IOErrorEvent.IO_ERROR,loadAssetDataError);
			dataV[loadId]=[folderPath+listXML.asset[loadId].@src.toString()];
			assetDataLoader.load(new URLRequest(dataV[loadId][0]));
		}
		private function loadAssetDataComplete(event:Event):void{
			assetDataLoader.removeEventListener(Event.COMPLETE,loadAssetDataComplete);
			assetDataLoader.removeEventListener(IOErrorEvent.IO_ERROR,loadAssetDataError);
			
			assetLoader=new Loader();
			container.addChild(assetLoader);
			assetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadAssetComplete);
			assetLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadAssetError);
			var swf:SWF=new SWF();
			swf.initBySWFData(assetDataLoader.data,null);
			loop:for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagTypes.DoABC:
					case TagTypes.DoABCWithoutFlagsAndName:
						throw new Error("asset 不应带代码");
					break;
					case TagTypes.ShowFrame:
						var symbolClass:SymbolClass=new SymbolClass();
						symbolClass.NameV=new Vector.<String>();
						symbolClass.TagV=new Vector.<int>();
						symbolClass.NameV[0]=assetDocClassName;
						symbolClass.TagV[0]=0;
						var symbolClassTag:Tag=new Tag();
						symbolClassTag.setBody(symbolClass);
						swf.tagV.splice(swf.tagV.indexOf(tag),0,SimpleDoABC.getDoABCTag(assetDocClassName,"mc"),symbolClassTag);
						break loop;
					break;
				}
			}
			var swfData:ByteArray=swf.toSWFData(null);
			assetLoader.loadBytes(swfData);
			assetLoader.mouseChildren=false;
			//dataV[loadId].push(swfData);
			dataV[loadId].push(assetDataLoader.data);
			
			assetDataLoader=null;
		}
		private function loadAssetDataError(event:IOErrorEvent):void{
			loadNextAsset();
		}
		
		private function loadAssetComplete(event:Event):void{
			assetLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadAssetComplete);
			assetLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadAssetError);
			
			var graphics:Graphics=assetLoader.content["graphics"];
			
			graphics.clear();
			
			//graphics.lineStyle(1,0x0000ff);
			//graphics.beginFill(0xff0000,0.3);trace("测试，用红色作 clickArea");
			
			graphics.beginFill(0x000000,0);
			
			graphics.drawRect(0,0,assetLoader.contentLoaderInfo.width,assetLoader.contentLoaderInfo.height);
			graphics.endFill();
			
			assetLoader.x=(loadId%w)*dw+(dw-assetLoader.contentLoaderInfo.width)/2;
			assetLoader.y=int(loadId/w)*dh+(dh-assetLoader.contentLoaderInfo.height)/2;
			
			assetV[loadId]=assetLoader.content as MovieClip;
			
			loadNextAsset();
		}
		private function loadAssetError(event:IOErrorEvent):void{
			assetLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadAssetComplete);
			assetLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadAssetError);
			
			loadNextAsset();
		}
		
		private function rollOverAsset(event:MouseEvent):void{
			for each(var asset:MovieClip in assetV){
				asset.filters=null;
			}
			((event.target as Loader).content as MovieClip).filters=[new GlowFilter(0xffffff,0.8)];
		}
		private function rollOutAsset(event:MouseEvent):void{
			for each(var asset:MovieClip in assetV){
				asset.filters=null;
			}
		}
		private function pressAsset(event:MouseEvent):void{
			if(onSelectAsset==null){
			}else{
				var asset:MovieClip=(event.target as Loader).content as MovieClip;
				var data:Array=dataV[assetV.indexOf(asset)];
				onSelectAsset(asset,data[0],data[1]);
			}
		}
	}
}