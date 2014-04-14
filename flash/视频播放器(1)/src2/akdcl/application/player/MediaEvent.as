package akdcl.application.player {
	import flash.events.Event;
	/**
	 * ...
	 * @author Akdcl
	 */
	/// @eventType	akdcl.application.player.MediaEvent.LIST_CHANGE
	[Event(name = "listChange", type = "akdcl.application.player.MediaEvent")]
	
	/// @eventType	akdcl.application.player.MediaEvent.VOLUME_CHANGE
	[Event(name = "volumeChange", type = "akdcl.application.player.MediaEvent")]

	/// @eventType	akdcl.application.player.MediaEvent.STATE_CHANGE
	[Event(name = "stateChange", type = "akdcl.application.player.MediaEvent")]
	
	/// @eventType	akdcl.application.player.MediaEvent.PLAY_ID_CHANGE
	[Event(name = "playIDChange", type = "akdcl.application.player.MediaEvent")]

	/// @eventType	akdcl.application.player.MediaEvent.PLAY_PROGRESS
	[Event(name = "playProgress", type = "akdcl.application.player.MediaEvent")]

	/// @eventType	akdcl.application.player.MediaEvent.PLAY_COMPLETE
	[Event(name = "playComplete", type = "akdcl.application.player.MediaEvent")]

	/// @eventType	akdcl.application.player.MediaEvent.LOAD_ERROR
	[Event(name = "loadError", type = "akdcl.application.player.MediaEvent")]

	/// @eventType	akdcl.application.player.MediaEvent.BUFFER_PROGRESS
	[Event(name = "bufferProgress", type = "akdcl.application.player.MediaEvent")]
	
	/// @eventType	akdcl.application.player.MediaEvent.LOAD_PROGRESS
	[Event(name = "loadProgress", type = "akdcl.application.player.MediaEvent")]
	
	/// @eventType	akdcl.application.player.MediaEvent.LOAD_COMPLETE
	[Event(name = "loadComplete", type = "akdcl.application.player.MediaEvent")]
	
	public class MediaEvent extends Event {
		public static const LIST_CHANGE : String = "listChange";
		public static const VOLUME_CHANGE : String = "volumeChange";
		public static const STATE_CHANGE : String = "stateChange";
		public static const PLAY_ID_CHANGE : String = "playIDChange";
		public static const PLAY_PROGRESS : String = "playProgress";
		public static const PLAY_COMPLETE : String = "playComplete";
		public static const LOAD_ERROR : String = "loadError";
		public static const BUFFER_PROGRESS : String = "bufferProgress";
		public static const LOAD_PROGRESS : String = "loadProgress";
		public static const LOAD_COMPLETE : String = "loadComplete";
		public function MediaEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void {
			super(type, bubbles, cancelable);
		}
	}
	
}