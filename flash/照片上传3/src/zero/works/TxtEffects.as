/***
TxtEffects
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月4日 19:21:47
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class TxtEffects extends Sprite{
		public var txt1:TxtEffect;
		public var txt2:TxtEffect;
		public function TxtEffects(){
			value=0;
			//txt1.x=-(txt1.width/2+1);
			//txt2.x=(txt2.width/2+1);
		}
		
		private var __value:int;
		public function get value():int{
			return __value;
		}
		public function set value(_value:int):void{
			if(__value==_value){
				return;
			}
			__value=_value;
			txt1.value=int(__value/10);
			txt2.value=__value%10;
		}
	}
}
		