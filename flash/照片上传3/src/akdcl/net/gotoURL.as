package akdcl.net {
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.external.ExternalInterface;

	import akdcl.utils.objectToURLVariables;
	import akdcl.manager.LoggerManager;

	/**
	 * ...
	 * @author Akdcl
	 */

	public function gotoURL(_urlOrXML:*, _target:String = "_blank", _data:Object = null, _method:String = "GET"):void {
		if (_urlOrXML is XMLList){
			_urlOrXML = _urlOrXML[0];
		}
		var _href:String;
		var _js:String;
		if (_urlOrXML is XML){
			_target = String(_urlOrXML.attribute("target")) || _target;
			var _hrefXML:XML = _urlOrXML.@href[0];
			if (_hrefXML){
				_href = _hrefXML.toString();
			} else {
				_href = null;
			}
			var _jsXML:XML = _urlOrXML.@js[0];
			if (_jsXML){
				_js = _jsXML.toString();
			} else {
				_js = null;
			}
		} else {
			_href = _urlOrXML;
		}
		
		
		
		

		if (_js is String && ExternalInterface.available){
			LoggerManager.getInstance().info(this, "执行JS:" + _js);
			ExternalInterface.call("eval", _js);
		}
		if (_href is String){
			var _request:URLRequest = new URLRequest(_href);
			LoggerManager.getInstance().info(this, "toURL(url:{0}, target:{1})", null, _request.url, _target);
			if (_data){
				if (_data["constructor"] === Object){
					_request.data = objectToURLVariables(_data);
				} else {
					_request.data = _data;
				}
				_request.method = _method;
				navigateToURL(_request, _target);
				LoggerManager.getInstance().info(this, "toURLAndPost:\n" + _request);
				return;
			}

			var _browserAgent:String;
			if (ExternalInterface.available){
				_browserAgent = ExternalInterface.call("eval", "navigator.userAgent;");
			}
			if (_browserAgent){
				var _browserName:String;
				if (_browserAgent.indexOf("Firefox") >= 0){
					_browserName = "Firefox";
				} else if (_browserAgent.indexOf("Safari") >= 0){
					_browserName = "Safari";
				} else if (_browserAgent.indexOf("MSIE") >= 0){
					_browserName = "IE";
				} else if (_browserAgent.indexOf("Opera") >= 0){
					_browserName = "Opera";
				} else {
					_browserName = "Unknown";
				}
			}
			
			switch (_browserName){
				case "Firefox":
				case "IE":
					if (ExternalInterface.available){
						ExternalInterface.call("window.open", _href, _target, "");
						//WebHREF.webGotoURL(_href, _target);
					} else {
						navigateToURL(_request, _target);
					}
					break;
				case "Safari":
				case "Opera":
					navigateToURL(_request, _target);
					break;
				default:
					navigateToURL(_request, _target);
					break;
			}
		}
	}
}

import flash.external.ExternalInterface;

class WebHREF {
	private static var isHREFCreated:Boolean;
	private static const JS:XML = <script><![CDATA[
		function __createHREF() {
			var _swfHREF = document.createElement("form");
			_swfHREF.id = "__swfWebHREF";
			_swfHREF.method = "get";
			_swfHREF.style.height = 0;
			_swfHREF.style.width = 0;
			_swfHREF.style.overflow = "hidden";
			document.body.appendChild(_swfHREF);
		}
		function __gotoURL(_href, _target) {
			var _swfHREF = document.getElementById("__swfWebHREF");
			if (_swfHREF) {
				_swfHREF.action = _href;
				_swfHREF.target = _target || "_blank";
				_swfHREF.submit(); 
			}
		}
		__createHREF();
	]]></script>
	
	public static function webGotoURL(_href:String, _target:String = null):void {
		if (!ExternalInterface.available){
			return;
		}
		if (!isHREFCreated) {
			ExternalInterface.call("eval", JS.toString());
			isHREFCreated = true;
		}
		ExternalInterface.call("__gotoURL", _href,_target);
	}
}