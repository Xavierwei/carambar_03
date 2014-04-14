package akdcl.media.providers {
	import com.greensock.loading.VideoLoader;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.ScaleMode;

	import akdcl.manager.SourceManager;
	import akdcl.events.MediaEvent;

	/**
	 * ...
	 * @author akdcl
	 */
	/// @eventType	akdcl.events.MediaEvent.DISPLAY_CHANGE
	[Event(name="displayChange",type="akdcl.events.MediaEvent")]
	final public class VideoProvider extends MediaProvider implements IDiplayProvider {
		private static const VIDEOLOADER_GROUP:String = "VideoLoader";
		private static const DEFAULT_PARAMS:Object = {autoPlay: false, repeat:0, scaleMode: ScaleMode.PROPORTIONAL_INSIDE, bgColor: 0x000000};

		private static var sM:SourceManager = SourceManager.getInstance();
		
		private var isBuffering:Boolean = false;
		
		protected var __displayContent:Object;
		public function get displayContent():Object {
			return __displayContent;
		}

		override public function get loadProgress():Number {
			return playContent ? playContent.progress : 0;
		}

		override public function get totalTime():uint {
			return playContent ? (playContent.duration * 1000) : 0;
		}

		override public function get bufferProgress():Number {
			if (loadProgress >= 1){
				return 1;
			}
			return playContent ? playContent.bufferProgress : 0;
		}

		override public function get position():uint {
			return playContent ? (playContent.videoTime * 1000) : 0;
		}

		override public function set volume(value:Number):void {
			super.volume = value;
			if (playContent){
				playContent.volume = volume;
			}
		}
		
		override protected function init():void 
		{
			super.init();
			name = "videoProvider";
		}
		
		override protected function onRemoveHandler():void 
		{
			removeContentListener();
			super.onRemoveHandler();
			__displayContent = null;
		}

		override protected function loadHandler():void {
			removeContentListener();
			playContent = sM.getSource(VIDEOLOADER_GROUP, playItem.source);
			if (playContent){
			} else {
				var _params:Object = null;
				if (_params){
					for (var _i:String in DEFAULT_PARAMS){
						if (!_params.hasOwnProperty(_i)){
							_params[_i] = DEFAULT_PARAMS[_i];
						}
					}
				}
				playContent = new VideoLoader(playItem.source, _params || DEFAULT_PARAMS);
				sM.addSource(VIDEOLOADER_GROUP, playItem.source, playContent);
				playContent.addEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
				playContent.load();
			}
			if (loadProgress >= 1){
				//playContent已经加载完毕，在waitHandler中调用onLoadCompleteHandler;
			} else {
				playContent.addEventListener(LoaderEvent.PROGRESS, onLoadProgressHandler);
				playContent.addEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
			}
			if (playContent.content && playContent.content.width > 0) {
				onDisplayChange();
			}else {
				playContent.addEventListener(LoaderEvent.INIT, onVideoInitHandler);
			}
			playContent.addEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
		}

		override protected function waitHandler():void {
			if (loadProgress >= 1){
				onLoadCompleteHandler();
			}
		}

		override protected function playHandler(_startTime:int = -1):void {
			if (playContent){
				if (_startTime < 0){
					playContent.playVideo();
				} else {
					playContent.videoTime = _startTime * 0.001;
					playContent.playVideo();
				}
				playContent.volume = volume;
			}
		}

		override protected function pauseHandler():void {
			if (playContent){
				playContent.pauseVideo();
			}
		}

		override protected function stopHandler():void {
			if (playContent){
				playContent.pauseVideo();
				playContent.videoTime = 0;
			}
		}

		override protected function onLoadErrorHandler(_evt:* = null):void {
			removeContentListener();
			sM.removeSource(VIDEOLOADER_GROUP, playContent);
			playContent.dispose();
			playContent = null;
			super.onLoadErrorHandler(_evt);
		}

		override protected function onLoadProgressHandler(_evt:* = null):void {
			if (!(_evt === false)){
				if (bufferProgress < 1){
					isBuffering = true;
					onBufferProgressHandler();
				} else if (isBuffering){
					isBuffering = false;
					onBufferProgressHandler();
				}
			}
			super.onLoadProgressHandler(_evt);
		}

		private function removeContentListener():void {
			if (playContent){
				//卸载playContent
				playContent.removeEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
				playContent.removeEventListener(LoaderEvent.PROGRESS, onLoadProgressHandler);
				playContent.removeEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
				playContent.removeEventListener(LoaderEvent.INIT, onVideoInitHandler);
				playContent.removeEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
			}
		}

		private function onVideoInitHandler(_e:LoaderEvent):void {
			playContent.removeEventListener(LoaderEvent.INIT, onVideoInitHandler);
			//
			onDisplayChange();
		}

		private function onDisplayChange():void {
			//加载显示对象
			__displayContent = playContent.content;
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