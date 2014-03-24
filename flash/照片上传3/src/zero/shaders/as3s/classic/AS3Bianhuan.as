/***
AS3Bianhuan
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月03日 10:24:34
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//从透明到不透明
//Fade.fromTo(mc,24,Bianhuan,
//	{alpha:0,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0}
//);

//从远到近
//Fade.fromTo(mc,24,Bianhuan,
//	{alpha:0,focalLength:200,center_z:1024,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0}
//);

//从左到右
//Fade.fromTo(mc,24,Bianhuan,
//	{center:new Float2(-80,60),alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0}
//);

//纵向从小变大
//Fade.fromTo(mc,24,Bianhuan,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:0,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0}
//);

//斜切打开
//Fade.fromTo(mc,24,Bianhuan,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:90,skewY:0,rotationX:0,rotationY:0,rotationZ:0,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0}
//);

//翻滚出现
//Fade.fromTo(mc,24,Bianhuan,
//	{alpha:0,focalLength:200,center_z:1024,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:30,rotationY:-215,rotationZ:180,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0}
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
	
	public class AS3Bianhuan extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public function AS3Bianhuan(){
			super("变换");
		}
		
		override protected function updateParams():void{
			updateTransform();
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				var tranParamKK:Number=tranParam1+tranParam2*oc.x+tranParam3*oc.y;
				dst=sampleNearest(src,new Float2(
					(tranParam4+tranParam5*oc.x+tranParam6*oc.y)/tranParamKK,
					(tranParam7+tranParam8*oc.x+tranParam9*oc.y)/-tranParamKK
				));
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}