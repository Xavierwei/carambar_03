package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function destroyObject(_data:*):void {
		if(_data){
		if (("length" in _data) && ("splice" in _data)){
			for (var _n:int = _data.length - 1; _n >= 0; _n--){
				_data.splice(_n, 1);
			}
		} else if ("remove" in _data){
			_data.remove();
		} else {
			for (var _i:String in _data){
				delete _data[_i];
			}
		}
		}
	}
}