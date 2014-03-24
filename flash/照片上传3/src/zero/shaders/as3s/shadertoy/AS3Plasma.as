/***
AS3Plasma
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 11:01:53
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
	
	public class AS3Plasma extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Plasma(){
			super("Plasma");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var x:Number = outCoord().x;
				var y:Number = outCoord().y;
				var mov0:Number = x+y+Math.cos(Math.sin(time)*2.)*100.+Math.sin(x/100.)*1000.;
				var mov1:Number = y / srcSize.y / 0.2 + time;
				var mov2:Number = x / srcSize.x / 0.2;
				var c1:Number = Math.abs(Math.sin(mov1+time)/2.+mov2/2.-mov1-mov2+time);
				var c2:Number = Math.abs(Math.sin(c1+Math.sin(mov0/1000.+time)+Math.sin(y/40.+time)+Math.sin((x+y)/100.)*3.));
				var c3:Number = Math.abs(Math.sin(c2+Math.cos(mov1+mov2+c2)+Math.cos(mov2)+Math.sin(x/1000.)));
				dst = new Pixel4( c1,c2,c3,alpha);
				
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

uniform vec2 resolution;
uniform float time;

void main(void)
{
	float x = gl_FragCoord.x;
	float y = gl_FragCoord.y;
	float mov0 = x+y+cos(sin(time)*2.)*100.+sin(x/100.)*1000.;
	float mov1 = y / resolution.y / 0.2 + time;
	float mov2 = x / resolution.x / 0.2;
	float c1 = abs(sin(mov1+time)/2.+mov2/2.-mov1-mov2+time);
	float c2 = abs(sin(c1+sin(mov0/1000.+time)+sin(y/40.+time)+sin((x+y)/100.)*3.));
	float c3 = abs(sin(c2+cos(mov1+mov2+c2)+cos(mov2)+sin(x/1000.)));
	gl_FragColor = vec4( c1,c2,c3,1.0);
}
*/