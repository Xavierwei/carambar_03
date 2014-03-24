/***
Pixel4
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月01日 18:03:21
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class Pixel4{
		public var r:Number;
		public var g:Number;
		public var b:Number;
		public var a:Number;
		public function Pixel4(_r:Number,_g:Number,_b:Number,_a:Number){
			r=_r;
			g=_g;
			b=_b;
			a=_a;
		}
		public function toString():String{
			return "Pixel4("+r+","+g+","+b+","+a+")";
		}
	}
}