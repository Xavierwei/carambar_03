package ui.transformTool
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	internal class ShapeClass extends Shape
	{
		private var _shape:Shape;
		public function ShapeClass():void
		{
			_shape = this;
			_shape.graphics.clear();
		}
		public function Clear():void {
			_shape.graphics.clear();
		}
		public function CreateRect( $x:Number, $y:Number, $w:Number, $h:Number, $col:uint = 0x0 ,$borderAlpha:Number=1, $borderSize:Number=1,  $borderColor:uint=0xffffff ):void 
		{
			_shape.graphics.lineStyle($borderSize, $borderColor,$borderAlpha);
			_shape.graphics.beginFill($col);
			_shape.graphics.drawRect($x, $y, $w, $h);
			_shape.graphics.endFill();
		}
		public function CreateRoundRect( $x:Number, $y:Number, $w:Number, $h:Number, $r:Number, $col:uint = 0x0, $borderSize:Number=1,  $borderColor:uint=0x0 ):void 
		{
			_shape.graphics.lineStyle($borderSize, $borderColor);
			_shape.graphics.beginFill($col);
			_shape.graphics.drawRoundRect($x, $y, $w, $h, $r);
			_shape.graphics.endFill();
		}
		public function CreateCircle( $x:Number, $y:Number, $r:Number, $col:uint = 0x0, $borderSize:Number=1,  $borderColor:uint=0x0 ):void 
		{
			_shape.graphics.lineStyle($borderSize, $borderColor);
			_shape.graphics.beginFill($col);
			_shape.graphics.drawCircle($x, $y, $r);
			_shape.graphics.endFill();
		}
		public function CreatCustomShap($array_point:Array, $bgColor:uint = 0x0, $bgApaha:Number = 1, $borderSize:Number = 1,  $borderColor:uint = 0x0, $borderApaha:Number=1 ):void 
		{
			var $_len:int = $array_point.length;
			if ($_len < 1 )
			{
				return;
			}
			
			_shape.graphics.lineStyle($borderSize, $borderColor,$borderApaha);
			_shape.graphics.beginFill($bgColor, $bgApaha);
			
			_shape.graphics.moveTo($array_point[0].x, $array_point[0].y);
			for (var i:int = 1; i < $_len; i++ ) {
				_shape.graphics.lineTo($array_point[i].x, $array_point[i].y);
			}
			_shape.graphics.lineTo($array_point[0].x, $array_point[0].y);
			
			_shape.graphics.endFill();
		}
		public function CreateLine($array_point:Array,  $borderSize:Number = 1, $borderColor:uint = 0x0 , $borderApaha:Number=1):void 
		{
			//-------------------
			//   0   3
			//   1   2
			//-------------------
			var $_len:int = $array_point.length;
			if ($_len < 1 )
			{
				return;
			}
			
			_shape.graphics.lineStyle($borderSize, $borderColor,$borderApaha);
			_shape.graphics.beginFill(0x0, 0);
			
			_shape.graphics.moveTo($array_point[0].x, $array_point[0].y);
			for (var i:int = 1; i < $_len; i++ ) {
				_shape.graphics.lineTo($array_point[i].x, $array_point[i].y);
			}
			
			_shape.graphics.endFill();
		}
		public function FillBitmap($bmp:BitmapData, $isOrigin:Boolean = false, $x:Number=0, $y:Number=0):void
		{
			var $_tmp_x:uint= $bmp.width * 0.5;
			var $_tmp_y:uint= $bmp.height * 0.5;
			var $_tmp_w:uint=$bmp.width;
			var $_tmp_h:uint=$bmp.height;
			var $_matr:Matrix = new Matrix(1, 0, 0, 1, $x - $_tmp_x, $y - $_tmp_y );
			_shape.graphics.lineStyle(0,0x0,0);
			if ($isOrigin)
			{
				//_shape.graphics.clear();
				_shape.graphics.beginBitmapFill($bmp,null,true);
				_shape.graphics.drawRect($x, $y, $_tmp_w, $_tmp_h);
				_shape.graphics.endFill();
			}else{
				//_shape.graphics.clear();
				_shape.graphics.beginBitmapFill($bmp,$_matr,true);
				_shape.graphics.drawRect($x-$_tmp_x, $y-$_tmp_y,$_tmp_w,$_tmp_h);
				_shape.graphics.endFill();
			}
		}
	}
}