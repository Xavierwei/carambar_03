/***
PasswordManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 17:02:45
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
	import zero.swf.TagTypes;
	import zero.swf.tagBodys.EnableDebugger;
	import zero.swf.tagBodys.EnableDebugger2;
	import zero.swf.tagBodys.EnableTelemetry;
	import zero.swf.tagBodys.Protect;
	import zero.swf.utils.stringComplexString;
	
	internal class PasswordManager extends BaseTagItemManager{
		public static function init(tag:Tag):Sprite{
			var passwordItem:Sprite=new (getAssetsClass("assets.PasswordItem"))();
			switch(tag.type){
				case TagTypes.Protect:
					updateTxtByPassword(passwordItem,tag.getBody(Protect,null));
				break;
				case TagTypes.EnableDebugger:
					updateTxtByPassword(passwordItem,tag.getBody(EnableDebugger,null));
				break;
				case TagTypes.EnableDebugger2:
					updateTxtByPassword(passwordItem,tag.getBody(EnableDebugger2,null));
				break;
				case TagTypes.EnableTelemetry:
					updateTxtByPassword(passwordItem,tag.getBody(EnableTelemetry,null));
				break;
			}
			updateDataTxtByTagData(passwordItem,tag.toData(null));
			passwordItem.addEventListener(Event.CHANGE,change);
			return passwordItem;
		}
		public static function clear(passwordItem:Sprite):void{
			passwordItem.removeEventListener(Event.CHANGE,change);
		}
		public static function getTag(passwordItem:Sprite):Tag{
			return BaseTagItemManager.getTag(passwordItem);
		}
		private static function change(event:Event):void{
			var passwordItem:Sprite=event.currentTarget as Sprite;
			switch(passwordItem["userData"].tag.type){
				case TagTypes.Protect:
					var password:*=BaseTagItemManager.getTag(passwordItem).getBody(Protect,null);
				break;
				case TagTypes.EnableDebugger:
					password=BaseTagItemManager.getTag(passwordItem).getBody(EnableDebugger,null);
				break;
				case TagTypes.EnableDebugger2:
					password=BaseTagItemManager.getTag(passwordItem).getBody(EnableDebugger2,null);
				break;
				case TagTypes.EnableTelemetry:
					password=BaseTagItemManager.getTag(passwordItem).getBody(EnableTelemetry,null);
				break;
			}
			switch(event.target){
				case passwordItem["dataTxt"]:
					updateTxtByPassword(passwordItem,password);
				break;
				default:
					updatePasswordByTxt(passwordItem,password);
					var tag:Tag=new Tag();
					tag.setBody(password);
					updateDataTxtByTagData(passwordItem,tag.toData(null));
				break;
			}
		}
		private static function updateTxtByPassword(passwordItem:Sprite,password:*):void{
			passwordItem["passwordTxt"].text=stringComplexString.escape(password.password);
		}
		private static function updatePasswordByTxt(passwordItem:Sprite,password:*):void{
			password["password"]=stringComplexString.unescape(passwordItem["passwordTxt"].text);
		}
		private static function updateDataTxtByTagData(passwordItem:Sprite,tagData:ByteArray):void{
			passwordItem["dataTxt"].text=BytesAndStr16.bytes2str16(tagData,0,tagData.length);
		}
	}
}