/***
AS3Twist
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 15:12:19
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
	
	public class AS3Twist extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Twist(){
			super("Twist");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var p:Float2 = subtract(multiply(2.0,divide(outCoord(),srcSize)),1.0);
				var uv:Float2=new Float2(0.0,0.0);
				
				var a:Number = Math.atan2(p.y,p.x);
				var r:Number = Math.sqrt(dot(p,p));
				
				uv.x = r - .25*time;
				uv.y = Math.cos(a*5.0 + 2.0*Math.sin(time+7.0*r)) ;
				
				var w:Number = .5+.5*uv.y;
				uv.y=1.0-uv.y;
				dst = multiply(w,sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0)))));
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
	
	float a = atan(p.y,p.x);
	float r = sqrt(dot(p,p));
	
	uv.x = r - .25*time;
	uv.y = cos(a*5.0 + 2.0*sin(time+7.0*r)) ;
	
	vec3 col =  (.5+.5*uv.y)*texture2D(tex0,uv).xyz;
	
	gl_FragColor = vec4(col,1.0);
}
*/