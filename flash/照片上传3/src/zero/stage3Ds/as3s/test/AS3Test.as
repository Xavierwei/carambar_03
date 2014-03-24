/***
AS3Test
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月13日 11:13:13
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
	
	public class AS3Test extends AS3BaseEffect{
		
		public var dimension:Number=10;
		public var u_dimension:Number;
		public var v_dimension:Number;
		
		public function AS3Test(){
		}
		
		override protected function evaluatePixel():void{
			
			constant(
				"u_d","v_d","u_wid","v_hei",
				"u_center","v_center","u_dimension","v_dimension",
				"alpha",0.5
			);
			
			line(sub,ft[0].xy,v[0].xy,["u_center","v_center"]);
			line(div,ft[0].xy,ft[0].xy,["u_dimension","v_dimension"]);
			line(add,ft[0].xy,ft[0].xy,[0.5,0.5]);
			
			line(frc,ft[1].xy,ft[0].xy);
			line(sub,ft[0].xy,ft[0].xy,ft[1].xy);
			
			line(mul,ft[0].xy,ft[0].xy,["u_dimension","v_dimension"]);
			line(add,ft[0].xy,ft[0].xy,["u_center","v_center"]);
			
			line(sub,ft[0].xy,ft[0].xy,["u_d","v_d"]);
			line(div,ft[0].xy,ft[0].xy,["u_wid","v_hei"]);
			line(sat,ft[0].xy,ft[0].xy);
			line(mul,ft[0].xy,ft[0].xy,["u_wid","v_hei"]);
			line(add,ft[0].xy,ft[0].xy,["u_d","v_d"]);
			
			line(tex,ft[0],ft[0].xy,fs[0],"2d");
			line(mul,ft[0],ft[0],["alpha","alpha","alpha","alpha"]);
			line(mov,oc,ft[0]);
			
		}
		
		override protected function updateParams():void{super.updateParams();
			u_dimension=dimension/effect.uploadBmd.width;
			v_dimension=dimension/effect.uploadBmd.height;
		}
	}
}