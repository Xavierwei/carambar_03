/***
AS3Pingpu
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月05日 00:12:48
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//从远到近
//Fade.fromTo(mc,24,Pingpu,
//	{alpha:1,focalLength:200,center_z:1024,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:45,rotationY:45,rotationZ:45,dis:20,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,dis:20}
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
	
	public class AS3Pingpu extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var dis:Number=0;
		xml.params[0].appendChild(<dis description="间距" minValue="-100" maxValue="100"/>);
		
		public function AS3Pingpu(){
			super("平铺");
		}
		
		override protected function updateParams():void{
			updateTransform();
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				var tranParamKK:Number=tranParam1+tranParam2*oc.x+tranParam3*oc.y;
				var x:Number=(tranParam4+tranParam5*oc.x+tranParam6*oc.y)/tranParamKK;
				var y:Number=(tranParam7+tranParam8*oc.x+tranParam9*oc.y)/-tranParamKK;
				
				//当 dis 为负值时图片裁剪部分不居中
				//x=mod(x,srcSize.x+dis);
				//y=mod(y,srcSize.y+dis);
				
				x=mod(x+dis*0.5,srcSize.x+dis)-dis*0.5;
				y=mod(y+dis*0.5,srcSize.y+dis)-dis*0.5;
				
				dst=sampleNearest(src,new Float2(x,y));
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}