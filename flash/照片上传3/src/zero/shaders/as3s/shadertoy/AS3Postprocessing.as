/***
AS3Postprocessing
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 00:05:55
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
	
	public class AS3Postprocessing extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Postprocessing(){
			super("Postprocessing");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var q:Float2 = divide(outCoord(),srcSize);
				var uv:Float2 = add(0.5,multiply(subtract(q,0.5),(0.9 + 0.1*Math.sin(0.2*time))));
				
				var oricol:Pixel4 = sampleNearest(src,new Float2(mod(q.x,1.0)*(srcSize.x-1.0),mod(q.y,1.0)*(srcSize.y-1.0)));
				uv.y=1.0-uv.y;
				dst=new Pixel4(
					sampleNearest(src,new Float2(mod(uv.x+0.003,1.0)*(srcSize.x-1.0),mod(-uv.y,1.0)*(srcSize.y-1.0))).r,
					sampleNearest(src,new Float2(mod(uv.x+0.000,1.0)*(srcSize.x-1.0),mod(-uv.y,1.0)*(srcSize.y-1.0))).g,
					sampleNearest(src,new Float2(mod(uv.x-0.003,1.0)*(srcSize.x-1.0),mod(-uv.y,1.0)*(srcSize.y-1.0))).b,
					1
				);
				uv.y=1.0-uv.y;
				
				dst = clamp(add(multiply(dst,0.5),multiply(multiply(multiply(0.5,dst),dst),1.2)),0.0,1.0);
				
				dst = multiply(dst,0.5 + 0.5*16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y));
				
				dst = multiply(dst,new Pixel4(0.8,1.0,0.7,1.0));
				
				dst = multiply(dst,0.9+0.1*Math.sin(10.0*time+uv.y*1000.0));
				
				dst = multiply(dst,0.97+0.03*Math.sin(110.0*time));
				
				var comp:Number = smoothStep( 0.2, 0.7, Math.sin(time) );
				dst = mix( dst, oricol, clamp(-2.0+2.0*q.x+3.0*comp,0.0,1.0) );
				
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
uniform sampler2D tex2;

void main(void)
{
	vec2 q = gl_FragCoord.xy / resolution.xy;
	vec2 uv = 0.5 + (q-0.5)*(0.9 + 0.1*sin(0.2*time));
	
	vec3 oricol = texture2D(tex0,vec2(q.x,1.0-q.y)).xyz;
	vec3 col;
	
	col.r = texture2D(tex0,vec2(uv.x+0.003,-uv.y)).x;
	col.g = texture2D(tex0,vec2(uv.x+0.000,-uv.y)).y;
	col.b = texture2D(tex0,vec2(uv.x-0.003,-uv.y)).z;
	
	col = clamp(col*0.5+0.5*col*col*1.2,0.0,1.0);
	
	col *= 0.5 + 0.5*16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y);
	
	col *= vec3(0.8,1.0,0.7);
	
	col *= 0.9+0.1*sin(10.0*time+uv.y*1000.0);
	
	col *= 0.97+0.03*sin(110.0*time);
	
	float comp = smoothstep( 0.2, 0.7, sin(time) );
	col = mix( col, oricol, clamp(-2.0+2.0*q.x+3.0*comp,0.0,1.0) );
	
	gl_FragColor = vec4(col,1.0);
}
*/