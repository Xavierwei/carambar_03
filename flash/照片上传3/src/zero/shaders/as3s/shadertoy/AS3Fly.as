/***
AS3Fly
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 17:04:03
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
	
	public class AS3Fly extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Fly(){
			super("Fly");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var p:Float2 = subtract(multiply(2.0,divide(outCoord(),srcSize)),1.0);
				var uv:Float2=new Float2(0.0,0.0);
				
				var an:Number = time*.25;
				
				var x:Number = p.x*Math.cos(an)-p.y*Math.sin(an);
				var y:Number = p.x*Math.sin(an)+p.y*Math.cos(an);
				
				uv.x = .25*x/Math.abs(y);
				uv.y = .20*time + .25/Math.abs(y);
				
				uv.y=1.0-uv.y;
				dst = multiply(sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0)))),y*y);
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
	
	float an = time*.25;
	
	float x = p.x*cos(an)-p.y*sin(an);
	float y = p.x*sin(an)+p.y*cos(an);
	
	uv.x = .25*x/abs(y);
	uv.y = .20*time + .25/abs(y);
	
	gl_FragColor = vec4(texture2D(tex0,uv).xyz * y*y, 1.0);
}
*/