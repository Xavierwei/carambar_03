package akdcl.utils {
	import flash.net.URLVariables;

	/**
	 * ...
	 * @author Akdcl
	 */
	public function objectToXML(_obj:*, _nodeName:String, _parentXML:XML = null):* {
		var _xml:XML;
		var _result:*;
		switch (_obj["constructor"]){
			case Object:
			case URLVariables:
				_xml = <{_nodeName}/>;
				for (var _key:String in _obj){
					_result = objectToXML(_obj[_key], _key, _xml);
					if (_result == _obj[_key]){
						_xml["@" + _key] = _obj[_key];
					} else if (_result){
						_xml.appendChild(_result);
					}
				}
				return _xml;
			case Array:
				for (var _id:String in _obj){
					if (_obj[_id]["constructor"] === Array){
						_xml = <{_nodeName}/>;
					}
					_result = objectToXML(_obj[_id], _nodeName, _xml ? _xml : _parentXML);
					if (_xml){
						_parentXML.appendChild(_xml);
					} else if (_result){
						_parentXML.appendChild(_result);
					}
					_xml = null;
				}
				return null;
			default:
				return _obj;
		}
		return null;
	}
}