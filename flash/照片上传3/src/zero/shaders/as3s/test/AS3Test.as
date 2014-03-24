/***
AS3Test
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月01日 18:06:42
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//测试uvxiuzheng
//Fade.fromTo(mc,24,Test,
//	{center:new Float2(125,21),alpha:1,dimension:10,useFrames:true},
//	{center:new Float2(105,78),alpha:1,dimension:68}
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
	
	public class AS3Test extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var dimension:Number=10;
		xml.params[0].appendChild(<dimension description="格子大小" minValue="1" maxValue="100"/>);
		
		public function AS3Test(){
			super("测试");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				var x:Number=oc.x-center.x;
				var y:Number=oc.y-center.y;
				x=Math.floor(x/dimension+0.5)*dimension;
				y=Math.floor(y/dimension+0.5)*dimension;
				x+=center.x;
				y+=center.y;
				x=clamp(x,0.0,srcSize.x-1.0);
				y=clamp(y,0.0,srcSize.y-1.0);
				dst=sampleNearest(src,new Float2(x,y));
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}