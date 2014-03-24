/***
AS3Shunxi
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月19日 13:31:40
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//从左上角吸入
//Fade.fromTo(mc,24,Shunxi,
//	{center:new Float2(0,0),alpha:1,progress:0,useFrames:true},
//	{center:new Float2(0,0),alpha:1,progress:1}
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
	
	public class AS3Shunxi extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var progress:Number=0;
		xml.params[0].appendChild(<progress description="当前显示进度" minValue="0" maxValue="1"/>);
		
		protected function updateK():void{
			k=progress*Math.sqrt(srcSize.x*srcSize.x+srcSize.y*srcSize.y);
		}
		xml.constFuns[0].appendChild(<updateK description="获取k"/>);
		
		protected var k:Number;
		xml.constParams[0].appendChild(<k description="k"/>);
		
		public function AS3Shunxi(){
			super("吮吸");
		}
		
		override protected function updateParams():void{
			updateK();
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var xy:Float2=subtract(
					outCoord(),
					center
				);
				dst=sampleNearest(src,add(
					center,
					multiply(
						xy,1.0+k/length(xy)
					)
				));
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}