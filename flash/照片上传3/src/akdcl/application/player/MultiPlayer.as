package akdcl.application.player{
	import akdcl.application.player.MediaEvent;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class MultiPlayer extends MediaPlayer{
		override public function get loadProgress():Number {
			return currentPlayer?currentPlayer.loadProgress:0; 
		}
		override public function get bufferProgress():Number {
			return currentPlayer?currentPlayer.bufferProgress:0; 
		}
		override public function get totalTime():uint { 
			return currentPlayer?currentPlayer.totalTime:0;
		}
		override public function get position():uint {
			return currentPlayer?currentPlayer.position:0;
		}
		override public function set position(value:uint):void {
			if (currentPlayer) {
				currentPlayer.position = value;
			}
		}
		override public function set contentWidth(value:uint):void {
			super.contentWidth = value;
			musicPlayer.contentWidth = contentWidth;
			imagePlayer.contentWidth = contentWidth;
			videoPlayer.contentWidth = contentWidth;
			wmpPlayer.contentWidth = contentWidth;
		}
		override public function set contentHeight(value:uint):void {
			super.contentHeight = value;
			musicPlayer.contentHeight = contentHeight;
			imagePlayer.contentHeight = contentHeight;
			videoPlayer.contentHeight = contentHeight;
			wmpPlayer.contentHeight = contentHeight;
		}
		override public function set volume(value:Number):void {
			super.volume = value;
			musicPlayer.volume = volume;
			imagePlayer.volume = volume;
			videoPlayer.volume = volume;
			wmpPlayer.volume = volume;
		}
		public var imagePlayer:ImagePlayer;
		public var musicPlayer:MusicPlayer;
		public var videoPlayer:VideoPlayer;
		public var wmpPlayer:WMPPlayer;
		protected var currentPlayer:MediaPlayer;
		override protected function init():void {
			super.init();
			musicPlayer = new MusicPlayer();
			imagePlayer = new ImagePlayer();
			videoPlayer = new VideoPlayer();
			wmpPlayer = new WMPPlayer();
			imagePlayer.repeat = 0;
			musicPlayer.repeat = 0;
			videoPlayer.repeat = 0;
			wmpPlayer.repeat = 0;
			//?
			imagePlayer.autoPlay = false;
			musicPlayer.autoPlay = false;
			videoPlayer.autoPlay = false;
			wmpPlayer.autoPlay = false;
		}
		override public function remove():void {
			imagePlayer.remove();
			musicPlayer.remove();
			videoPlayer.remove();
			wmpPlayer.remove();
			imagePlayer = null;
			musicPlayer = null;
			videoPlayer = null;
			wmpPlayer = null;
			currentPlayer = null;
			super.remove();
		}
		override public function play():void {
			if (currentPlayer) {
				currentPlayer.play();
			}
			super.play();
		}
		override public function pause():void {
			if (currentPlayer) {
				currentPlayer.pause();
			}
			super.pause();
		}
		override public function stop():void {
			if (currentPlayer) {
				currentPlayer.stop();
			}
			super.stop();
		}
		override public function hideContent():void {
			super.hideContent();
			if (currentPlayer) {
				currentPlayer.hideContent();
			}
		}
		override protected function onPlayIDChangeHandler(_playID:int):void {
			stop();
			if (currentPlayer) {
				currentPlayer.removeEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				currentPlayer.removeEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
				currentPlayer.removeEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				currentPlayer.removeEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
				currentPlayer.removeEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);	
			}
			hideContent();
			
			super.onPlayIDChangeHandler(_playID);
			
			var _mediaSource:String = getMediaByID(_playID);
			var _mediaType:String = _mediaSource.split("?")[0];
			_mediaType = String(_mediaType.split(".").pop()).toLowerCase();
			switch(_mediaType) {
				case "mp3":
				case "wav":
					currentPlayer = musicPlayer;
					break;
				case "bmp":
				case "gif":
				case "jpg":
				case "png":
					currentPlayer = imagePlayer;
					break;
				case "flv":
				case "mov":
				case "mp4":
				case "f4v":
					currentPlayer = videoPlayer;
					break;
				case "wma":
				case "wmv":
				case "mms":
				default:
					currentPlayer = wmpPlayer;
					break;
			}
			currentPlayer.addEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
			currentPlayer.addEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
			currentPlayer.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
			currentPlayer.addEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
			currentPlayer.addEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);
			currentPlayer.container = container;
			currentPlayer.playlist = _mediaSource;
			__content = currentPlayer.content;
			play();
		}
	}
}