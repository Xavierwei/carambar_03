package akdcl.net.events {
	import flash.events.Event;

	public class ResultEvent extends Event {
		public static const RESULT:String = "result";	

		public var result : Object;

		public function ResultEvent(type : String, result : Object,bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			this.result = result;
		}
	}
}
