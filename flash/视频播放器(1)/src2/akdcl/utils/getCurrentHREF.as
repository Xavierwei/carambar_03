package akdcl.utils {
	import flash.external.ExternalInterface;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function getCurrentHREF():String {
		var _href:String;
		if (ExternalInterface.available){
			_href = ExternalInterface.call("eval", "window.location.href;");
		}
		return _href;
	}
}