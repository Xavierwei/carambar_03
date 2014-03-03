package akdcl.layout {
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;

	/**
	 * ...
	 * @author ...
	 */

	/// @eventType	flash.events.Event.CHANGE
	[Event(name="change",type="flash.events.Event")]
	public class Display extends Rect {
		private var content:Object;
		private var eventChange:Event;

		private var scaleWidth:Number = 0;
		private var scaleHeight:Number = 0;
		private var aspectRatio:Number = 1;
		private var originalWidth:Number = 0;
		private var originalHeight:Number = 0;
		private var scaleX:Number;
		private var scaleY:Number;

		private var __scrollX:Number;
		private var __scrollY:Number;
		//-1:outside,0:noscale,1:inside;
		//>1||<-1:scale
		//NaN:stretch,10:onlywidth,-10:onlyheight;
		//11:onlywidth and ratio,-11:onlyheight and ratio;
		private var __scaleMode:Number;

		override public function get width():Number {
			if (__scaleMode == -11 || __scaleMode == -10) {
				return scaleWidth + border * 2;
			}
			return __width;
		}

		override public function get height():Number {
			if (__scaleMode == 11 || __scaleMode == 10) {
				return scaleHeight + border * 2;
			}
			return __height;
		}

		public function get scrollX():Number {
			return __scrollX;
		}

		public function set scrollX(_value:Number):void {
			if (_value < -scaleWidth){
				_value = -scaleWidth;
			} else if (_value > __width){
				_value = __width;
			}
			if (__width <= scaleWidth){
				if (_value < __width - scaleWidth){
					_value = (_value + __width - scaleWidth) * 0.5;
				} else if (_value < 0){
					_value = _value;
				} else {
					_value = _value * 0.5;
				}
			} else {
				if (_value < 0){
					_value = _value * 0.5;
				} else if (_value < __width - scaleWidth){
					_value = _value;
				} else {
					_value = (_value + __width - scaleWidth) * 0.5;
				}
			}
			__scrollX = _value;
			__alignX = __scrollX / (__width - scaleWidth);
			if (isNaN(__alignX)) {
				__alignX = 0;
			}
			if (autoUpdate){
				updatePoint(true);
			}
		}

		public function get scrollY():Number {
			return __scrollY;
		}

		public function set scrollY(_value:Number):void {
			if (_value < -scaleHeight){
				_value = -scaleHeight;
			} else if (_value > __height){
				_value = __height;
			}
			if (__height <= scaleHeight){
				if (_value < __height - scaleHeight){
					_value = (_value + __height - scaleHeight) * 0.5;
				} else if (_value < 0){
					_value = _value;
				} else {
					_value = _value * 0.5;
				}
			} else {
				if (_value < 0){
					_value = _value * 0.5;
				} else if (_value < __height - scaleHeight){
					_value = _value;
				} else {
					_value = (_value + __height - scaleHeight) * 0.5;
				}
			}
			__scrollY = _value;
			__alignY = __scrollY / (__height - scaleHeight);
			if (isNaN(__alignY)) {
				__alignY = 0;
			}
			if (autoUpdate){
				updatePoint(true);
			}
		}

		public function get scaleMode():Number {
			return __scaleMode;
		}

		public function set scaleMode(_value:Number):void {
			if (__scaleMode == _value){
				return;
			}
			__scaleMode = _value;
			if (autoUpdate){
				//未改变__width, __height不需要发出事件
				updateSize(false);
			}
		}

		public function Display(_x:Number, _y:Number, _width:Number, _height:Number, _alignX:Number = 0, _alignY:Number = 0, _scaleMode:Number = NaN):void {
			__scaleMode = _scaleMode;
			super(_x, _y, _width, _height, _alignX, _alignY);
		}

		override protected function init():void {
			super.init();
			name = "display";
			__scrollX = 0;
			__scrollY = 0;
			eventChange = new Event(Event.CHANGE);
		}

		override protected function onRemoveHandler():void {
			super.onRemoveHandler();
			content = null;
			eventChange = null;
		}

		public function setContent(_content:Object, _alignX:Number = NaN, _alignY:Number = NaN, _scaleMode:Number = NaN):void {
			if (!_content) {
				content = null;
				return;
			}
			if (_alignX) {
				__alignX = _alignX;
			}
			if (_alignY) {
				__alignY = _alignY;
			}
			if (!isNaN(_scaleMode)) {
				__scaleMode = _scaleMode;
			}
			content = _content;
			if (content is Loader){
				originalWidth = content.contentLoaderInfo.width;
				originalHeight = content.contentLoaderInfo.height;
			} else if (content is DisplayObject){
				originalWidth = content.width / content.scaleX;
				originalHeight = content.height / content.scaleY;
			} else {
				originalWidth = content.width;
				originalHeight = content.height;
			}
			aspectRatio = originalWidth / originalHeight;
			//未改变__width, __height不需要发出事件?
			updateSize(__scaleMode == 11 || __scaleMode == -11 || __scaleMode == 10 || __scaleMode == -10);
			if (hasEventListener(Event.CHANGE)){
				dispatchEvent(eventChange);
			}
		}

		public function getScaleWidth():int {
			return scaleWidth;
		}

		public function getScaleHeight():int {
			return scaleHeight;
		}

		public function getOriginalWidth():int {
			return originalWidth;
		}

		public function getOriginalHeight():int {
			return originalHeight;
		}

		override protected function updatePoint(_dispathEvent:Boolean = true):void {
			__scrollX = (__width - scaleWidth) * __alignX - (__alignX * 2 - 1) * border;
			__scrollY = (__height - scaleHeight) * __alignY - (__alignY * 2 - 1) * border;
			if (content){
				content.x = __x + __scrollX;
				content.y = __y + __scrollY;
			}
			super.updatePoint(_dispathEvent);
		}

		override protected function updateSize(_dispathEvent:Boolean = true):void {
			var _scaleABS:Number = Math.abs(__scaleMode);
			var _width:Number = __width - border * 2;
			var _height:Number = __height - border * 2;
			if (isNaN(_scaleABS)){
				scaleX = _width / originalWidth;
				scaleY = _height / originalHeight;

				scaleWidth = _width;
				scaleHeight = _height;
			} else if (_scaleABS == 10){
				if (__scaleMode > 0){
					scaleX = _width / originalWidth;

					scaleWidth = _width;
					scaleHeight = originalHeight;
				} else {
					scaleY = _height / originalHeight;

					scaleHeight = _height;
					scaleWidth = originalWidth;
				}
			} else if (_scaleABS == 11){
				if (__scaleMode > 0){
					scaleY = scaleX = _width / originalWidth;

					scaleWidth = _width;
					scaleHeight = originalHeight * scaleX;
				} else {
					scaleX = scaleY = _height / originalHeight;

					scaleHeight = _height;
					scaleWidth = originalWidth * scaleY;
				}
				//trace(scaleWidth, scaleHeight, originalWidth, originalHeight);
			} else {
				var _scale:Number;
				if (__scaleMode < 0 ? (_width / _height > aspectRatio) : (_width / _height < aspectRatio)){
					_scale = _width / originalWidth;
					//scaleWidth = _width;
				} else {
					_scale = _height / originalHeight;
					//scaleWidth = _width;
				}
				if (_scaleABS <= 1){
					_scale = 1 + (_scale - 1) * _scaleABS;
				} else {
					_scale = (1 + (_scale - 1)) * _scaleABS;
				}
				scaleY = scaleX = _scale;

				scaleWidth = originalWidth * scaleX;
				scaleHeight = originalHeight * scaleY;
			}

			if (content){
				if (content is Loader){
					content.scaleX = scaleX;
					content.scaleY = scaleY;
				} else {
					if (roundWH) {
						content.width = Math.round(scaleWidth);
						content.height = Math.round(scaleHeight);
					}else {
						content.width = scaleWidth;
						content.height = scaleHeight;
					}
				}
			}
			updatePoint(_dispathEvent);
			super.updateSize(_dispathEvent);
		}
	}
}