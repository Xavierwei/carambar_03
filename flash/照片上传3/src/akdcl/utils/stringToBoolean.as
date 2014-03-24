package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function stringToBoolean(_str:String, _unparam:Boolean = false):Boolean {
		if (_str){
			_str = String(_str);
		}
		if (!_str || (_unparam ? false : (_str == "false" || _str == "0")) || _str.replace(/\s+/, "") == ""){
			return false;
		}
		return true;
	}
}