package akdcl.utils{
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function objectToURLVariables(_data:Object):URLVariables {
		var _urlVariables:URLVariables=new URLVariables();
		for(var _i:String in _data){
			_urlVariables[_i] = _data[_i];
		}
		return _urlVariables;
	}
}