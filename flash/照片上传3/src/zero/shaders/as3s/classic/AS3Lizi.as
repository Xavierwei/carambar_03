/***
AS3Lizi
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 00:57:47
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//原地出现
//Fade.fromTo(mc,24,Lizi,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,ran_size:256,dimension:1,progress:0,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,ran_size:256,dimension:1,progress:1,follow:false}
//);

//翻滚出现
//Fade.fromTo(mc,24,Lizi,
//	{alpha:1,focalLength:200,center_z:100,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:45,rotationY:45,rotationZ:45,ran_size:256,dimension:1,progress:0,follow:true,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,ran_size:256,dimension:1,progress:1,follow:true}
//);

//燥动出现
//Fade.fromTo(mc,24,Lizi,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,ran_size:1,dimension:1,progress:0,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,ran_size:256,dimension:1,progress:1,follow:false}
//);

//风向右上角吹
//Fade.fromTo(mc,24,Lizi,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,ran_size:256,dimension:1,progress:0,follow:false,useFrames:true},
//	{center:new Float2(142,-8),alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,ran_size:256,dimension:1,progress:1,follow:false}
//);

//风向右上角吹2
//Fade.fromTo(mc,24,Lizi,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:45,rotationX:0,rotationY:0,rotationZ:0,ran_size:256,dimension:1,progress:0,follow:false,useFrames:true},
//	{center:new Float2(211,-26),alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,ran_size:256,dimension:1,progress:1,follow:false}
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
	
	public class AS3Lizi extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var dimension:Number=10;
		xml.params[0].appendChild(<dimension description="单元大小" minValue="1" maxValue="100"/>);
		
		public var progress:Number=0;
		xml.params[0].appendChild(<progress description="当前显示进度" minValue="0" maxValue="1"/>);
		
		public var follow:Boolean=false;
		xml.params[0].appendChild(<follow description="false像素不跟随矩阵；true像素跟随矩阵"/>);
		
		public function AS3Lizi(){
			super("粒子");
		}
		
		override protected function updateParams():void{
			updateTransform();
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0&&progress>0.0){
				var oc:Float2=outCoord();
				
				var tranParamKK:Number=tranParam1+tranParam2*oc.x+tranParam3*oc.y;
				var x:Number=(tranParam4+tranParam5*oc.x+tranParam6*oc.y)/tranParamKK;
				var y:Number=(tranParam7+tranParam8*oc.x+tranParam9*oc.y)/-tranParamKK;
				
				if(follow){
					oc.x=x;
					oc.y=y;
				}
				
				if(progress<1.0){
					//貌似 sampleNearest(ran,...) 会不正确，只能 sample(ran,...)
					if(sample(ran,new Float2(
						mod(Math.floor(x/dimension)*dimension,ran_size),
						mod(Math.floor(y/dimension)*dimension,ran_size)
					))<progress*ran_size*ran_size){
						dst=sampleNearest(src,oc);
						dst.a*=alpha;
					}else{
						dst=float4(0.0,0.0,0.0,0.0);
					}
				}else{
					dst=sampleNearest(src,oc);
					dst.a*=alpha;
				}
				
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}