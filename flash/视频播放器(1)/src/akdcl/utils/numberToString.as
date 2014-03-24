package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function numberToString(_value:Number, _lenght:uint = 2, _dotLength:uint = 0):String {
		if (_value < 0) {
			_value = 0;
		}
		var _str:String = String(_value);
		_lenght--;
		var _d:uint = Math.pow(10, _lenght);
		if (_dotLength > 0) {
			var _dD:uint = Math.pow(10, _dotLength);
			_value = int(_value * _dD) / _dD;
		}
		if (_value < _d){
			_value += _d;
			_str = "0" + String(_value).substr(1);
			_value -= _d;
		}
		if (_dotLength > 0) {
			var _dot:String = _str.split(".")[1];
			if (!_dot) {
				_str += "." + String(_dD).substr(1);
			}else if(_dot.length < _dotLength) {
				_str += String(Math.pow(10, _dotLength - _dot.length)).substr(1);
			}
		}
		return _str;
	}
}