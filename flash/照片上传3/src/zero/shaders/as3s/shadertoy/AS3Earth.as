/***
AS3Earth
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 17:29:01
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
	import zero.shaders.Float3;
	import zero.shaders.Pixel4;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3Earth extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var time:Number=0;
		xml.params[0].appendChild(<time description="uniform float time: current time in seconds." minValue="0" maxValue="10"/>);
		
		public function AS3Earth(){
			super("Earth（卡；不兼容flash）");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				// render this with four sampels per pixel
				//var col0:Pixel4 = doit( divide(add(outCoord(),new Float2(0.0,0.0) ),srcSize) );
				//var col1:Pixel4 = doit( divide(add(outCoord(),new Float2(0.5,0.0) ),srcSize) );
				//var col2:Pixel4 = doit( divide(add(outCoord(),new Float2(0.0,0.5) ),srcSize) );
				//var col3:Pixel4 = doit( divide(add(outCoord(),new Float2(0.5,0.5) ),srcSize) );
				
				var t:Number=0.0;
				var nor:Float3=new Float3(0,0,0);
				var uv:Float2=new Float2(0,0);
				
				var pix:Float2=divide(add(outCoord(),new Float2(0.0,0.0) ),srcSize);
				var p:Float2 = subtract(multiply(2.0,pix),1.0);
				p.x *= srcSize.x/srcSize.y;
				
				var ro:Float3 = new Float3( 0.0, 0.0, 2.5);
				var rd:Float3 = normalize( new Float3( p.x,p.y, -2.0) );
				
				var col0:Pixel4 = new Pixel4(0.0,0.0,0.0,1.0);
				
				// intersect sphere
				var b:Number = dot(ro,rd);
				var c:Number = dot(ro,ro) - 1.0;
				var h:Number = b*b - c;
				if( h>0.0 )
				{
					t = -b - Math.sqrt(h);
					nor = add(ro , multiply(t,rd));
					
					// texture mapping
					uv=new Float2(
						Math.atan2(nor.x,nor.z)/6.2831 - 0.05*time - center.x/srcSize.x,
						Math.acos(nor.y)/3.1416
					);
					if(uv.y>0.5){
						uv.y = 0.5 + Math.pow( uv.y-0.5, 1.2 );
					}else{
						uv.y = 0.5 - Math.pow( 0.5-uv.y, 1.2 );
					}
					uv.y=1.0-uv.y;
					col0 = sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0))));
					
					// lighting
					col0 = multiply(col0,0.3 + 0.7*Math.max(nor.x*2.0+nor.z,0.0));
				}
				
				pix=divide(add(outCoord(),new Float2(0.5,0.0) ),srcSize);
				p = subtract(multiply(2.0,pix),1.0);
				p.x *= srcSize.x/srcSize.y;
				
				ro = new Float3( 0.0, 0.0, 2.5);
				rd = normalize( new Float3( p.x,p.y, -2.0) );
				
				var col1:Pixel4 = new Pixel4(0.0,0.0,0.0,1.0);
				
				// intersect sphere
				b = dot(ro,rd);
				c = dot(ro,ro) - 1.0;
				h = b*b - c;
				if( h>0.0 )
				{
					t = -b - Math.sqrt(h);
					nor = add(ro , multiply(t,rd));
					
					// texture mapping
					uv=new Float2(
						Math.atan2(nor.x,nor.z)/6.2831 - 0.05*time - center.x/srcSize.x,
						Math.acos(nor.y)/3.1416
					);
					if(uv.y>0.5){
						uv.y = 0.5 + Math.pow( uv.y-0.5, 1.2 );
					}else{
						uv.y = 0.5 - Math.pow( 0.5-uv.y, 1.2 );
					}
					uv.y=1.0-uv.y;
					col1 = sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0))));
					
					// lighting
					col1 = multiply(col1,0.3 + 0.7*Math.max(nor.x*2.0+nor.z,0.0));
				}
				
				pix=divide(add(outCoord(),new Float2(0.0,0.5) ),srcSize);
				p = subtract(multiply(2.0,pix),1.0);
				p.x *= srcSize.x/srcSize.y;
				
				ro = new Float3( 0.0, 0.0, 2.5);
				rd = normalize( new Float3( p.x,p.y, -2.0) );
				
				var col2:Pixel4 = new Pixel4(0.0,0.0,0.0,1.0);
				
				// intersect sphere
				b = dot(ro,rd);
				c = dot(ro,ro) - 1.0;
				h = b*b - c;
				if( h>0.0 )
				{
					t = -b - Math.sqrt(h);
					nor = add(ro , multiply(t,rd));
					
					// texture mapping
					uv=new Float2(
						Math.atan2(nor.x,nor.z)/6.2831 - 0.05*time - center.x/srcSize.x,
						Math.acos(nor.y)/3.1416
					);
					if(uv.y>0.5){
						uv.y = 0.5 + Math.pow( uv.y-0.5, 1.2 );
					}else{
						uv.y = 0.5 - Math.pow( 0.5-uv.y, 1.2 );
					}
					uv.y=1.0-uv.y;
					col2 = sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0))));
					
					// lighting
					col2 = multiply(col2,0.3 + 0.7*Math.max(nor.x*2.0+nor.z,0.0));
				}
				
				pix=divide(add(outCoord(),new Float2(0.5,0.5) ),srcSize);
				p = subtract(multiply(2.0,pix),1.0);
				p.x *= srcSize.x/srcSize.y;
				
				ro = new Float3( 0.0, 0.0, 2.5);
				rd = normalize( new Float3( p.x,p.y, -2.0) );
				
				var col3:Pixel4 = new Pixel4(0.0,0.0,0.0,1.0);
				
				// intersect sphere
				b = dot(ro,rd);
				c = dot(ro,ro) - 1.0;
				h = b*b - c;
				if( h>0.0 )
				{
					t = -b - Math.sqrt(h);
					nor = add(ro , multiply(t,rd));
					
					// texture mapping
					uv=new Float2(
						Math.atan2(nor.x,nor.z)/6.2831 - 0.05*time - center.x/srcSize.x,
						Math.acos(nor.y)/3.1416
					);
					if(uv.y>0.5){
						uv.y = 0.5 + Math.pow( uv.y-0.5, 1.2 );
					}else{
						uv.y = 0.5 - Math.pow( 0.5-uv.y, 1.2 );
					}
					uv.y=1.0-uv.y;
					col3 = sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0))));
					
					// lighting
					col3 = multiply(col3,0.3 + 0.7*Math.max(nor.x*2.0+nor.z,0.0));
				}
				
				dst=multiply(add(add(add(col0,col1),col2),col3),0.25);
				dst.a=alpha;
				
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
		
		/*
		private function doit(pix:Float2):Pixel4{
			var p:Float2 = subtract(multiply(2.0,pix),1.0);
			p.x *= srcSize.x/srcSize.y;
			
			var ro:Float3 = new Float3( 0.0, 0.0, 2.5);
			var rd:Float3 = normalize( new Float3( p.x,p.y, -2.0) );
			
			var col:Pixel4 = new Pixel4(0.0,0.0,0.0,1.0);
			
			// intersect sphere
			var b:Number = dot(ro,rd);
			var c:Number = dot(ro,ro) - 1.0;
			var h:Number = b*b - c;
			if( h>0.0 )
			{
				var t:Number = -b - Math.sqrt(h);
				var nor:Float3 = add(ro , multiply(t,rd));
				
				// texture mapping
				var uv:Float2=new Float2(
					Math.atan2(nor.x,nor.z)/6.2831 - 0.05*time - center.x/srcSize.x,
					Math.acos(nor.y)/3.1416
				);
				if(uv.y>0.5){
					uv.y = 0.5 + Math.pow( uv.y-0.5, 1.2 );
				}else{
					uv.y = 0.5 - Math.pow( 0.5-uv.y, 1.2 );
				}
				uv.y=1.0-uv.y;
				col = sampleNearest(src,multiply(mod(uv,1.0),(subtract(srcSize,1.0))));
				
				// lighting
				col = multiply(col,0.3 + 0.7*Math.max(nor.x*2.0+nor.z,0.0));
			}
			
			return col;
		}
		*/
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

float spow( float x, float y ) { float s = sign( x ); return s*pow( s*x, y ); }

vec3 doit( in vec2 pix )
{
	vec2 p = -1.0 + 2.0*pix;
	p.x *= resolution.x/resolution.y;
	
	vec3 ro = vec3( 0.0, 0.0, 2.5 );
	vec3 rd = normalize( vec3( p, -2.0 ) );
	
	vec3 col = vec3(0.0);
	
	// intersect sphere
	float b = dot(ro,rd);
	float c = dot(ro,ro) - 1.0;
	float h = b*b - c;
	if( h>0.0 )
	{
		float t = -b - sqrt(h);
		vec3 pos = ro + t*rd;
		vec3 nor = pos;
		
		// texture mapping
		vec2 uv;
		uv.x = atan(nor.x,nor.z)/6.2831 - 0.05*time - mouse.x/resolution.x;
		uv.y = acos(nor.y)/3.1416;
		uv.y = 0.5 + spow( uv.y-0.5, 1.2 );
		col = texture2D(tex0,uv).xyz;
		
		// lighting
		col *= 0.3 + 0.7*max(nor.x*2.0+nor.z,0.0);
	}
	
	return col;
}

void main(void)
{
	// render this with four sampels per pixel
	vec3 col0 = doit( (gl_FragCoord.xy+vec2(0.0,0.0) )/resolution.xy );
	vec3 col1 = doit( (gl_FragCoord.xy+vec2(0.5,0.0) )/resolution.xy );
	vec3 col2 = doit( (gl_FragCoord.xy+vec2(0.0,0.5) )/resolution.xy );
	vec3 col3 = doit( (gl_FragCoord.xy+vec2(0.5,0.5) )/resolution.xy );
	vec3 col = 0.25*(col0 + col1 + col2 + col3);
	
	gl_FragColor = vec4(col,1.0);
}
*/