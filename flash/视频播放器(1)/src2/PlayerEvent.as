/***
PlayerEvent
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月22日 17:59:31
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.events.Event;

	public class PlayerEvent extends Event{
		public static const STATE_CHANGE:String="stateChange";
		public var state:String;
		public function PlayerEvent(_state:String){
			super(STATE_CHANGE);
			state=_state;
		}
	}
}