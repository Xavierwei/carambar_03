package akdcl.utils {

	/**
	 * ...
	 * @author ...
	 */
	
	public function xmlListFilter(_xmlList:XMLList, _key:String, _value:String):XMLList {
		var _filter:XMLList = new XMLList();
		var _length:uint = _xmlList.length();
		for (var _i:int = 0; _i < _length; _i++ ) {
			var _xml:XML = _xmlList[_i];
			if (_xml["@" + _key].toString() == _value) {
				_filter[_filter.length()] = _xmlList[_i];
			}
		}
		return _filter;
	}

}