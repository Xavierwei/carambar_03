package akdcl.utils {
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	import com.adobe.serialization.json.JSON;
	
	import akdcl.utils.replaceString;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function objectToString(...args):String {
		var _str:String = "";
		
		var _eachStr:String;
		var _obj:*= args[_i];
		for (var _i:uint; _i < args.length; _i++ ) {
			_obj = args[_i];
			switch(_obj?_obj["constructor"]:_obj) {
				case Object:
				case URLRequest:
				case URLVariables:
				case Dictionary:
				case Array:
					_eachStr = replaceString(com.adobe.serialization.json.JSON.encode(_obj),",{",",\n{");
					break;
				default:
					if (_obj is Vector.<*>) {
						_eachStr = replaceString(com.adobe.serialization.json.JSON.encode(_obj),",{",",\n{")+"\n"+_obj;
					}else {
						_eachStr = _obj + "\n";
					}
					break;
			}
			_str += _eachStr;
		}
		return _str;
	}
}