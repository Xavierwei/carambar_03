/***
AS3ReliefTunnel
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 16:51:25
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
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3ReliefTunnel extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3ReliefTunnel(){
			super("Relief Tunnel");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var p:Float2 = subtract(multiply(2.0,divide(outCoord(),srcSize)),1.0);
				var uv:Float2=new Float2(0.0,0.0);
				
				var r:Number = Math.sqrt( dot(p,p) );
				var a:Number = Math.atan2(p.y,p.x) + 0.5*Math.sin(0.5*r-0.5*time);
				
				var s:Number = 0.5 + 0.5*Math.cos(7.0*a);
				s = smoothStep(0.0,1.0,s);
				s = smoothStep(0.0,1.0,s);
				s = smoothStep(0.0,1.0,s);
				s = smoothStep(0.0,1.0,s);
				
				uv.x = time + 1.0/( r + .2*s);
				uv.y = 3.0*a/3.1416;
				
				var w:Number = (0.5 + 0.5*s)*r*r;
				
				var ao:Number = 0.5 + 0.5*Math.cos(7.0*a);
				ao = smoothStep(0.0,0.4,ao)-smoothStep(0.4,0.7,ao);
				ao = 1.0-0.5*ao*r;
				
				uv.y=1.0-uv.y;
				dst = multiply(sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0)))),w*ao);
				dst.a=alpha;
				
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
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

void main(void)
{
	vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
	vec2 uv;
	
	float r = sqrt( dot(p,p) );
	float a = atan(p.y,p.x) + 0.5*sin(0.5*r-0.5*time);
	
	float s = 0.5 + 0.5*cos(7.0*a);
	s = smoothstep(0.0,1.0,s);
	s = smoothstep(0.0,1.0,s);
	s = smoothstep(0.0,1.0,s);
	s = smoothstep(0.0,1.0,s);
	
	uv.x = time + 1.0/( r + .2*s);
	uv.y = 3.0*a/3.1416;
	
	float w = (0.5 + 0.5*s)*r*r;
	
	vec3 col = texture2D(tex0,uv).xyz;
	
	float ao = 0.5 + 0.5*cos(7.0*a);
	ao = smoothstep(0.0,0.4,ao)-smoothstep(0.4,0.7,ao);
	ao = 1.0-0.5*ao*r;
	
	gl_FragColor = vec4(col*w*ao,1.0);
}
*/