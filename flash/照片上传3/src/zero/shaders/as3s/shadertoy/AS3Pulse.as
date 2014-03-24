/***
AS3Pulse
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 17:07:40
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
	
	public class AS3Pulse extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Pulse(){
			super("Pulse");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var halfres:Float2 = divide(srcSize,2.0);
				var cPos:Float2 = outCoord();
				
				cPos.x -= 0.5*halfres.x*Math.sin(time/2.0)+0.3*halfres.x*Math.cos(time)+halfres.x;
				cPos.y -= 0.4*halfres.y*Math.sin(time/5.0)+0.3*halfres.y*Math.cos(time)+halfres.y;
				var cLength:Number = length(cPos);
				
				var uv:Float2 = add(divide(outCoord(),srcSize),multiply(divide(cPos,cLength),Math.sin(cLength/30.0-time*10.0)/25.0));
				
				uv.y=1.0-uv.y;
				dst = multiply(sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0)))),50.0/cLength);
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

void main(void)
{
	vec2 halfres = resolution.xy/2.0;
	vec2 cPos = gl_FragCoord.xy;
	
	cPos.x -= 0.5*halfres.x*sin(time/2.0)+0.3*halfres.x*cos(time)+halfres.x;
	cPos.y -= 0.4*halfres.y*sin(time/5.0)+0.3*halfres.y*cos(time)+halfres.y;
	float cLength = length(cPos);
	
	vec2 uv = gl_FragCoord.xy/resolution.xy+(cPos/cLength)*sin(cLength/30.0-time*10.0)/25.0;
	vec3 col = texture2D(tex0,uv).xyz*50.0/cLength;
	
	gl_FragColor = vec4(col,1.0);
}
*/