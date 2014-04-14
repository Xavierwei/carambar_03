package akdcl.utils
{
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	
	import akdcl.math.Vector2D;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class HitTest
	{
		public static var hitPoint:Vector2D = new Vector2D();
		public static var hitTest:Function = hitTestPoint;
		//hitTestPoint需要global
		//getPixel32需要bitmapData容器的local坐标
		public static function hitTestPoint(_x:Number, _y:Number, _display:DisplayObject):Boolean {
			return _display.hitTestPoint(_x, _y, true);
		}
		public static function hitTestPixel(_x:Number, _y:Number, _display:BitmapData):Boolean {
			return _display.getPixel32(_x, _y) >>> 8 != 0;
		}
		
		//x0,y0开始为没有撞倒的点
		public static function hitTestCross(_x0:Number, _y0:Number, _xt:Number, _yt:Number, _display:Object, _minStep:Number = 1):Boolean {
			var _isHit:Boolean = false;
			var _x:Number;
			var _y:Number;
			var _i:int = 0;
			
			if (hitTest(_x0, _y0, _display)) {
				//应该反向查找
				hitPoint.x = _x0;
				hitPoint.y = _y0;
				return true;
			}
			
			if (hitTest(_xt, _yt, _display)) {
				//初始点未碰撞，而目标点碰撞，则采用二分法
				//仍有穿透障碍物的可能
				while (sideMax(_x0, _y0, _xt, _yt) > _minStep && _i++ < 50){
					_x = (_x0 + _xt) * 0.5;
					_y = (_y0 + _yt) * 0.5;
					if (hitTest(_x, _y, _display)) {
						_isHit = true;
						_xt = _x;
						_yt = _y;
					} else {
						_x0 = _x;
						_y0 = _y;
					}
				}
			}else {
				//逼近检测
				var _dis:Number = int(distance(_x0, _y0, _xt, _yt));
				_x = (_xt - _x0) / _dis * _minStep;
				_y = (_yt - _y0) / _dis * _minStep;
				while (_i++ < _dis) {
					_isHit = hitTest(_x0 + _x, _y0 + _y, _display);
					if (_isHit) {
						break;
					}
					_x0 += _x;
					_y0 += _y;
				}
			}
			
			if (_isHit) {
				hitPoint.x = _x0;
				hitPoint.y = _y0;
			}
			return _isHit;
		}
		
		//获得hitTest点的切面弧度，未碰撞返回NaN
		public static function hitTestRadian(_x0:Number, _y0:Number, _xt:Number, _yt:Number, _display:Object, _radius:uint = 10):Number {
			var _isHit:Boolean;
			_isHit = hitTestCross(_x0, _y0, _xt, _yt, _display);
			if (_isHit) {
				var _hitX:Number = hitPoint.x;
				var _hitY:Number = hitPoint.y;
				
				var _dX:Number = _xt - _x0;
				var _dY:Number = _yt - _y0;
				var _radian:Number = Math.atan2(_dY, _dX);
				
				_dX = Math.cos(_radian) * _radius;
				_dY = Math.sin(_radian) * _radius;
				
				var _rX:Number;
				var _rY:Number;
				var _lX:Number;
				var _lY:Number;
				if (!hitTestCross(_hitX - _dX, _hitY - _dY, _hitX + _dY, _hitY - _dX, _display)) {
					hitTestCross(_hitX + _dY, _hitY - _dX, _hitX + _dX, _hitY + _dY, _display);
				}
				_rX = hitPoint.x;
				_rY = hitPoint.y;
				if (!hitTestCross(_hitX - _dX, _hitY - _dY, _hitX - _dY, _hitY + _dX, _display)) {
					hitTestCross(_hitX - _dY, _hitY + _dX, _hitX + _dX, _hitY + _dY, _display);
				}
				_lX = hitPoint.x;
				_lY = hitPoint.y;
				
				hitPoint.x = _hitX;
				hitPoint.y = _hitY;
				return Math.atan2(_rY - _lY, _rX - _lX);
			}
			return NaN;
		}

		//返回矩形区域最大正边长
		private static function sideMax(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			var _dX:Number = _xt - _x0;
			var _dY:Number = _yt - _y0;
			if (_dX < 0) {
				_dX = -_dX;
			}
			if (_dY < 0) {
				_dY = -_dY;
			}
			return _dX > _dY?_dX:_dY;
		}

		private static function distance(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			var _dX:Number = _xt - _x0;
			var _dY:Number = _yt - _y0;
			return Math.sqrt(_dX * _dX + _dY * _dY);
		}
	}
	
}