/***
ScriptLimitsManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 17:03:01
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
	import zero.swf.tagBodys.ScriptLimits;
	
	internal class ScriptLimitsManager extends BaseTagItemManager{
		private static const attNameV:Vector.<String>=new <String>[
			"MaxRecursionDepth",
			"ScriptTimeoutSeconds"
		];
		public static function init(tag:Tag):Sprite{
			var scriptLimitsItem:Sprite=new (getAssetsClass("assets.ScriptLimitsItem"))();
			for each(var attName:String in attNameV){
				scriptLimitsItem[attName+"Txt"].restrict="0-9";
			}
			updateTxtsByScriptLimits(scriptLimitsItem,tag.getBody(ScriptLimits,null));
			updateDataTxtByTagData(scriptLimitsItem,tag.toData(null));
			scriptLimitsItem.addEventListener(Event.CHANGE,change);
			return scriptLimitsItem;
		}
		public static function clear(scriptLimitsItem:Sprite):void{
			scriptLimitsItem.removeEventListener(Event.CHANGE,change);
		}
		public static function getTag(scriptLimitsItem:Sprite):Tag{
			return BaseTagItemManager.getTag(scriptLimitsItem);
		}
		private static function change(event:Event):void{
			var scriptLimitsItem:Sprite=event.currentTarget as Sprite;
			var scriptLimits:ScriptLimits=BaseTagItemManager.getTag(scriptLimitsItem).getBody(ScriptLimits,null);
			switch(event.target){
				case scriptLimitsItem["dataTxt"]:
					updateTxtsByScriptLimits(scriptLimitsItem,scriptLimits);
				break;
				default:
					updateScriptLimitsByTxts(scriptLimitsItem,scriptLimits);
					var tag:Tag=new Tag();
					tag.setBody(scriptLimits);
					updateDataTxtByTagData(scriptLimitsItem,tag.toData(null));
				break;
			}
		}
		private static function updateTxtsByScriptLimits(scriptLimitsItem:Sprite,scriptLimits:ScriptLimits):void{
			for each(var attName:String in attNameV){
				scriptLimitsItem[attName+"Txt"].text=scriptLimits[attName].toString();
			}
		}
		private static function updateScriptLimitsByTxts(scriptLimitsItem:Sprite,scriptLimits:ScriptLimits):void{
			for each(var attName:String in attNameV){
				scriptLimits[attName]=int(scriptLimitsItem[attName+"Txt"].text);
			}
		}
		private static function updateDataTxtByTagData(scriptLimitsItem:Sprite,tagData:ByteArray):void{
			scriptLimitsItem["dataTxt"].text=BytesAndStr16.bytes2str16(tagData,0,tagData.length);
		}
	}
}