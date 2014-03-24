/***
AS3SquareTunnel
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 16:59:59
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
	
	public class AS3SquareTunnel extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3SquareTunnel(){
			super("Square Tunnel");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var p:Float2 = subtract(multiply(2.0,divide(outCoord(),srcSize)),1.0);
				var uv:Float2=new Float2(0.0,0.0);
				
				var r:Number = Math.pow( Math.pow(p.x*p.x,16.0) + Math.pow(p.y*p.y,16.0), 1.0/32.0 );
				uv.x = .5*time + 0.5/r;
				uv.y = 1.0*Math.atan2(p.y,p.x)/3.1416;
				
				uv.y=1.0-uv.y;
				dst = multiply(sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0)))),r*r*r);
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
	
	float r = pow( pow(p.x*p.x,16.0) + pow(p.y*p.y,16.0), 1.0/32.0 );
	uv.x = .5*time + 0.5/r;
	uv.y = 1.0*atan(p.y,p.x)/3.1416;
	
	vec3 col =  texture2D(tex0,uv).xyz;
	
	gl_FragColor = vec4(col*r*r*r,1.0);
}
*/