package ui {
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import akdcl.manager.ButtonManager;
	import akdcl.events.UIEvent;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Slider extends ProgressBar {
		private static const bM:ButtonManager = ButtonManager.getInstance();
		public var rollOver:Function;
		public var rollOut:Function;
		public var press:Function;
		public var release:Function;

		public var mouseWheelEnabled:Boolean = true;
		protected var timeHolded:uint;
		protected var scale:Number;
		
		private var mouseOffX:Number = 0;

		protected var __maximum:Number = 100;
		public function get maximum():Number {
			return __maximum;
		}
		public function set maximum(_maximum:Number):void {
			__maximum = _maximum;
			setStyle();
		}
		
		protected var __minimum:Number = 0;
		public function get minimum():Number {
			return __minimum;
		}
		public function set minimum(_minimum:Number):void {
			__minimum = _minimum;
			setStyle();
		}
		
		protected var __snapInterval:Number = 1;
		public function get snapInterval():Number {
			return __snapInterval;
		}
		public function set snapInterval(_snapInterval:Number):void {
			__snapInterval = _snapInterval;
			setStyle();
		}

		public function get isHold():Boolean {
			return timeHolded > 0;
		}
		
		override protected function init():void {
			super.init();
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
			addEventListener(UIEvent.PRESS, onPressHandler);
			addEventListener(UIEvent.RELEASE, onReleaseHandler);
			addEventListener(UIEvent.RELEASE_OUTSIDE, onReleaseHandler);
			addEventListener(UIEvent.UPDATE_STYLE, onUpdateStyle);
			bM.addButton(this);
			buttonMode = true;
			if (txt){
				txt.mouseEnabled = false;
				mouseEnabled = false;
			}else {
				mouseChildren = false;
			}
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			bM.removeButton(this);
			rollOver = null;
			rollOut = null;
			press = null;
			release = null;
		}

		protected function onUpdateStyle(_e:UIEvent):void {
			if (_e.isActive){
				bM.setButtonClipPlay(thumb, true);
				bM.setButtonClipPlay(maskClip, true);
				bM.setButtonClipPlay(bar, true);
				bM.setButtonClipPlay(track, true);
			} else {
				bM.setButtonClipPlay(thumb, false);
				bM.setButtonClipPlay(maskClip, false);
				bM.setButtonClipPlay(bar, false);
				bM.setButtonClipPlay(track, false);
			}
		}

		protected function onPressHandler(_e:UIEvent):void {
			if (thumb && thumb.getRect(thumb).contains(thumb.mouseX, 0)) {
				mouseOffX = thumb.mouseX;
			}else {
				mouseOffX = 0;
			}
			timeHolded = 1;
			onHoldingHandler(null);
			addEventListener(Event.ENTER_FRAME, onHoldingHandler);
		}
		
		protected function onReleaseHandler(_e:UIEvent):void {
			timeHolded = 0;
			removeEventListener(Event.ENTER_FRAME, onHoldingHandler);
		}

		protected function onMouseWheelHandler(_e:MouseEvent):void {
			if (mouseWheelEnabled && timeHolded == 0){
				value += (_e.delta > 0 ? 10 : -10) * __snapInterval;
			}
		}

		protected function onHoldingHandler(_evt:Event):void {
			if (bar){
				value = Math.round((mouseX - bar.x + offXThumb) / scale / __snapInterval) * __snapInterval + __minimum;
			} else {
				value = Math.round((mouseX - mouseOffX) / scale / __snapInterval) * __snapInterval + __minimum;
			}
			timeHolded++;
		}

		override protected function formatValue(_value:Number):Number {
			if (isNaN(_value)){
				_value = 0;
			}
			if (_value < __minimum){
				_value = __minimum;
			} else if (_value > __maximum){
				_value = __maximum;
			}
			return _value;
		}

		override protected function getClipsValue():Number {
			scale = __length / (__maximum - __minimum);
			return (__value - __minimum) * scale;
		}
		
		override protected function defaultLabelFunction(_value:Number):String {
			return Math.round(__value)+"";
		}
	}
}