/***
AS3Pixelate
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月03日 09:23:58
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//溶解
//Fade.fromTo(mc,24,Pixelate,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,dimension:1,dis:0,useFrames:true},
//	{alpha:0,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:1,dimension:10,dis:0}
//);

//旋转颗粒
//Fade.fromTo(mc,24,Pixelate,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:-90,style:0,dimension:10,dis:0,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,style:0,dimension:10,dis:0}
//);

package zero.shaders.as3s.classic{
	import zero.shaders.Float2;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3Pixelate extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var style:uint=0;
		xml.params[0].appendChild(<style description="形状类型" enum="椭圆|矩形|菱形|心形"/>);
		
		public var dimension:Number=10;
		xml.params[0].appendChild(<dimension description="单元大小" minValue="1" maxValue="100"/>);
		
		public var dis:Number=0;
		xml.params[0].appendChild(<dis description="间距" minValue="-100" maxValue="100"/>);
		
		public function AS3Pixelate(){
			super("像素化");
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
				
				var x1:Number=Math.floor((x-cc.x)/(dimension+dis))*(dimension+dis)+cc.x;
				var y1:Number=Math.floor((y-cc.y)/(dimension+dis))*(dimension+dis)+cc.y;
				var x2:Number=x1+(dimension+dis);
				var y2:Number=y1+(dimension+dis);
				var x0:Number=(x1+x2)*0.5;
				var y0:Number=(y1+y2)*0.5;
				
				x-=x0;
				y-=y0;
				
				x*=2.0/dimension;
				y*=2.0/dimension;
				
				var z:Number;
				
				var draw:Boolean;
				if(style==1){//矩形
					if(dis==0.0){//否则可能会出现裂缝
						draw=true;
					}else{
						draw=x>-1.0&&x<1.0&&y>-1.0&&y<1.0;
					}
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
				
				if(draw){
					x=x0*ma+y0*md+mtx;
					y=x0*mb+y0*me+mty;
					z=x0*mc+y0*mf+mtz;
					x=x*focalLength/(focalLength+z)+o.x;
					y=y*focalLength/(focalLength+z)+o.y;
					x=clamp(x,0.0,srcSize.x-1.0);
					y=clamp(y,0.0,srcSize.y-1.0);
					dst=sampleNearest(src,new Float2(x,y));
					dst.a*=alpha;
				}else{
					dst=float4(0.0,0.0,0.0,0.0);
				}
				
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}