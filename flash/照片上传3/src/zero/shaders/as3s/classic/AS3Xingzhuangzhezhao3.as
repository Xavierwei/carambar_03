/***
AS3Xingzhuangzhezhao3
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月05日 16:02:40
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//圆阵出现
//Fade.fromTo(mc,24,Xingzhuangzhezhao3,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:0,isMask:true,width:0,height:0,disX:20,disY:20,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:0,isMask:true,width:30,height:30,disX:-10,disY:-10,follow:false}
//);

//圆阵出现2
//Fade.fromTo(mc,24,Xingzhuangzhezhao3,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:45,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:0,isMask:true,width:0,height:0,disX:5,disY:5,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:0,isMask:true,width:30,height:30,disX:-10,disY:-10,follow:false}
//);

//方阵出现
//Fade.fromTo(mc,24,Xingzhuangzhezhao3,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:true,width:0,height:0,disX:20,disY:20,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:true,width:20,height:20,disX:0,disY:0,follow:false}
//);

//百页窗
//Fade.fromTo(mc,24,Xingzhuangzhezhao3,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:true,width:0,height:100,disX:30,disY:0,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:true,width:30,height:100,disX:0,disY:0,follow:false}
//);

//网格消失
//Fade.fromTo(mc,24,Xingzhuangzhezhao3,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:false,width:0,height:0,disX:1,disY:1,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:360,skewY:360,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:false,width:40,height:40,disX:0,disY:0,follow:false}
//);

//无数心从小到大
//Fade.fromTo(mc,24,Xingzhuangzhezhao3,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:3,isMask:true,width:0,height:0,disX:0,disY:0,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:360,skewY:360,rotationX:0,rotationY:0,rotationZ:0,style:3,isMask:true,width:340,height:340,disX:0,disY:0,follow:false}
//);

//上升出现
//Fade.fromTo(mc,24,Xingzhuangzhezhao3,
//	{center:new Float2(81,121),alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:2,isMask:true,width:0,height:0,disX:20,disY:20,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:2,isMask:true,width:40,height:40,disX:-20,disY:-20,follow:false}
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
	
	public class AS3Xingzhuangzhezhao3 extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var style:uint=0;
		xml.params[0].appendChild(<style description="形状类型" enum="椭圆|矩形|菱形|心形"/>);
		
		public var isMask:Boolean=true;
		xml.params[0].appendChild(<isMask description="false挖孔；true遮罩"/>);
		
		public var width:Number=20;
		xml.params[0].appendChild(<width description="宽" minValue="-100" maxValue="100"/>);
		
		public var height:Number=20;
		xml.params[0].appendChild(<height description="高" minValue="-100" maxValue="100"/>);
		
		public var disX:Number=0;
		xml.params[0].appendChild(<disX description="横间距" minValue="-100" maxValue="100"/>);
		
		public var disY:Number=0;
		xml.params[0].appendChild(<disY description="竖间距" minValue="-100" maxValue="100"/>);
		
		public var follow:Boolean=false;
		xml.params[0].appendChild(<follow description="false像素不跟随矩阵；true像素跟随矩阵"/>);
		
		public function AS3Xingzhuangzhezhao3(){
			super("形状遮罩（方阵）");
		}
		
		override protected function updateParams():void{
			updateTransform();
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				if(width==0.0||height==0.0){
					
					if(isMask){
						dst=float4(0.0,0.0,0.0,0.0);
					}else{
						dst=sampleNearest(src,outCoord());
						dst.a*=alpha;
					}
					
				}else{
					var oc:Float2=outCoord();
					
					var tranParamKK:Number=tranParam1+tranParam2*oc.x+tranParam3*oc.y;
					var x:Number=(tranParam4+tranParam5*oc.x+tranParam6*oc.y)/tranParamKK;
					var y:Number=(tranParam7+tranParam8*oc.x+tranParam9*oc.y)/-tranParamKK;
					
					if(follow){
						oc.x=x;
						oc.y=y;
					}
					
					x-=o.x;
					y-=o.y;
					
					x-=Math.floor(x/(width+disX)+0.5)*(width+disX);
					y-=Math.floor(y/(height+disY)+0.5)*(height+disY);
					
					x*=2.0/width;
					y*=2.0/height;
					
					var draw:Boolean;
					if(style==1){//矩形
						draw=x>-1.0&&x<1.0&&y>-1.0&&y<1.0;
					}else if(style==2){//菱形
						draw=x+y<1.0&&x-y<1.0&&-x+y<1.0&&-x-y<1.0;
					}else if(style==3){//心形
						y-=0.213;
						y*=1.299;
						if(x<0.0){
							x*=-1.0;
						}
						var y_sqrt_x:Number=y+Math.sqrt(x);
						draw=x*x+y_sqrt_x*y_sqrt_x<1.0;
					}/*else if(style==n){//心形（ρ=a（1+sinφ））
						y+=0.770;
						y*=1.140;
						x*=1.315;
						var sqrtxxyy:Number=sqrt(x*x+y*y);
						draw=sqrtxxyy<1.0*(1.0+y/sqrtxxyy);
					}*/else{//椭圆形
						draw=x*x+y*y<1.0;
					}
					
					//if(!mask){//!mask将会工作不正常
					//	draw=!draw;//draw=!draw将会工作不正常
					//}
					//if(draw){
					//	dst=sampleNearest(src,oc);
					//	dst.a*=alpha;
					//}else{
					//	dst=float4(0.0,0.0,0.0,0.0);
					//}
					
					if(xOr(isMask,draw)){
						dst=float4(0.0,0.0,0.0,0.0);
					}else{
						dst=sampleNearest(src,oc);
						dst.a*=alpha;
					}
					
				}
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}