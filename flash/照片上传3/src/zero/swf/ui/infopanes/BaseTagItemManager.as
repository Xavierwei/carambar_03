/***
BaseTagItemManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 14:26:03
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
	
	internal class BaseTagItemManager{
		protected static function getTag(baseTagItem:Sprite):Tag{
			var tagData:ByteArray=getTagData(baseTagItem);
			if(tagData.length){
				var tag:Tag=new Tag();
				tag.initByData(tagData,0);
			}else{
				tag=new Tag(baseTagItem["userData"].tag.type);
				tag.setBodyData(tagData);
			}
			return tag;
		}
		protected static function getTagData(baseTagItem:Sprite):ByteArray{
			var dataStr:String=baseTagItem["dataTxt"].text.replace(/^\s*|\s*$/g,"");
			if(dataStr){
				if(/^[a-fA-F0-9][a-fA-F0-9](\s+[a-fA-F0-9][a-fA-F0-9])*$/.test(dataStr)){
					return BytesAndStr16.str162bytes(dataStr);
				}
				return baseTagItem["userData"].tag.toData(null);
			}
			return new ByteArray();
		}
	}
}