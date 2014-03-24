/***
Float3
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月07日 10:01:14
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
	
	public class Float3{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public function Float3(_x:Number,_y:Number,_z:Number){
			x=_x;
			y=_y;
			z=_z;
		}
		public function toString():String{
			return "Float3("+x+","+y+","+z+")";
		}
	}
}