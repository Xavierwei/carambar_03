/***
AS3Metablob
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 01:23:11
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
	
	public class AS3Metablob extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Metablob(){
			super("Metablob");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				//the centre point for each blob
				var move1:Float2=new Float2(Math.cos(time)*0.4,Math.sin(time*1.5)*0.4);
				var move2:Float2=new Float2(Math.cos(time*2.0)*0.4,Math.sin(time*3.0)*0.4);
				
				//screen coordinates
				var p:Float2 = subtract(multiply(2.0,divide(outCoord(),srcSize)),1.0);
				
				//radius for each blob
				var r1:Number =(dot(subtract(p,move1),subtract(p,move1)))*8.0;
				var r2:Number =(dot(add(p,move2),add(p,move2)))*16.0;
				
				//sum the meatballs
				var metaball:Number =(1.0/r1+1.0/r2);
				//alter the cut-off power
				var col:Number = Math.pow(metaball,8.0);
				
				//set the output color
				dst=new Pixel4(col,col,col,alpha);
				
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

void main(void)
{
	//the centre point for each blob
	vec2 move1;
	move1.x = cos(time)*0.4;
	move1.y = sin(time*1.5)*0.4;
	vec2 move2;
	move2.x = cos(time*2.0)*0.4;
	move2.y = sin(time*3.0)*0.4;
	
	//screen coordinates
	vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
	
	//radius for each blob
	float r1 =(dot(p-move1,p-move1))*8.0;
	float r2 =(dot(p+move2,p+move2))*16.0;
	
	//sum the meatballs
	float metaball =(1.0/r1+1.0/r2);
	//alter the cut-off power
	float col = pow(metaball,8.0);
	
	//set the output color
	gl_FragColor = vec4(col,col,col,1.0);
}
*/