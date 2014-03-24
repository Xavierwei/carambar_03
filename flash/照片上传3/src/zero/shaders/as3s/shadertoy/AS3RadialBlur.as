/***
AS3RadialBlur
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 09:54:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders.as3s.shadertoy{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import flashx.textLayout.formats.Float;
	
	import zero.shaders.Float2;
	import zero.shaders.Pixel4;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3RadialBlur extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3RadialBlur(){
			super("Radial Blur（非常卡）");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var p:Float2 = subtract(multiply(2.0,divide(outCoord(),srcSize)),1.0);
				var s:Float2=new Float2(p.x,p.y);
				
				var total:Pixel4 = new Pixel4(0.0,0.0,0.0,1.0);
				var d:Float2 = divide(subtract(new Float2(0.0,0.0),p),40.0);
				var w:Number = 1.0;
				
				var deform_uv:Float2=new Float2(0,0);
				
				//+++++++++++++++++++++++
				var deform_q:Float2 = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				var deform_a:Number = Math.atan2(deform_q.y,deform_q.x);
				var deform_r:Number = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				var res:Pixel4 = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				//+++++++++++++++++++++++
				deform_q = new Float2( Math.sin(1.1*time+s.x),Math.sin(1.2*time+s.y) );
				
				deform_a = Math.atan2(deform_q.y,deform_q.x);
				deform_r = Math.sqrt(dot(deform_q,deform_q));
				
				deform_uv.x = Math.sin(0.0+1.0*time)+s.x*Math.sqrt(deform_r*deform_r+1.0);
				deform_uv.y = Math.sin(0.6+1.1*time)+s.y*Math.sqrt(deform_r*deform_r+1.0);
				
				deform_uv=multiply(deform_uv,0.5);
				deform_uv.y=1.0-deform_uv.y;
				res = sampleNearest(src,multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))));
				
				res = smoothStep(0.1,1.0,multiply(res,res));
				total = add(total,multiply(w,res));
				w *= .99;
				s = add(s,d);
				
				total = divide(total,40.0);
				var r:Number = 1.5/(1.0+dot(p,p));
				dst = new Pixel4( total.r*r,total.g*r,total.b*r,alpha);
				
			}else{
				dst=sampleNearest(src,new Float2(0,0));//- -
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
		
		/*
		private function deform(deform_p:Float2):Pixel4{
			var deform_uv:Float2=new Float2(0,0);
			
			var deform_q:Float2 = new Float2( Math.sin(1.1*time+deform_p.x),Math.sin(1.2*time+deform_p.y) );
			
			var deform_a:Number = Math.atan2(deform_q.y,deform_q.x);
			var deform_r:Number = Math.sqrt(dot(deform_q,deform_q));
			
			deform_uv.x = Math.sin(0.0+1.0*time)+deform_p.x*Math.sqrt(deform_r*deform_r+1.0);
			deform_uv.y = Math.sin(0.6+1.1*time)+deform_p.y*Math.sqrt(deform_r*deform_r+1.0);
			
			deform_uv.y=1.0-deform_uv.y;
			
			return sampleNearest(src,multiply(multiply(mod(deform_uv,1.0),(subtract(srcSize,1.0))),.5));
		}
		*/
	}
}

/*
#ifdef GL_ES
precision highp float;
#endif

uniform vec2 resolution;
uniform float time;
uniform sampler2D tex0;
uniform sampler2D tex1;

vec3 deform( in vec2 p )
{
	vec2 uv;
	
	vec2 q = vec2( sin(1.1*time+p.x),sin(1.2*time+p.y) );
	
	float a = atan(q.y,q.x);
	float r = sqrt(dot(q,q));
	
	uv.x = sin(0.0+1.0*time)+p.x*sqrt(r*r+1.0);
	uv.y = sin(0.6+1.1*time)+p.y*sqrt(r*r+1.0);
	
	return texture2D(tex0,uv*.5).xyz;
}

void main(void)
{
	vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
	vec2 s = p;
	
	vec3 total = vec3(0.0);
	vec2 d = (vec2(0.0,0.0)-p)/40.0;
	float w = 1.0;
	for( int i=0; i<40; i++ )
	{
		vec3 res = deform(s);
		res = smoothstep(0.1,1.0,res*res);
		total += w*res;
		w *= .99;
		s += d;
	}
	total /= 40.0;
	float r = 1.5/(1.0+dot(p,p));
	gl_FragColor = vec4( total*r,1.0);
}
*/