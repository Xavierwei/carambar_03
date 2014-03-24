/***
BaseCom
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月20日 19:55:18
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
	import flash.ui.*;
	import flash.utils.*;
	
	public class BaseCom extends Sprite{
		
		public var version:String;
		
		public var wid:int;
		public var hei:int;
		
		public var xml:XML;
		private var xmlLoader:URLLoader;
		
		protected var assets:Object;
		private var assetLoader:Loader;
		private var onLoadAssetComplete:Function;
		
		private function get defaultXML():XML{
			var defaultXML:XML=new XML(this["defaultXMLStr"]);
			if(defaultXML.@bg.toString()){
			}else{
				defaultXML.@bg="";
			}
			return defaultXML;
		}
		
		public function BaseCom(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.ENTER_FRAME,init);
			//init();
		}
		public function init(...args):void{
			if(wid>0&&hei>0){
			}else{
				try{
					wid=this.loaderInfo.width;
					hei=this.loaderInfo.height;
				}catch(e:Error){
					wid=0;
					hei=0;
					return;
				}
			}
			this.removeEventListener(Event.ENTER_FRAME,init);
			
			if(this.contextMenu){
			}else{
				this.contextMenu=new ContextMenu();
			}
			this.contextMenu.hideBuiltInItems();
			if(this.contextMenu.customItems){
			}else{
				this.contextMenu.customItems=new Array();
			}
			var item:ContextMenuItem=new ContextMenuItem("宽 "+wid+" 像素，高 "+hei+" 像素"+(version?"；出厂时间："+version:""));
			this.contextMenu.customItems.push(item);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,clickMenuItem);
			
			if(xml){
				initXML(xml);
				initParam();
			}else if(this.loaderInfo.parameters.xml){
				initXML(this.loaderInfo.parameters.xml);
			}else{
				initXML(defaultXML);
				initParam();
			}
		}
		private function clickMenuItem(event:ContextMenuEvent):void{
			var urlArr:Array=this.loaderInfo.url.replace(/^(.*)\?.*$/,"$1").split("/");
			//do{
				var url1:String=urlArr.pop();
				var url2:String=urlArr.pop();
			//}while(url2=="[[DYNAMIC]]");
			var src:String=url2+"/"+url1;
			
			System.setClipboard(
				'<script src="http://www.wanmei.com/public/js/swfobject.js" type="text/javascript"></script>\n'+
				'<div id="containerID"></div>\n'+
				'<script type="text/javascript">\n'+
				'	addSWF("'+src+'","containerID",'+wid+','+hei+',{xml:"'+xml.toXMLString().replace(/"/g,"'").replace(/[\r\n]+/g,'"+\n"')+'"});\n'+
				'</script>\n'
			);
		}
		
		private function initProperty():void{
			if(xml){
			}else{
				xml=<xml/>;
			}
			for each(var attXML:XML in defaultXML.attributes()){
				var paramName:String=attXML.name().toString();
				var paramXML:XML=xml["@"+paramName][0];
				if(paramXML){
				}else{
					xml["@"+paramName]=attXML.toString();
				}
			}
			//trace("initProperty xml="+xml.toXMLString());
		}
		private function initParam():void{
			initProperty();
			var parameters:Object=this.loaderInfo.parameters;
			for each(var attXML:XML in defaultXML.attributes()){
				var paramName:String=attXML.name().toString();
				if(parameters.hasOwnProperty(paramName)){
					xml["@"+paramName]=parameters[paramName];
				}
			}
			//trace("initParam xml="+xml.toXMLString());
		}
		private function initXML(_xml:*):void{
			if(_xml){
				if(_xml is XML){
					xml=_xml;
				}else{
					var xmlStr:String=_xml;
					xmlStr=xmlStr.replace(/^\s*|\s*$/g,"");
					if(xmlStr){
						if(xmlStr.indexOf("<")==0){
							try{
								xml=new XML(xmlStr);
								if(xml.name().toString()){
								}else{
									xml=null;
								}
							}catch(e:Error){
								xml=null;
							}
							initProperty();
						}else{
							xmlLoader=new URLLoader();
							xmlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
							xmlLoader.load(new URLRequest(xmlStr));
							return;
						}
					}
				}
				
				try{
					var assetData:ByteArray=new (getDefinitionByName("AssetData"))();
					if(assetData.length){
						assets=assetData.readObject();
					}else{
						assets=null;
					}
				}catch(e:Error){
					assets=null;
				}
				
				if(xml&&xml.@bg.toString()){
					loadAsset(xml.@bg.toString(),loadBgComplete);
				}else if(assets&&assets.bgData){
					loadAsset("bgData",loadBgComplete);
				}else{
					this["initComplete"]();
				}
			}
			//trace("initXML xml="+xml.toXMLString());
		}
		
		private function loadXMLComplete(event:Event):void{
			var xmlStr:String=xmlLoader.data;
			xmlLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
			initXML(xmlLoader.data);
			xmlLoader=null;
		}
		
		public function loadAsset(dataNameOrSrc:String,_onLoadAssetComplete:Function):void{
			trace("loadAsset："+dataNameOrSrc);
			if(assetLoader){
				throw new Error("不可同时加载两个或两个以上的素材");
			}
			onLoadAssetComplete=_onLoadAssetComplete;
			assetLoader=new Loader();
			assetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadAssetComplete);
			if(assets&&assets[dataNameOrSrc]){
				assetLoader.loadBytes(assets[dataNameOrSrc]);
			}else{
				assetLoader.load(new URLRequest(dataNameOrSrc));
			}
		}
		private function loadAssetComplete(event:Event):void{
			assetLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadAssetComplete);
			if(assetLoader.content is Bitmap){
				(assetLoader.content as Bitmap).smoothing=true;
			}
			var _assetLoader:Loader=assetLoader;
			var _onLoadAssetComplete:Function=onLoadAssetComplete;
			assetLoader=null;
			onLoadAssetComplete=null;
			if(_onLoadAssetComplete==null){
			}else{
				_onLoadAssetComplete(_assetLoader);
			}
		}
		private function loadBgComplete(bgLoader:Loader):void{
			this.addChildAt(bgLoader,0);
			var bgWid:int=Math.round(bgLoader.contentLoaderInfo.width);
			var bgHei:int=Math.round(bgLoader.contentLoaderInfo.height);
			if(wid==bgWid){
			}else{
				bgLoader.scaleX=wid/bgWid;
			}
			if(hei==bgHei){
			}else{
				bgLoader.scaleY=hei/bgHei;
			}
			this["initComplete"]();
		}
	}
}