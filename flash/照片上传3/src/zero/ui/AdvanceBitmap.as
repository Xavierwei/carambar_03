/***
AdvanceBitmap
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月21日 13:56:46
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class AdvanceBitmap extends Bitmap{
		
		//变形点（相对于 this 的坐标系）
		public var x0:Number;
		public var y0:Number;
		
		public var tran_scaleX:Number;
		public var tran_scaleY:Number;
		
		public var tran_skewX:Number;
		public var tran_skewY:Number;
		
		public var tran_x:Number;
		public var tran_y:Number;
		
		private var m:Matrix;
		private var skew_matrix:Matrix;
		
		public function AdvanceBitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false){
			
			super(bitmapData, pixelSnapping, smoothing);
			
			m=new Matrix();
			skew_matrix=new Matrix();
			
			x0=0;
			y0=0;
			
			tran_scaleX=1;
			tran_scaleY=1;
			
			tran_skewX=0;
			tran_skewY=0;
			
			tran_x=0;
			tran_y=0;
		}
		
		public function update():void{
			
			m.a=1;
			m.b=0;
			m.c=0;
			m.d=1;
			m.tx=-x0;
			m.ty=-y0;
			
			m.scale(tran_scaleX,tran_scaleY);
			
			var rad:Number=tran_skewX*(Math.PI/180);
			skew_matrix.c=-Math.sin(rad);
			skew_matrix.d=Math.cos(rad);
			rad=tran_skewY*(Math.PI/180);
			skew_matrix.a=Math.cos(rad);
			skew_matrix.b=Math.sin(rad);
			m.concat(skew_matrix);
			
			m.translate(tran_x,tran_y);
			
			this.transform.matrix=m;
		}
	}
}