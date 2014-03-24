/***
ProductInfoManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 17:03:37
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.ui.infopanes{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.BytesAndStr16;
	import zero.swf.Tag;
	import zero.swf.tagBodys.ProductIDAndEditions;
	import zero.swf.tagBodys.ProductInfo;
	import zero.utils.getDate;
	import zero.utils.getTime;
	
	internal class ProductInfoManager extends BaseTagItemManager{
		public static function init(tag:Tag):Sprite{
			var productInfoItem:Sprite=new (getAssetsClass("assets.ProductInfoItem"))();
			
			productInfoItem["ProductIDCb"].rowCount=10;
			productInfoItem["ProductIDCb"].dataProvider=new (getAssetsClass("fl.data.DataProvider"))(ProductIDAndEditions.productIDV.join(",").split(","));
			productInfoItem["EditionCb"].rowCount=10;
			productInfoItem["EditionCb"].dataProvider=new (getAssetsClass("fl.data.DataProvider"))(ProductIDAndEditions.editionV.join(",").split(","));
			
			productInfoItem["MajorVersionTxt"].restrict="0-9";
			productInfoItem["MinorVersionTxt"].restrict="0-9";
			productInfoItem["BuildLowTxt"].restrict="0-9";
			productInfoItem["BuildHighTxt"].restrict="0-9";
			
			updateUIsByProductInfo(productInfoItem,tag.getBody(ProductInfo,null));
			updateDataTxtByTagData(productInfoItem,tag.toData(null));
			
			productInfoItem["ProductIDCb"].addEventListener(Event.CHANGE,changeCb);
			productInfoItem["EditionCb"].addEventListener(Event.CHANGE,changeCb);
			productInfoItem.addEventListener(Event.CHANGE,change);
			
			return productInfoItem;
		}
		public static function clear(productInfoItem:Sprite):void{
			productInfoItem["ProductIDCb"].removeEventListener(Event.CHANGE,changeCb);
			productInfoItem["EditionCb"].removeEventListener(Event.CHANGE,changeCb);
			productInfoItem.removeEventListener(Event.CHANGE,change);
		}
		public static function getTag(productInfoItem:Sprite):Tag{
			return BaseTagItemManager.getTag(productInfoItem);
		}
		private static function changeCb(event:Event):void{
			var productInfoItem:Sprite=event.currentTarget.parent;
			var productInfo:ProductInfo=BaseTagItemManager.getTag(productInfoItem).getBody(ProductInfo,null);
			changeUIs(productInfoItem,productInfo);
		}
		private static function change(event:Event):void{
			var productInfoItem:Sprite=event.currentTarget as Sprite;
			var productInfo:ProductInfo=BaseTagItemManager.getTag(productInfoItem).getBody(ProductInfo,null);
			switch(event.target){
				case productInfoItem["dataTxt"]:
					updateUIsByProductInfo(productInfoItem,productInfo);
				break;
				default:
					changeUIs(productInfoItem,productInfo);
				break;
			}
		}
		private static function changeUIs(productInfoItem:Sprite,productInfo:ProductInfo):void{
			updateProductInfoByUIs(productInfoItem,productInfo);
			var tag:Tag=new Tag();
			tag.setBody(productInfo);
			updateDataTxtByTagData(productInfoItem,tag.toData(null));
		}
		private static function updateUIsByProductInfo(productInfoItem:Sprite,productInfo:ProductInfo):void{
			
			productInfoItem["ProductIDCb"].selectedIndex=productInfo.ProductID;
			productInfoItem["EditionCb"].selectedIndex=productInfo.Edition;
			
			productInfoItem["MajorVersionTxt"].text=productInfo.MajorVersion.toString();
			productInfoItem["MinorVersionTxt"].text=productInfo.MinorVersion.toString();
			productInfoItem["BuildLowTxt"].text=productInfo.BuildLow.toString();
			productInfoItem["BuildHighTxt"].text=productInfo.BuildHigh.toString();
			
			productInfoItem["CompilationDateTxt"].text=getTime(null,new Date(productInfo.CompilationDate));
			
		}
		private static function updateProductInfoByUIs(productInfoItem:Sprite,productInfo:ProductInfo):void{
			
			productInfo.ProductID=productInfoItem["ProductIDCb"].selectedIndex;
			productInfo.Edition=productInfoItem["EditionCb"].selectedIndex;
			
			productInfo.MajorVersion=int(productInfoItem["MajorVersionTxt"].text);
			productInfo.MinorVersion=int(productInfoItem["MinorVersionTxt"].text);
			productInfo.BuildLow=int(productInfoItem["BuildLowTxt"].text);
			productInfo.BuildHigh=int(productInfoItem["BuildHighTxt"].text);
			
			productInfo.CompilationDate=getDate(productInfoItem["CompilationDateTxt"].text).time;
			
		}
		private static function updateDataTxtByTagData(productInfoItem:Sprite,tagData:ByteArray):void{
			productInfoItem["dataTxt"].text=BytesAndStr16.bytes2str16(tagData,0,tagData.length);
		}
	}
}