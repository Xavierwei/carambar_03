/***
AS3Flower
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 23:22:35
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
	
	public class AS3Flower extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Flower(){
			super("Flower");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var p:Float2 = divide(subtract(multiply(2.0,outCoord()),srcSize),srcSize.y);
				
				var a:Number = Math.atan2(p.x,p.y);
				var r:Number = length(p)*.75;
				
				var w:Number = Math.cos(3.1415927*time-r*2.0);
				var h:Number = 0.5+0.5*Math.cos(12.0*a-w*7.0+r*8.0);
				var d:Number = 0.25+0.75*Math.pow(h,1.0*r)*(0.7+0.3*w);
				
				var col:Number = ( d-r < 0.0 ? -1.0:1.0) * Math.sqrt(1.0-r/d)*r*2.5;
				col *= 1.25+0.25*Math.cos((12.0*a-w*7.0+r*8.0)/2.0);
				col *= 1.0 - 0.35*(0.5+0.5*Math.sin(r*30.0))*(0.5+0.5*Math.cos(12.0*a-w*7.0+r*8.0));
				
				dst=new Pixel4(
					col,
					col-h*0.5+r*.2 + 0.35*h*(1.0-r),
					col-h*r + 0.1*h*(1.0-r),
					alpha
				);
				
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

//float u( float x ) { return 0.5+0.5*sign(x); }
float u( float x ) { return (x>0.0)?1.0:0.0; }
//float u( float x ) { return abs(x)/x; }

void main(void)
{
	vec2 p = (2.0*gl_FragCoord.xy-resolution)/resolution.y;
	
	float a = atan(p.x,p.y);
	float r = length(p)*.75;
	
	float w = cos(3.1415927*time-r*2.0);
	float h = 0.5+0.5*cos(12.0*a-w*7.0+r*8.0);
	float d = 0.25+0.75*pow(h,1.0*r)*(0.7+0.3*w);
	
	float col = u( d-r ) * sqrt(1.0-r/d)*r*2.5;
	col *= 1.25+0.25*cos((12.0*a-w*7.0+r*8.0)/2.0);
	col *= 1.0 - 0.35*(0.5+0.5*sin(r*30.0))*(0.5+0.5*cos(12.0*a-w*7.0+r*8.0));
	gl_FragColor = vec4(
		col,
		col-h*0.5+r*.2 + 0.35*h*(1.0-r),
		col-h*r + 0.1*h*(1.0-r),
		1.0);
}
*/