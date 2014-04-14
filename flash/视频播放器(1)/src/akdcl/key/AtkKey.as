package akdcl.key {
	import flash.events.EventDispatcher;
	import akdcl.math.Combination;

	public class AtkKey extends EventDispatcher {
		protected var keyManager:KeyManager;
		protected var keyGroupName:String;
		protected var keyGroupID:uint;
		protected var keyCombList:Array;
		protected var keyComb:Combination;
		//
		protected var keyList:Array;
		protected var length:uint;

		//
		public function AtkKey(_keyManager:KeyManager, ... _keys){
			keyManager = _keyManager;
			keyList = new Array();
			for (var i:uint = 0; i < _keys.length; i++){
				if (_keys[i] is Key){
					keyList.push(_keys[i]);
				} else {
					throw new Error("[akdcl.key.AtkKey]无法把" + typeof _keys[i] + "转化为Key类");
				}
			}
			length = keyList.length;
			keyGroupName = keyManager.getNewGroupName();
			keyGroupID = keyManager.getGroupID(keyGroupName);
			//
			var _keysName:Array = new Array();
			for (i = 0; i < length; i++){
				keyList[i].combined = true;
				keyList[i].groupName = keyGroupName;
				keyList[i].groupID = keyGroupID;
				keyList[i].disable = true;
				keyManager.addKey(keyList[i]);
				_keysName.push(keyList[i].keyName);
			}
			//
			keyComb = new Combination(_keysName);
			_keysName = keyComb.getList();
			keyCombList = new Array();
			for (i = 0; i < _keysName.length; i++){
				keyCombList[_keysName[i].code] = _keysName[i].name;
			}
			//
			keyManager.addEventListener(KeyEvent.KEY_UP, keyUp);
			keyManager.addEventListener(KeyEvent.KEY_DOWN, keyDown);
			keyManager.addEventListener(KeyEvent.KEY_HOLD, keyHold);
		}

		public function start():void {
			for (var i:uint = 0; i < length; i++){
				keyList[i].disable = false;
			}
			dispatchEvent(new KeyEvent(KeyEvent.GROUP_START));
		}

		public function stop():void {
			for (var i:uint = 0; i < length; i++){
				keyList[i].disable = true;
			}
			dispatchEvent(new KeyEvent(KeyEvent.CROSS_STOP));
		}
		public var onKeyDown:Function;

		protected function keyDown(_evt:KeyEvent):void {
			if (_evt.groupID == keyGroupID){
				if (onKeyDown != null){
					_evt.keysName = keyCombList[_evt.keysCode];
					onKeyDown(_evt);
				}
			}
		}
		public var onKeyUp:Function;

		protected function keyUp(_evt:KeyEvent):void {
			if (_evt.groupID == keyGroupID){
				if (onKeyUp != null){
					_evt.keysName = keyCombList[_evt.keysCode];
					onKeyUp(_evt);
				}
			}
		}
		public var onKeyHold:Function;

		protected function keyHold(_evt:KeyEvent):void {
			if (_evt.groupID == keyGroupID){
				if (onKeyHold != null){
					_evt.keysName = keyCombList[_evt.keysCode];
					onKeyHold(_evt);
				}
			}
		}
	}
}