package akdcl.media.providers {
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Security;
	import flash.system.SecurityPanel;

	import akdcl.events.MediaEvent;

	/**
	 * ...
	 * @author akdcl
	 */

	/// @eventType	akdcl.events.MediaEvent.DISPLAY_CHANGE
	[Event(name="displayChange",type="akdcl.events.MediaEvent")]

	final public class CameraProvider extends MediaProvider implements IDiplayProvider  {
		
		protected var __displayContent:Object;
		public function get displayContent():Object {
			return __displayContent;
		}
		
		private var camera:Camera;
		private var isCameraAdded:Boolean;
		
		override protected function init():void 
		{
			super.init();
			name = "cameraProvider";
		}
		
		override protected function onRemoveHandler():void 
		{
			if (camera){
				camera.removeEventListener(ActivityEvent.ACTIVITY, onCameraHandler);
				camera.removeEventListener(StatusEvent.STATUS, onCameraHandler);
			}
			playContent.removeEventListener(Event.FRAME_CONSTRUCTED, onVideoFrameConstructedHandler);
			super.onRemoveHandler();
			playContent = null;
			__displayContent = null;
			camera = null;
		}
		
		override protected function loadHandler():void {
			if (!camera){
				setCameraMode();
			}
			if (camera){
				camera.addEventListener(StatusEvent.STATUS, onCameraHandler);
				if (camera.muted && isCameraAdded){
					Security.showSettings(SecurityPanel.PRIVACY);
				}
				__displayContent = null;
				playContent.addEventListener(Event.FRAME_CONSTRUCTED, onVideoFrameConstructedHandler);
				playContent.attachCamera(camera);
				playContent.smoothing = true;
			} else {
				onLoadErrorHandler();
			}
		}
		
		private function onVideoFrameConstructedHandler(e:Event):void 
		{
			if (playContent.videoWidth * playContent.videoHeight > 0) {
				if (!__displayContent) {
					onDisplayChange(playContent);
					onLoadCompleteHandler();
				}
			}else if (__displayContent) {
				onDisplayChange(null);
			}
		}
		
		override protected function playHandler(_startTime:int = -1):void 
		{
			if (camera && playContent){
				playContent.addEventListener(Event.FRAME_CONSTRUCTED, onVideoFrameConstructedHandler);
				playContent.attachCamera(camera);
				playContent.smoothing = true;
			}
		}
		
		override protected function pauseHandler():void 
		{
			if (playContent){
				playContent.removeEventListener(Event.FRAME_CONSTRUCTED, onVideoFrameConstructedHandler);
				playContent.attachCamera(null);
			}
		}
		
		override protected function stopHandler():void 
		{
			if (playContent){
				playContent.removeEventListener(Event.FRAME_CONSTRUCTED, onVideoFrameConstructedHandler);
				playContent.attachCamera(null);
				playContent.clear();
			}
		}

		public function setCameraMode(_width:int = 0, _height:int = 0):void {
			camera = Camera.getCamera();
			if (camera){
				camera.setMode(_width || 1280, _height || 960, camera.fps);
				if (playContent){

				} else {
					playContent = new Video(camera.width, camera.height);
				}
				trace("camera:", camera.width, camera.height);
				trace("video:", playContent.width, playContent.height);
			}
		}

		private function onCameraHandler(_evt:* = null):void {
			switch (_evt.code){
				case "Camera.Muted":
					if (!isCameraAdded){
						onLoadErrorHandler();
					}
					isCameraAdded = true;
					playContent.removeEventListener(Event.FRAME_CONSTRUCTED, onVideoFrameConstructedHandler);
					onDisplayChange(null);
					break;
				case "Camera.Unmuted":
					isCameraAdded = true;
					playContent.addEventListener(Event.FRAME_CONSTRUCTED, onVideoFrameConstructedHandler);
					break;
				default:
					break;
			}
		}

		private function onDisplayChange(_display:*):void {
			//加载显示对象
			//playContent;
			__displayContent = _display;
			showDisplay();
			if (hasEventListener(MediaEvent.DISPLAY_CHANGE)){
				dispatchEvent(new MediaEvent(MediaEvent.DISPLAY_CHANGE));
			}
		}
		
		public function showDisplay():void {
			if (__displayContent) {
				__displayContent.visible = true;
			}
		}
		
		public function hideDisplay():void {
			if (__displayContent) {
				__displayContent.visible = false;
			}
		}
	}
}