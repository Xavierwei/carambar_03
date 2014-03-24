package akdcl.math {
	import flash.display.Graphics;
	import flash.geom.Point;

	/**
	 * A basic 2-dimensional vector class.
	 */
	public class Vector2D extends Point {
		protected static var vectorTemp_0:Vector2D = new Vector2D();
		protected static var vectorTemp_1:Vector2D = new Vector2D();

		public static function isPointOnRightSide(_pt:Vector2D, _p0:Vector2D, _p1:Vector2D):Boolean {
			vectorTemp_0.copy(_pt);
			vectorTemp_1.copy(_p1);
			var _crossProduct:Number = vectorTemp_0.subtractTo(_p0).crossProd(vectorTemp_1.subtractTo(_p0));
			return _crossProduct > 0;
		}

		/**
		 * Calculates the radian between two vectors.
		 * @param v1 The first Vector2D instance.
		 * @param v2 The second Vector2D instance.
		 * @return Number the radian between the two given vectors.
		 */
		public static function radianBetween(v1:Vector2D, v2:Vector2D):Number {
			/*if (!v1.isNormalized()){
				v1 = v1.clone().normalize(1);
			}
			if (!v2.isNormalized()){
				v2 = v2.clone().normalize(1);
			}*/
			return Math.acos(v1.dotProd(v2));
		}
		
		public function set length(_value:Number):void {
			var _a:Number = radian;
			x = Math.cos(_a) * _value;
			y = Math.sin(_a) * _value;
		}
		
		public function Vector2D(_x:Number = 0, _y:Number = 0){
			x = _x;
			y = _y;
		}
		
		public function setPosition(_x:Number = 0, _y:Number = 0){
			x = _x;
			y = _y;
		}

		/**
		 * Can be used to visualize the vector. Generally used for debug purposes only.
		 * @param graphics The Graphics instance to draw the vector on.
		 * @param color The color of the line used to represent the vector.
		 */
		public function draw(_graphics:Graphics, color:uint = 0):void {
			_graphics.lineStyle(0, color);
			_graphics.moveTo(0, 0);
			_graphics.lineTo(x, y);
		}

		public function copy(_v2:Vector2D):Vector2D {
			x = _v2.x;
			y = _v2.y;
			return this;
		}
		
		override public function clone():flash.geom.Point 
		{
			return new Vector2D(x, y);
		}

		/**
		 * Sets this vector's x and y values, and thus length, to zero.
		 * @return Vector2D A reference to this vector.
		 */
		public function zero():Vector2D {
			x = 0;
			y = 0;
			return this;
		}

		/**
		 * Whether or not this vector is equal to zero, i.e. its x, y, and length are zero.
		 * @return Boolean True if vector is zero, otherwise false.
		 */
		public function isZero():Boolean {
			return x == 0 && y == 0;
		}


		/**
		 * Gets / sets the radian of this vector. Changing the radian changes the x and y but retains the same length.   */
		public function set radian(value:Number):void {
			var len:Number = length;
			x = Math.cos(value) * len;
			y = Math.sin(value) * len;
		}

		public function get radian():Number {
			return Math.atan2(y, x);
		}

		/**
		 * Ensures the length of the vector is no longer than the given value.
		 * @param max The maximum value this vector should be. If length is larger than max, it will be truncated to this value.
		 * @return Vector2D A reference to this vector.
		 */
		public function truncate(max:Number):Vector2D {
			length = Math.min(max, length);
			return this;
		}

		/**
		 * Reverses the direction of this vector.
		 * @return Vector2D A reference to this vector.
		 */
		public function reverse():Vector2D {
			x = -x;
			y = -y;
			return this;
		}

		/**
		 * Calculates the dot product of this vector and another given vector.
		 * @param v2 Another Vector2D instance.
		 * @return Number The dot product of this vector and the one passed in as a parameter.
		 */
		public function dotProd(v2:Vector2D):Number {
			return x * v2.x + y * v2.y;
		}

		/**
		 * Calculates the cross product of this vector and another given vector.
		 * @param v2 Another Vector2D instance.
		 * @return Number The cross product of this vector and the one passed in as a parameter.
		 */
		public function crossProd(v2:Vector2D):Number {
			return x * v2.y - y * v2.x;
		}

		public function isRight(_v2:Vector2D):Boolean {
			//是否在p的右边
			return crossProd(_v2) < 0;
		}

		/**
		 * Determines if a given vector is to the right or left of this vector.
		 * @return int If to the left, returns -1. If to the right, +1.
		 */
		public function sign(v2:Vector2D):int {
			return perp.dotProd(v2) < 0 ? -1 : 1;
		}

		/**
		 * Finds a vector that is perpendicular to this vector.
		 * @return Vector2D A vector that is perpendicular to this vector.
		 */
		public function get perp():Vector2D {
			return new Vector2D(-y, x);
		}

		/**
		 * Calculates the distance from this vector to another given vector.
		 * @param v2 A Vector2D instance.
		 * @return Number The distance from this vector to the vector passed as a parameter.
		 */
		public function dist(v2:Vector2D):Number {
			return Math.sqrt(distSQ(v2));
		}

		/**
		 * Calculates the distance squared from this vector to another given vector.
		 * @param v2 A Vector2D instance.
		 * @return Number The distance squared from this vector to the vector passed as a parameter.
		 */
		public function distSQ(v2:Vector2D):Number {
			var dx:Number = v2.x - x;
			var dy:Number = v2.y - y;
			return dx * dx + dy * dy;
		}

		public function addTo(v2:Vector2D):Vector2D {
			x += v2.x;
			y += v2.y;
			return this;
		}

		public function subtractTo(v2:Vector2D):Vector2D {
			x -= v2.x;
			y -= v2.y;
			return this;
		}

		/**
		 * Multiplies this vector by a value, creating a new Vector2D instance to hold the result.
		 * @param v2 A Vector2D instance.
		 * @return Vector2D A new vector containing the results of the multiplication.
		 */
		public function multiply(value:Number):Vector2D {
			x *= value;
			y *= value;
			return this;
		}

		/**
		 * Divides this vector by a value, creating a new Vector2D instance to hold the result.
		 * @param v2 A Vector2D instance.
		 * @return Vector2D A new vector containing the results of the division.
		 */
		public function divide(value:Number):Vector2D {
			x /= value;
			y /= value;
			return this;
		}
	}
}