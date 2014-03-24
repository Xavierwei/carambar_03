/***
AS3Smudger
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 16:08:58
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

/////////////////////////////////////////////////////
//  smudger
//
//	author 	   : frank reitberger
//	blog 	   : http://www.prinzipiell.com
//  copyright 2008
//
/////////////////////////////////////////////////////

//出现
//Fade.fromTo(mc,24,Smudger,
//	{alpha:1,dimension:5,amount:5,useFrames:true},
//	{alpha:1,dimension:5,amount:0}
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
	
	public class AS3Smudger extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var dimension:Number=5;
		xml.params[0].appendChild(<dimension description="单元大小" minValue="0" maxValue="100"/>);
		
		public var amount:Number=0.5;
		xml.params[0].appendChild(<amount description="amount" minValue="0" maxValue="5"/>);
		
		public function AS3Smudger(){
			super("水斑点马赛克");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var pos : Float2   = outCoord();
				
				//////////////////////////
				// patterize transition
				//////////////////////////  
				var nx : Number     = dimension * (Math.cos(pos.y / dimension));
				var ny : Number     = dimension * (Math.cos(pos.x / dimension));  
				var pnt : Float2   = new Float2(  nx*ny , nx* ny  );
				dst = sampleNearest( src, add(pos, multiply(pnt , amount)));     
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}