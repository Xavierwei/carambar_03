/***
AS3Deform
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 22:29:21
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//右下角到左上角
//Fade.fromTo(mc,24,Deform,
//	{center:new Float2(0,0),alpha:1,time:0,useFrames:true},
//	{center:new Float2(0,0),alpha:1,time:10}
//);

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
	
	public class AS3Deform extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Deform(){
			super("Deform");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var p:Float2 = subtract(multiply(2.0,divide(outCoord(),srcSize)),1.0);
				var m:Float2 = subtract(multiply(2.0,divide(center,srcSize)),1.0);
				
				var a1:Number = Math.atan2(p.y-m.y,p.x-m.x);
				var r1:Number = Math.sqrt(dot(subtract(p,m),subtract(p,m)));
				var a2:Number = Math.atan2(p.y+m.y,p.x+m.x);
				var r2:Number = Math.sqrt(dot(add(p,m),add(p,m)));
				
				var uv:Float2=new Float2(
					0.2*time + (r1-r2)*0.25,
					Math.sin(2.0*(a1-a2))
				);
				
				var w:Number = r1*r2*0.8;
				uv.y=1.0-uv.y;
				dst = divide(sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0)))),(0.1+w));
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
	vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
	vec2 m = -1.0 + 2.0 * mouse.xy / resolution.xy;
	
	float a1 = atan(p.y-m.y,p.x-m.x);
	float r1 = sqrt(dot(p-m,p-m));
	float a2 = atan(p.y+m.y,p.x+m.x);
	float r2 = sqrt(dot(p+m,p+m));
	
	vec2 uv;
	uv.x = 0.2*time + (r1-r2)*0.25;
	uv.y = sin(2.0*(a1-a2));
	
	float w = r1*r2*0.8;
	vec3 col = texture2D(tex0,uv).xyz;
	
	gl_FragColor = vec4(col/(.1+w),1.0);
}
*/