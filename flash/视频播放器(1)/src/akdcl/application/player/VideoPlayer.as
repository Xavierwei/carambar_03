package akdcl.application.player{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.VideoLoader;
	import com.greensock.layout.ScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class VideoPlayer extends MediaPlayer {
		protected static const DEFAULT_PARAMS:Object = { autoPlay:false, scaleMode:ScaleMode.PROPORTIONAL_INSIDE, bgColor:0x000000 };
		protected static var videoDic:Object = { };
		protected static function loadVideo(_source:String, _params:Object = null):VideoLoader {
			var _video:VideoLoader = videoDic[_source];
			if (!_video) {
				if (_params) {
					for (var _i:String in DEFAULT_PARAMS) {
						if (!_params.hasOwnProperty(_i)) {
							_params[_i] = DEFAULT_PARAMS[_i];
						}
					}
				}
				_video = new VideoLoader(_source, _params || DEFAULT_PARAMS);
				videoDic[_source] = _video;
			}
			return _video;
		}
		protected static function removeVideo(_video:VideoLoader):void {
			for (var _source:String in videoDic) {
				if (videoDic[_source]==_video) {
					delete videoDic[_source];
					break;
				}
			}
		}
		
		override public function get loadProgress():Number {
			return video?video.progress:0; 
		}
		override public function get bufferProgress():Number {
			return video?video.bufferProgress:0;
		}
		override public function get totalTime():uint { 
			return video?(video.duration * 1000):0;
		}
		override public function get position():uint {
			return video?(video.videoTime * 1000):0;
		}
		override public function set position(value:uint):void {
			if (video) {
				video.videoTime = Math.min(value, totalTime * video.progress * 0.99) * 0.001;
			}
		}
		override public function set volume(value:Number):void {
			super.volume = value;
			if (video) {
				video.volume = volume;
			}
		}
		override public function set contentWidth(value:uint):void {
			super.contentWidth = value;
			if (content) {
				content.fitWidth = contentWidth;
			}
		}
		override public function set contentHeight(value:uint):void {
			super.contentHeight = value;
			if (content) {
				content.fitHeight = contentHeight;
			}
		}
		override public function get content():* {
			return video?video.content:null;
		}
		
		override public function set container(value:*):void {
			super.container = value;
			if (container && content) {
				container.addChild(content);
				content.fitWidth = contentWidth;
				content.fitHeight = contentHeight;
			}
		}
		
		protected var video:VideoLoader;
		public var videoParams:Object;
		override public function remove():void {
			hideContent();
			video.cancel();
			video = null;
			videoParams = null;
			super.remove();
		}
		override public function play():void {
			if (video&&!video.paused) {
				 video.playVideo();
			}
			super.play();
		}
		override public function pause():void {
			video && video.pauseVideo();
			super.pause();
		}
		override public function stop():void {
			if (video) {
				if (autoRewind && video.videoTime != 0) {
					video.videoTime = 0;
				}
				video.pauseVideo();
			}
			super.stop();
		}
		override public function hideContent():void {
			super.hideContent();
			if (container && content && container.contains(content)) {
				container.removeChild(content);
			}
		}
		override protected function onPlayIDChangeHandler(_playID:int):void {
			stop();
			if (video) {
				video.removeEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
				video.removeEventListener(LoaderEvent.PROGRESS, onLoadProgressHandler);
				video.removeEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
				video.removeEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
			}
			hideContent();
			
			super.onPlayIDChangeHandler(_playID);
			
			var _videoSource:String = getMediaByID(_playID);
			video = loadVideo(_videoSource, videoParams);
			video.addEventListener(LoaderEvent.ERROR, onLoadErrorHandler);
			video.addEventListener(LoaderEvent.PROGRESS, onLoadProgressHandler);
			video.addEventListener(LoaderEvent.COMPLETE, onLoadCompleteHandler);
			video.addEventListener(VideoLoader.VIDEO_COMPLETE, onPlayCompleteHandler);
			video.load();
			if (container && content) {
				container.addChild(content);
				content.fitWidth = contentWidth;
				content.fitHeight = contentHeight;
			}
			play();
			timer.addEventListener(TimerEvent.TIMER, onBufferProgressHandler);
		}
		override protected function onPlayCompleteHandler(_evt:* = null):void {
			super.onPlayCompleteHandler(_evt);
			timer.removeEventListener(TimerEvent.TIMER, onBufferProgressHandler);
		}
		override protected function onLoadErrorHandler(_evt:* = null):void {
			super.onLoadErrorHandler(_evt);
			removeVideo(video);
		}
		protected var isBuffering:Boolean;
		override protected function onBufferProgressHandler(_evt:* = null):void {
			if (bufferProgress < 1 && video && video.videoPaused) {
				if (!isBuffering) {
					//
				}
				super.onBufferProgressHandler(_evt);
				isBuffering = true;
			}else {
				if (isBuffering) {
					super.onBufferProgressHandler(_evt);
					//
				}
				isBuffering = false;
			}
		}
	}
}