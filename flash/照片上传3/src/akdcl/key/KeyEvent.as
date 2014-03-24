package akdcl.key{
	import flash.events.Event;
	public class KeyEvent extends Event {
		protected var _holdTime:uint;
		protected var _voidTime:uint;
		//
		static public var GROUP_START = "groupKeyStart";
		static public var CROSS_STOP = "groupKeyStop";
		//
		static public var KEY_CHANGE = "keyChange";
		//
		static public var KEY_UP = "keyUp";
		static public var KEY_DOWN = "keyDown";
		static public var KEY_HOLD = "keyHold";
		//
		static public var onCrossUp_UP = "CKUup";
		static public var onCrossUp_DOWN = "CKUdonw";
		static public var onCrossUp_LEFT = "CKUleft";
		static public var onCrossUp_RIGHT = "CKUright";
		static public var onCrossUp_LEFTUP = "CKUleftup";
		static public var onCrossUp_RIGHTUP = "CKUrightup";
		static public var onCrossUp_LEFTDOWN = "CKUleftdown";
		static public var onCrossUp_RIGHTDOWN = "CKUrightdown";
		static public var onCrossUp_NONE = "CKUnone";
		static public var onCrossUp_LEFTRIGHT = "CKUleftright";
		static public var onCrossUp_UPDOWN = "CKUupdown";
		//
		static public var onCrossDown_UP = "CKDup";
		static public var onCrossDown_DOWN = "CKDdown";
		static public var onCrossDown_LEFT = "CKDleft";
		static public var onCrossDown_RIGHT = "CKDright";
		static public var onCrossDown_LEFTUP = "CKDleftup";
		static public var onCrossDown_RIGHTUP = "CKDrightup";
		static public var onCrossDown_LEFTDOWN = "CKDleftdown";
		static public var onCrossDown_RIGHTDOWN = "CKDrightdown";
		static public var onCrossDown_LEFTRIGHT = "CKDleftright";
		static public var onCrossDown_UPDOWN = "CKDupdown";
		//
		static public var onCrossHold_UP = "CKHup";
		static public var onCrossHold_DOWN = "CKHdown";
		static public var onCrossHold_LEFT = "CKHleft";
		static public var onCrossHold_RIGHT = "CKHright";
		static public var onCrossHold_LEFTUP = "CKHleftup";
		static public var onCrossHold_RIGHTUP = "CKHrightup";
		static public var onCrossHold_LEFTDOWN = "CKHleftdown";
		static public var onCrossHold_RIGHTDOWN = "CKHrightdown";
		static public var onCrossHold_LEFTRIGHT = "CKHleftright";
		static public var onCrossHold_UPDOWN = "CKHupdown";
		//
		public function KeyEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, _key:Key = null, holdTime:uint = 0, voidTime:uint = 0):void {
			super(type, bubbles, cancelable);
			this._holdTime = holdTime;
			this._voidTime = voidTime;
			__key = _key;
		}
		private var __key:Key;
		public function get key():Key {
			return __key;
		}
		public function get keyCode():uint {
			return key.keyCode;
		}
		public function get keyName():String{
			return key.keyName;
		}
		public function get groupName():String {
			return key.groupName;
		}
		public function get groupID():int {
			return key.groupID;
		}
		private var __keysCode:int;
		public function get keysCode():int {
			return __keysCode;
		}
		public function set keysCode(_code:int):void {
			__keysCode=_code;
		}
		private var __keysName:String;
		public function get keysName():String {
			return __keysName;
		}
		public function set keysName(_name:String):void {
			__keysName=_name;
		}
		public function get voidTime():uint {
			return this._voidTime;
		}
		public function set voidTime(time:uint):void {
			this._voidTime=time;
		}
		public function get holdTime():uint {
			return this._holdTime;
		}
		public function set holdTime(time:uint):void {
			this._holdTime=time;
		}
	}
}