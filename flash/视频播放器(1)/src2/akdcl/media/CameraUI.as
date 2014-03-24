package akdcl.media {

	import flash.display.BitmapData;

	import flash.events.Event;
	import flash.events.IOErrorEvent;

	import akdcl.media.providers.CameraProvider;
	import akdcl.display.UIDisplay;
	import akdcl.events.MediaEvent;
	import akdcl.utils.setDisplayWH;

	import ui.Alert;

	import akdcl.events.UIEventDispatcher;
	import flash.display.IBitmapDrawable;

	/**
	 * ...
	 * @author akdcl
	 */

	/// @eventType	flash.events.Event.COMPLETE
	[Event(name="complete",type="flash.events.Event")]
	/// @eventType	flash.events.IOErrorEvent.IO_ERROR
	[Event(name="ioError",type="flash.events.IOErrorEvent")]

	public class CameraUI extends UIEventDispatcher {
		private static const CAMERA_WIDTH:uint = 240;
		private static const CAMERA_HEIGHT:uint = 180;

		public var data:BitmapData;

		private var eventComplete:Event;

		private var cameraP:CameraProvider;
		private var display:UIDisplay;
		
		private var alert:Alert;

		override protected function init():void {
			super.init();
			display = new UIDisplay(CAMERA_WIDTH, CAMERA_HEIGHT, 0);
			display.autoRemove = false;
			display.enabled = false;

			eventComplete = new Event(Event.COMPLETE);
			
			cameraP = new CameraProvider();
			cameraP.addEventListener(MediaEvent.DISPLAY_CHANGE, onCameraChangeHandler);
			cameraP.addEventListener(MediaEvent.LOAD_ERROR, onCameraErrorHandler);
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			cameraP.remove();
			display.remove();
			if (data) {
				data.dispose();
			}
			cameraP = null;
			display = null;
			eventComplete = null;
			data = null;
		}

		public function launch():void {
			cameraP.load(null);
		}

		public function setCameraMode(_width:int = 0, _height:int = 0):void {
			cameraP.setCameraMode(_width, _height);
		}

		private function onCameraErrorHandler(_e:MediaEvent):void {
			if (hasEventListener(IOErrorEvent.IO_ERROR)){
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			}
		}

		private function onCameraChangeHandler(_e:MediaEvent):void {
			if (cameraP.displayContent) {
				display.proxy.setSize(cameraP.displayContent.width, cameraP.displayContent.height, false);
				
				setDisplayWH(display.proxy, CAMERA_WIDTH, CAMERA_HEIGHT);
				
				display.setContent(cameraP.displayContent, 0);

				alert = Alert.show("", "拍照|取消", onAlertHandler);
				alert.addItem(display);
			}else {
				if (alert) {
					alert.remove();
				}
				alert = null;
			}
		}

		private function onAlertHandler(_b:Boolean):void {
			if (_b) {
				try{
					data.width;
				}catch (_e:Error) {
					data = null;
				}
				if (!data || data.width != cameraP.displayContent.width || data.height != cameraP.displayContent.height){
					if (data){
						data.dispose();
					}
					data = new BitmapData(cameraP.displayContent.width / cameraP.displayContent.scaleX, cameraP.displayContent.height / cameraP.displayContent.scaleY, false, 0);
				}
				data.draw(cameraP.displayContent as IBitmapDrawable);
				if (hasEventListener(Event.COMPLETE)){
					dispatchEvent(eventComplete);
				}
			}
			cameraP.stop();
		}
	}

}