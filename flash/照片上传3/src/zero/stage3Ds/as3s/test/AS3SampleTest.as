/***
AS3SampleTest
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月14日 14:57:30
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds.as3s.test{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.stage3Ds.Xiuzhengs;
	import zero.stage3Ds.as3s.AS3BaseEffect;
	
	public class AS3SampleTest extends AS3BaseEffect{
		
		public var sampleX:int=12;
		public var u_sampleX:Number;
		
		public var sampleY:int=34;
		public var v_sampleY:Number;
		
		public function AS3SampleTest(){
		}
		
		override protected function evaluatePixel():void{
			line(tex,oc,["u_sampleX","v_sampleY"],fs[0],"2d");
		}
		
		override protected function updateParams():void{super.updateParams();
			u_sampleX=(Xiuzhengs.d+sampleX+0.5)/effect.uploadBmd.width;
			v_sampleY=(Xiuzhengs.d+sampleY+0.5)/effect.uploadBmd.height;
		}
	}
}