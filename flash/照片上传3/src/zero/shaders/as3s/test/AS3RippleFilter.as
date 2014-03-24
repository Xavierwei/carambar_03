/***
AS3RippleFilter
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 15:42:54
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

/** Ripple filter by Boris van Schooten.
 * http://www.borisvanschooten.nl/ */

//水波纹
//Fade.fromTo(mc,24,RippleFilter,
//	{alpha:1,displacement:6,size:550,ripplewidth:20,phase:-10,lightbright:0.003,useFrames:true},
//	{alpha:1,displacement:6,size:550,ripplewidth:20,phase:10,lightbright:0.003}
//);

package zero.shaders.as3s.test{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.shaders.Float2;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3RippleFilter extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var displacement:Number=18;
		xml.params[0].appendChild(<displacement description="Displacement in pixels" minValue="0" maxValue="40"/>);
		
		public var size:Number=550;
		xml.params[0].appendChild(<size description="Size of effect in pixels" minValue="0" maxValue=" 8192"/>);
		
		public var ripplewidth:Number=32;
		xml.params[0].appendChild(<ripplewidth description="Size of single ripple in pixels" minValue="0" maxValue="512"/>);
		
		public var phase:Number=0;
		xml.params[0].appendChild(<phase description="Phase shift of ripple (change to animate)" minValue="-10" maxValue="10"/>);
		
		public var lightdir:Float2=null;
		xml.params[0].appendChild(<lightdir description="Light direction vector (must be normalised!)"/>);
		
		public var lightbright:Number=0;
		xml.params[0].appendChild(<lightbright description="Brightness of directional light source" minValue="0" maxValue="1"/>);
		
		public function AS3RippleFilter(){
			super("水波纹");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var pos : Float2 = outCoord();
				var ofs : Float2 = subtract(pos,center);
				
				// distance from center
				var r : Number = length(ofs);
				
				if (r < size) {
					// disp = # pixels to displace, ang = displace direction
					var disp : Number = (1.0 - r/size) * displacement
						* Math.sin(-phase + r/(ripplewidth/6.28));
					var ang : Number = Math.atan2(ofs.x,ofs.y);
					// brightness of pixel is based on displacement and angle between
					// displacement and lightdir
					var bright : Number = 1.0 + (lightbright*disp/displacement
						* (ofs.x*lightdir.x/r + ofs.y*lightdir.y/r) );
					dst = multiply(sampleNearest(src,
						new Float2(pos.x+disp*Math.sin(ang), pos.y+disp*Math.cos(ang))),bright);
				} else {
					dst = sampleNearest(src,pos);
				}
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}