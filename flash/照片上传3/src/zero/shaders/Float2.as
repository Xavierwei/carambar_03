/***
Float2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月01日 14:01:11
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
	
	public class Float2{
		public var x:Number;
		public var y:Number;
		public function Float2(_x:Number,_y:Number){
			x=_x;
			y=_y;
		}
		public function toString():String{
			return "Float2("+x+","+y+")";
		}
	}
}