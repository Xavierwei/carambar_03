/***
ProductInfoItem
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月04日 17:02:29
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package assets{
	import fl.controls.ComboBox;
	import fl.controls.TextInput;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class ProductInfoItem extends BaseTagItem{
		public var dataTxt:TextField;
		public var ProductIDCb:ComboBox;
		public var EditionCb:ComboBox;
		public var MajorVersionTxt:TextInput;
		public var MinorVersionTxt:TextInput;
		public var BuildLowTxt:TextInput;
		public var BuildHighTxt:TextInput;
		public var CompilationDateTxt:TextInput;
		public function ProductInfoItem(){
		}
	}
}