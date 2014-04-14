package akdcl.utils {
	/**
	 * ...
	 * @author Akdcl
	 */

	public function replaceString(_strOld:String, _str:String = "\r\n", _rep:String = "\r"):String {
		if(_strOld){
			return _strOld.split(_str).join(_rep);
		}
		return "";
	}
}