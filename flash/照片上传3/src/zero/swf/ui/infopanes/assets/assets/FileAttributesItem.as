/***
FileAttributesItem
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 08:48:53
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package assets{
	import fl.controls.CheckBox;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class FileAttributesItem extends BaseTagItem{
		public var dataTxt:TextField;
		public var UseGPUCb:CheckBox;
		public var UseDirectBlitCb:CheckBox;
		public var HasMetadataCb:CheckBox;
		public var ActionScript3Cb:CheckBox;
		public var suppressCrossDomainCachingCb:CheckBox;
		public var swfRelativeUrlsCb:CheckBox;
		public var UseNetworkCb:CheckBox;
		public function FileAttributesItem(){
		}
	}
}