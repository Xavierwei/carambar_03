package akdcl.layout {
	import flash.events.Event;

	import akdcl.events.UIEventDispatcher;

	/**
	 * ...
	 * @author ...
	 */

	/// @eventType	flash.events.Event.RESIZE
	[Event(name="resize",type="flash.events.Event")]

	/// @eventType	flash.events.Event.SCROLL
	[Event(name="scroll",type="flash.events.Event")]
	public class Rect extends UIEventDispatcher {
		internal var isAverageWidth:Boolean;
		internal var isAverageHeight:Boolean;

		internal var __x:Number;
		internal var __y:Number;
		internal var __width:Number;
		internal var __height:Number;
		//alignX,alignY 0~1
		internal var __alignX:Number;
		internal var __alignY:Number;

		internal var percentWidth:Number;
		internal var percentHeight:Number;

		private var eventResize:Event;
		private var eventScroll:Event;

		public var autoUpdate:Boolean;
		public var border:int;
		public var roundWH:Boolean;

		public function get x():Number {
			return __x;
		}

		public function set x(_value:Number):void {
			if (__x == _value){
				return;
			}
			__x = _value;
			if (autoUpdate){
				updatePoint(true);
			}
		}

		public function get y():Number {
			return __y;
		}

		public function set y(_value:Number):void {
			if (__y == _value){
				return;
			}
			__y = _value;
			if (autoUpdate){
				updatePoint(true);
			}
		}

		public function get width():Number {
			return __width;
		}

		public function set width(_value:Number):void {
			if (_value < 0) {
				_value = 0;
			}
			if (__width == _value){
				return;
			}
			__width = _value;
			if (autoUpdate){
				updateSize(true);
			}
		}

		public function get height():Number {
			return __height;
		}

		public function set height(_value:Number):void {
			if (_value < 0) {
				_value = 0;
			}
			if (__height == _value){
				return;
			}
			__height = _value;
			if (autoUpdate){
				updateSize(true);
			}
		}

		public function get alignX():Number {
			return __alignX;
		}

		public function set alignX(_value:Number):void {
			if (__alignX == _value){
				return;
			}
			__alignX = _value;
			if (autoUpdate){
				updatePoint(true);
			}
		}

		public function get alignY():Number {
			return __alignY;
		}

		public function set alignY(_value:Number):void {
			if (__alignY == _value){
				return;
			}
			__alignY = _value;
			if (autoUpdate){
				updatePoint(true);
			}
		}

		public function Rect(_x:Number, _y:Number, _width:Number, _height:Number, _alignX:Number = 0, _alignY:Number = 0):void {
			__x = _x;
			__y = _y;
			if (_width > 1) {
				__width = _width;
				percentWidth = 0;
			} else {
				percentWidth = _width;
				//?
				__width = 0;
			}
			if (_height > 1){
				__height = _height;
				percentHeight = 0;
			} else {
				percentHeight = _height;
				//?
				__height = 0;
			}
			__alignX = _alignX;
			__alignY = _alignY;
			super();
		}

		override protected function init():void {
			super.init();
			border = 0;
			autoUpdate = true;
			isAverageWidth = !Boolean(__width) && !Boolean(percentWidth);
			isAverageHeight = !Boolean(__height) && !Boolean(percentHeight);
			eventResize = new Event(Event.RESIZE);
			eventScroll = new Event(Event.SCROLL);
		}

		override protected function onRemoveHandler():void {
			super.onRemoveHandler();
			eventResize = null;
			eventScroll = null;
		}

		public function setPoint(_x:Number, _y:Number, _dispathEvent:Boolean = true):void {
			if (__x == _x && __y == _y){
				return;
			}
			__x = Math.round(_x);
			__y = Math.round(_y);
			if (autoUpdate){
				updatePoint(_dispathEvent);
			}
		}

		public function setSize(_width:Number, _height:Number, _dispathEvent:Boolean = true):void {
			if (__width == _width && __height == _height){
				return;
			}
			__width = Math.round(_width);
			__height = Math.round(_height);
			if (autoUpdate){
				updateSize(_dispathEvent);
			}
		}

		public function update(_dispathEvent:Boolean = true):void {
			updatePoint(_dispathEvent);
			updateSize(_dispathEvent);
		}

		protected function updatePoint(_dispathEvent:Boolean = true):void {
			if (_dispathEvent && hasEventListener(Event.SCROLL)){
				dispatchEvent(eventScroll);
			}
		}

		protected function updateSize(_dispathEvent:Boolean = true):void {
			if (_dispathEvent && hasEventListener(Event.RESIZE)){
				dispatchEvent(eventResize);
			}
		}

		override public function toString():String {
			var _str:String = "name:" + name + ", "
			+ "x:" + x + ", "
			+ "y:" + y + ", "
			+ "width:" + width + ", "
			+ "height:" + height + "\n";
			return _str;
		}
	}

}