/***
SetBackgroundColorManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 16:17:22
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package  zero.swf.ui.infopanes{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.BytesAndStr16;
	import zero.swf.Tag;
	import zero.swf.tagBodys.SetBackgroundColor;
	
	internal class SetBackgroundColorManager extends BaseTagItemManager{
		public static function init(tag:Tag):Sprite{
			var setBackgroundColorItem:Sprite=new (getAssetsClass("assets.SetBackgroundColorItem"))();
			updateCpBySetBackgroundColor(setBackgroundColorItem,tag.getBody(SetBackgroundColor,null));
			updateDataTxtByTagData(setBackgroundColorItem,tag.toData(null));
			setBackgroundColorItem.addEventListener(Event.CHANGE,change);
			return setBackgroundColorItem;
		}
		public static function clear(setBackgroundColorItem:Sprite):void{
			setBackgroundColorItem.removeEventListener(Event.CHANGE,change);
		}
		public static function getTag(setBackgroundColorItem:Sprite):Tag{
			return BaseTagItemManager.getTag(setBackgroundColorItem);
		}
		private static function change(event:Event):void{
			var setBackgroundColorItem:Sprite=event.currentTarget as Sprite;
			var setBackgroundColor:SetBackgroundColor=BaseTagItemManager.getTag(setBackgroundColorItem).getBody(SetBackgroundColor,null);
			switch(event.target){
				case setBackgroundColorItem["dataTxt"]:
					updateCpBySetBackgroundColor(setBackgroundColorItem,setBackgroundColor);
				break;
				default:
					updateSetBackgroundColorByCp(setBackgroundColorItem,setBackgroundColor);
					var tag:Tag=new Tag();
					tag.setBody(setBackgroundColor);
					updateDataTxtByTagData(setBackgroundColorItem,tag.toData(null));
				break;
			}
		}
		private static function updateCpBySetBackgroundColor(setBackgroundColorItem:Sprite,setBackgroundColor:SetBackgroundColor):void{
			setBackgroundColorItem["cp"].selectedColor=setBackgroundColor.BackgroundColor;
		}
		private static function updateSetBackgroundColorByCp(setBackgroundColorItem:Sprite,setBackgroundColor:SetBackgroundColor):void{
			setBackgroundColor.BackgroundColor=setBackgroundColorItem["cp"].selectedColor;
		}
		private static function updateDataTxtByTagData(setBackgroundColorItem:Sprite,tagData:ByteArray):void{
			setBackgroundColorItem["dataTxt"].text=BytesAndStr16.bytes2str16(tagData,0,tagData.length);
		}
	}
}