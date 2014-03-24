/***
AS3Xingzhuangzhezhao2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月05日 15:34:32
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//菊花旋转出现
//Fade.fromTo(mc,24,Xingzhuangzhezhao2,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:true,width:0,height:0,num:1,value1:1,value2:1,value3:0,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:10,scaleY:10,skewX:360,skewY:360,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:true,width:1,height:1,num:64,value1:1,value2:1,value3:0,follow:false}
//);

//十字从中间打开
//Fade.fromTo(mc,24,Xingzhuangzhezhao2,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:false,width:0,height:0,num:4,value1:1,value2:1,value3:0,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,isMask:false,width:120,height:120,num:4,value1:1,value2:1,value3:0,follow:false}
//);

//五角星旋转出现
//Fade.fromTo(mc,24,Xingzhuangzhezhao2,
//	{alpha:1,focalLength:200,center_z:0,scaleX:0,scaleY:0,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:2,isMask:true,width:200,height:200,num:5,value1:1,value2:1,value3:0.32,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:360,skewY:360,rotationX:0,rotationY:0,rotationZ:0,style:2,isMask:true,width:200,height:200,num:5,value1:1,value2:1,value3:0.32,follow:false}
//);

//一圈心旋转出现
//Fade.fromTo(mc,24,Xingzhuangzhezhao2,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:3,isMask:true,width:100,height:100,num:10,value1:0.2,value2:0,value3:1,follow:false,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:360,skewY:360,rotationX:0,rotationY:0,rotationZ:0,style:3,isMask:true,width:100,height:100,num:10,value1:0.2,value2:1,value3:1,follow:false}
//);

//斜线左上角打开
//Fade.fromTo(mc,24,Xingzhuangzhezhao2,
//	{center:new Float2(0,0),alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:135,skewY:135,rotationX:0,rotationY:0,rotationZ:0,style:2,isMask:true,width:0,height:2000,num:1,value1:1,value2:1,value3:1,follow:false,useFrames:true},
//	{center:new Float2(0,0),alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:135,skewY:135,rotationX:0,rotationY:0,rotationZ:0,style:2,isMask:true,width:2000,height:2000,num:1,value1:1,value2:1,value3:1,follow:false}
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
	
	public class AS3Xingzhuangzhezhao2 extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var style:uint=0;
		xml.params[0].appendChild(<style description="形状类型" enum="椭圆|矩形|菱形|心形"/>);
		
		public var isMask:Boolean=true;
		xml.params[0].appendChild(<isMask description="false挖孔；true遮罩"/>);
		
		public var width:Number=100;
		xml.params[0].appendChild(<width description="宽" minValue="0" maxValue="2048"/>);
		
		public var height:Number=100;
		xml.params[0].appendChild(<height description="高" minValue="0" maxValue="2048"/>);
		
		public var num:int=5;
		xml.params[0].appendChild(<num description="份数" minValue="1" maxValue="64"/>);
		
		public var value1:Number=1;
		xml.params[0].appendChild(<value1 description="控制量1" minValue="0" maxValue="1"/>);
		
		public var value2:Number=1;
		xml.params[0].appendChild(<value2 description="控制量2" minValue="0" maxValue="1"/>);
		
		public var value3:Number=1;
		xml.params[0].appendChild(<value3 description="控制量3" minValue="0" maxValue="1"/>);
		
		public var follow:Boolean=false;
		xml.params[0].appendChild(<follow description="false像素不跟随矩阵；true像素跟随矩阵"/>);
		
		public function AS3Xingzhuangzhezhao2(){
			super("形状遮罩（环阵）");
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
					
					x*=2.0/width;
					y*=2.0/height;
					
					if(num>1.0){
						
						var radian:Number=Math.atan2(y,x);
						
						/*
						var radian:Number;
						//atan2(y,x)：
						if(x<0.0&&y<=0.0){
							radian=Math.atan(y/x)-Math.PI;//(-90~90)-180=(-270~-90)
						}else if(x>=0.0&&y<0.0){
							radian=-Math.atan(x/y)-Math.PI*0.5;//(-90~90)-90=(-180~0)
						}else if(x>0.0&&y>=0.0){
							radian=Math.atan(y/x);//(-90~90)=(-90~90)
						}else if(x<=0.0&&y>0.0){
							radian=Math.PI*0.5-Math.atan(x/y);//90-(-90~90)=(0~180)
						}else{
							radian=0.0;
						}
						*/
						
						var dRad:Number=Math.PI*2/Number(num);//每份占的角度
						radian+=Math.PI*0.5+dRad*0.5;
						radian-=Math.floor(radian/dRad)*dRad;
						radian-=Math.PI*0.5+dRad*0.5;
						
						var len:Number=Math.sqrt(x*x+y*y);
						x=len*Math.cos(radian);
						y=len*Math.sin(radian);
					}
					
					var draw:Boolean;
					y=(y+value2)*value3;
					if(style==1){//矩形
						//value1 小矩形边长，0 为 0，1 为 大圆直径
						//value2 小矩形和大圆心的距离，0 为 0，1 为 大圆半径
						//value3 小矩形的扁度，0 为 正方形，1 为 无限扁
						draw=x>-value1&&x<value1&&y>-value1&&y<value1;
					}else if(style==2){
						//
						draw=x+y<value1&&x-y<value1&&-x+y<value1&&-x-y<value1;
					}else if(style==3){//心形
						//
						y-=0.213;
						y*=1.299;
						if(x<0.0){
							x*=-1.0;
						}
						var y_sqrt_x:Number=y+Math.sqrt(x*value1);
						draw=x*x+y_sqrt_x*y_sqrt_x<value1*value1;
					}/*else if(style==n){//心形（ρ=a（1+sinφ））
						//
						y+=0.770;
						y*=1.140;
						x*=1.315;
						var sqrtxxyy:Number=sqrt(x*x+y*y);
						draw=sqrtxxyy<1.0*(1.0+y/sqrtxxyy);
					}*/else{//椭圆
						//value1 小圆半径，0 为 0，1 为 大圆半径
						//value2 小圆和大圆心的距离，0 为 0，1 为 大圆半径
						//value3 小圆的扁度，0 为 正圆，1 为 无限扁
						draw=x*x+y*y<value1*value1;
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