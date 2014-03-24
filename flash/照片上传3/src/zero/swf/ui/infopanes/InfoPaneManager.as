/***
InfoPaneManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年01月30日 16:42:11
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.ui.infopanes{
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.LoaderContext;
	import flash.text.TextFieldAutoSize;
	import flash.utils.ByteArray;
	
	import zero.swf.SWF;
	import zero.swf.Tag;
	import zero.swf.TagTypes;
	import zero.swf.tagBodys.DefineSprite;
	import zero.ui.So;
	
	public class InfoPaneManager{
		
		private static var container:Sprite;
		private static var loader:Loader;
		private static var onInitComplete:Function;
		
		public static var infoPane:Sprite;
		private static var changeTagTypePane:Sprite;
		
		private static var currTagItem:Sprite;
		
		private static var itemArea:Sprite;
		
		private static var onSave:Function;
		
		private static var typeNameArr:Array;
		
		public static function init(_container:Sprite,_onInitComplete:Function,_onSave:Function):void{
			
			if(loader){
				throw new Error("不允许再次 init");
			}
			
			container=_container;
			onInitComplete=_onInitComplete;
			onSave=_onSave;
			
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			var loaderContext:LoaderContext=new LoaderContext();
			loaderContext.allowCodeImport=true;
			loader.loadBytes(new InfoPaneSWFData(),loaderContext);
			
		}
		private static function loadComplete(...args):void{
			
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
			
			So.init("InfoPaneManager20130306",loader.contentLoaderInfo.applicationDomain.getDefinition);
			getAssetsClass=_getAssetsClass;
			
			container.addChild(infoPane=new (getAssetsClass("assets.InfoPane"))());
			infoPane.name="infoPane";
			
			infoPane.mouseChildren=false;
			infoPane.alpha=0.5;
			
			changeTagTypePane=new (getAssetsClass("assets.ChangeTagTypePane"))();
			changeTagTypePane.name="changeTagTypePane";
			//infoPane["typeRb0"].selected=true;
			
			infoPane["versionCb"].restrict="0-9";
			infoPane["versionCb"].rowCount=15;
			infoPane["versionCb"].editable=true;
			infoPane["versionCb"].dataProvider=new (getAssetsClass("fl.data.DataProvider"))([4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]);
			//infoPane["versionCb"].selectedIndex=5;
			
			//infoPane["xTxt"].text="0";
			infoPane["xTxt"].restrict="0-9.";
			//infoPane["yTxt"].text="0";
			infoPane["yTxt"].restrict="0-9.";
			//infoPane["widthTxt"].text="0";
			infoPane["widthTxt"].restrict="0-9.";
			//infoPane["heightTxt"].text="0";
			infoPane["heightTxt"].restrict="0-9.";
			
			//infoPane["frameRateTxt"].text="0";
			infoPane["frameRateTxt"].restrict="0-9.";
			
			//So.add(infoPane["typeRb0"]);
			//So.add(infoPane["versionCb"]);
			//So.add(infoPane["xTxt"]);
			//So.add(infoPane["yTxt"]);
			//So.add(infoPane["widthTxt"]);
			//So.add(infoPane["heightTxt"]);
			//So.add(infoPane["frameRateTxt"]);
			
			infoPane["resetBtn"].addEventListener(MouseEvent.CLICK,reset);
			infoPane["saveAsBtn"].addEventListener(MouseEvent.CLICK,saveAs);
			
			typeNameArr=new Array();
			for each(var typeName:String in TagTypes.typeNameV){
				if(typeName){
					typeNameArr.push(typeName);
				}
			}
			typeNameArr.sort();
			infoPane["addTagTypeCb"].rowCount=15;
			infoPane["addTagTypeCb"].editable=true;
			infoPane["addTagTypeCb"].dataProvider=new (getAssetsClass("fl.data.DataProvider"))(typeNameArr);
			infoPane["addTagTypeCb"].selectedIndex=0;
			changeTagTypePane["tagTypeCb"].rowCount=15;
			changeTagTypePane["tagTypeCb"].editable=true;
			changeTagTypePane["tagTypeCb"].dataProvider=new (getAssetsClass("fl.data.DataProvider"))(typeNameArr);
			changeTagTypePane["tagTypeCb"].selectedIndex=0;
			changeTagTypePane.addEventListener(MouseEvent.CLICK,clickChangeTagTypePane);
			changeTagTypePane.mouseEnabled=false;
			
			infoPane.addEventListener(MouseEvent.CLICK,clickItem);
			
			So.add(infoPane["addTagTypeCb"],2);
			So.add(changeTagTypePane["tagTypeCb"],2,{enterAction:confirmTagType});//不为保存，只为输入时可以自动匹配。。。
			
			if(onInitComplete==null){
			}else{
				onInitComplete();
			}
			
			container=null;
			onInitComplete=null;
			
		}
		
		private static function _getAssetsClass(className:String):Class{
			return loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
		}
		
		private static function clickChangeTagTypePane(event:MouseEvent):void{
			switch(event.target){
				case changeTagTypePane["closeBtn"]:
				case changeTagTypePane["cancelBtn"]:
					changeTagTypePane.visible=false;
					infoPane.stage.removeChild(changeTagTypePane);
				break;
				case changeTagTypePane["okBtn"]:
					confirmTagType();
				break;
			}
		}
		private static function confirmTagType():void{
			changeTagTypePane.visible=false;
			infoPane.stage.removeChild(changeTagTypePane);
			var tag:Tag=new Tag(TagTypes[changeTagTypePane["tagTypeCb"].selectedLabel]);
			tag.setBodyData(getDefaultTagBodyData(tag.type));
			itemArea.addChildAt(getTagItem(tag),itemArea.getChildIndex(currTagItem));
			removeTagItem(currTagItem);
			currTagItem=null;
			updateItemArea();
		}
		
		private static function reset(...args):void{
			update(swf);
		}
		public static function update(_swf:SWF):void{
			
			if(infoPane){
			}else{
				throw new Error("infoPane="+infoPane);
			}
			
			swf=_swf;
			
			if(swf){
				
				infoPane.mouseChildren=true;
				infoPane.alpha=1;
				
				var i:int=infoPane["typeRb0"].group.numRadioButtons;
				while(--i>=0){
					var typeRb:Sprite=infoPane["typeRb0"].group.getRadioButtonAt(i);
					if(typeRb["label"]==swf.type){
						infoPane["typeRb0"].group.selection=typeRb;
						break;
					}
				}
				
				infoPane["versionCb"].validateNow();
				infoPane["versionCb"].text=swf.Version.toString();
				
				infoPane["fileLengthTxt"].text=swf.FileLength.toString()+"字节";
				
				infoPane["xTxt"].text=swf.x.toString();
				infoPane["yTxt"].text=swf.y.toString();
				infoPane["widthTxt"].text=swf.width.toString();
				infoPane["heightTxt"].text=swf.height.toString();
				
				infoPane["frameRateTxt"].text=swf.FrameRate.toString();
				
				infoPane["frameCountTxt"].text=swf.FrameCount.toString()+"帧";
				
				if(itemArea){
					i=itemArea.numChildren;
					while(--i>=0){
						removeTagItem(itemArea.getChildAt(i) as Sprite);
					}
				}
				infoPane["scrollPane"].source=null;
				
				itemArea=new Sprite();
				itemArea.mouseEnabled=false;
				for each(var tag:Tag in swf.tagV){
					itemArea.addChild(getTagItem(tag));
				}
				
				updateItemArea();
				
			}else{
				
				infoPane.mouseChildren=false;
				infoPane.alpha=0.5;
				
			}
		}
		private static function getItemManager(tagType:int):*{
			//trace("tagType="+TagTypes.typeNameV[tagType]);
			switch(tagType){
				case TagTypes.FileAttributes:
					return FileAttributesItemManager;
				break;
				case TagTypes.Metadata:
					return MetadataItemManager;
				break;
				case TagTypes.SetBackgroundColor:
					return SetBackgroundColorManager;
				break;
				case TagTypes.Protect:
				case TagTypes.EnableDebugger:
				case TagTypes.EnableDebugger2:
				case TagTypes.EnableTelemetry:
					return PasswordManager;
				break;
				case TagTypes.DebugID:
					return DebugIDManager;
				break;
				case TagTypes.ScriptLimits:
					return ScriptLimitsManager;
				break;
				case TagTypes.ProductInfo:
					return ProductInfoManager;
				break;
				default:
					return DefaultTagItemManager;
				break;
			}
		}
		private static function getDefaultTagBodyData(tagType:int):ByteArray{
			//trace("tagType="+TagTypes.typeNameV[tagType]);
			var defaultTagBodyData:ByteArray=new ByteArray();
			switch(tagType){
				//case TagTypes.FileAttributes:
				//	//
				//break;
				case TagTypes.Metadata:
					defaultTagBodyData.writeUTFBytes("<metadata/>\x00");
				break;
				//case TagTypes.SetBackgroundColor:
				//	//
				//break;
				//case TagTypes.Protect:
				//case TagTypes.EnableDebugger:
				//case TagTypes.EnableDebugger2:
				//case TagTypes.EnableTelemetry:
				//	//
				//break;
				case TagTypes.DebugID:
					defaultTagBodyData.writeUTFBytes("\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00");
				break;
				//case TagTypes.ScriptLimits:
				//	//
				//break;
				//case TagTypes.ProductInfo:
				//	//
				//break;
				//default:
				//	//
				//break;
			}
			return defaultTagBodyData;
		}
		private static function removeTagItem(tagItem:Sprite):void{
			getItemManager(tagItem["userData"].tag.type).clear(tagItem);
			itemArea.removeChild(tagItem);
		}
		private static function getTagItem(tag:Tag):Sprite{
			var tagItem:Sprite=getItemManager(tag.type).init(tag);
			
			tagItem.mouseEnabled=false;
			tagItem.x=5;
			tagItem["typeBtn"].mouseChildren=false;
			tagItem["typeBtn"].buttonMode=true;
			tagItem["typeBtn"]["txt"].autoSize=TextFieldAutoSize.LEFT;
			tagItem["typeBtn"]["txt"].text=TagTypes.typeNameV[tag.type]+"（"+tag.type+"）";
			tagItem["userData"]={tag:tag};
			
			return tagItem;
				
		}
		private static function clickItem(event:MouseEvent):void{
			
			var btn:SimpleButton=event.target as SimpleButton;
			
			if(btn){
				switch(btn){
					case infoPane["addBtn"]:
						var tag:Tag=new Tag(TagTypes[infoPane["addTagTypeCb"].selectedLabel]);
						tag.setBodyData(getDefaultTagBodyData(tag.type));
						itemArea.addChildAt(getTagItem(tag),0);
					break;
					default:
						var tagItem:Sprite=btn.parent.parent as Sprite;
						if(tagItem){
						}else{
							return;
						}
					break;
				}
				if(tagItem){
					switch(btn.name){
						case "deleteBtn":
							removeTagItem(tagItem);
						break;
						case "upBtn":
							itemArea.addChildAt(tagItem,itemArea.getChildIndex(tagItem)-1);
						break;
						case "downBtn":
							itemArea.addChildAt(tagItem,itemArea.getChildIndex(tagItem)+1);
						break;
						case "duplicateBtn":
							tag=new Tag();
							tag.initByData(tagItem["userData"].tag.toData(null),0);
							itemArea.addChildAt(getTagItem(tag),itemArea.getChildIndex(tagItem)+1);
						break;
						case "addBtn":
							tag=new Tag(TagTypes[infoPane["addTagTypeCb"].selectedLabel]);
							tag.setBodyData(getDefaultTagBodyData(tag.type));
							itemArea.addChildAt(getTagItem(tag),itemArea.getChildIndex(tagItem)+1);
						break;
						default:
							return;
						break;
					}
				}
				updateItemArea();
				return;
			}
			
			var sp:Sprite=event.target as Sprite;
			if(sp){
				if(sp.name=="typeBtn"){
					tagItem=sp.parent as Sprite;
					if(tagItem){
						currTagItem=tagItem;
						infoPane.stage.addChild(changeTagTypePane);
						changeTagTypePane["tagTypeCb"].selectedIndex=typeNameArr.indexOf(TagTypes.typeNameV[tagItem["userData"].tag.type]);
						changeTagTypePane.x=Math.round(infoPane.stage.stageWidth/2);
						changeTagTypePane.y=Math.round(infoPane.stage.stageHeight/2);
						changeTagTypePane["bg"].x=-changeTagTypePane.x;
						changeTagTypePane["bg"].y=-changeTagTypePane.y;
						changeTagTypePane["bg"].width=infoPane.stage.stageWidth;
						changeTagTypePane["bg"].height=infoPane.stage.stageHeight;
						changeTagTypePane.visible=true;
						infoPane.stage.focus=changeTagTypePane["tagTypeCb"];
					}
				}
			}
		}
		
		private static function updateItemArea():void{
			var y:int=5;
			for(var i:int=0;i<itemArea.numChildren;i++){
				var tagItem:Sprite=itemArea.getChildAt(i) as Sprite;
				tagItem.y=y;
				tagItem["btns"].upBtn.mouseEnabled=true;
				tagItem["btns"].upBtn.alpha=1;
				tagItem["btns"].downBtn.mouseEnabled=true;
				tagItem["btns"].downBtn.alpha=1;
				y+=tagItem["bg"].height+5;
			}
			if(tagItem){
				
				//最后一个 tagItem
				tagItem["btns"].downBtn.mouseEnabled=false;
				tagItem["btns"].downBtn.alpha=0.5;
				
				//第一个tagItem
				tagItem=itemArea.getChildAt(0) as Sprite;
				tagItem["btns"].upBtn.mouseEnabled=false;
				tagItem["btns"].upBtn.alpha=0.5;
			}
			itemArea.graphics.clear();
			itemArea.graphics.beginFill(0x00ff00,0.3);
			itemArea.graphics.drawRect(0,0,itemArea.width+10,y+5);
			infoPane["scrollPane"].source=itemArea;
		}
		
		public static function getModifySWF():SWF{
			
			var modifySWF:SWF=new SWF();
			
			modifySWF.type=infoPane["typeRb0"].group.selection.label;
			modifySWF.Version=int(infoPane["versionCb"].text);
			
			modifySWF.x=Number(infoPane["xTxt"].text);
			modifySWF.y=Number(infoPane["yTxt"].text);
			modifySWF.width=Number(infoPane["widthTxt"].text);
			modifySWF.height=Number(infoPane["heightTxt"].text);
			
			modifySWF.FrameRate=Number(infoPane["frameRateTxt"].text);
			
			modifySWF.FrameCount=Number(infoPane["frameCountTxt"].text);
			
			modifySWF.tagV=new Vector.<Tag>();
			for(var i:int=0;i<itemArea.numChildren;i++){
				var tagItem:Sprite=itemArea.getChildAt(i) as Sprite;
				modifySWF.tagV.push(getItemManager(tagItem["userData"].tag.type).getTag(tagItem));
			}
			
			return modifySWF;
			
		}
		
		private static function saveAs(...args):void{
			if(onSave==null){
			}else{
				onSave(getModifySWF().toSWFData(null));
			}
		}
		
	}
}
