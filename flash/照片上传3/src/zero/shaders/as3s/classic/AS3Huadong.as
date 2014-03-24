/***
AS3Huadong
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 00:06:48
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//斜插
//Fade.fromTo(mc,24,Huadong,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:45,skewY:0,rotationX:0,rotationY:0,rotationZ:0,dimension:10,progress:0,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:45,rotationX:0,rotationY:0,rotationZ:0,dimension:10,progress:1}
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
	
	public class AS3Huadong extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var dimension:Number=10;
		xml.params[0].appendChild(<dimension description="单元大小" minValue="1" maxValue="100"/>);
		
		public var progress:Number=0;
		xml.params[0].appendChild(<progress description="当前显示进度" minValue="0" maxValue="1"/>);
		
		public function AS3Huadong(){
			super("滑动");
		}
		
		override protected function updateParams():void{
			updateTransform();
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				
				var tranParamKK:Number=tranParam1+tranParam2*oc.x+tranParam3*oc.y;
				var x0:Number=(tranParam4+tranParam5*oc.x+tranParam6*oc.y)/tranParamKK;
				var y0:Number=(tranParam7+tranParam8*oc.x+tranParam9*oc.y)/-tranParamKK;
				
				if(mod(Math.floor(y0/dimension),2.0)<1.0){
					x0+=(1.0-progress)*srcSize.x;
				}else{
					x0-=(1.0-progress)*srcSize.x;
				}
				
				var x:Number=x0*ma+y0*md+mtx;
				var y:Number=x0*mb+y0*me+mty;
				var z:Number=x0*mc+y0*mf+mtz;
				x=x*focalLength/(focalLength+z)+o.x;
				y=y*focalLength/(focalLength+z)+o.y;
				
				dst=sampleNearest(src,new Float2(x,y));
				dst.a*=alpha;
				
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}