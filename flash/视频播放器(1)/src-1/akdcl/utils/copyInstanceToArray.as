package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function copyInstanceToArray(_instance:*, _length:uint, _ary:Array, _eachFun:Function, ... args):Array {
		if (!_ary){
			_ary = new Array();
		}
		var _instanceCopy:*;
		var _instanceClass:Class = _instance.constructor as Class;
		for (var _i:uint = 0; _i < _length; _i++){
			_instanceCopy = _ary[_i];
			if (!_instanceCopy){
				_instanceCopy = new _instanceClass();
				_ary[_i] = _instanceCopy;
			}
			if (_eachFun != null){
				_eachFun.apply(this, [_instanceCopy, _i, _ary, _length].concat(args));
			}
		}
		return _ary;
	}
}