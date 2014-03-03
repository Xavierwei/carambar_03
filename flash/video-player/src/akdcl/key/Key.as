package akdcl.key {
	import flash.events.EventDispatcher;

	public class Key extends EventDispatcher implements IKey {
		public var userData:Object;

		public function Key(_code:*, _name:String = null, _type:String = "system", _groupName:String = null):void {
			keyCode = (_code is Number) ? _code : String(_code).toUpperCase().charCodeAt(0);
			keyName = _name || String.fromCharCode(keyCode);
			type = _type;
			groupName = _groupName;
			//isUp(true);
		}

		//
		public function isDown(_state:Boolean = false):Boolean {
			var _outB:Boolean = _state;
			if (_state){
				__holdTime++;
				__voidTime = 0;
			}
			__holdTime && (_outB = true);
			return _outB;
		}

		public function isUp(_state:Boolean = false):Boolean {
			var _outB:Boolean = _state;
			if (_state){
				__voidTime++;
				__holdTime = 0;
			}
			__voidTime && (_outB = true);
			return _outB;
		}
		//
		private var __keyCode:uint;

		public function get keyCode():uint {
			return __keyCode;
		}

		public function set keyCode(_code:uint):void {
			__keyCode = _code;
		}
		private var __keyName:String;

		public function get keyName():String {
			return __keyName;
		}

		public function set keyName(_name:String):void {
			__keyName = _name;
		}
		private var __type:String;

		public function get type():String {
			return __type;
		}

		public function set type(type:String):void {
			__type = type;
		}
		private var __groupName:String;

		public function get groupName():String {
			return __groupName;
		}

		public function set groupName(_name:String):void {
			__groupName = _name;
		}
		private var __groupID:int = -1;

		public function get groupID():int {
			return __groupID;
		}

		public function set groupID(_id:int):void {
			var oldID:int = __groupID;
			__groupID = _id;
			if (oldID != -1 && oldID != _id){
				var e:KeyEvent = new KeyEvent(KeyEvent.KEY_CHANGE);
				this.dispatchEvent(e);
			}
		}
		private var __combined:Boolean;

		public function get combined():Boolean {
			return __combined;
		}

		public function set combined(type:Boolean):void {
			__combined = type;
		}
		private var __disable:Boolean;

		public function get disable():Boolean {
			return __disable;
		}

		public function set disable(boolean:Boolean):void {
			__disable = boolean;
		}
		private var __holdTime:uint;

		public function get holdTime():uint {
			return __holdTime;
		}

		public function set holdTime(time:uint):void {
			__holdTime = time;
		}
		private var __voidTime:uint;

		public function set voidTime(time:uint):void {
			__voidTime = time;
		}

		public function get voidTime():uint {
			return __voidTime;
		}
	}
}