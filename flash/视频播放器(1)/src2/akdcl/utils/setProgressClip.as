package akdcl.utils {
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author Akdcl
	 */
	public function setProgressClip(_clip:*, _progress:Number, _visible:Boolean = false):void {
		if (_clip) {
			if (_visible) {
				_clip.visible = _progress < 1 && _progress >= 0;
			}
			if ("value" in _clip){
				_clip.value = _progress;
			} else if ("text" in _clip){
				_clip.text = Math.round(_progress * 100) + " %";
			} else if (_clip is MovieClip){
				if (_progress < 1) {
					_clip.play();
				} else {
					_clip.stop();
				}
			}
		}
	}
}