////////////////////////////////////////////////////////////////////////////////
//
//  Power by www.RIAHome.cn
//                 -- Y.Boy
//
////////////////////////////////////////////////////////////////////////////////

package com.makeit.filters
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	
	/**
	 *  DisplayObjectFilters 类包含各种对显示对象进行过滤的常数值和方法，包括：相底反色效果、灰度、查找边缘、锐化、马赛克效果（两种方法）、浮雕效果、杂点效果、素描效果、水彩效果、扩散效果（毛玻璃效果）、球面效果（鱼眼效果）、挤压效果、光照效果（高光效果）、PS里的颜色阈值效果、油画效果、旧照片效果。
	 */
	public class DisplayObjectFilter
	{
		
		
		/**
		 *  相底反色效果。
		 *
		 *  <p>一个给 ColorMatrixFilter 对象作参数用的描述相底反色的常数数组。</p>
		 */
		public static const DIGITAL_NEGATIVE_MATRIX:Array = [
															-1, 0,  0,  0, 255,
															0,  -1, 0,  0, 255,
															0,  0,  -1, 0, 255,
															0,  0,  0,  1, 1
															];
		
		
		
		/**
		 *  灰度
		 *
		 *  <p>一个给 ColorMatrixFilter 对象作参数用的描述灰度的常数数组。</p>
		 */
		public static const GRAY_SCALE_MATRIX:Array = [
														0.3086, 0.6094, 0.0820, 0, 0,
														0.3086, 0.6094, 0.0820, 0, 0,
														0.3086, 0.6094, 0.0820, 0, 0,
														0,      0,      0,      1, 0
														];
		
		
		
		/**
		 *  查找边缘
		 *
		 *  <p>一个给 ConvolutionFilter 对象作参数用的描述查找边缘的常数数组。</p>
		 */
		public static const EDGE_DETECT_MATRIX:Array = [
												0, -1, 0,
												-1, 4, -1,
												0, -1, 0
												];
		
		
		
		/**
		 *  锐化
		 *
		 *  <p>一个给 ConvolutionFilter 对象作参数用的描述锐化的常数数组。</p>
		 */
		public static const SHARPEN_MATRIX:Array = [
											0, -1, 0,
											-1, 5, -1,
											0, -1, 0
											];
		
		
		
	    /**
	     *  构造函数
	     *  <p>本类所有方法均为静态方法，不应创建实例。</p>
	     */
		public function DisplayObjectFilter()
		{
			
		}
		
		
		
		/**
		 *  马赛克效果（算法一）
		 *
		 *  @param source 要施加马赛克效果的 BitmapData 对象。
		 *
		 *  @param block 每块马赛克（正方形）的大小，单位：像素。
		 *
		 *  @returns 返回一个经过马赛克效果处理的 BitmapData 对象。
		 */
		public static function mosaicFilter( source:BitmapData, block:Number = 5 ):BitmapData
		{
			var returnBitmapData:BitmapData = source.clone();
			
			// 一个 block 的 RGB 信息统计和该 block 的像素总数
			var sumRed:uint = 0;
			var sumGreen:uint = 0;
			var sumBlue:uint = 0;
			var sumPixel:int = 0;
			
			// 一个像素的 RGB 信息
			var pixelColor:uint = 0;
			var pixelRed:uint = 0;
			var pixelGreen:uint = 0;
			var pixelBlue:uint = 0;
			
			// 一个 block 的平均 RGB 信息
			var averageRed:uint = 0;
			var averageGreen:uint = 0;
			var averageBlue:uint = 0;
			var averageColor:uint = 0;
			
			// 当前轮询像素的位置信息
			var blockColumn:Number = 0;
			var blockRow:Number = 0;
			var pixelY:int = 0;
			var pixelX:int = 0;
			
			// 当前轮询的 block 的 Rectangle
			var rect:Rectangle = new Rectangle();
			
			for( blockColumn = 0; blockColumn < source.height; blockColumn += block )
			{
				for( blockRow = 0; blockRow < source.width; blockRow += block )
				{
					// 开始对一个 block 进行处理
					sumRed = sumGreen = sumBlue = sumPixel = 0;
					
					for( pixelY = 0; pixelY < block; pixelY++ )
					{
						for( pixelX = 0; pixelX < block; pixelX++ )
						{
							// 开始对一个 pixel 进行处理
							if( blockColumn + pixelY < source.height && blockRow + pixelX < source.width )
							{
								pixelColor = returnBitmapData.getPixel( blockRow + pixelX, blockColumn + pixelY );
								pixelRed = ( pixelColor & 0xFF0000 ) >> 16;
								pixelGreen = ( pixelColor & 0x00FF00 ) >> 8;
								pixelBlue = pixelColor & 0x0000FF;
								
								sumRed += pixelRed;
								sumGreen += pixelGreen;
								sumBlue += pixelBlue;
								
								sumPixel++;
							}
						}
					}
					
					averageRed = uint( sumRed / sumPixel );
					averageGreen = uint( sumGreen / sumPixel );
					averageBlue = uint( sumBlue / sumPixel );
					averageColor = averageRed * 65536 + averageGreen * 256 + averageBlue;
					
					// 填充颜色平均颜色的两种算法
					
					// 算法一
					rect.x = blockRow;
					rect.y = blockColumn;
					rect.width = rect.height = block;
					
					returnBitmapData.fillRect( rect, averageColor );
					
					// 算法二
					/*
					for( pixelColumn = 0; pixelColumn < block; pixelColumn++ )
					{
						for( pixelRow = 0; pixelRow < block; pixelRow++ )
						{
							// 开始对一个 pixel 进行处理
							if( blockColumn + pixelColumn < source.height && blockRow + pixelRow < source.width )
							{
								source.setPixel( blockRow + pixelRow, blockColumn + pixelColumn, averageRed * 65536 + averageGreen * 256 + averageBlue );
							}
						}
					}
					*/
					
				}
			}
			
			return returnBitmapData;
			
		}
		
		
		
		/**
		 *  马赛克效果（算法二）。此方法比算法一执行效率要快，但这是非正式的马赛克算法。
		 *
		 *  @param source 要施加马赛克效果的 DisplayObject 对象。
		 *
		 *  @param scale 马赛克效果的程度，等同于以此参数为缩小率把 source 缩小后的马赛克程度，范围在 [0.0001, 1]，当值小于 0.0001 时以 0.0001 计算；当值大于 1 时，以 1 计算。
		 *
		 *  @returns 返回一个经过马赛克效果处理的 BitmapData 对象。
		 */
		public static function mosaicFilter2( source:DisplayObject, scale:Number ):BitmapData
		{
			var tempBitmapData:BitmapData;
			var returnBitmapData:BitmapData = new BitmapData( source.width, source.height, true, 0x00000000);
			
			// 确保 scale 的范围在：[0.00001, 1]
			scale = Math.min( 1, Math.max( 0.0001, scale ) );
			
			if( scale == 0.0001 )
			{
				tempBitmapData = new BitmapData( 1, 1, true, 0x00000000 );
			}else
			{
				tempBitmapData = new BitmapData( Math.ceil( source.width * scale ), Math.ceil( source.height * scale ), true, 0x00000000 );
			}
			
			var m:Matrix = source.transform.matrix;
			m.scale( scale, scale );
			tempBitmapData.draw( source, m );
			
			//m.scale( (1 / pixelation)*(1 / pixelation), (1 / pixelation)*(1 / pixelation) );
			m.a = m.d = 1 / scale;
			returnBitmapData.draw( tempBitmapData, m );
			tempBitmapData.dispose();
			
			return returnBitmapData;
		}
		
		
		
		/**
		 *  浮雕效果
		 *
		 *  @param value 浮雕程度值。
		 *
		 *  @returns 一个给 ConvolutionFilter 对象作参数用的描述浮雕程度的数组。
		 */
		public static function getEmbossMatrix( value:Number ):Array
		{
			return [
					-value, -1, 0,
					-1,     1,  1,
					0,      1,  value
					];
		}
		
		
		
		/**
		 *  杂点效果
		 *
		 *  @param sourse 需要添加杂点效果的 BitmapData 对象。
		 *
		 *  @param degree 杂点程度值，范围在 [0, 255]。
		 *
		 *  @returns 返回一个包含杂点效果的 BitmapData 对象。
		 */
		public static function noiseFilter( source:BitmapData, degree:Number = 128 ):BitmapData
		{
			var noise:int = 0;
			var color:uint = 0;
			var r:uint = 0;
			var g:uint = 0;
			var b:uint = 0;
			
			var returnBitmapData:BitmapData = source.clone();
			
			for( var i:int = 0; i < source.height; i++ )
			{
				for( var j:int = 0; j < source.width; j++ )
				{
					noise = int( Math.random() * degree * 2 ) - degree; // 范围在 [-degree, degree]
					
					color = returnBitmapData.getPixel( j, i );
					r = (color & 0xff0000) >> 16;
					g = (color & 0x00ff00) >> 8;
					b = color & 0x0000ff;
					
					r = r + noise < 0 ? 0 : (r + noise > 255 ? 255 : r + noise);
					g = g + noise < 0 ? 0 : (g + noise > 255 ? 255 : g + noise);
					b = b + noise < 0 ? 0 : (b + noise > 255 ? 255 : b + noise);
					returnBitmapData.setPixel( j, i, r * 65536 + g * 256 + b );
				}
			}
			
			return returnBitmapData;
			
		}
		
		
		
		/**
		 *  素描效果
		 *
		 *  @param source 需要添加素描效果的 BitmapData 对象。
		 *
		 *  @param threshold 门槛值。值越大，素描线越少。范围建议在 [0, 20]。
		 *
		 *  @returns 返回经过素描效果处理的 BitmapData 对象。
		 */
		public static function sketchFilter( source:BitmapData, threshold:Number = 5 ):BitmapData
		{
			var color:uint = 0;
			var gray1:uint = 0;
			var gray2:uint = 0;
			
			var returnBitmapData:BitmapData = source.clone();
			
			for( var i:int = 0; i < source.height - 1; i++ )
			{
				for( var j:int = 0; j < source.width - 1; j++ )
				{
					color = returnBitmapData.getPixel( j, i );
					gray1 = (color & 0xff0000) >> 16;
					color = returnBitmapData.getPixel( j + 1, i + 1 );
					gray2 = (color & 0xff0000) >> 16;
					
					if( Math.abs( gray1 - gray2 ) >= threshold )
					{
						returnBitmapData.setPixel( j, i, 0x222222 );
					} else
					{
						returnBitmapData.setPixel( j, i, 0xFFFFFF );
					}
				}
			}
			
			return returnBitmapData;
			
		}
		
		
		
		/**
		 *  水彩效果
		 *
		 *  @param source 需要添加水彩效果的 BitmapData 对象。
		 *
		 *  @param scaleX X 径向晕彩。
		 *
		 *  @param scaleY Y 径向晕彩。
		 *
		 *  @returns 返回经过水彩效果处理的 BitmapData 对象。
		 */
		public static function waterColorFilter( source:BitmapData, scaleX:Number = 5, scaleY:Number = 5 ):BitmapData
		{
			var returnBitmapData:BitmapData = source.clone();
			
			var tempBitmapData:BitmapData = new BitmapData( source.width, source.height, true, 0x00FFFFFF );
			tempBitmapData.perlinNoise( 3, 3, 1, 1, false, true, 1, false );
			
			var filter:DisplacementMapFilter = new DisplacementMapFilter( tempBitmapData, new Point( 0, 0 ), 1, 1, scaleX, scaleY, DisplacementMapFilterMode.COLOR, 0x000000, 0x000000 );
			returnBitmapData.applyFilter( returnBitmapData, returnBitmapData.rect, new Point( 0, 0 ), filter );
			
			return returnBitmapData;
			
		}
		
		
		
		/**
		 *  扩散效果（毛玻璃效果）
		 *
		 *  @param source 需要添加扩散效果的 BitmapData 对象。
		 *
		 *  @param scaleX X 径向扩散。
		 *
		 *  @param scaleY Y 径向扩散。
		 *
		 *  @returns 返回经过扩散效果处理的 BitmapData 对象。
		 */
		public static function diffuseFilter( source:BitmapData, scaleX:Number = 5, scaleY:Number = 5):BitmapData
		{
			var returnBitmapData:BitmapData = source.clone();
			
			var tempBitmapData:BitmapData = new BitmapData( source.width, source.height, true, 0x00FFFFFF );
			tempBitmapData.noise( 888888 );
			
			var filter:DisplacementMapFilter = new DisplacementMapFilter( tempBitmapData, new Point( 0, 0 ), 1, 1, scaleX, scaleY, DisplacementMapFilterMode.COLOR, 0x000000, 0x000000 );
			returnBitmapData.applyFilter( returnBitmapData, returnBitmapData.rect, new Point( 0, 0 ), filter );
			
			tempBitmapData.dispose();
			
			return returnBitmapData;
		}
		
		
		
		/**
		 *  球面效果（鱼眼效果）
		 *
		 *  @param source 需要添加球面效果（鱼眼效果）的 BitmapData 对象。
		 *
		 *  @param targetX 球面的中心点 x 坐标。
		 *
		 *  @param targetY 球面的中心点 y 坐标。
		 *
		 *  @returns 返回经过球面效果（鱼眼效果）处理的 BitmapData 对象。
		 */
		public static function spherizeFilter( source:BitmapData, targetX:int, targetY:int ):BitmapData
		{
			var returnBitmapData:BitmapData = source.clone();
			var tempBitmapData:BitmapData = returnBitmapData.clone();
			
			var maxTargetXY:int = Math.max( targetX, targetY);
			
			var radian:Number = 0;
			var radius:Number = 0;
			var offsetX:Number = 0;
			var offsetY:Number = 0;
			var color:uint = 0;
			var r:uint = 0;
			var g:uint = 0;
			var b:uint = 0;
			
			for( var i:int = 0; i < source.height - 1; i++ )
			{
				for( var j:int = 0; j < source.width - 1; j++ )
				{
					offsetX = j - targetX;
					offsetY = i - targetY;
					radian = Math.atan2( offsetY, offsetX );
					radius = (offsetX * offsetX + offsetY * offsetY) / maxTargetXY;
					
					var x:int = int( radius * Math.cos( radian ) ) + targetX;
					var y:int = int( radius * Math.sin( radian ) ) + targetY;
					
					if( x < 0 )
					{
						x = 0;
					}else if( x >= source.width )
					{
						x = source.width - 1;
					}
					
					if( y < 0 )
					{
						y = 0;
					}else if( y >= source.height )
					{
						y = source.height - 1;
					}
					
					color = tempBitmapData.getPixel( x, y );
					
					r = (color & 0xFF0000) >> 16;
					g = (color & 0x00FF00) >> 8;
					b = color & 0x0000FF;
					
					returnBitmapData.setPixel( j, i, r * 65536 + g * 256 + b );
				}
			}
			
			tempBitmapData.dispose();
			
			return returnBitmapData;
			
		}
		
		
		
		/**
		 *  挤压效果
		 *
		 *  @param source 需要添加挤压效果的 BitmapData 对象。
		 *
		 *  @param targetX 挤压的中心点 x 坐标。
		 *
		 *  @param targetY 挤压的中心点 y 坐标。
		 *
		 *  @param degree 挤压程度值。
		 *
		 *  @returns 返回经过挤压效果处理的 BitmapData 对象。
		 */
		public static function pinchFilter( source:BitmapData, targetX:int, targetY:int, degree:Number = 16 ):BitmapData
		{
			var returnBitmapData:BitmapData = source.clone();
			var tempBitmapData:BitmapData = returnBitmapData.clone();
			
			var maxMidXY:int = Math.max( targetX, targetY);
			
			var radian:Number = 0;
			var radius:Number = 0;
			var offsetX:Number = 0;
			var offsetY:Number = 0;
			var color:uint = 0;
			var r:uint = 0;
			var g:uint = 0;
			var b:uint = 0;
			
			for( var i:int = 0; i < source.height - 1; i++ )
			{
				for( var j:int = 0; j < source.width - 1; j++ )
				{
					offsetX = j - targetX;
					offsetY = i - targetY;
					radian = Math.atan2( offsetY, offsetX );
					radius = Math.sqrt( offsetX * offsetX + offsetY * offsetY );
					radius = Math.sqrt( radius ) * degree;
					var x:int = int( radius * Math.cos( radian ) ) + targetX;
					var y:int = int( radius * Math.sin( radian ) ) + targetY;
					
					if( x < 0 )
					{
						x = 0;
					}else if( x >= source.width )
					{
						x = source.width - 1;
					}
					
					if( y < 0 )
					{
						y = 0;
					}else if( y >= source.height )
					{
						y = source.height - 1;
					}
					
					color = tempBitmapData.getPixel( x, y );
					
					r = (color & 0xff0000) >> 16;
					g = (color & 0x00ff00) >> 8;
					b = color & 0x0000ff;
					
					returnBitmapData.setPixel( j, i, r * 65536 + g * 256 + b );
				}
			}
			
			tempBitmapData.dispose();
			
			return returnBitmapData;
			
		}
		
		
		
		/**
		 *  光照效果（高光效果）
		 *
		 *  @param source 需要添加光照效果的 BitmapData 对象。
		 *
		 *  @param targetX 光照效果的中心点 x 坐标。
		 *
		 *  @param targetY 光照效果的中心点 y 坐标。
		 *
		 *  @param radius 光照圈的半径。
		 *
		 *  @param power 施加光照的强度。范围在 [0, 255]。
		 *
		 *  @returns 返回经过光照效果处理的 BitmapData 对象。
		 *
		 */
		public static function lightingFilter( source:BitmapData, targetX:int, targetY:int, radius:int = 0, power:Number = 128 ):BitmapData
		{
			var returnBitmapData:BitmapData = source.clone();
			
			if( radius == 0 )
			{
				radius = Math.max( source.width, source.height );
			}
			
			var sr:int = radius * radius;
			
			var sd:int = 0;
			var color:uint = 0;
			var r:uint = 0;
			var g:uint = 0;
			var b:uint = 0;
			var distance:Number = 0;
			var brightness:int = 0;
			
			for( var y:int = 0; y < source.height; y++ )
			{
				for( var x:int = 0; x < source.width; x++ )
				{
					sd = (x - targetX) * (x - targetX) + (y - targetY) * (y - targetY);
					if( sd < sr )
					{
						color = returnBitmapData.getPixel( x, y );
						r = (color & 0xff0000) >> 16;
						g = (color & 0x00ff00) >> 8;
						b = color & 0x0000ff;
						distance = Math.sqrt( sd );
						brightness = int( power * (radius - distance) / radius );
						r = r + brightness > 255 ? 255 : r + brightness;
						g = g + brightness > 255 ? 255 : g + brightness;
						b = b + brightness > 255 ? 255 : b + brightness;
						returnBitmapData.setPixel( x, y, r * 65536 + g * 256 + b );
					}
				}
			}
			
			return returnBitmapData;
			
		}
		
		
		
		/**
		 *  PS里的颜色阈值效果
		 *
		 *  @param source 需要添加颜色阈值效果的 BitmapData 对象。
		 *
		 *  @param threshold 阈值。范围在 [0, 255]。
		 *
		 *  @returns 返回经过颜色阈值效果处理的 BitmapData 对象。
		 */
		public static function thresholdFilter( source:BitmapData, threshold:uint = 128 ):BitmapData
		{
			var returnBitmapData:BitmapData = new BitmapData( source.width, source.height, true, 0xFF000000 );
			
			threshold = Math.max( 0, Math.min( threshold, 255 ) );
			threshold =  255 * 0xFFFFFF + threshold * 0xFFFF + threshold * 0xFF + threshold;
			
			returnBitmapData.threshold( source, returnBitmapData.rect, new Point(0, 0), ">", threshold, 0x00FFFFFF, 0xFFFFFFFF, false );
			
			return returnBitmapData;
		}
		
		
		
		/**
		 *  油画效果
		 *
		 *  @param source 需要添加油画效果的 BitmapData 对象。
		 *
		 *  @param brushSize 笔刷大小。范围在 [1, 8]。
		 *
		 *  @param coarseness 粗糙值。范围在 [1, 255]。
		 *
		 *  @returns 返回一个添加了油画效果的 BitmapData 对象。
		 */
		public static function oilPaintingFilter( source:BitmapData, brushSize:Number = 1, coarseness:Number = 32 ):BitmapData
		{
			var color:uint = 0;
			var gray:uint = 0;
			var r:uint = 0;
			var g:uint = 0;
			var b:uint = 0;
			var a:uint = 0;
			
			var arraylen:int = coarseness + 1;
			var CountIntensity:Array = new Array();
			var RedAverage:Array = new Array();
			var GreenAverage:Array = new Array();
			var BlueAverage:Array = new Array();
			var AlphaAverage:Array = new Array();
			
			var filter:ColorMatrixFilter = new ColorMatrixFilter( DisplayObjectFilter.GRAY_SCALE_MATRIX );
			var returnBitmapData:BitmapData = source.clone();
			var tempBitmapData:BitmapData = returnBitmapData.clone();
			returnBitmapData.applyFilter( returnBitmapData, returnBitmapData.rect, new Point( 0, 0 ), filter );
			
			var top:int = 0;
			var bottom:int = 0;
			var left:int = 0;
			var right:int = 0;
			
			for( var y:int = 0; y < source.height; y++ )
			{
				top = y - brushSize;
				bottom = y + brushSize + 1;
				
				if( top < 0 )
				{
					top = 0;
				}
				
				if( bottom >= source.height )
				{
					bottom = source.height - 1;
				}
				
				for( var x:int = 0; x < source.width; x++ )
				{
					left = x - brushSize;
					right = x + brushSize + 1;
					
					if( left < 0 )
					{
						left = 0;
					}
					
					if( right >= source.width )
					{
						right = source.width;
					}
					
					for( var i:int = 0; i < arraylen; i++ )
					{
						CountIntensity[i] = 0;
						RedAverage[i] = 0;
						GreenAverage[i] = 0;
						BlueAverage[i] = 0;
						AlphaAverage[i] = 0;
					}
					
					for( var j:int = top; j < bottom; j++ )
					{
						for( i = left; i < right; i++ )
						{
							color = returnBitmapData.getPixel( i, j );
							gray = (color & 0xff0000) >> 16;
							color = tempBitmapData.getPixel32( i, j );
							a = color >> 24 & 0xFF;
							r = color >> 16 & 0xFF;
							g = color >> 8 & 0xFF;
							b = color & 0xFF;
							var intensity:int = int( coarseness * gray / 255 );
							CountIntensity[intensity]++;
							RedAverage[intensity] += r;
							GreenAverage[intensity] += g;
							BlueAverage[intensity] += b;
							AlphaAverage[intensity] += a;
						}
					}
					
					var closenIntensity:int = 0;
					var maxInstance:uint = CountIntensity[0];
					
					for( i = 1; i < arraylen; i++ )
					{
						if( CountIntensity[i] > maxInstance )
						{
							closenIntensity = i;
							maxInstance = CountIntensity[i];
						}
					}
					
					a = int( AlphaAverage[closenIntensity] / maxInstance );
					r = int( RedAverage[closenIntensity] / maxInstance );
					g = int( GreenAverage[closenIntensity] / maxInstance );
					b = int( BlueAverage[closenIntensity] / maxInstance );
					returnBitmapData.setPixel32( x, y, a * 16777216 + r * 65536 + g * 256 + b );
				}
			}
			
			return returnBitmapData;
			
		}
		
		
		
		/**
		 *  旧照片效果
		 *
		 *  @param source 需要添加旧照片效果的 BitmapData 对象。
		 *
		 *  @returns 返回一个添加了旧照片效果的 BitmapData 对象。
		 */
		public static function oldPictureFilter( source:BitmapData ):BitmapData
		{
			var oldPictureMatrix:Array = [
											0.94, 0,   0,   0,   0,
											0,    0.9, 0,   0,   0,
											0,    0,   0.8, 0,   0,
											0,    0,   0,   0.8, 0
											];
			var returnBitmapData:BitmapData = source.clone();
			var grayFilter:ColorMatrixFilter = new ColorMatrixFilter( DisplayObjectFilter.GRAY_SCALE_MATRIX );
			var oldPictureFilter:ColorMatrixFilter = new ColorMatrixFilter( oldPictureMatrix );
			
			returnBitmapData.applyFilter( returnBitmapData, returnBitmapData.rect, new Point( 0, 0 ), grayFilter );
			returnBitmapData.applyFilter( returnBitmapData, returnBitmapData.rect, new Point( 0, 0 ), oldPictureFilter );
			
			return returnBitmapData;
			
		}
		
		
		
	}
}