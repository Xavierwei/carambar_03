/***
AS3Chessboard
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月05日 00:36:16
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//黑白
//Fade.fromTo(mc,24,Chessboard,
//	{alpha:1,dimension:10,color1:new Pixel4(1,1,1,1),color2:new Pixel4(0,0,0,1),useFrames:true},
//	{alpha:1,dimension:10,color1:new Pixel4(1,1,1,1),color2:new Pixel4(0,0,0,1)}
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
	import zero.shaders.Pixel4;
	
	public class AS3Chessboard extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var dimension:Number=10;
		xml.params[0].appendChild(<dimension description="格子大小" minValue="1" maxValue="100"/>);
		
		public var color1:Pixel4=null;
		xml.params[0].appendChild(<color1 description="颜色1"/>);
		
		public var color2:Pixel4=null;
		xml.params[0].appendChild(<color2 description="颜色2"/>);
		
		public function AS3Chessboard(){
			super("棋盘");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				
				dst=sampleNearest(src,oc);
				
				if(mod(Math.floor(oc.x/dimension)+Math.floor(oc.y/dimension),2.0)==0.0){
					dst=multiply(dst,color1);
				}else{
					dst=multiply(dst,color2);
				}
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}