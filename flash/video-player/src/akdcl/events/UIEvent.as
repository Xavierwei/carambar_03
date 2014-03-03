package akdcl.events {
	import flash.events.Event;

	/**
	 * ...
	 * @author ...
	 */
	public class UIEvent extends Event {
		public static const ROLL_OVER:String = "uiRollOver";
		public static const ROLL_OUT:String = "uiRollOut";
		public static const PRESS:String = "uiPress";
		public static const RELEASE:String = "uiPelease";
		public static const RELEASE_OUTSIDE:String = "uiReleaseOutside";
		public static const DRAG_OVER:String = "uiDragOver";
		public static const DRAG_OUT:String = "uiDragOut";
		public static const DRAG_MOVE:String = "uiDragMove";
		public static const UPDATE_STYLE:String = "uiUpdateStyle";

		public var isActive:Boolean;
		//public var userData:Object;
		
		override public function get target():Object 
		{
			return myTarget || super.target;
		}
		private var myTarget:Object;
		public function UIEvent(_type:String, _isActive:Boolean = false, _target:Object=null) {
			super(_type, false, false);
			isActive = _isActive;
			myTarget = _target;
		}
		
		override public function clone():Event 
		{
			var _e:UIEvent = new UIEvent(type, isActive, myTarget);
			//_e.userData = userData;
			return _e;
		}
	}

}