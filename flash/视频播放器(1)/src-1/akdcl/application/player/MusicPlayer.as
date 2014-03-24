package akdcl.application.player{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	public class MusicPlayer extends MediaPlayer {
		override public function get loadProgress():Number {
			return sound?sound.loadProgress:0; 
		}
		override public function get totalTime():uint { 
			return sound?sound.totalTime:0;
		}
		override public function get position():uint {
			return sound?sound.position:0;
		}
		override public function set position(value:uint):void {
			if (sound) {
				sound.position = value;
			}
		}
		override public function set volume(value:Number):void {
			super.volume = value;
			if (sound) {
				sound.volume = volume;
			}
		}
		protected var sound:Sound;
		override public function remove():void {
			if (sound) {
				sound.stop(true);
				sound = null;
			}
			super.remove();
		}
		override public function play():void {
			sound && sound.play();
			super.play();
		}
		override public function pause():void {
			sound && sound.pause();
			super.pause();
		}
		override public function stop():void {
			sound && sound.stop();
			super.stop();
		}
		override protected function onPlayIDChangeHandler(_playID:int):void {
			stop();
			if (sound) {
				sound.removeEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
				sound.removeEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
				sound.removeEventListener(Event.COMPLETE, onLoadCompleteHandler);
				sound.removeEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
				sound.stop(true);
			}
			
			super.onPlayIDChangeHandler(_playID);
			
			var _musicSource:String = getMediaByID(_playID);
			sound = Sound.loadSound(_musicSource);
			if (sound.loadProgress==1) {
				onLoadProgressHandler();
				onLoadCompleteHandler();
			}else {
				sound.addEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
				sound.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
				sound.addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
			}
			sound.addEventListener(Event.SOUND_COMPLETE, onPlayCompleteHandler);
			play();
		}
	}
}