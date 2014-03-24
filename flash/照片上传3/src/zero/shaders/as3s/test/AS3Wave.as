/***
AS3Wave
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月05日 00:29:24
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//干涉图样
//Fade.fromTo(mc,24,Wave,
//	{center1:new Float2(30,30),center2:new Float2(130,30),alpha:1,A1:4,w1:1,q1:0,A2:4,w2:1,q2:0,useFrames:true},
//	{center1:new Float2(30,30),center2:new Float2(130,30),alpha:1,A1:4,w1:1,q1:4,A2:4,w2:1,q2:4}
//);

//出现
//Fade.fromTo(mc,24,Wave,
//	{alpha:0,A1:10,w1:0.3,q1:0,A2:10,w2:0.3,q2:0,useFrames:true},
//	{alpha:1,A1:0,w1:0,q1:5,A2:0,w2:0,q2:5}
//);

//出现2
//Fade.fromTo(mc,24,Wave,
//	{center1:new Float2(40,60),center2:new Float2(120,60),alpha:0,A1:10,w1:0.3,q1:0,A2:10,w2:0.3,q2:0,useFrames:true},
//	{center1:new Float2(40,60),center2:new Float2(120,60),alpha:1,A1:0,w1:0,q1:5,A2:0,w2:0,q2:5}
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
	
	public class AS3Wave extends AS3BaseShader{
		
		public static const xml:XML=AS3BaseShader.xml.copy();
		
		public var center1:Float2=null;
		xml.params[0].appendChild(<center1 description="振源中心1"/>);
		
		public var A1:Number=10;
		xml.params[0].appendChild(<A1 description="振幅1" minValue="0" maxValue="100"/>);
		
		public var w1:Number=0.3;
		xml.params[0].appendChild(<w1 description="角速度1" minValue="0" maxValue="1"/>);
		
		public var q1:Number=0;
		xml.params[0].appendChild(<q1 description="初相1" minValue="0" maxValue="100"/>);
		
		public var center2:Float2=null;
		xml.params[0].appendChild(<center2 description="振源中心2"/>);
		
		public var A2:Number=10;
		xml.params[0].appendChild(<A2 description="振幅2" minValue="0" maxValue="100"/>);
		
		public var w2:Number=0.3;
		xml.params[0].appendChild(<w2 description="角速度2" minValue="0" maxValue="1"/>);
		
		public var q2:Number=0;
		xml.params[0].appendChild(<q2 description="初相2" minValue="0" maxValue="100"/>);
		
		public function AS3Wave(){
			super("波浪");
		}
		
		override protected function evaluatePixel():void{
			if(alpha>0.0){
				var oc:Float2=outCoord();
				var value:Number;
				if(A1==0.0){
					value=0.0;
				}else{
					value=A1*Math.sin(w1*distance(center1,oc)-q1);
				}
				if(A2==0.0){
					value;
				}else{
					value+=A2*Math.sin(w2*distance(center2,oc)-q2);
				}
				dst=sampleNearest(src,add(oc,value));
				dst.a*=alpha;
			}else{
				dst=float4(0.0,0.0,0.0,0.0);
			}
		}
	}
}