/***
AS3Dongtaimohu
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 15:04:41
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//从右下角出现
//Fade.fromTo(mc,24,Dongtaimohu,
//	{center:new Float2(160,120),alpha:1,k:1.2,useFrames:true},
//	{alpha:1,k:1}
//);

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
	
	public class AS3Dongtaimohu extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var k:Number=1;
		xml.params[0].appendChild(<k description="系数" minValue="0" maxValue="2"/>);
		
		public function AS3Dongtaimohu(){
			super("动态模糊");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var oc:Float2=outCoord();
				
				var dx:Number=oc.x-center.x;
				var dy:Number=oc.y-center.y;
				
				dst=sampleNearest(src,new Float2(center.x+dx,center.y+dy));
				dx*=k;dy*=k;dst=add(dst,sampleNearest(src,new Float2(center.x+dx,center.y+dy)));
				dx*=k;dy*=k;dst=add(dst,sampleNearest(src,new Float2(center.x+dx,center.y+dy)));
				dx*=k;dy*=k;dst=add(dst,sampleNearest(src,new Float2(center.x+dx,center.y+dy)));
				dx*=k;dy*=k;dst=add(dst,sampleNearest(src,new Float2(center.x+dx,center.y+dy)));
				dx*=k;dy*=k;dst=add(dst,sampleNearest(src,new Float2(center.x+dx,center.y+dy)));
				dx*=k;dy*=k;dst=add(dst,sampleNearest(src,new Float2(center.x+dx,center.y+dy)));
				dx*=k;dy*=k;dst=add(dst,sampleNearest(src,new Float2(center.x+dx,center.y+dy)));
				dx*=k;dy*=k;dst=add(dst,sampleNearest(src,new Float2(center.x+dx,center.y+dy)));
				dx*=k;dy*=k;dst=add(dst,sampleNearest(src,new Float2(center.x+dx,center.y+dy)));
				
				dst=divide(dst,10.0);
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}