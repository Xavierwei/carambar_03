/***
AS3Penjian
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月05日 18:02:29
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders.as3s.classic{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.shaders.Float2;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3Penjian extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var strength:Number=0;
		xml.params[0].appendChild(<strength description="强度" minValue="0" maxValue="1"/>);
		
		public var progress:Number=0;
		xml.params[0].appendChild(<progress description="当前显示进度" minValue="0" maxValue="1"/>);
		
		public var angle:Number=0;
		xml.params[0].appendChild(<angle description="旋转角度" minValue="-360" maxValue="360"/>);
		
		protected function updateSC():void{
			angle_c=Math.cos(angle*(Math.PI/180));
			angle_s=Math.sin(angle*(Math.PI/180));
		}
		xml.constFuns[0].appendChild(<updateSC description="获取angle的余弦值和正弦值"/>);
		
		protected var angle_c:Number;
		xml.constParams[0].appendChild(<angle_c description="angle的余弦值"/>);
		
		protected var angle_s:Number;
		xml.constParams[0].appendChild(<angle_s description="angle的正弦值"/>);
		
		public function AS3Penjian(){
			super("喷溅");
		}
		
		override protected function updateParams():void{
			updateSC();
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				
				var x:Number=oc.x-srcSize.x*0.5;
				var y:Number=oc.y-srcSize.y*0.5;
				
				var len:Number;
				if(angle_c<0.0){
					len=-srcSize.x*angle_c;
				}else{
					len=srcSize.x*angle_c;
				}
				if(angle_s<0.0){
					len-=srcSize.y*angle_s;
				}else{
					len+=srcSize.y*angle_s;
				}
				var mm:Number=(progress-0.5)*len;
				var dis:Number=mm-(x*angle_c+y*angle_s);
				if(dis<0.0){//位于直线 x*c+y*s=mm “左”侧
					
					//经过 (x1,y1) 和 直线 x*c+y*s=mm 相交的直线：x*s-y*c=nn
					//两直线的交点：
					//	x=mm*c+nn*s
					//	y=mm*s-nn*c
					
					var nn:Number=x*angle_s-y*angle_c;
					x=mm*angle_c+nn*angle_s;
					y=mm*angle_s-nn*angle_c;
					dst=sampleNearest(src,new Float2(
						x+srcSize.x*0.5,
						y+srcSize.y*0.5
					));
					
					oc.x-=x;
					oc.y-=y;
					dst.a*=(1.0-length(oc)/len*(1.0-strength));
					
				}else{
					dst=sampleNearest(src,oc);
				}
				
				dst.a*=alpha;
				
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}