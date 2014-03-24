/***
DefaultTagItemManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 14:18:09
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
	
	internal class DefaultTagItemManager extends BaseTagItemManager{
		public static function init(tag:Tag):Sprite{
			var defaultTagItem:Sprite=new (getAssetsClass("assets.DefaultTagItem"))();
			if(tag.bodyLength>-1){
				var tagData:ByteArray=tag.toData({swf_Version:swf.Version});
				if(tag.bodyLength<13){
					defaultTagItem["dataTxt"].text=BytesAndStr16.bytes2str16(tagData,0,tagData.length);
				}else{
					defaultTagItem["dataTxt"].text=BytesAndStr16.bytes2str16(tagData,0,12)+"...";
				}
			}else{
				defaultTagItem["dataTxt"].text="/";
			}
			return defaultTagItem;
		}
		public static function clear(defaultTagItem:Sprite):void{
			//
		}
		public static function getTag(defaultTagItem:Sprite):Tag{
			return BaseTagItemManager.getTag(defaultTagItem);
		}
	}
}