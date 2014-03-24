package akdcl.manager {
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.events.EventDispatcher;

	import flash.net.LocalConnection;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author akdcl
	 */

	/// @eventType	akdcl.manager.LoggerConnectManager.LOG_CONNECT
	[Event(name="logConnect",type="akdcl.manager.LoggerConnectManager")]

	final public class LoggerConnectManager extends BaseManager {
		baseManager static var instance:LoggerConnectManager;
		public static function getInstance():LoggerConnectManager {
			return createConstructor(LoggerConnectManager) as LoggerConnectManager;
		}
		
		public function LoggerConnectManager() {
			super(this);
			sourceDic = {};
			localConnection = new LocalConnection();
		}

		public static const LOG_CONNECT:String = "akdcl.manager.LoggerConnectManager.logConnect";

		public static const E_CLASSES:String = "classes";
		public static const E_CLASS:String = "class";
		public static const E_TARGET:String = "target";
		public static const E_LOGS:String = "logs";
		public static const E_LOG:String = "log";

		public static const A_PATH:String = "path";
		public static const A_ID:String = "id";
		public static const A_LEVEL:String = "level";
		public static const A_TIME:String = "time";
		public static const A_MSG:String = "msg";
		public static const A_LOG_COUNT:String = "logCount";

		private static function getClassNode(_xml:XML, _id:String):XML {
			var _result:XML;
			//_xml.elements(E_CLASS).(attribute(A_ID) == _id)[0];
			for each (var _node:XML in _xml.elements(E_CLASS)){
				if (_node.attribute(A_ID) == _id){
					_result = _node;
					break;
				} else {
					_result = getClassNode(_node, _id);
					if (_result){
						break;
					}
				}
			}
			return _result;
		}

		public var lastSource:XML;
		public var lastTarget:XML;

		private var sourceDic:Object;
		private var localConnection:LocalConnection;

		//private var timeOff:uint;
		//private var countOff:uint;
		
		private var __isConnected:Boolean;
		public function get isConnected():Boolean {
			return __isConnected;
		}

		public function startClient():void {
			if (__isConnected){
				return;
			}
			__isConnected = true;
			localConnection.allowDomain("*");
			localConnection.client = {};
			localConnection.client[LoggerManager.CONNECTION_METHOD_NAME] = onConnectHandler;
			localConnection.addEventListener(StatusEvent.STATUS, connectStatusHandler);
			try {
				localConnection.connect(LoggerManager.LOCAL_CONNECTION_NAME);
			} catch (_e:*){
			}
		}

		public function stopClient():void {
			if (!__isConnected){
				return;
			}
			__isConnected = false;
			localConnection.client[LoggerManager.CONNECTION_METHOD_NAME] = null;
			localConnection.removeEventListener(StatusEvent.STATUS, connectStatusHandler);
			try {
				localConnection.close();
			} catch (_e:*){
			}
		}
		
		public function clear(_managerID:String):void {
			if (sourceDic[_managerID]) {
				delete sourceDic[_managerID];
			}
		}

		private function onConnectHandler(_managerID:String, _logConnectCount:uint, _extends:String, _id:String, _name:String, _level:int, _time:uint, _msg:String, ... args):void {
			if (hasEventListener(LOG_CONNECT)){

				lastSource = sourceDic[_managerID];

				if (lastSource){
					/*var _list:XMLList = lastSource.elements(E_LOGS).elements(E_LOG);
					if (_list.length() > 0 && int(_list[_list.length() - 1].attribute(A_TIME)) > _time){
						timeOff = new Date().time - int(lastSource.attribute(A_TIME));
					}
					var _countBefore:uint = int(lastSource.elements(E_LOGS)[0].attribute(A_LOG_COUNT));
					if (_countBefore >= _logConnectCount){
						countOff = _countBefore;
					}
					lastSource.elements(E_LOGS)[0]["@" + A_LOG_COUNT] = countOff + _logConnectCount;*/
				} else {
					lastSource = sourceDic[_managerID] =  <root {A_ID}={_managerID} {A_TIME}={new Date().time}/>;
					lastSource.appendChild(<{E_CLASSES} {A_ID}={E_CLASSES} {A_PATH}="0"/>);
					lastSource.appendChild(<{E_LOGS} {A_LOG_COUNT}="1"/>);
				}

				var _extendsXMLList:XMLList = new XMLList(_extends);

				var _length:uint = _extendsXMLList.length();
				var _classRoot:XML = lastSource.elements(E_CLASSES)[0];
				var _classCheck:XML;
				var _eachClass:XML;
				var _path:String;

				var _logXML:XML;

				for (var _i:int = _length - 1; _i >= 0; _i--){
					_path = _classRoot.attribute(A_PATH);
					_eachClass = _extendsXMLList[_i];
					_classCheck = getClassNode(_classRoot, _eachClass.attribute(A_ID));
					if (_classCheck){
						_classRoot = _classCheck;
					} else {
						_classRoot.appendChild(_eachClass);
						_classRoot = _eachClass;
						_classRoot["@" + A_PATH] = _path + "|" + _classRoot.childIndex();
					}
				}
				_path = _classRoot.attribute(A_PATH);

				if (_id){
					lastTarget = _classRoot.elements(E_TARGET).(attribute("_id") == _id)[0];
					if (!lastTarget){
						lastTarget =  <{E_TARGET}/>;
						lastTarget["@" + A_ID] = _name;
						lastTarget["@" + "_id"] = _id;
						_classRoot.appendChild(lastTarget);
					}
					_path += "|" + lastTarget.childIndex();
				} else {
					_name = _classRoot.attribute(A_ID);
				}

				_logXML =  <{E_LOG}/>;
				_logXML["@" + A_PATH] = _path;
				_logXML["@" + A_ID] = _name;
				_logXML["@" + A_LEVEL] = _level;
				_logXML["@" + A_TIME] = _time;
				//+ timeOff;
				_logXML["@" + A_MSG] = _msg;
				lastSource.elements(E_LOGS)[0].appendChild(_logXML);

				dispatchEvent(new Event(LOG_CONNECT));
			}
		}

		private function connectStatusHandler(_e:StatusEvent):void {

		}
	}

}