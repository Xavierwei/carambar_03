package ui.transformTool
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	import flash.geom.Point;
	internal class ContainPointClass 
	{
		private var _math:MathClass;
		
		public function ContainPointClass() 
		{
			_math = new MathClass();
		}
		public function IsInRect($testpoint:Point, $point:Point, $w:Number, $h:Number):Boolean
		{
			var $_min_x:Number = $point.x - $w ;
			var $_max_x:Number = $point.x + $w ;
			var $_min_y:Number = $point.y - $h ;
			var $_max_y:Number = $point.y + $h ;
			
			if ( $testpoint.x < $_min_x || $testpoint.x > $_max_x || $testpoint.y < $_min_y || $testpoint.y > $_max_y )
			{
				return false;
			}
			return true;
		}
		public function IsInBouds($testpoint:Point, $point_arr:Array):Boolean
		{
			//-------------------
			//   0   1
			//   2   3
			//-------------------
			
			var $_p0:Point = $point_arr[0];
			var $_p1:Point = $point_arr[1];
			var $_p2:Point = $point_arr[2];
			var $_p3:Point = $point_arr[3];
			
			var $_angle0:Number = _math.GetAngle($_p0, $_p1);
			var $_angle1:Number = _math.GetAngle($_p0, $_p2);
			
			var $_cp0:Point = _math.GetCrossPoint( $testpoint, $_angle0, $_p0, $_angle1 );
			var $_cp1:Point = _math.GetCrossPoint( $testpoint, $_angle0, $_p1, $_angle1 );
			var $_cp2:Point = _math.GetCrossPoint( $testpoint, $_angle1, $_p0, $_angle0 );
			var $_cp3:Point = _math.GetCrossPoint( $testpoint, $_angle1, $_p2, $_angle0 );
			
			var $_pos0:Number = _math.GetPos($_p0, $_p1);
			var $_pos1:Number = _math.GetPos($_p0, $_p2);
			
			var $_s0:Number = _math.GetPos($testpoint, $_cp0);
			var $_s1:Number = _math.GetPos($testpoint, $_cp1);
			var $_s2:Number = _math.GetPos($testpoint, $_cp2);
			var $_s3:Number = _math.GetPos($testpoint, $_cp3);
			
			if ($_s0>$_pos0 || $_s1>$_pos0 || $_s2>$_pos1 || $_s3>$_pos1) 
			{
				return false;
			}
			return true;
		}
	}
}