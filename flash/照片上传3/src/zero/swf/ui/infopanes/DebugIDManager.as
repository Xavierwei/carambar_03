/***
DebugIDManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 17:02:54
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
	import zero.swf.tagBodys.DebugID;
	
	internal class DebugIDManager extends BaseTagItemManager{
		public static function init(tag:Tag):Sprite{
			var debugIDItem:Sprite=new (getAssetsClass("assets.DebugIDItem"))();
			updateTxtByDebugID(debugIDItem,tag.getBody(DebugID,null));
			updateDataTxtByTagData(debugIDItem,tag.toData(null));
			debugIDItem.addEventListener(Event.CHANGE,change);
			return debugIDItem;
		}
		public static function clear(debugIDItem:Sprite):void{
			debugIDItem.removeEventListener(Event.CHANGE,change);
		}
		public static function getTag(debugIDItem:Sprite):Tag{
			return BaseTagItemManager.getTag(debugIDItem);
		}
		private static function change(event:Event):void{
			var debugIDItem:Sprite=event.currentTarget as Sprite;
			var debugID:DebugID=BaseTagItemManager.getTag(debugIDItem).getBody(DebugID,null);
			switch(event.target){
				case debugIDItem["dataTxt"]:
					updateTxtByDebugID(debugIDItem,debugID);
				break;
				default:
					updateDebugIDByTxt(debugIDItem,debugID);
					var tag:Tag=new Tag();
					tag.setBody(debugID);
					updateDataTxtByTagData(debugIDItem,tag.toData(null));
				break;
			}
		}
		private static function updateTxtByDebugID(debugIDItem:Sprite,debugID:*):void{
			debugIDItem["idTxt"].text=debugID.id;
		}
		private static function updateDebugIDByTxt(debugIDItem:Sprite,debugID:*):void{
			debugID.id=debugIDItem["idTxt"].text;
		}
		private static function updateDataTxtByTagData(debugIDItem:Sprite,tagData:ByteArray):void{
			debugIDItem["dataTxt"].text=BytesAndStr16.bytes2str16(tagData,0,tagData.length);
		}
	}
}