/***
AS3Fangdajing
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 14:36:37
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//小头变大头
//Fade.fromTo(mc,24,Fangdajing,
//	{center:new Float2(90,50),alpha:1,strength:-1,radius:30,useFrames:true},
//	{center:new Float2(90,50),alpha:1,strength:1,radius:30}
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
	
	public class AS3Fangdajing extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var strength:Number=0.5;
		xml.params[0].appendChild(<strength description="强度" minValue="-1" maxValue="1"/>);
		
		public var radius:Number=100;
		xml.params[0].appendChild(<radius description="半径" minValue="0" maxValue="2048"/>);
		
		public function AS3Fangdajing(){
			super("放大镜");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				if(radius>0.0){
					var dx:Number=oc.x-center.x;
					var dy:Number=oc.y-center.y;
					var len2:Number=dx*dx+dy*dy;
					if(len2<radius*radius){
						len2=Math.sqrt(len2);
						len2=(1.0-strength)+strength*len2/radius;
						dst=sampleNearest(src,new Float2(
							center.x+dx*len2,
							center.y+dy*len2
						));
					}else{
						dst=sampleNearest(src,oc);
					}
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