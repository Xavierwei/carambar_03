/***
AS3Yuanqiepian
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月05日 16:36:37
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//旋涡
//Fade.fromTo(mc,60,Yuanqiepian,
//	{alpha:1,num:10,radius:0,angle:360,alpha1:1,alpha2:0,showOutside:false,useFrames:true},
//	{alpha:1,num:10,radius:326,angle:0,alpha1:1,alpha2:1,showOutside:false}
//);

package zero.shaders.as3s.classic{
	import zero.shaders.Float2;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3Yuanqiepian extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var num:Number=1;
		xml.params[0].appendChild(<num description="同心圆数目" minValue="1" maxValue="100"/>);
		
		public var radius:Number=40;
		xml.params[0].appendChild(<radius description="半径" minValue="0" maxValue="2048"/>);
		
		public var angle:Number=0;
		xml.params[0].appendChild(<angle description="旋转角度" minValue="-360" maxValue="360"/>);
		
		public var alpha1:Number=1;
		xml.params[0].appendChild(<alpha1 description="透明度1" minValue="0" maxValue="1"/>);
		
		public var alpha2:Number=1;
		xml.params[0].appendChild(<alpha2 description="透明度2" minValue="0" maxValue="1"/>);
		
		public var showOutside:Boolean=true;
		xml.params[0].appendChild(<showOutside description="显示外框"/>);
		
		public function AS3Yuanqiepian(){
			super("圆切片");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				if(radius>0.0){
					var dx:Number=oc.x-center.x;
					var dy:Number=oc.y-center.y;
					var len2:Number=dx*dx+dy*dy;
					if(len2<radius*radius){
						len2=Math.sqrt(len2);
						var radian:Number=(
							angle
							-
							angle/num*Math.floor(
								len2*(num/radius)
							)
						)*(Math.PI/180);
						var c:Number=Math.cos(radian);
						var s:Number=Math.sin(radian);
						
						dst=sampleNearest(src,new Float2(
							center.x+dx*c+dy*s,
							center.y-dx*s+dy*c
						));
						
						dst.a*=alpha*(alpha1+(1.0-alpha1)*len2/radius)*(1.0-(1.0-alpha2)*(len2/radius));
						
					}else{
						if(showOutside){
							dst=sampleNearest(src,oc);
							dst.a*=alpha*alpha2;
						}else{
							dst=float4(0.0,0.0,0.0,0.0);
						}
					}
				}else{
					if(showOutside){
						dst=sampleNearest(src,oc);
						dst.a*=alpha*alpha2;
					}else{
						dst=float4(0.0,0.0,0.0,0.0);
					}
				}
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}