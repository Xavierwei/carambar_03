package ui {
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	import akdcl.display.UISprite;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class TxtAutoRoll extends UISprite {
		public var txt:TextField;
		public var rollSpeed:Number = 1;

		public var isVertical:Boolean=true;

		private var __rollArea:Number = 100;

		private var rect:Rectangle;

		public function get rollArea():Number {
			return __rollArea;
		}

		public function set rollArea(_rollArea:Number):void {
			__rollArea = _rollArea;
			fixScrollRect();
		}

		private var __text:String;

		public function get text():String {
			return __text;
		}

		public function set text(_text:String):void {
			if (__text != _text){
				__text = _text;
				txt.htmlText = __text;
				txt.autoSize = TextFieldAutoSize.LEFT;
				if (isVertical){
					if (__text && txt.height > __rollArea){
						txt.y = __rollArea;
						fixScrollRect();
						addEventListener(Event.ENTER_FRAME, onRollingHandler);
					} else {
						txt.y = int((__rollArea - txt.height) * 0.5);
						removeEventListener(Event.ENTER_FRAME, onRollingHandler);
					}
				} else {
					if (__text && txt.width > __rollArea){
						txt.x = __rollArea;
						fixScrollRect();
						addEventListener(Event.ENTER_FRAME, onRollingHandler);
					} else {
						txt.x = int((__rollArea - txt.width) * 0.5);
						removeEventListener(Event.ENTER_FRAME, onRollingHandler);
					}
				}
			}
		}

		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			rect = new Rectangle();
			if (txt){
				if (isVertical){
					rollArea = txt.height;
				} else {
					rollArea = txt.width;
				}
			} else {
				txt = new TextField();
				addChild(txt);
				fixScrollRect();
			}
		}

		override protected function onRemoveHandler():void {
			super.onRemoveHandler();
			txt = null;
		}

		protected function fixScrollRect():void {
			if (isVertical){
				rect.width = txt.width;
				rect.height = __rollArea;
			} else {
				rect.width = __rollArea;
				rect.height = txt.height;
			}
			scrollRect = rect;

			if (isVertical){
				txt.multiline = true;
				txt.wordWrap = true;
			} else {
				txt.multiline = false;
				txt.wordWrap = false;
			}
		}

		protected function onRollingHandler(_evt:Event):void {
			if (isVertical){
				txt.y -= rollSpeed;
				if (txt.y + txt.height < 0){
					txt.y = __rollArea;
				}
			} else {
				txt.x -= rollSpeed;
				if (txt.x + txt.width < 0){
					txt.x = __rollArea;
				}
			}
		}
	}

}