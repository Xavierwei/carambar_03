////////////////////////////////////////////////////////////////////////////////
//
//  Power by www.RIAHome.cn
//                 -- Y.Boy
//
////////////////////////////////////////////////////////////////////////////////

package com.makeit.color
{
	/**
	 *  DisplayObjectAdjustColor 类包含对显示对象进行调整颜色的静态方法：亮度、对比度、饱和度和色相。
	 */
	public class DisplayObjectAdjustColor
	{
		
		/**
		 *  @private
		 *
		 *  constant for contrast calculations:
		 */
		private static const DELTA_INDEX:Array = [
			0,    0.01, 0.02, 0.04, 0.05, 0.06, 0.07, 0.08, 0.1,  0.11,
			0.12, 0.14, 0.15, 0.16, 0.17, 0.18, 0.20, 0.21, 0.22, 0.24,
			0.25, 0.27, 0.28, 0.30, 0.32, 0.34, 0.36, 0.38, 0.40, 0.42,
			0.44, 0.46, 0.48, 0.5,  0.53, 0.56, 0.59, 0.62, 0.65, 0.68, 
			0.71, 0.74, 0.77, 0.80, 0.83, 0.86, 0.89, 0.92, 0.95, 0.98,
			1.0,  1.06, 1.12, 1.18, 1.24, 1.30, 1.36, 1.42, 1.48, 1.54,
			1.60, 1.66, 1.72, 1.78, 1.84, 1.90, 1.96, 2.0,  2.12, 2.25, 
			2.37, 2.50, 2.62, 2.75, 2.87, 3.0,  3.2,  3.4,  3.6,  3.8,
			4.0,  4.3,  4.7,  4.9,  5.0,  5.5,  6.0,  6.5,  6.8,  7.0,
			7.3,  7.5,  7.8,  8.0,  8.4,  8.7,  9.0,  9.4,  9.6,  9.8, 
			10.0
		];
		
		
	    /**
	     *  构造函数
	     *  <p>本类所有方法均为静态方法，不应创建实例。</p>
	     */
		public function DisplayObjectAdjustColor()
		{
			
		}
		
		
		
		/**
		 *  获得亮度矩阵。
		 *
		 *  @param value 亮度值，范围在[-100, 100]。
		 *
		 *  @returns 一个描述亮度值的数组。
		 */
		public static function getBrightnessMatrix( value:Number ):Array
		{
			value = Math.max( -100, Math.min( value, 100 ) );
			
			return [
					1, 0, 0, 0, value,
					0, 1, 0, 0, value,
					0, 0, 1, 0, value,
					0, 0, 0, 1, 0,
					0, 0, 0, 0, 1
					];
		}
		
		
		
		/**
		 *  获得对比度矩阵。
		 *
		 *  @param value 对比度值，范围在[-100, 100]。
		 *
		 *  @returns 一个描述对比度值的数组。
		 */
		public static function getContrastMatrix( value:Number ):Array
		{
			value = Math.max( -100, Math.min( value, 100 ) );
			
			var x:Number = 0;
			if( value < 0 )
			{
				x = 127 + value / 100 * 127;
			}else
			{
				x = value % 1;
				if( x == 0 )
				{
					x = DELTA_INDEX[value];
				}else
				{
					//x = DELTA_INDEX[(p_val<<0)]; // this is how the IDE does it.
					x = DELTA_INDEX[(value<<0)] * (1 - x) + DELTA_INDEX[(value<<0) + 1] * x; // use linear interpolation for more granularity.
				}
				x = x * 127 + 127;
			}
			
			return [
					x/127, 0,     0,     0, 0.5*(127-x),
					0,     x/127, 0,     0, 0.5*(127-x),
					0,     0,     x/127, 0, 0.5*(127-x),
					0,     0,     0,     1, 0,
					0,     0,     0,     0, 1
					];
		}
		
		
		
		/**
		 *  获得饱和度矩阵。
		 *
		 *  @param value 饱和度值，范围在[-100, 100]。
		 *
		 *  @returns 一个描述饱和度值的数组。 
		 */
		public static function getSaturationMatrix( value:Number ):Array
		{
			value = Math.max( -100, Math.min( value, 100 ) );
			
			var x:Number = 1 + ((value > 0) ? 3 * value / 100 : value / 100);
			var lumR:Number = 0.3086;
			var lumG:Number = 0.6094;
			var lumB:Number = 0.0820;
			
			return [
					lumR*(1-x)+x, lumG*(1-x),   lumB*(1-x),   0, 0,
					lumR*(1-x),   lumG*(1-x)+x, lumB*(1-x),   0, 0,
					lumR*(1-x),   lumG*(1-x),   lumB*(1-x)+x, 0, 0,
					0,            0,            0,            1, 0,
					0,            0,            0,            0, 1
					];
		}
		
		
		
		/**
		 *  获得色相矩阵。
		 *
		 *  @param value 色相值，范围在[-180, 180]。
		 *
		 *  @returns 一个描述色相值的数组。 
		 */
		public static function getHueMatrix( value:Number ):Array
		{
			value = Math.max( -180, Math.min( value, 180 ) );
			
			var cosVal:Number = Math.cos( value );
			var sinVal:Number = Math.sin( value );
			var lumR:Number = 0.213;
			var lumG:Number = 0.715;
			var lumB:Number = 0.072;
			
			return [
					lumR+cosVal*(1-lumR)+sinVal*(-lumR),    lumG+cosVal*(-lumG)+sinVal*(-lumG),  lumB+cosVal*(-lumB)+sinVal*(1-lumB), 0, 0,
					lumR+cosVal*(-lumR)+sinVal*(0.143),     lumG+cosVal*(1-lumG)+sinVal*(0.140), lumB+cosVal*(-lumB)+sinVal*(-0.283), 0, 0,
					lumR+cosVal*(-lumR)+sinVal*(-(1-lumR)), lumG+cosVal*(-lumG)+sinVal*(lumG),   lumB+cosVal*(1-lumB)+sinVal*(lumB),  0, 0,
					0,                                      0,                                   0,                                   1, 0,
					0,                                      0,                                   0,                                   0, 1
					];
		}
		
		

	}
}