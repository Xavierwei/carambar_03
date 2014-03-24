/***
AS3Star
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 14:56:27
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
	
	public class AS3Star extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Star(){
			super("Star");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var uv:Float2=new Float2(0.0,0.0);
				
				var p:Float2 = subtract(multiply(2.0,divide(outCoord(),srcSize)),1.0);
				var a:Number = Math.atan2(p.y,p.x);
				var r:Number = Math.sqrt(dot(p,p));
				var s:Number = r * (1.0+0.8*Math.cos(time*1.0));
				
				uv.x =          .02*p.y+.03*Math.cos(-time+a*3.0)/s;
				uv.y = .1*time +.02*p.x+.03*Math.sin(-time+a*3.0)/s;
				
				var w:Number = .9 + Math.pow(Math.max(1.5-r,0.0),4.0);
				
				w*=0.6+0.4*Math.cos(time+3.0*a);
				
				uv.y=1.0-uv.y;
				dst = multiply(sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0)))),w);
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

uniform float time;
uniform vec2 resolution;
uniform vec4 mouse;
uniform sampler2D tex0;
uniform sampler2D tex1;

void main(void)
{
	vec2 uv;
	
	vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
	float a = atan(p.y,p.x);
	float r = sqrt(dot(p,p));
	float s = r * (1.0+0.8*cos(time*1.0));
	
	uv.x =          .02*p.y+.03*cos(-time+a*3.0)/s;
	uv.y = .1*time +.02*p.x+.03*sin(-time+a*3.0)/s;
	
	float w = .9 + pow(max(1.5-r,0.0),4.0);
	
	w*=0.6+0.4*cos(time+3.0*a);
	
	vec3 col =  texture2D(tex0,uv).xyz;
	
	gl_FragColor = vec4(col*w,1.0);
}
*/