/***
AS3Monjori
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 14:41:41
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
	
	public class AS3Monjori extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Monjori(){
			super("Monjori");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var p:Float2 = divide(subtract(multiply(2.0,outCoord()),srcSize),srcSize.y);
				
				var a:Number = time*40.0;
				var g:Number=1.0/40.0;
				var e:Number=400.0*(p.x*0.5+0.5);
				var f:Number=400.0*(p.y*0.5+0.5);
				var i:Number=200.0+Math.sin(e*g+a/150.0)*20.0;
				var d:Number=200.0+Math.cos(f*g/2.0)*18.0+Math.cos(e*g)*7.0;
				var r:Number=Math.sqrt(Math.pow(i-e,2.0)+Math.pow(d-f,2.0));
				var q:Number=f/r;
				e=(r*Math.cos(q))-a/2.0;f=(r*Math.sin(q))-a/2.0;
				d=Math.sin(e*g)*176.0+Math.sin(e*g)*164.0+r;
				var h:Number=((f+d)+a/2.0)*g;
				i=Math.cos(h+r*p.x/1.3)*(e+e+a)+Math.cos(q*g*6.0)*(r+h/3.0);
				h=Math.sin(f*g)*144.0-Math.sin(e*g)*212.0*p.x;
				h=(h+(f-e)*q+Math.sin(r-(a+h)/7.0)*10.0+i/4.0)*g;
				i+=Math.cos(h*2.3*Math.sin(a/350.0-q))*184.0*Math.sin(q-(r*4.3+a/12.0)*g)+Math.tan(r*g+h)*184.0*Math.cos(r*g+h);
				i=mod(i/5.6,256.0)/64.0;
				if(i<0.0){
					i+=4.0;
				}
				if(i>=2.0){
					i=4.0-i;
				}
				d=r/350.0;
				d+=Math.sin(d*d*8.0)*0.52;
				f=(Math.sin(a*g)+1.0)/2.0;
				dst=add(
					multiply(
						new Pixel4(
							f*i/1.6,
							i/2.0+d/13.0,
							i,
							1
						),d*p.x
					),multiply(
						new Pixel4(
							i/1.3+d/8.0,
							i/2.0+d/18.0,
							i,
							1
						),d*(1.0-p.x)
					)
				);
				dst.a=alpha;
				
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
	vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
	float a = time*40.0;
	float d,e,f,g=1.0/40.0,h,i,r,q;
	e=400.0*(p.x*0.5+0.5);
	f=400.0*(p.y*0.5+0.5);
	i=200.0+sin(e*g+a/150.0)*20.0;
	d=200.0+cos(f*g/2.0)*18.0+cos(e*g)*7.0;
	r=sqrt(pow(i-e,2.0)+pow(d-f,2.0));
	q=f/r;
	e=(r*cos(q))-a/2.0;f=(r*sin(q))-a/2.0;
	d=sin(e*g)*176.0+sin(e*g)*164.0+r;
	h=((f+d)+a/2.0)*g;
	i=cos(h+r*p.x/1.3)*(e+e+a)+cos(q*g*6.0)*(r+h/3.0);
	h=sin(f*g)*144.0-sin(e*g)*212.0*p.x;
	h=(h+(f-e)*q+sin(r-(a+h)/7.0)*10.0+i/4.0)*g;
	i+=cos(h*2.3*sin(a/350.0-q))*184.0*sin(q-(r*4.3+a/12.0)*g)+tan(r*g+h)*184.0*cos(r*g+h);
	i=mod(i/5.6,256.0)/64.0;
	if(i<0.0) i+=4.0;
	if(i>=2.0) i=4.0-i;
	d=r/350.0;
	d+=sin(d*d*8.0)*0.52;
	f=(sin(a*g)+1.0)/2.0;
	gl_FragColor=vec4(vec3(f*i/1.6,i/2.0+d/13.0,i)*d*p.x+vec3(i/1.3+d/8.0,i/2.0+d/18.0,i)*d*(1.0-p.x),1.0);
}
*/
