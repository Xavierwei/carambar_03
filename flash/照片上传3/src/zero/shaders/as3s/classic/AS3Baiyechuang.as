/***
AS3Baiyechuang
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 00:31:54
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//从无到有
//Fade.fromTo(mc,24,Baiyechuang,
//	{alpha:1,focalLength:200,dimension:20,angle:-90,useFrames:true},
//	{alpha:1,focalLength:200,dimension:20,angle:0}
//);

package zero.shaders.as3s.classic{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.shaders.Float2;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3Baiyechuang extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var dimension:Number=20;
		xml.params[0].appendChild(<dimension description="单元大小" minValue="1" maxValue="100"/>);
		
		public var angle:Number=0;
		xml.params[0].appendChild(<angle description="旋转角度" minValue="-360" maxValue="360"/>);
		
		protected function updateSC():void{
			angle_c=Math.cos(angle*(Math.PI/180));
			angle_s=Math.sin(angle*(Math.PI/180));
		}
		xml.constFuns[0].appendChild(<updateSC description="获取angle的余弦值和正弦值"/>);
		
		protected var angle_c:Number;
		xml.constParams[0].appendChild(<angle_c description="angle的余弦值"/>);
		
		protected var angle_s:Number;
		xml.constParams[0].appendChild(<angle_s description="angle的正弦值"/>);
		
		public function AS3Baiyechuang(){
			super("百页窗");
		}
		
		override protected function updateParams():void{
			updateSC();
		}
		
		override protected function evaluatePixel():void{
			if(angle_c==0.0){
				dst=float4(0.0,0.0,0.0,0.0);
			}else{
				var oc:Float2=outCoord();
				var centerX:Number=center.x+(Math.floor((oc.x-center.x)/dimension)+0.5)*dimension;
				var x:Number=oc.x-centerX;
				var y:Number=oc.y-center.y;
				x=x*focalLength/(focalLength+x*angle_s/angle_c);
				y=y*(focalLength+(x*angle_s/angle_c))/focalLength;
				x/=angle_c;
				if(x<-dimension*0.5||x>dimension*0.5){
					dst=float4(0.0,0.0,0.0,0.0);
				}else{
					dst=sampleNearest(src,new Float2(centerX+x,center.y+y));
					dst.a*=alpha;
				}
			}
		}
	}
}