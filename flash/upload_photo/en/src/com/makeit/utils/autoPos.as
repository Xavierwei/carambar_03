package com.makeit.utils {
	import flash.net.LocalConnection;
	/** ===============setDisplayPos==============
	 * h:水平相对位置   
	 * v:垂直相对位置
	 * l:离舞台左边距
	 * r:离舞台右边距
	 * t:离舞台上边距
	 * b:离舞台下边距
	 * global:全局坐标
	 * time:缓动时间
	 * display:相对display位置
	 */
	import com.greensock.*;

	import flash.display.*;
	import flash.utils.Dictionary;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class autoPos {
		private static var disPlayArr : Dictionary = new Dictionary(true);
		private static var _stage : Stage;
		private static var _time : Number;
		private static var _width : Number;
		private static var _height : Number;

		public function autoPos() {
		}

		public static function init($stage : Stage, $width : Number = 0, $height : Number = 0, $time : Number = 0) : void {
			_stage = $stage;
			_time = $time;
			_width = ($width == 0 ? _stage.stageWidth : $width);
			_height = ($height == 0 ? _stage.stageHeight : $height);
			_stage.align = "";
			try {
				_stage.addEventListener(Event.RESIZE, resizeHandler);
			} catch (e : Event) {
			}
		}

		private static function resizeHandler(e : Event = null) : void {
			var _x : Number = 0;
			var _y : Number = 0;

			for (var i:* in disPlayArr) {
				try {
					var display : DisplayObject = disPlayArr[i].target;
					var posObj : Object = disPlayArr[i].pos;

					_x = display.x;
					_y = display.y;
					if (posObj.display != undefined && posObj.x != undefined) {
						_x = posObj.display.x + posObj.x;
					} else if (posObj.h != undefined) {
						_x = _stage.stageWidth * posObj.h - (_stage.stageWidth - _width) / 2	;
					} else if (posObj.l != undefined) {
						_x = -(_stage.stageWidth - _width) / 2 + posObj.l;
					} else if (posObj.r != undefined) {
						_x = _width + (_stage.stageWidth - _width) / 2 - posObj.r;
					}
					if (posObj.display != undefined && posObj.y != undefined) {
						_y = posObj.display.y + posObj.y;
					} else if (posObj.v != undefined) {
						_y = _stage.stageHeight * posObj.v - (_stage.stageHeight - _height) / 2	;
					} else if (posObj.t != undefined) {
						_y = - (_stage.stageHeight - _height) / 2 + posObj.t;
					} else if (posObj.b != undefined) {
						_y = _height + (_stage.stageHeight - _height) / 2 - posObj.b;
					}
					if (posObj.global) {
						var point : Point = new Point(_x, _y);
						if (display.parent) {
							var newPoint : Point = MovieClip(display.parent).globalToLocal(point);
							_x = newPoint.x;
							_y = newPoint.y;
						}
					}
					if (posObj.time) {
						var timeX : Number = posObj.time;
						var timeY : Number = posObj.time;
					} else {
						if (posObj.timeX == undefined) {
							timeX = 0;
						} else {
							timeX = posObj.timeX;
						}
						if (posObj.timeY == undefined) {
							timeY = 0;
						} else {
							timeY = posObj.timeY;
						}
					}
					if (timeX != 0) {
						TweenLite.to(display, timeX, {x:_x, overwrite:0});
					} else {
						display.x = _x;
					}
					if (timeY != 0) {
						TweenLite.to(display, timeY, {y:_y, overwrite:0});
					} else {
						display.y = _y;
					}
				} catch (e : Error) {
					continue;
				}
			}
		}

		public static function setDisplayPos(display : DisplayObject, obj : Object) : void {
			//if (disPlayArr[display]) {
				
			//} else {
				disPlayArr[display] = {target:display, pos:obj};
				resizeHandler();
				display.addEventListener(Event.REMOVED_FROM_STAGE, removeDisplayToStage);
			//}

			// disPlayArr.push( { target:display, pos:obj } )
			//
		}
		
		public static function setRelative(display : DisplayObject, obj : Object) : void {
			var disH : Number = (_stage.width - display.width) / 2;
			var disV : Number = (_stage.height - display.height) / 2;
			var selfBounds : Rectangle = display.getBounds(_stage);

			var tempDisX : Number = disH - selfBounds.x;
			var tempDisY : Number = disV - selfBounds.y;
			display.x += tempDisX;
			display.y += tempDisY;

			var h : Number = display.x / _stage.stageWidth;
			var v : Number = display.y / _stage.stageHeight;
			obj.h = h;
			obj.v = v;
			setDisplayPos(display, obj);
		}

		private static function removeDisplayToStage(e : Event) : void {
			removeDisplay(e.currentTarget);
		}

		public static function removeDisplay(display : *) : Boolean {
			try {
				if (disPlayArr[display]) {
					display.removeEventListener(Event.REMOVED_FROM_STAGE, removeDisplayToStage);
					TweenLite.killTweensOf(display);
					disPlayArr[display] = null;
					delete disPlayArr[display];
					display=null;
					try {
						new LocalConnection().connect('foo');
						new LocalConnection().connect('foo');
					} catch (e : *) {
					}
					return true;
				}
			} catch (e : Error) {
			}
			
			return false;
		}

		public static function removeResizeEvent() : void {
			_stage.removeEventListener(Event.RESIZE, resizeHandler);
		}
	}
}