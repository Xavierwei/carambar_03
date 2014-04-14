package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function copySimpleTo(_dataTo:Object, _dataFrom:Object):Object {
		var _value:Object;
		for (var _key:String in _dataFrom) {
			_value = _dataFrom[_key];
			if (_value is Number||_value is Boolean ||_value is String) {
				if (_key in _dataTo) {
					_dataTo[_key] = _value;
				}
			}
		}
		return _dataTo;
	}
}