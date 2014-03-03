package akdcl.utils {
	import flash.filters.ColorMatrixFilter;

	/**
	 * ...
	 * @author Akdcl
	 */

	public function setDisplayGrayAndDisable(_display:*, _isGray:Boolean, _useDisable:Boolean = true):void {
		_display.filters = _isGray ? [
			new ColorMatrixFilter([0.3086000084877014, 0.6093999743461609, 0.0820000022649765, 0, 0, 0.3086000084877014, 0.6093999743461609, 0.0820000022649765, 0, 0, 0.3086000084877014, 0.6093999743461609, 0.0820000022649765, 0, 0, 0, 0, 0, 1, 0])
		] : null;
		if (_useDisable){
			_display.mouseEnabled = _display.mouseChildren = !_isGray;
		}
	}
}