package akdcl.net.events {
	import com.klstudio.net.remoting.Fault;

	import flash.events.Event;

	public class FaultEvent extends Event {
		public static const FAULT : String = "fault";	

		public var fault : Fault;

		public function FaultEvent(type : String, fault : Fault,bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			this.fault = fault;
		}
	}
}
