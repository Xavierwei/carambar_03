/***
MetadataItemManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 15:32:16
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
	
	import zero.swf.Tag;
	import zero.swf.tagBodys.Metadata;
	
	internal class MetadataItemManager extends BaseTagItemManager{
		public static function init(tag:Tag):Sprite{
			var metadataItem:Sprite=new (getAssetsClass("assets.MetadataItem"))();
			var metadata:Metadata=tag.getBody(Metadata,null);
			metadataItem["metadataTxt"].text=metadata.metadata;
			return metadataItem;
		}
		public static function clear(metadataItem:Sprite):void{
			//
		}
		public static function getTag(metadataItem:Sprite):Tag{
			var metadata:Metadata=new Metadata();
			metadata.metadata=metadataItem["metadataTxt"].text;
			var tag:Tag=new Tag();
			tag.setBody(metadata);
			return tag;
		}
	}
}