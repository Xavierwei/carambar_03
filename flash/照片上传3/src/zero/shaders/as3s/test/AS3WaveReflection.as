/***
AS3WaveReflection
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 17:38:46
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//namespace : "com.rphelan";
//vendor : "Ryan Phelan";

package zero.shaders.as3s.test{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.shaders.Float2;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3WaveReflection extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var progress:Number=0;
		xml.params[0].appendChild(<progress description="animate this value to create the ripple effect" minValue="0" maxValue="1"/>);
		
		public var amplitude:Number=0.33;
		xml.params[0].appendChild(<amplitude description="controls the height of the waves" minValue="0" maxValue="1"/>);
		
		public var frequency:Number=0.22;
		xml.params[0].appendChild(<frequency description="controls the frequency of the waves" minValue="0" maxValue="0.54"/>);
		
		public function AS3WaveReflection(){
			super("水波倒影反射");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var coord : Float2 = outCoord();
				coord.y += Math.sin((coord.y-(1.0-progress))*(100.54-frequency))*(amplitude*0.1)*(1.0-coord.y);    
				dst = sampleNearest(src, coord);
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}