package akdcl.key {

	import flash.utils.setInterval
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import akdcl.math.AkdclMath;

	public class KeyManager extends EventDispatcher {
		static private var stageList:Array = new Array;
		//
		protected var stage:*;
		protected var groupNameList:Array = new Array;
		protected var keyList:Array = new Array;
		protected var keyGroupList:Array = new Array;

		protected var keyState:Array = new Array;
		protected var keyCodeList:Array = new Array;
		protected var upEvent:KeyEvent = new KeyEvent(KeyEvent.KEY_UP);
		protected var downEvent:KeyEvent = new KeyEvent(KeyEvent.KEY_DOWN);
		protected var holdEvent:KeyEvent = new KeyEvent(KeyEvent.KEY_HOLD);
		protected var onUpKeyIndex:Array = new Array;
		protected var keyIntervalManager:Number;
		protected var precision:uint;

		//
		public function KeyManager(_stage:*, precision:uint=1, ... Keys):void {
			var test:Boolean = true;
			for (var s:uint = 0; s < KeyManager.stageList.length; s++){
				if (KeyManager.stageList[s] == _stage){
					test = false;
					break;
				}
			}
			if (test){
				stage = _stage;
				KeyManager.stageList.push(_stage);
				keyList = Keys;
				precision = precision;
				for (var i:uint = 0; i < keyList.length; i++){
					addKey(keyList[i]);
				}
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				//
				keyIntervalManager = setInterval(eventTest, precision, [0]);
			} else {
				throw new Error("在" + _stage + "中已经存在一个KeyCath实例，在同一对象中KeyCath只允许实例化一次。");
			}
		}
		public function clear():void {
			lastKeyCode = 0;
			for (var i:uint = 0; i < keyList.length; i++){
				var nowKey:Key = keyList[i];
				keyState[nowKey.groupID][keyCodeList[nowKey.groupID][nowKey.keyCode]] = KeyType.CODE_UP;
				var nowHoldTime:uint = nowKey.holdTime;
				nowKey.isUp(true);
				onUpKeyIndex[nowKey.groupID] = keyCodeList[nowKey.groupID][nowKey.keyCode];
				eventTest(nowHoldTime);
			}
		}
		public function addKey(key:Key):void {
			var test:Boolean = true;
			for (var i:uint = 0; i < keyList.length; i++){
				if (key.keyCode == keyList[i].keyCode){
					test = false;
					break;
				}
			}
			if (test){
				key.addEventListener(KeyEvent.KEY_CHANGE, onKeyChange);
				if (!keyGroupList[key.groupID]){
					keyGroupList[key.groupID] = new Array;
					keyState[key.groupID] = new Array;
					keyCodeList[key.groupID] = new Array;
				}
				keyList.push(key);
				keyGroupList[key.groupID].push(key);
				keyState[key.groupID].push(KeyType.CODE_UP);
				keyCodeList[key.groupID][key.keyCode] = keyState[key.groupID].length - 1;
			}
		}

		public function getNewGroupName():String {
			var outS:String = "KeyGroup" + (groupNameList.length + 1);
			onUpKeyIndex[groupNameList.length] = -1;
			groupNameList.push(outS);
			return outS;
		}

		public function getGroupID(groupName:String):uint {
			var outU:uint;
			for (var i:uint = 0; i < groupNameList.length; i++){
				if (groupName == groupNameList[i]){
					outU = i;
					break;
				}
			}
			return outU;
		}

		protected function onKeyChange(_evt:KeyEvent):void {
			trace(_evt.target.keysCode, _evt.target.groupID);
		}
		private var lastKeyCode:uint;

		protected function onKeyDown(_evt:KeyboardEvent):void {
			if (lastKeyCode == _evt.keyCode){
				return;
			}
			lastKeyCode = _evt.keyCode;
			for (var i:uint = 0; i < keyList.length; i++){
				var nowKey:Key = keyList[i];
				if (_evt.keyCode == nowKey.keyCode && !nowKey.disable){
					keyState[nowKey.groupID][keyCodeList[nowKey.groupID][nowKey.keyCode]] = KeyType.CODE_DOWN;
					var nowVoidTime:uint = nowKey.voidTime;
					nowKey.isDown(true);
					eventTest(nowVoidTime);
					break;
				}
			}
		}

		protected function onKeyUp(_evt:KeyboardEvent):void {
			lastKeyCode = 0;
			for (var i:uint = 0; i < keyList.length; i++){
				var nowKey:Key = keyList[i];
				if (_evt.keyCode == nowKey.keyCode && !nowKey.disable){
					keyState[nowKey.groupID][keyCodeList[nowKey.groupID][nowKey.keyCode]] = KeyType.CODE_UP;
					var nowHoldTime:uint = nowKey.holdTime;
					nowKey.isUp(true);
					onUpKeyIndex[nowKey.groupID] = keyCodeList[nowKey.groupID][nowKey.keyCode];
					eventTest(nowHoldTime);
					break;
				}
			}
		}

		protected function getCodeInt(target:Array):int {
			var outI:int = 0;
			target.slice().forEach(callback);
			function callback(item:*, index:int, array:Array):void {
				item && (outI += Math.pow(2, index));
			}
			return outI;
		}

		protected function eventTest(time:uint):void {
			for (var i:uint = 0; i < keyList.length; i++){
				var nowKey:Key = keyList[i];
				if (nowKey.isUp()){
					if (nowKey.voidTime == 1){
						upEvent = new KeyEvent(KeyEvent.KEY_UP, true, false, nowKey);
						var upState:Array = keyState[nowKey.groupID].slice();
						upState[onUpKeyIndex[nowKey.groupID]] = 1;
						upEvent.keysCode = getCodeInt(upState);
						upEvent.voidTime = 0;
						upEvent.holdTime = getHoldTime(nowKey, time, upEvent.keysCode);
						dispatchEvent(upEvent);
					}
					nowKey.voidTime++;
				}
				//
				if (nowKey.isDown()){
					if (nowKey.holdTime > 1){
						holdEvent = new KeyEvent(KeyEvent.KEY_HOLD, true, false, nowKey);
						holdEvent.keysCode = getCodeInt(keyState[nowKey.groupID]);
						holdEvent.voidTime = 0;
						holdEvent.holdTime = getHoldTime(nowKey, 0, holdEvent.keysCode);
						dispatchEvent(holdEvent);
					} else {
						downEvent = new KeyEvent(KeyEvent.KEY_DOWN, true, false, nowKey);
						downEvent.keysCode = getCodeInt(keyState[nowKey.groupID]);
						downEvent.voidTime = getVoidTime(nowKey, time, downEvent.keysCode);
						downEvent.holdTime = 1;
						dispatchEvent(downEvent);
					}
					nowKey.holdTime++;
				}
			}
		}

		protected function getHoldTime(key:Key, keyHoldTime:uint, keyCode:uint):uint {
			var testA:Array = new Array();
			for (var i:uint = 0; i < keyState[key.groupID].length; i++){
				var nowKey:Key = keyGroupList[key.groupID][i];
				if (keyCode & Math.pow(2, i)){
					if (nowKey != key){
						testA.push(nowKey.holdTime);
					} else {
						if (keyHoldTime){
							testA.push(keyHoldTime);
						} else {
							testA.push(nowKey.holdTime);
						}
					}
				}
			}
			var outU:uint = testA.length > 1 ? AkdclMath.getMin(testA)[0] : testA[0];
			return outU;
		}

		//		
		protected function getVoidTime(key:Key, keyVoidTime:uint, keyCode:uint):uint {
			var testA:Array = new Array();
			for (var i:uint = 0; i < keyState[key.groupID].length; i++){
				var nowKey:Key = keyGroupList[key.groupID][i];
				if (keyCode & Math.pow(2, i)){
					if (nowKey != key){
						testA.push(nowKey.voidTime);
					} else {
						testA.push(keyVoidTime);
					}
				}
			}
			var outU:uint = testA.length > 1 ? AkdclMath.getMax(testA)[0] : testA[0];
			return outU;
		}

		//
		public function getKeyList():Array {
			return keyList;
		}

		public function get length():uint {
			return keyList.length;
		}
	}
}