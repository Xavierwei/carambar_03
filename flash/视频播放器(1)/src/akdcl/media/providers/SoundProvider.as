package akdcl.media.providers {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	import flash.net.URLRequest;

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	import akdcl.manager.SourceManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	final public class SoundProvider extends MediaProvider {
		private static var sM:SourceManager = SourceManager.getInstance();
		private static var REQUEST:URLRequest = new URLRequest();

		private static function setChannelVolume(_channel:SoundChannel, _volume:Number):void {
			var _soundTransform:SoundTransform = _channel.soundTransform;
			_soundTransform.volume = _volume;
			_channel.soundTransform = _soundTransform;
		}
		
		private var channel:SoundChannel;
		private var pausePosition:uint = 0;
		private var isBuffering:Boolean = false;

		override public function get loadProgress():Number {
			return (playContent && playContent.bytesTotal > 0) ? (playContent.bytesLoaded / playContent.bytesTotal) : 0;
		}

		override public function get totalTime():uint {
			return (playContent && loadProgress > 0) ? (playContent.length / loadProgress) : 0;
		}

		override public function get bufferProgress():Number {
			return Math.min((totalTime * loadProgress - position) / SoundMixer.bufferTime * 1000, 1);
		}

		override public function get position():uint {
			return pausePosition ? pausePosition : (channel ? channel.position : 0);
		}

		override public function set volume(value:Number):void {
			super.volume = value;
			if (channel){
				setChannelVolume(channel, volume);
			}
		}
		
		override protected function init():void 
		{
			super.init();
			name = "soundProvider";
		}
		
		override protected function onRemoveHandler():void 
		{
			removeContentListener();
			super.onRemoveHandler();
		}

		override protected function loadHandler():void {
			removeContentListener();
			playContent = sM.getSource(SourceManager.SOUND_GROUP, playItem.source);
			if (playContent){
			} else {
				playContent = new Sound();
				sM.addSource(SourceManager.SOUND_GROUP, playItem.source, playContent);
				REQUEST.url = playItem.source;
				playContent.addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
				playContent.load(REQUEST);
			}
			if (loadProgress >= 1){
				//playContent已经加载完毕，在waitHandler中调用onLoadCompleteHandler;
			} else {
				playContent.addEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
				playContent.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
			}
		}
		
		override protected function waitHandler():void {
			if (loadProgress >= 1 && !playContent.hasEventListener(Event.COMPLETE)) {
				onLoadCompleteHandler();
			}
		}

		override protected function playHandler(_startTime:int = -1):void {
			if (playContent){
				removeChannel();
				if (_startTime < 0 && pausePosition > 0){
					_startTime = pausePosition;
				}
				if (_startTime < 0){
					_startTime = 0;
				}
				pausePosition = 0;
				channel = playContent.play(_startTime);
				setChannelVolume(channel, __volume);
				channel.addEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
			}
		}

		override protected function pauseHandler():void {
			pausePosition = position;
			removeChannel();
		}

		override protected function stopHandler():void {
			pausePosition = 0;
			removeChannel();
		}

		override protected function onLoadErrorHandler(_evt:* = null):void {
			removeContentListener();
			sM.removeSource(SourceManager.SOUND_GROUP, playContent);
			playContent = null;
			super.onLoadErrorHandler(_evt);
		}

		override protected function onLoadProgressHandler(_evt:* = null):void {
			if (bufferProgress < 1){
				isBuffering = true;
				onBufferProgressHandler();
			} else if (isBuffering){
				isBuffering = false;
				onBufferProgressHandler();
			}
			super.onLoadProgressHandler(_evt);
		}

		private function removeContentListener():void {
			if (playContent){
				//卸载playContent
				playContent.removeEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
				playContent.removeEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
				playContent.removeEventListener(Event.COMPLETE, onLoadCompleteHandler);
			}
		}

		private function removeChannel():void {
			if (channel){
				channel.stop();
				channel.removeEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
			}
			channel = null;
		}
	}

}