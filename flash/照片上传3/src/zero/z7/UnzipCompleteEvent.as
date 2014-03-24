/***
UnzipCompleteEvent
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年08月30日 11:05:48
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.z7{
	import flash.events.Event;
	
	public class UnzipCompleteEvent extends Event{
		
		public static const COMPLETE:String="complete";
		
		public var output:String;
		
		public function UnzipCompleteEvent(_output:String){
			super(COMPLETE);
			output=_output;
		}
	}
}