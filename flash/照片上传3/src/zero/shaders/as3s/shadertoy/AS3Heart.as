/***
AS3Heart
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 23:42:00
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
	
	import zero.shaders.Float2;
	import zero.shaders.Pixel4;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3Heart extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Heart(){
			super("Heart（不兼容flash）");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var p:Float2 = divide(subtract(multiply(2.0,outCoord()),srcSize),srcSize.y);
				
				// animate
				var tt:Number = mod(time,2.0)/2.0;
				var ss:Number = Math.pow(tt,.2)*0.5 + 0.5;
				ss -= ss*0.2*Math.sin(tt*6.2831*5.0)*Math.exp(-tt*6.0);
				p = multiply(p,add(new Float2(0.5,1.5),multiply(ss,new Float2(0.5,-0.5))));
				
				
				var a:Number = Math.atan2(p.x,p.y)/3.141593;
				var r:Number = length(p);
				
				// shape
				var h:Number = Math.abs(a);
				var d:Number = (13.0*h - 22.0*h*h + 10.0*h*h*h)/(6.0-5.0*h);
				
				// color
				var f:Number = step(r,d) * Math.pow(1.0-r/d,0.25);
				
				dst=new Pixel4(f,0.0,0.0,alpha);
				
			}else{
				dst=sampleNearest(src,new Float2(0,0));//- -
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}

/*
#ifdef GL_ES
precision highp float;
#endif

uniform float time;
uniform vec2 resolution;
uniform vec4 mouse;

void main(void)
{
	vec2 p = (2.0*gl_FragCoord.xy-resolution)/resolution.y;
	
	// animate
	float tt = mod(time,2.0)/2.0;
	float ss = pow(tt,.2)*0.5 + 0.5;
	ss -= ss*0.2*sin(tt*6.2831*5.0)*exp(-tt*6.0);
	p *= vec2(0.5,1.5) + ss*vec2(0.5,-0.5);
	
	
	float a = atan(p.x,p.y)/3.141593;
	float r = length(p);
	
	// shape
	float h = abs(a);
	float d = (13.0*h - 22.0*h*h + 10.0*h*h*h)/(6.0-5.0*h);
	
	// color
	float f = step(r,d) * pow(1.0-r/d,0.25);
	
	gl_FragColor = vec4(f,0.0,0.0,1.0);
}
*/