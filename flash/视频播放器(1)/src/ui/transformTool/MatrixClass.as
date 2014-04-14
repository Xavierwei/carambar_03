package ui.transformTool
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	internal class MatrixClass 
	{
		private var _math:MathClass;
		public function MatrixClass():void
		{
			_math = new MathClass();
		}
		public function GetMatrix($obj:DisplayObject, $midPoint:Point=null):Object
		{
			
			var $_bounds:Object=$obj.getBounds($obj);
			var $_arr_point:Array = new Array();
			
			var $_w:Number;
			var $_h:Number;
			
			var $_i:uint = 0;
			var $_j:uint = 0;
			
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			
			for ($_i = 0; $_i < 3; $_i++)
			{
				$_w = $_bounds.width * $_i * 0.5;
				
				for ($_j = 0; $_j < 3; $_j++)
				{
					$_h = $_bounds.height * $_j * 0.5;
					var $_tmp_point:Point = new Point($_bounds.x + $_w, $_bounds.y + $_h);
					$_tmp_point = ($obj.parent).globalToLocal( $obj.localToGlobal($_tmp_point));
					
					$_arr_point.push($_tmp_point);
					
				}
			}
			if ($midPoint != null)
			{
				$_tmp_point = ($obj.parent).globalToLocal( $obj.localToGlobal($midPoint));
				$_arr_point[4] = $_tmp_point;
			}
			
			var $_scalex:Number = _math.GetPos( $_arr_point[0],$_arr_point[6] )/ $_bounds.width;
			var $_scaley:Number = _math.GetPos( $_arr_point[0],$_arr_point[2] )/ $_bounds.height;
			var $_skewx:Number  = _math.GetAngle( $_arr_point[0],$_arr_point[2] )-90;
			var $_skewy:Number  = _math.GetAngle( $_arr_point[0],$_arr_point[6] );
			
			var $_reObject:Object = 
			{
				array : $_arr_point,
				w : $_bounds.width,
				h : $_bounds.height,
				tx : $obj.x,
				ty : $obj.y,
				scalex : $_scalex,
				scaley : $_scaley,
				skewx : $_skewx,
				skewy : $_skewy
			}
			return $_reObject;
		}
		public function SetMidPoint($obj:DisplayObject, $internalPoint:Point, $externalPoint:Point):void 
		{
			var $_p1:Point =  ($obj.parent).localToGlobal($externalPoint);
			var $_p2:Point =  $obj.localToGlobal( $internalPoint );
			$obj.x = $obj.x +($_p1.x - $_p2.x);
			$obj.y = $obj.y +($_p1.y - $_p2.y);
		}
		public function SetMatrix($obj:DisplayObject, $tx:Number=NaN, $ty:Number=NaN, $scalex:Number=NaN, $scaley:Number=NaN, $skewx:Number=NaN, $skewy:Number=NaN):void
		{
			var $_transform:Transform = $obj.transform;
			var $_newMatrix:Object = GetMatrix($obj);
			var $_skewMatrix:Matrix = new Matrix();
			
			isNaN($tx) && ($tx = $_newMatrix.tx);
			isNaN($ty) && ($ty = $_newMatrix.ty);
			isNaN($scalex) && ($scalex = $_newMatrix.scalex);
			isNaN($scaley) && ($scaley = $_newMatrix.scaley);
			isNaN($skewx ) && ($skewx = $_newMatrix.skewx);
			isNaN($skewy ) && ($skewy = $_newMatrix.skewy);
			
			$_skewMatrix.a = Math.cos($skewy*Math.PI/180) * $scalex;
			$_skewMatrix.d = Math.cos($skewx*Math.PI/180) * $scaley;
			$_skewMatrix.b = Math.tan($skewy*Math.PI/180) * $_skewMatrix.a;
			$_skewMatrix.c = Math.tan($skewx * Math.PI / 180) * $_skewMatrix.d * -1;
			$_skewMatrix.tx = $tx;
			$_skewMatrix.ty = $ty;
			
			$_transform.matrix = $_skewMatrix;
		}
	}
	
}