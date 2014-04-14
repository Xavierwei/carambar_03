package akdcl.media.providers {
	import flash.events.Event;

	import akdcl.manager.RequestManager;
	import akdcl.events.MediaEvent;
	import akdcl.media.PlayState;

	/**
	 * ...
	 * @author ...
	 */
	/// @eventType	akdcl.events.MediaEvent.DISPLAY_CHANGE
	[Event(name="displayChange",type="akdcl.events.MediaEvent")]
	final public class ImageProvider extends MediaProvider implements IDiplayProvider {
		public static var defaultTotalTime:uint = 5000;

		protected static var rM:RequestManager = RequestManager.getInstance();

		protected var __displayContent:Object;
		public function get displayContent():Object {
			return __displayContent;
		}
		
		private var lastSource:String;
		private var __loadProgress:Number = 0;

		override public function get loadProgress():Number {
			return __loadProgress;
		}

		private var __totalTime:uint = 0;

		override public function get totalTime():uint {
			return __totalTime;
		}

		override public function get bufferProgress():Number {
			return __loadProgress;
		}

		override public function get position():uint {
			return timer.currentCount * timer.delay;
		}

		override protected function init():void {
			super.init();
			name = "imageProvider";
		}

		override protected function onRemoveHandler():void {
			if (lastSource){
				rM.unloadDisplay(lastSource, onLoadCompleteHandler, onLoadErrorHandler, onLoadProgressHandler);
			}
			super.onRemoveHandler();
			__displayContent = null;
			lastSource = null;
		}

		override protected function loadHandler():void {
			if (lastSource){
				rM.unloadDisplay(lastSource, onLoadCompleteHandler, onLoadErrorHandler, onLoadProgressHandler);
			}
			__loadProgress = 0;
			lastSource = playItem.source;
			//判断是否是bmd并加载完毕，将onLoadCompleteHandler移入waitHandler
			rM.loadDisplay(lastSource, onLoadCompleteHandler, onLoadErrorHandler, onLoadProgressHandler, playItem.flashVars);
			timer.stop();
		}

		override protected function playHandler(_startTime:int = -1):void {
			if (position == totalTime){
				timer.reset();
				timer.start();
			}
		}

		override protected function pauseHandler():void {
			timer.stop();
		}

		override protected function stopHandler():void {
			timer.reset();
			timer.stop();
		}

		override protected function onLoadProgressHandler(_evt:* = null):void {
			if (_evt is Event){
				__loadProgress = _evt.bytesLoaded / _evt.bytesTotal;
			} else if (_evt is Number){
				__loadProgress = _evt;
			} else {
				__loadProgress = 0;
			}
			if (isNaN(__loadProgress)){
				__loadProgress = 0;
			}
			onBufferProgressHandler();
			super.onLoadProgressHandler(_evt);
		}

		override protected function onLoadCompleteHandler(_evt:* = null):void {
			__totalTime = defaultTotalTime;
			playContent = _evt;
			onDisplayChange();
			if (isPlaying){
				timer.start();
			}
			super.onLoadCompleteHandler(null);
		}

		override protected function onPlayProgressHander(_evt:* = null):void {
			if (loadProgress == 1) {
				super.onPlayProgressHander(_evt);
				if (position >= totalTime && __playState != PlayState.COMPLETE){
					onPlayCompleteHandler();
				}
			} else {
				//loadProgress为1以前，都不播放
				timer.reset();
				timer.stop();
			}
		}

		private function onDisplayChange():void {
			//加载显示对象
			__displayContent = playContent;
			if (hasEventListener(MediaEvent.DISPLAY_CHANGE)){
				dispatchEvent(new MediaEvent(MediaEvent.DISPLAY_CHANGE));
			}
		}
		
		public function showDisplay():void {
		}
		
		public function hideDisplay():void {
		}
	}

}