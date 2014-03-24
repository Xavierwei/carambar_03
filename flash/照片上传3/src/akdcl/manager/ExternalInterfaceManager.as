package akdcl.manager {
	import akdcl.utils.objectToString;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.system.Security;


	/**
	 * ...
	 * @author Akdcl
	 */

	/// @eventType	ExternalInterfaceManager.CALL
	[Event(name="call",type="ExternalInterfaceManager")]

	final public class ExternalInterfaceManager extends BaseManager {
		baseManager static var instance:ExternalInterfaceManager;
		public static function getInstance():ExternalInterfaceManager {
			return createConstructor(ExternalInterfaceManager) as ExternalInterfaceManager;
		}
		
		public function ExternalInterfaceManager() {
			super(this);
			
			if (Security.sandboxType == Security.LOCAL_WITH_FILE){
				__isAvailable = false;
			} else {
				try {
					ExternalInterface.call("window.location.href.toString");
					__isAvailable = true;
				} catch (_e:Error){
					__isAvailable = false;
				}
			}
			
			if (isAvailable){
				ExternalInterface.addCallback(CALL, swfInterface);
			}
			
			externalHandler = EXTERNAL_LISTENER;
			
			lM.info(ExternalInterfaceManager, "init isAvailable:{0} objectID:{1}", null, isAvailable, objectID);
		}

		public static const CALL:String = "call";
		public static const EXTERNAL_LISTENER:String = "swfEventHandler";
		
		public var callResult:*;//20131023

		public var externalHandler:String;
		public var eventParams:Array;

		private var __isAvailable:Boolean = false;
		public function get isAvailable():Boolean {
			return __isAvailable;
		}

		private var __eventType:String = null;
		public function get eventType():String {
			return __eventType;
		}

		private var __objectID:String;
		public function get objectID():String {
			return ExternalInterface.objectID || __objectID;
		}
		public function set objectID(_str:String):void {
			__objectID = _str;
		}

		public function hasInterface(_funName:String):Boolean {
			if (isAvailable){
				return ExternalInterface.call("eval", _funName + "!=" + "null");
			}
			return false;
		}

		public function callInterface(_funName:String, ... args):Object {
			var _object:Object;
			if (isAvailable && hasInterface(_funName)){
				if (args && args.length > 0) {
					_object = ExternalInterface.call.apply(ExternalInterface, [_funName].concat(args));
				}else {
					_object = ExternalInterface.call(_funName);
				}
			}
			var _str:String = "callInterface(funName:{2}, args:{3}) isAvailable:{0} objectID:{1}";
			if (_object) {
				_str += "====>>>>\n" + objectToString(_object);
			}
			
			lM.info(ExternalInterfaceManager, _str, null, isAvailable, objectID, _funName, args);
			return _object;
		}

		//广播as调用js的事件
		public function dispatchSWFEvent(_type:String, ... args):void {
			if (isAvailable){
				if (args && args.length > 0) {
					callInterface.apply(ExternalInterfaceManager, [externalHandler, objectID, _type].concat(args));
				} else {
					callInterface(externalHandler, objectID, _type);
				}
			}
		}
		
		public function debugMessage(_message:String):void {
			callInterface("alert", _message);
		}

		//广播js调用as的事件
		//addEventListener(ExternalInterfaceManager.CALL);
		//addEventListener(__eventType);
		private function swfInterface(_type:String, ... args):* {
			__eventType = _type;
			if (args && args.length > 0) {
				eventParams = args;
			} else {
				eventParams = null;
			}
			
			lM.info(ExternalInterfaceManager, "接收外部事件(type:{2}, args:{3}) isAvailable:{0} objectID:{1}", null, isAvailable, objectID, __eventType, args);
			
			if (hasEventListener(CALL)) {
				dispatchEvent(new Event(CALL));
			}
			if (hasEventListener(__eventType)){
				var _event:Event = new Event(__eventType);
				dispatchEvent(_event);
			}
			
			if(callResult===undefined){
			}else{
				var _callResult:*=callResult;
				callResult=undefined;
				return _callResult;
			}
			
		}
	}
}