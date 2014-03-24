/***
FileAttributesItemManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 14:13:31
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
	import zero.swf.tagBodys.FileAttributes;
	
	internal class FileAttributesItemManager extends BaseTagItemManager{
		private static const attNameV:Vector.<String>=new <String>[
			"UseGPU",
			"UseDirectBlit",
			"HasMetadata",
			"ActionScript3",
			"suppressCrossDomainCaching",
			"swfRelativeUrls",
			"UseNetwork"
		];
		public static function init(tag:Tag):Sprite{
			var fileAttributesItem:Sprite=new (getAssetsClass("assets.FileAttributesItem"))();
			updateCbsByFileAttributes(fileAttributesItem,tag.getBody(FileAttributes,null));
			updateDataTxtByTagData(fileAttributesItem,tag.toData(null));
			fileAttributesItem.addEventListener(Event.CHANGE,change);
			return fileAttributesItem;
		}
		public static function clear(fileAttributesItem:Sprite):void{
			fileAttributesItem.removeEventListener(Event.CHANGE,change);
		}
		public static function getTag(fileAttributesItem:Sprite):Tag{
			return BaseTagItemManager.getTag(fileAttributesItem);
		}
		private static function change(event:Event):void{
			var fileAttributesItem:Sprite=event.currentTarget as Sprite;
			var fileAttributes:FileAttributes=BaseTagItemManager.getTag(fileAttributesItem).getBody(FileAttributes,null);
			switch(event.target){
				case fileAttributesItem["dataTxt"]:
					updateCbsByFileAttributes(fileAttributesItem,fileAttributes);
				break;
				default:
					updateFileAttributesByCbs(fileAttributesItem,fileAttributes);
					var tag:Tag=new Tag();
					tag.setBody(fileAttributes);
					updateDataTxtByTagData(fileAttributesItem,tag.toData(null));
				break;
			}
		}
		private static function updateCbsByFileAttributes(fileAttributesItem:Sprite,fileAttributes:FileAttributes):void{
			for each(var attName:String in attNameV){
				fileAttributesItem[attName+"Cb"].selected=fileAttributes[attName];
			}
		}
		private static function updateFileAttributesByCbs(fileAttributesItem:Sprite,fileAttributes:FileAttributes):void{
			for each(var attName:String in attNameV){
				fileAttributes[attName]=fileAttributesItem[attName+"Cb"].selected;
			}
		}
		private static function updateDataTxtByTagData(fileAttributesItem:Sprite,tagData:ByteArray):void{
			fileAttributesItem["dataTxt"].text=BytesAndStr16.bytes2str16(tagData,0,tagData.length);
		}
	}
}