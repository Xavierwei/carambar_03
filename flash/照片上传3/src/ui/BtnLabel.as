package ui{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import akdcl.events.UIEvent;
	
	public class BtnLabel extends Btn {
		public var txt:*;
		public var bar:*;
		public var endClip:*;
		
		protected var widthAdd:int;
		protected var heightAdd:int;
		protected var xOff:int;
		protected var yOff:int;
		
		protected var __widthMax:uint;
		[Inspectable(defaultValue=0,type="int",name="0_固定宽")]
		public function set widthMax(_widthMax:uint):void {
			if (_widthMax==0) {
				return;
			}
			__widthMax = _widthMax;
			onUpdateStyle();
		}
		
		/*
		protected var __heightMax:int;
		[Inspectable(defaultValue=0,type="int",name="0_固定高")]
		public function set heightMax(_heightMax:int):void {
			__heightMax = _heightMax;
			onUpdateStyle();
		}
		*/
		[Inspectable(enumeration="left,right,center",defaultValue="left",type="String",name="1_对齐")]
		public function set autoSize(_autoSize:String):void {
			txt.autoSize = _autoSize;
			onUpdateStyle();
		}
		private var __label:String;
		public function get label():String {
			return __label;
		}
		[Inspectable(defaultValue="label",type="String",name="2_文本")]
		public function set label(_label:String):void {
			if (__label!=_label) {
				__label=_label;
				txt.text=__label;
				onUpdateStyle();
			}
		}
		override protected function init():void {
			super.init();
			if (bar) {
				xOff = int(bar.x - txt.x);
				yOff = int(bar.y - txt.y);
			}
			widthAdd = -xOff * 2;
			heightAdd = -yOff * 2;
			addEventListener(UIEvent.UPDATE_STYLE, onUpdateStyle);
		}
		override protected function onRemoveHandler():void {
			super.onRemoveHandler();
			txt = null;
			bar = null;
			endClip = null;
		}

		protected function onUpdateStyle(_e:UIEvent = null):void {
			if (totalFrames > 8 || !bar) {
				if (txt && !(txt is TextField)) {
					if (txt.autoSize == TextFieldAutoSize.RIGHT) {
						txt.txt.x = -int(txt.txt.width);
					} else if (txt.autoSize == TextFieldAutoSize.CENTER) {
						txt.txt.x = -int(txt.txt.width * 0.5);
					} else {
						txt.txt.x = 0;
					}
				}
			}else if (bar){
				if (txt.width + widthAdd < __widthMax && txt.width + widthAdd * 0.25 < __widthMax) {
					bar.width = int(__widthMax);
				}else {
					bar.width = int(txt.width + widthAdd);
				}
				if (txt.autoSize == TextFieldAutoSize.RIGHT) {
					bar.x = -bar.width;
					txt.txt.x = int((txt.width - bar.width) * 0.5 - txt.width) - txt.x;
				} else if (txt.autoSize == TextFieldAutoSize.CENTER) {
					bar.x = -int(bar.width * 0.5);
					txt.txt.x = -int(txt.width * 0.5) - txt.x;
				} else {
					bar.x = 0;
					txt.txt.x = -int((txt.width - bar.width) * 0.5) - txt.x;
				}
				bar.y = 0;
				txt.txt.y = bar.y - yOff - txt.y;
			}
			if (endClip) {
				endClip.x = txt.x + txt.txt.x + txt.width;
				endClip.mouseEnabled = false;
				endClip.mouseChildren = false;
			}
		}
	}
}