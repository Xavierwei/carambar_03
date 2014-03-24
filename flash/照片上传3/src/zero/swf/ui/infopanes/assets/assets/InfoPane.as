/***
InfoPane
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年01月30日 09:15:32
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package assets{
	
	import fl.containers.ScrollPane;
	import fl.controls.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class InfoPane extends Sprite{
		
		public var typeRb0:RadioButton;
		public var versionCb:ComboBox;
		public var fileLengthTxt:Label;
		
		public var xTxt:TextInput;
		public var yTxt:TextInput;
		public var widthTxt:TextInput;
		public var heightTxt:TextInput;
		public var frameRateTxt:TextInput;
		public var frameCountTxt:Label;
		
		public var scrollPane:ScrollPane;
		public var addTagTypeCb:ComboBox;
		public var addBtn:SimpleButton;
		
		public var resetBtn:Button;
		public var saveAsBtn:Button;
		
		public function InfoPane(){
		}
	}
}