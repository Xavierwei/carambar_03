/***
AS3ARGB
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月17日 23:04:17
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
	
	import zero.stage3Ds.as3s.AS3BaseEffect;
	
	public class AS3ARGB extends AS3BaseEffect{
		
		public var red:Number=1;
		
		public var green:Number=1;
		
		public var blue:Number=1;
		
		public function AS3ARGB(){
		}
		
		override protected function evaluatePixel():void{
			line(tex,ft[0],v[0],fs[0],"2d");
			line(mul,ft[0],ft[0],["red","green","blue","alpha"]);
			line(mul,ft[0].xyz,ft[0].xyz,["alpha","alpha","alpha"]);
			line(mov,oc,ft[0]);
		}
	}
}