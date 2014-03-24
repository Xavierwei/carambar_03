/***
AS3ARGB
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月05日 00:24:30
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//变红
//Fade.fromTo(mc,24,ARGB,
//	{alpha:1,red:1,green:1,blue:1,useFrames:true},
//	{alpha:1,red:1,green:0,blue:0}
//);

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
	
	public class AS3ARGB extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var red:Number=1;
		xml.params[0].appendChild(<red description="红" minValue="0" maxValue="1"/>);
		
		public var green:Number=1;
		xml.params[0].appendChild(<green description="绿" minValue="0" maxValue="1"/>);
		
		public var blue:Number=1;
		xml.params[0].appendChild(<blue description="蓝" minValue="0" maxValue="1"/>);
		
		public function AS3ARGB(){
			super("透明红绿蓝");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				dst=sampleNearest(src,outCoord());
				dst.r*=red;
				dst.g*=green;
				dst.b*=blue;
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}