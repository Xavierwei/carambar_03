package akdcl.net.action {
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequestMethod;

	import flash.net.URLVariables;
	import flash.display.BitmapData;

	import zero.codec.JPEGEncoder;

	import ui.Alert;

	import akdcl.manager.LoggerManager;
	import akdcl.manager.RequestManager;
	import akdcl.events.UIEventDispatcher;
	import akdcl.net.gotoURL;
	import akdcl.utils.objectToString;
	import akdcl.utils.stringToBoolean;
	import akdcl.utils.replaceString;

	/**
	 * ...
	 * @author Akdcl
	 */

	/// @eventType	flash.events.Event.COMPLETE
	[Event(name="complete",type="flash.events.Event")]

	/// @eventType	flash.events.IOErrorEvent.IO_ERROR
	[Event(name="ioError",type="flash.events.IOErrorEvent")]

	public class RemoteAction extends UIEventDispatcher {
		public static const E_SEND:String = "send";
		public static const E_LOAD:String = "load";
		public static const E_VARIABLE:String = "variable";
		public static const E_CASE:String = "case";
		public static const E_DEFAULT:String = "default";
		public static const E_IO_ERROR:String = "IOError";

		public static const A_SOURCE:String = "source";
		public static const A_METHOD:String = "method";
		public static const A_DEBUG:String = "debug";

		public static const A_NAME:String = "name";
		public static const A_VALUE:String = "value";
		public static const A_REMOTE_NAME:String = "remoteName";
		public static const A_REMOTE_VALUE:String = "remoteValue";

		public static const A_ALERT:String = "alert";

		public static const A_CONTENT:String = "content";
		public static const A_LABEL:String = "label";

		public static const A_SELECTED_TEXT:String = "selectedText";
		public static const A_QUALITY:String = "quality";

		public static const A_DATA_STRUCTURE:String = "dataStructure";
		public static const A_DATA_TYPE:String = "dataType";

		protected static const lM:LoggerManager = LoggerManager.getInstance();
		protected static const rM:RequestManager = RequestManager.getInstance();

		public static function replaceValue(_content:String, _str:String, _rep:String):String {
			return replaceString(_content, "${" + _str + "}", _rep);
		}

		public static function getValue(_content:String, _id:uint = 0):String {
			var _ary:Array = _content.match(/\$\{.*?\}/g);
			if (_ary && _ary[_id]){
				var _str:String = _ary[_id];
				return _str.substring(2, _str.length - 1);
			}
			return null;
		}

		public static function isRemoteNode(_xml:XML):Boolean {
			var _b:Boolean;
			_b = _xml.elements(E_SEND).length() > 0 || _xml.elements(E_LOAD).length() > 0;
			_b = _b && _xml.attribute(A_SOURCE).length() > 0;
			return _b;
		}

		public var rawData:Object;
		public var data:Object;
		public var dataPreset:Object;
		
		public var sendProxy:Object;
		public var dataSend:Object;
		public var dataSendFormated:Object;
		public var alert:Alert;

		protected var options:XML;
		protected var optionsSend:XML;
		protected var optionsLoad:XML;
		
		protected var alertXML:XML;
		protected var actionXML:XML;

		protected var isLoading:Boolean;

		public function RemoteAction(_optionsXML:XML = null){
			dataSend = {};
			dataPreset = {};
			sendProxy = {};
			if (_optionsXML){
				setOptions(_optionsXML);
			}
			super();
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			if (alert){
				alert.remove();
			}
			clear();
			alert = null;
			options = null;
			optionsSend = null;
			optionsLoad = null;
			alertXML = null;
			dataPreset = null;
			dataSend = null;
			sendProxy = null;
		}

		public function setOptions(_optionsXML:XML):void {
			if (isRemoteNode(_optionsXML)){
				options = _optionsXML;
				name = options.attribute(A_NAME);
				optionsSend = options.elements(E_SEND)[0];
				optionsLoad = options.elements(E_LOAD)[0];
				resolveSend(optionsSend);
				resolveLoad(optionsLoad);

				sendProxy.url = String(options.attribute(A_SOURCE)[0]);
				sendProxy.method = String(options.attribute(A_METHOD)[0] || URLRequestMethod.POST).toLocaleUpperCase();
				//json,form,amf3
				sendProxy.sendFormat = String(optionsSend.attribute(A_DATA_STRUCTURE)[0] || "").toLocaleLowerCase();
				//binary,variables,text,json,xml,amf3
				sendProxy.loadFormat = String(optionsLoad.attribute(A_DATA_STRUCTURE)[0] || "").toLocaleLowerCase();
				//sendProxy.random = true;
				//sendProxy.contentType
				lM.info(this, "setOptions====>>>>\n" + _optionsXML.toXMLString());
			} else {
				throw new Error("[ERROR]:数据源不匹配！");
			}
		}

		public function add(_key:String, _value:*):void {
			lM.info(this, "add(key:{0}, value:{1})", null, _key, _value);
			//var _xmlList:XMLList = optionsSend.elements(_key);
			dataSend[_key] = _value;
		}
		
		public function getSendVariable(_key:String):XML {
			return optionsSend?optionsSend.elements(E_VARIABLE).(attribute(A_NAME) == _key)[0]:null;
		}

		public function clear():void {
			lM.info(this, "clear");
			dataSend = {};
			rawData = null;
			data = null;
		}

		public function sendAndLoad():Boolean {
			if (isLoading){
				lM.info(this, "sendAndLoad() 正在发送数据，需等待！");
				return true;
			}
			isLoading = true;
			alertXML = null;
			actionXML = null;
			for (var _i:String in dataPreset){
				if (!dataSend[_i]){
					dataSend[_i] = dataPreset[_i];
				}
			}
			//dataSend.random = Math.random();
			var _str:String;
			_str = objectToString("[" + name + " send]", dataSend);
			dataSendFormated = formatData(dataSend, optionsSend, true);
			_str += "\n" + objectToString("[" + name + " remote send]", dataSendFormated);
			lM.info(this, "sendAndLoad()====>>>>\n" + _str);
			trace(_str);
			sendProxy.data = dataSendFormated;
			rM.load(sendProxy, onCompleteHandler, onErrorHandler, null);
			return true;
		}

		protected function resolveSend(_submitXML:XML):void {
			if (!_submitXML){
				return;
			}
			var _name:String;
			var _value:String;
			for each (var _eachNode:XML in _submitXML.elements(E_VARIABLE)){
				//预置A_VALUE，扩展为可以预置复杂对象
				_name = _eachNode.attribute(A_NAME)[0];
				_value = _eachNode.attribute(A_VALUE)[0];
				if (_name && _value){
					dataPreset[_name] = _value;
				}
			}
		}

		protected function resolveLoad(_resultXML:XML):void {

		}

		protected function onCompleteHandler(_data:*, _url:String):void {
			var _str:String;
			isLoading = false;
			rawData = _data;
			if (rawData) {
				
			} else {
				_str = "后台数据错误！";
				lM.error(this, _str);
				alert = Alert.show(_str);
				return;
			}
			_str = objectToString("[" + name + " remote load]", rawData);
			data = formatData(rawData, optionsLoad, false);

			var _name:String;
			var _value:String;
			for each (var _eachNode:XML in optionsLoad.elements(E_VARIABLE)){
				//扩展为可以置入xml预置load值
				_name = _eachNode.attribute(A_NAME)[0];
				_value = _eachNode.attribute(A_VALUE)[0];
				if (_name && _value && !data[_name]){
					data[_name] = _value;
				}
			}

			_str += "\n" + objectToString("[" + name + " load]", data);
			
			lM.info(this, "sendAndLoadComplete====>>>>\n" + _str);
			trace(_str);
			if (alertXML){
				showAlert(alertXML);
			}
			if (actionXML) {
				for (var _i:String in data){
					actionXML = XML(replaceValue(actionXML.toXMLString(), _i, data[_i]));
				}
				gotoURL(actionXML);
			}
			if (hasEventListener(Event.COMPLETE)) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		protected function onErrorHandler(_evt:Event):void {
			isLoading = false;
			data = null;
			rawData = null;
			var _str:String;
			if (_evt is SecurityErrorEvent) {
				_str = "安全沙箱冲突，无法跨域访问！";
			}else {
				_str = options.elements(E_IO_ERROR)[0] || "网络错误，请稍后重试！";
			}
			lM.error(this, _str);
			alert = Alert.show(_str);
			if (hasEventListener(IOErrorEvent.IO_ERROR)) {
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			}
		}

		protected function formatData(_data:*, _xml:XML, _isSend:Boolean):* {
			var _dataFormat:*;
			var _tempXML:XML;
			//没有传递_data也取E_DEFAULT值或空值
			switch (_data ? _data["constructor"] : null){
				case Array:
					_dataFormat = [];
					for (var _id:String in _data){
						_dataFormat[_id] = formatData(_data[_id], _xml, _isSend);
					}
					break;
				case Object:
				case URLVariables:
					_dataFormat = {};
					var _keyFormat:String;
					for (var _key:String in _data){
						_keyFormat = null;
						if (_isSend){
							_tempXML = getVariableList(_xml).(attribute(A_NAME) == _key)[0];
							if (_tempXML){
								//优先匹配A_REMOTE_NAME/A_NAME
								_keyFormat = _tempXML.attribute(A_REMOTE_NAME)[0] || _tempXML.attribute(A_NAME)[0];

								_dataFormat[_keyFormat] = formatData(_data[_key], _tempXML, _isSend);
							} else {
								//没有对应配置的数据
								_dataFormat[_key] = _data[_key];
							}
						} else {
							for each (_tempXML in getVariableList(_xml)){
								_keyFormat = _tempXML.attribute(A_REMOTE_NAME)[0];
								if (_keyFormat == _key){
									//有匹配的A_REMOTE_NAME
									break;
								} else {
									_keyFormat = null;
								}
							}
							if (_keyFormat){
								//有匹配的A_REMOTE_NAME
								_dataFormat[_tempXML.attribute(A_NAME)[0]] = formatData(_data[_key], _tempXML, _isSend);
							} else {
								_tempXML = getVariableList(_xml).(attribute(A_NAME) == _key)[0];
								if (_tempXML){
									_keyFormat = _tempXML.attribute(A_NAME)[0];
									_dataFormat[_keyFormat] = formatData(_data[_key], _tempXML, _isSend);
								} else {
									//没有对应配置的数据
									_dataFormat[_key] = _data[_key];
								}
							}
						}
					}
					break;
				case null:
				default:
					var _value:String;
					var _defaultValue:String;
					var _tempXMLList:XMLList;
					if (_isSend){
						_tempXMLList = _xml.elements(E_CASE);
						if (_tempXMLList.length() > 0){
							//包含case节点，映射remoteValue到_data
							//没有对应的remoteValue则取_data
							if (_tempXMLList.attribute(A_REMOTE_VALUE).length() > 0 && _tempXMLList.attribute(A_VALUE).length() > 0){
								_tempXML = _tempXMLList.(attribute(A_VALUE) == String(_data))[0];
								_dataFormat = _tempXML ? String(_tempXML.attribute(A_REMOTE_VALUE)[0]) : _data;
							} else if (_tempXMLList.attribute(A_VALUE).length() > 0){
								_tempXML = _tempXMLList[_data];
								_dataFormat = _tempXML ? String(_tempXML.attribute(A_VALUE)[0]) : _data;
							} else {
								if (isNaN(_data)) {
									_dataFormat = _data;
								}else {
									_tempXML = _tempXMLList[_data];
									_dataFormat = _tempXML ? String(_tempXML.attribute(A_LABEL)[0]) : _data;
								}
							}
						} else {
							//不包含case节点直接赋值
							if (_data is BitmapData){
								//如果数据是BitmapData则格式化为JPEG格式的ByteArray，以后可能扩展成png和gif可选
								_data = JPEGEncoder.encode(_data as BitmapData,int(_xml.attribute(A_QUALITY)[0]) || 80);
							}
							_dataFormat = _data;
						}
					} else {
						_tempXMLList = _xml.elements(E_CASE);
						if (_tempXMLList.length() > 0){
							//包含case节点，映射remoteValue到value
							//没有对应的value则取E_DEFAULT值或空值
							if (_tempXMLList.attribute(A_REMOTE_VALUE).length() > 0){
								_tempXML = _tempXMLList.(attribute(A_REMOTE_VALUE) == String(_data))[0];
							} else {
								_tempXML = _tempXMLList.(attribute(A_VALUE) == String(_data))[0];
							}
							_value = _tempXML ? _tempXML.attribute(A_VALUE)[0] : null;
							_defaultValue = _xml.elements(E_DEFAULT).attribute(A_VALUE)[0];
							switch (String(_xml.attribute(A_DATA_TYPE))){
								case "Boolean":
									if (_value){
										_dataFormat = stringToBoolean(_value);
									} else {
										_dataFormat = stringToBoolean(_defaultValue);
									}
									break;
								case "Number":
									if (_value){
										_dataFormat = Number(_value);
									} else {
										_dataFormat = stringToBoolean(_defaultValue, true) ? Number(_defaultValue) : NaN;
									}
									break;
								default:
									if (_value){
										_dataFormat = _value;
									} else {
										_dataFormat = _defaultValue || null;
									}
									break;
							}
							_tempXML = _tempXML || _xml.elements(E_DEFAULT)[0];
							if (_tempXML){
								//存alert节点，等数据格式完毕后，显示alert
								if (!alertXML){
									alertXML = _tempXML.elements(A_ALERT)[0];
									if (alertXML){

									} else if (_tempXML.attribute(A_ALERT)[0]){
										alertXML = _tempXML;
									}
								}
								if (!actionXML){
									if (_tempXML.attribute("href").length() > 0 || _tempXML.attribute("js").length() > 0){
										if (_tempXML.elements(A_ALERT).length() == 0 && _tempXML.attribute(A_ALERT).length() == 0){
											actionXML = _tempXML;
										}
									}
								}
							} else {
								//返回结果不对应或未返回结果，且没有E_DEFAULT节点
							}
						} else {
							//不包含case节点直接赋值
							_dataFormat = _data;
						}
					}
					break;
			}
			return _dataFormat;
		}

		protected function getVariableList(_xml:XML):XMLList {
			return _xml.elements(E_VARIABLE);
		}

		protected function showAlert(_xml:XML):void {
			if (alert){
				alert.remove();
			}
			var _selectText:String = _xml.attribute(A_SELECTED_TEXT)[0];
			for (var _i:String in data){
				if (_selectText){
					_selectText = replaceValue(_selectText, _i, data[_i]);
				}
				_xml = XML(replaceValue(_xml.toXMLString(), _i, data[_i]));
			}
			alert = Alert.show(_xml);
			if (_selectText){
				alert.setTextSelectedText(_selectText);
			}
		}
	}

}