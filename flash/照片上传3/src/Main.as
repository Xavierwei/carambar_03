/***
Main
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2014年03月06日 15:18:54
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import com.hurlant.util.Base64;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Matrix;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import nt.imagine.exif.ExifExtractor;
	import nt.imagine.exif.prototype.IFDEntry;
	
	import ui.Btn;
	
	import zero.FileTypes;
	import zero.codec.BMPEncoder;
	import zero.codec.JPEGEncoder;
	
	public class Main extends Sprite{
		
		private static const bmdPX:int=800;
		
		public var imgArea:Sprite;
		public var dragArea:Sprite;
		public var btnAdd:Btn;
		public var btnBig:Btn;
		public var btnSmall:Btn;
		public var msgTxt:TextField;
		public var btnAgree:Btn;
		public var btnSubmit:Btn;
		
		private var xmlLoader:URLLoader;
		private var xml:XML;
		
		private var fr:FileReference;
		private var imgLoader:Loader;
		
		private var bmpContainer:Sprite;
		private var bmp:Bitmap;
		
		private var Orientation:int;
		
		private var currAction:String;
		
		public function Main(){
			
			this.visible=false;
			
			this.tabEnabled=this.tabChildren=false;
			this.mouseEnabled=false;
			
			xmlLoader=new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
			xmlLoader.load(new URLRequest(
				this.loaderInfo.parameters.xml
				||
				"xml/config.xml"
			));
			
		}
		
		private function loadXMLComplete(...args):void{
			
			xmlLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
			xml=new XML(xmlLoader.data);
			xmlLoader=null;
			
			init();
			
		}
		
		private function init():void{
			
			fr=new FileReference();
			fr.addEventListener(Event.SELECT,select);
			fr.addEventListener(Event.COMPLETE,loadComplete);
			imgLoader=new Loader();
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadImgComplete);
			
			(imgArea["container"] as Sprite).addChild(bmpContainer=new Sprite());
			bmpContainer.addChild(bmp=new Bitmap());
			imgArea.scrollRect=(imgArea["bottom"] as Sprite).getBounds(imgArea);
			
			this.tabEnabled=false;
			this.tabChildren=false;
			
			dragArea.buttonMode=true;
			dragArea.addEventListener(MouseEvent.MOUSE_DOWN,startDragImg);
			btnAdd.release=browse;
			btnBig.press=big;
			btnSmall.press=small;
			btnSubmit.release=submit;
			
			msgTxt.addEventListener(Event.CHANGE,changeMsg);
			if(xml.msg[0].@maxChars.toString()){
				msgTxt.maxChars=int(xml.msg[0].@maxChars.toString());
			}
			
			_reset();
			
			this.visible=true;
			
			if(ExternalInterface.available){
				ExternalInterface.addCallback(xml.js2flash[0].@callback.toString(),js2flashUploadComplete);
				ExternalInterface.addCallback(xml.js2flash[1].@callback.toString(),reset);
			}
			
			if(ExternalInterface.available){
				ExternalInterface.call("eval",xml.onLoaded[0].@action.toString());
			}
			
		}
		
		private function browse():void{
			try{
				fr.browse([new FileFilter("图片（*.jpg;*.png;*.gif;*.bmp）","*.jpg;*.png;*.gif;*.bmp")]);
			}catch(e:Error){
				if(ExternalInterface.available){
					ExternalInterface.call("alert","e="+e);
				}
			}
		}
		private function select(...args):void{
			fr.load();
		}
		private function loadComplete(...args):void{
			
			Orientation=1;
			
			switch(FileTypes.getType(fr.data,fr.name)){
				case FileTypes.JPG:
					
					var exifMgr:ExifExtractor=new ExifExtractor(fr.data);
					
					for each(var tag:IFDEntry in exifMgr.getAllTag()){
						if(tag.EN=="Orientation"){
							Orientation=int(tag.values);
							break;
						}
					}
					
					imgLoader.loadBytes(fr.data);
					
				break;
				case FileTypes.PNG:
				case FileTypes.GIF:
					imgLoader.loadBytes(fr.data);
				break;
				case FileTypes.BMP:
					doo(BMPEncoder.decode(fr.data));
				break;
			}
		}
		private function loadImgComplete(...args):void{
			var bmd0:BitmapData=(imgLoader.content as Bitmap).bitmapData;
			//http://www.media.mit.edu/pia/Research/deepview/exif.html
			//0x0112 Orientation  unsigned short 1  The orientation of the camera relative to the scene, when the image was captured. The start point of stored data is, '1' means upper left, '3' lower right, '6' upper right, '8' lower left, '9' undefined. 
			trace("Orientation="+Orientation);
			switch(Orientation){
				case 3:
					bmd=new BitmapData(bmd0.width,bmd0.height,bmd0.transparent,0x00000000);
					bmd.draw(bmd0,new Matrix(-1,0,0,-1,bmd.width,bmd.height));
				break;
				case 6:
					bmd=new BitmapData(bmd0.height,bmd0.width,bmd0.transparent,0x00000000);
					bmd.draw(bmd0,new Matrix(0,1,-1,0,bmd.width,0));
				break;
				case 8:
					bmd=new BitmapData(bmd0.height,bmd0.width,bmd0.transparent,0x00000000);
					bmd.draw(bmd0,new Matrix(0,-1,1,0,0,bmd.height));
				break;
				default:
					var bmd:BitmapData=bmd0;
				break;
			}
			doo(bmd);
		}
		
		private function doo(bmd:BitmapData):void{
			
			if(bmp.bitmapData){
				bmp.bitmapData.dispose();
			}
			bmp.bitmapData=bmd;
			bmp.smoothing=true;
			bmpContainer.transform.matrix=new Matrix();
			//if(bmp.width>bmdPX||bmp.height>bmdPX){
			if(bmpContainer.width/bmpContainer.height<bmdPX/bmdPX){
				bmpContainer.scaleX=bmpContainer.scaleY=bmdPX/bmpContainer.width;
			}else{
				bmpContainer.scaleX=bmpContainer.scaleY=bmdPX/bmpContainer.height;
			}
			//}
			bmp.x=-bmp.width/2;
			bmp.y=-bmp.height/2;
			bmpContainer.x+=bmdPX/2;
			bmpContainer.y+=bmdPX/2;
			
			btnBig.mouseEnabled=true;
			btnBig.alpha=1;
			btnSmall.mouseEnabled=true;
			btnSmall.alpha=1;
			
			btnAdd.visible=false;
			
			updateBtnSubmit();
			
			if(ExternalInterface.available){
				ExternalInterface.call("eval",xml.onGetImg[0].@action.toString());
			}
		}
		
		private function startDragImg(...args):void{
			stage.addEventListener(MouseEvent.MOUSE_UP,stopDragImg);
			bmpContainer.startDrag();
		}
		private function stopDragImg(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopDragImg);
			stopDrag();
		}
		private function big():void{
			currAction="big";
			startZoom();
		}
		private function small():void{
			currAction="small";
			startZoom();
		}
		private function startZoom():void{
			stage.addEventListener(MouseEvent.MOUSE_UP,stopZoom);
			stage.addEventListener(Event.ENTER_FRAME,zoom);
		}
		private function zoom(...args):void{
			switch(currAction){
				case "big":
					bmpContainer.scaleY=bmpContainer.scaleX+=0.1;
				break;
				case "small":
					bmpContainer.scaleY=bmpContainer.scaleX-=0.1;
				break;
			}
		}
		private function stopZoom(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopZoom);
			stage.removeEventListener(Event.ENTER_FRAME,zoom);
		}
		
		private function changeMsg(...args):void{
			updateBtnSubmit();
		}
		
		private function agree():void{
			if(btnAgree["v"].visible){
				btnAgree["v"].visible=false;
				btnAgree.selected=false;
			}else{
				btnAgree["v"].visible=true;
				btnAgree.selected=true;
			}
			
			updateBtnSubmit();
			
		}
		
		private function updateBtnSubmit():void{
			if(
				//bmp.bitmapData
				//&&
				btnAgree.selected
				&&
				msgTxt.text
			){
				btnSubmit.mouseEnabled=true;
				btnSubmit.alpha=1;
			}else{
				btnSubmit.mouseEnabled=false;
				btnSubmit.alpha=0.5;
			}
			
		}
		
		private function submit():void{
			
			if(bmp.bitmapData){
				var targetBmd:BitmapData=new BitmapData(bmdPX,bmdPX,false,0xffffff);
				targetBmd.draw(imgArea["container"]);
				var jpgData:ByteArray=JPEGEncoder.encode(targetBmd);
				targetBmd.dispose();
				var Photo:String=Base64.encodeByteArray(jpgData);
			}else{
				Photo="";
			}
			
			if(ExternalInterface.available){
				var action:String=xml.flash2js[0].@action.toString()
					.replace(/\$\{Photo\}/g,Photo)
					.replace(/\$\{Msg\}/g,msgTxt.text);
				ExternalInterface.call("eval",action);
			}else{
				if(jpgData){
					new FileReference().save(jpgData,"img.jpg");
				}
			}
			
		}
		
		private function js2flashUploadComplete(...args):void{}
		
		private function reset():void{
			_reset();
			if(ExternalInterface.available){
				ExternalInterface.call("eval",xml.onReset[0].@action.toString());
			}
		}
		private function _reset():void{
			
			if(bmp.bitmapData){
				bmp.bitmapData.dispose();
				bmp.bitmapData=null;
			}
			btnAdd.visible=true;
			
			msgTxt.text="";
			
			btnBig.mouseEnabled=false;
			btnBig.alpha=0;
			btnSmall.mouseEnabled=false;
			btnSmall.alpha=0;
			
			btnAgree["v"].visible=false;
			btnAgree.release=agree;
			updateBtnSubmit();
		}
		
	}
}