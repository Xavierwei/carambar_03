package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */
	public function numberToTime(_num:uint, _length:uint = 2, _interSign:String = ":"):String {

		var minutes:uint;
		var seconds:uint;
		if (_num < 60){
			minutes = 0;
			seconds = _num;
		} else if (_num < 3600){
			minutes = Math.floor(_num / 60);
			seconds = _num % 60;
		}
		var s_m:String = minutes < 10 ? "0" + String(minutes) : String(minutes);
		var s_s:String = seconds < 10 ? "0" + String(seconds) : String(seconds);
		return s_m + _interSign + s_s;
	}
}