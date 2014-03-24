package ui{
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import akdcl.display.UISprite;
	
	public class Txt extends UISprite {
		public var txt:TextField;
		
		protected var __widthMax:int;
		[Inspectable(defaultValue=0,type="int",name="0_固定宽")]
		public function get widthMax():int{
			return __widthMax;
		}
		public function set widthMax(_widthMax:int):void {
			__widthMax=_widthMax;
			if(__widthMax){
				//txt.multiline=true;
				txt.wordWrap=true;
			}
		}
		
		private var __text:String="";
		public function get text():String {
			if (txt.selectable) {
				__text=txt.text;
			}
			return __text;
		}
		public function set text(_text:String):void {
			if (__text!=_text) {
				txt.htmlText = __text = _text;
				setStyle();
			}
		}
		public function get autoSize():String {
			return txt.autoSize;
		}
		
		[Inspectable(enumeration="left,right,center,none",defaultValue="left",type="String",name="对齐")]
		public function set autoSize(_autoSize:String):void {
			try{
				txt.autoSize = _autoSize;
				txt.wordWrap = false;
			}catch (_ero:*) {
				
			}
			setStyle();
		}
		public function get type():String {
			return txt.type;
		}
		public function set type(_type:String):void {
			txt.type=_type;
		}
		public function set selectable(_selectable:Boolean):void {
			txt.selectable = _selectable;
		}
		public function set maxChars(_maxChars:int):void {
			txt.maxChars = _maxChars;
		}
		public function set restrict(_restrict:String):void {
			txt.restrict = _restrict;
		}
		public function set styleSheet(_styleSheet:StyleSheet):void {
			txt.styleSheet = _styleSheet;
		}
		
		protected var textFormat:TextFormat;
		
		override protected function init():void {
			super.init();
			txt.mouseWheelEnabled = false;
			txt.mouseEnabled = false;
			txt.selectable = false;
			//txt.autoSize = "left";
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			textFormat = null;
			txt = null;
		}
		
		public function setStyle():void {
			if (widthMax) {
				txt.wordWrap=true;
				txt.width = widthMax;
				try {
					if (!textFormat) {
						textFormat = new TextFormat();
					}
					textFormat.align = txt.autoSize;
					txt.setTextFormat(textFormat);
				}catch (_ero:*) {
					
				}
			} else {
				txt.autoSize = txt.autoSize;
			}
			if (txt.autoSize=="left") {
				//txt.x=0;
			} else if (txt.autoSize == "right") {
				//txt.x=- int(txt.width);
			} else if (txt.autoSize == "center") {
				//txt.x=- int(txt.width*0.5);
			}
		}
	}
}