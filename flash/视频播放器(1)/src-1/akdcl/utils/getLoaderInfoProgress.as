package akdcl.utils {
	import flash.display.LoaderInfo;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public function getLoaderInfoProgress(_loaderInfo:LoaderInfo):Number {
		var _loaded:uint = _loaderInfo?_loaderInfo.bytesLoaded:0;
		var _total:uint = _loaderInfo?(_loaderInfo.bytesTotal || 1):1;
		return _loaded / _total;
	}
}