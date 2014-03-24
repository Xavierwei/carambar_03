/***
AS3Wanhuatong
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 16:40:04
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//突然出现
//Fade.fromTo(mc,24,Wanhuatong,
//	{alpha:1,num:16,scale:4,angle:-360,useFrames:true},
//	{alpha:1,num:1,scale:1,angle:0}
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
	
	public class AS3Wanhuatong extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var num:int=5;
		xml.params[0].appendChild(<num description="份数" minValue="1" maxValue="256"/>);
		
		public var scale:Number=1;
		xml.params[0].appendChild(<scale description="scale" minValue="-4" maxValue="4"/>);
		
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
		
		public function AS3Wanhuatong(){
			super("万花筒");
		}
		
		override protected function updateParams():void{
			updateSC();
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var oc:Float2=outCoord();
				
				var dx:Number=oc.x-center.x;
				var dy:Number=oc.y-center.y;
				
				var radian:Number=Math.atan2(dy,dx);
				
				var dRad:Number=Math.PI*2/Number(num);//每份占的角度
				radian+=Math.PI*0.5+dRad*0.5;
				radian-=Math.floor(radian/dRad)*dRad;
				radian-=Math.PI*0.5+dRad*0.5;
				
				var len:Number=Math.sqrt(dx*dx+dy*dy);
				
				dx=len*Math.cos(radian)*scale;
				dy=len*Math.sin(radian)*scale;
				
				dst=sampleNearest(src,new Float2(
					mod(center.x+(center.x-srcSize.x*0.5)+dx*angle_c+dy*angle_s,srcSize.x),
					mod(center.y+(center.y-srcSize.y*0.5)+dy*angle_c-dx*angle_s,srcSize.y)
				));
				dst.a*=alpha;
				
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}