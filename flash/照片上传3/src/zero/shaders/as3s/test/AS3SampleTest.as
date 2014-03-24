/***
AS3SampleTest
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月14日 14:59:17
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

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
	
	public class AS3SampleTest extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var sampleX:int=12;
		xml.params[0].appendChild(<sampleX description="取样点X" minValue="-1" maxValue="160"/>);
		
		public var sampleY:int=34;
		xml.params[0].appendChild(<sampleY description="取样点Y" minValue="-1" maxValue="120"/>);
		
		public function AS3SampleTest(){
			super("取样测试");
		}
		
		override protected function evaluatePixel():void{
			dst=sampleNearest(src,new Float2(sampleX,sampleY));
		}
	}
}