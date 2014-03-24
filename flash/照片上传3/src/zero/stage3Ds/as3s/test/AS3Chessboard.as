/***
AS3Chessboard
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月18日 10:34:27
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
	
	import zero.shaders.Pixel4;
	import zero.stage3Ds.as3s.AS3BaseEffect;
	
	public class AS3Chessboard extends AS3BaseEffect{
		
		public var dimension:Number=10;
		public var u_dimension:Number;
		public var v_dimension:Number;
		
		public var color1:Pixel4=null;
		public var color1_r:Number;
		public var color1_g:Number;
		public var color1_b:Number;
		public var color1_a:Number;
		
		public var color2:Pixel4=null;
		public var color2_r:Number;
		public var color2_g:Number;
		public var color2_b:Number;
		public var color2_a:Number;
		
		public function AS3Chessboard(){
		}
		
		override protected function evaluatePixel():void{
			
			//var oc:Float2=outCoord();
			
			//dst=sampleNearest(src,oc);
			
			//if(mod(Math.floor(oc.x/dimension)+Math.floor(oc.y/dimension),2.0)==0.0){
			//	dst=multiply(dst,color1);
			//}else{
			//	dst=multiply(dst,color2);
			//}
			//dst.a*=alpha;
			
			
			//b01=frc((floor(u/u_dimension)+floor(v/v_dimension))/2)!=0?1:0
			//color=color*color1*b01+color*color2*(1-b01)
			
			line(tex,ft[0],v[0],fs[0],"2d");
			
			line(mul,ft[1],ft[0],["color1_r","color1_g","color1_b","color1_a"]);
			line(mul,ft[1].xyz,ft[1].xyz,["color1_a","color1_a","color1_a"]);
			
			line(mul,ft[2],ft[0],["color2_r","color2_g","color2_b","color2_a"]);
			line(mul,ft[2].xyz,ft[2].xyz,["color2_a","color2_a","color2_a"]);
			
			//line(mov,ft[3].x,[1]);
			//line(mov,ft[3].x,[0]);
			line(div,ft[3].xy,v[0].xy,["u_dimension","v_dimension"]);
			line(frc,ft[4].xy,ft[3].xy);
			line(sub,ft[3].xy,ft[3].xy,ft[4].xy);
			line(add,ft[3].x,ft[3].x,ft[3].y);
			line(div,ft[3].x,ft[3].x,[2]);
			line(frc,ft[3].x,ft[3].x);
			line(seq,ft[3].x,ft[3].x,[0]);
			
			line(mul,ft[1],ft[1],ft[3].xxxx);
			line(sub,ft[3].x,[1],ft[3].x);
			line(mul,ft[2],ft[2],ft[3].xxxx);
			line(add,ft[0],ft[1],ft[2]);
			
			line(mul,ft[0],ft[0],["alpha","alpha","alpha","alpha"]);
			line(mov,oc,ft[0]);
		}
		
		override protected function updateParams():void{super.updateParams();
			u_dimension=dimension/effect.uploadBmd.width;
			v_dimension=dimension/effect.uploadBmd.height;
			color1_r=color1.r;
			color1_g=color1.g;
			color1_b=color1.b;
			color1_a=color1.a;
			color2_r=color2.r;
			color2_g=color2.g;
			color2_b=color2.b;
			color2_a=color2.a;
		}
	}
}