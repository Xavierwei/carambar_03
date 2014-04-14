package ui.transformTool
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	import flash.geom.Point;
	internal class MathClass 
	{
		public function GetCrossPoint($target0:Point,$angle0:Number, $target1:Point,$angle1:Number):Point 
		{
			
			// var $target0:Point = new Point(0,0);
			// var $target1:Point = new Point(0,0);
			
			var $_k0:Number = 0;
			var $_k1:Number = 0;
			var $_x :Number = 0;
			var $_y :Number = 0;  
			
			var $_isExtra0:int = $angle0 % 180 == 0 ? 1 : $angle0 % 90 == 0 ? -1 : 0;
			var $_isExtra1:int = $angle1 % 180 == 0 ? 1 : $angle1 % 90 == 0 ? -1 : 0;
			
			($_isExtra0 ==  0) && ($_k0 =  Math.tan($angle0 * Math.PI / 180) );
			($_isExtra1 ==  0) && ($_k1 =  Math.tan($angle1 * Math.PI / 180) );
			
			var $_tmp_add:int = Math.abs($angle0) + Math.abs($angle1) ;
			if (  ($_tmp_add == 180 && $angle0*$angle1 < 0) || int($angle0) == int($angle1)) 
			{
				return null;
			}
			
			if (($_isExtra0 ==  0) && ($_isExtra1 ==  0)) 
			{
				
				$_x = (( $_k0 * $target0.x - $target0.y ) - ( $_k1 * $target1.x - $target1.y ) ) / ( $_k0 - $_k1 );
				$_y = (( $_k0 * $target1.y - $target1.x * $_k0* $_k1) - ( $_k1 * $target0.y - $target0.x * $_k0* $_k1) ) / ($_k0 - $_k1);
				
			}else if (($_isExtra0 ==  0) && ($_isExtra1 ==  1)) {
				
				$_y = $target1.y;
				$_x = ( $_y - $target0.y ) / $_k0  + $target0.x;
				
			}else if (($_isExtra0 ==  0) && ($_isExtra1 == -1)) {
				
				$_x = $target1.x;
				$_y = ( $_x - $target0.x ) * $_k0  + $target0.y;
				
			}else if (($_isExtra0 ==  1) && ($_isExtra1 ==  0)) {
				
				$_y = $target0.y;
				$_x = ( $_y - $target1.y ) / $_k1  + $target1.x;
				
			}else if (($_isExtra0 ==  1) && ($_isExtra1 ==  -1)) {
				
				$_y = $target0.y;
				$_x = $target1.x;
				
			}else if (($_isExtra0 == -1) && ($_isExtra1 ==  0)) {
				
				$_x = $target0.x;
				$_y = ( $_x - $target1.x ) * $_k1  + $target1.y;
				
			}else if (($_isExtra0 == -1) && ($_isExtra1 ==  1)) {
				
				$_x = $target0.x;
				$_y = $target1.y;
				
			}else {
				return null;	
			}
			
			return (new Point( int($_x*1000)/1000, int($_y*1000)/1000 ));
		}
		public function GetAngle($target0:Point, $target1:Point):Number 
		{
			if (!$target0 || !$target1)
			{
				return 0;
			}
			var $_tmp_x:Number = $target1.x - $target0.x;
			var $_tmp_y:Number = $target1.y - $target0.y;
			var $_tmp_angle:Number = Math.atan2( $_tmp_y, $_tmp_x ) * 180 / Math.PI;
		
			return $_tmp_angle;
		}
		public function GetPos($target0:Point, $target1:Point):Number 
		{
			
			if (!$target0 || !$target1)
			{
				return 0;
			}
			var $_tmp_s:Number = Point.distance($target0, $target1);
			return 	$_tmp_s;
		}
	}
}