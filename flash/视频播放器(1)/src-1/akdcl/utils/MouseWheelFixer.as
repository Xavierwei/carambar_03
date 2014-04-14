package akdcl.utils {
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.external.ExternalInterface;

    /**
     * 用于校正flash鼠标滚动和页面鼠标滚动的冲突。
     * <p>使用方法：MouseWheelFixer.apply(stage);</p>
     * @author as4game@gmail.com
     */
    public class MouseWheelFixer {

        private static var _mouseInStage:Boolean = false;
        private static var _mouseWheelEnabled:Boolean = true;

        /**
         * 应用校正。
         */
        public static function apply(stage:Stage):void {
            stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMousIn);
            stage.addEventListener(Event.MOUSE_LEAVE, handleMousOut);
        }

        /**
         * 取消校正。
         */
        public static function cancel(stage:Stage):void {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMousIn);
            stage.removeEventListener(Event.MOUSE_LEAVE, handleMousOut);
        }

        private static function handleMousIn(e:Event):void {
            if(!_mouseInStage) {
                _mouseInStage = true;
                mouseWheelEnabled = false;
            }
        }

        private static function handleMousOut(e:Event):void {
            if(_mouseInStage) {
                _mouseInStage = false;
                mouseWheelEnabled = true;
            }
        }

        /**
         * 获取/设置 window 的鼠标滚动是否可用，用此属性可用启用或者禁用 window 对鼠标滚轮的响应。
         */
        public static function set mouseWheelEnabled(value:Boolean):void {
            if (!ExternalInterface.available) {
				return;
			}
			_mouseWheelEnabled = value;
			if (!_mouseWheelEnabled) {
				ExternalInterface.call("eval", "var _onFlashMousewheel = function(e){e = e || event;e.preventDefault && e.preventDefault();e.stopPropagation && e.stopPropagation();return e.returnValue = false;};if(navigator.appName.indexOf(\"Microsoft\") == -1){var type = (document.getBoxObjectFor=='undefined'?'mousewheel':'DOMMouseScroll');window.addEventListener(type, _onFlashMousewheel, false);}else{document.onmousewheel = _onFlashMousewheel;}");
			}else {
				ExternalInterface.call("eval", "if(navigator.appName.indexOf(\"Microsoft\") == -1){var type = (document.getBoxObjectFor=='undefined'?'mousewheel':'DOMMouseScroll');window.removeEventListener(type, _onFlashMousewheel, false);}else{document.onmousewheel = null;}");
			}
        }
        public static function get mouseWheelEnabled():Boolean {
            return _mouseWheelEnabled;
        }
    }
}
