/***
AS3Waiqu
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 11:44:49
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//旗帜
//Fade.fromTo(mc,24,Waiqu,
//	{center:new Float2(0,60),alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,strength:10,w:0.1,value1:0,value2:1,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,strength:10,w:0.1,value1:0,value2:1}
//);

//合上
//Fade.fromTo(mc,24,Waiqu,
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,strength:0,w:0.1,value1:0,value2:1,useFrames:true},
//	{alpha:1,focalLength:200,center_z:0,scaleX:1,scaleY:1,skewX:0,skewY:0,rotationX:0,rotationY:0,rotationZ:0,strength:0,w:0,value1:-1,value2:1}
//);

package zero.shaders.as3s.classic{
	import zero.shaders.Float2;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3Waiqu extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var strength:Number=0;
		xml.params[0].appendChild(<strength description="强度" minValue="-100" maxValue="100"/>);
		
		public var w:Number=0.1;
		xml.params[0].appendChild(<w description="角速度" minValue="-1" maxValue="1"/>);
		
		public var value1:Number=0;
		xml.params[0].appendChild(<value1 description="控制量1" minValue="-1" maxValue="1"/>);
		
		public var value2:Number=1;
		xml.params[0].appendChild(<value2 description="控制量2" minValue="-1" maxValue="1"/>);
		
		public function AS3Waiqu(){
			super("歪曲");
		}
		
		override protected function updateParams():void{
			updateTransform();
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				
				var oc:Float2=outCoord();
				
				var tranParamKK:Number=tranParam1+tranParam2*oc.x+tranParam3*oc.y;
				var x0:Number=(tranParam4+tranParam5*oc.x+tranParam6*oc.y)/tranParamKK;
				var y0:Number=(tranParam7+tranParam8*oc.x+tranParam9*oc.y)/-tranParamKK;
				
				var dx:Number=x0-o.x;
				var dy:Number=y0-o.y;
				var c:Number=Math.cos(dx*w);
				y0=o.y+dy*(1.0/(c*value1+value2))+strength*c;
				
				var x:Number=x0*ma+y0*md+mtx;
				var y:Number=x0*mb+y0*me+mty;
				var z:Number=x0*mc+y0*mf+mtz;
				x=x*focalLength/(focalLength+z)+o.x;
				y=y*focalLength/(focalLength+z)+o.y;
				
				dst=sampleNearest(src,new Float2(x,y));
				dst.a*=alpha;
				
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
	
	/*
	import zero.shaders.Float2;
	import zero.shaders.as3s.AS3BaseShader;
	
	public class AS3Waiqu extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var strength:Number=0;
		xml.params[0].appendChild(<strength description="强度" minValue="-100" maxValue="100"/>);
		
		public var w:Number=0.1;
		xml.params[0].appendChild(<w description="角速度" minValue="-1" maxValue="1"/>);
		
		public var value1:Number=0;
		xml.params[0].appendChild(<value1 description="控制量1" minValue="-1" maxValue="1"/>);
		
		public var value2:Number=1;
		xml.params[0].appendChild(<value2 description="控制量2" minValue="-1" maxValue="1"/>);
		
		public function AS3Waiqu(){
			super("歪曲");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				var dx:Number=oc.x-center.x;
				var dy:Number=oc.y-center.y;
				var c:Number=Math.cos(dx*w);
				oc.y=center.y+dy*(1.0/(c*value1+value2))+strength*c;
				dst=sampleNearest(src,oc);
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
	*/
	
}