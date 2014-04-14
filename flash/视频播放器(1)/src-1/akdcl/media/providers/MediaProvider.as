package akdcl.media.providers {
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import akdcl.manager.LoggerManager;
	
	import akdcl.events.UIEventDispatcher;
	import akdcl.events.MediaEvent;
	
	import akdcl.media.PlayItem;
	import akdcl.media.PlayState;

	/**
	 * ...
	 * @author Akdcl
	 */
	/// @eventType	akdcl.events.MediaEvent.VOLUME_CHANGE
	[Event(name="volumeChange",type="akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.STATE_CHANGE
	[Event(name="stateChange",type="akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.PLAY_PROGRESS
	[Event(name="playProgress",type="akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.PLAY_COMPLETE
	[Event(name="playComplete",type="akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.LOAD_ERROR
	[Event(name="loadError",type="akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.LOAD_PROGRESS
	[Event(name="loadProgress",type="akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.BUFFER_PROGRESS
	[Event(name="bufferProgress",type="akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.LOAD_COMPLETE
	[Event(name="loadComplete",type="akdcl.events.MediaEvent")]

	public class MediaProvider extends UIEventDispatcher {
		public static var TIMER_INTERVAL:uint = 100;
		
		private static const VOLUME_DEFAULT:Number = 0.8;
		private static const lM:LoggerManager = LoggerManager.getInstance();
		
		protected var playContent:*;
		protected var timer:Timer;

		protected var playItem:PlayItem;

		public function get loadProgress():Number {
			return 0;
		}

		public function get totalTime():uint {
			return 0;
		}

		public function get bufferProgress():Number {
			return 1;
		}

		public function get position():uint {
			return 0;
		}

		public function set position(_position:uint):void {
			/*if (_position == position){
				return;
			}*/
			setPlayState(PlayState.SEEK);
			play(_position);
		}

		public function get playProgress():Number {
			return totalTime > 0 ? (position / totalTime) : 0;
		}

		public function set playProgress(_playProgress:Number):void {
			if (_playProgress < 0){
				_playProgress = 0;
			} else if (_playProgress > 1){
				_playProgress = 1;
			}
			position = totalTime * _playProgress;
		}

		public function get isPlaying():Boolean {
			return __playState == PlayState.PLAY;
		}

		protected var __playState:String = PlayState.READY;

		public function get playState():String {
			return __playState;
		}

		private var volumeLast:Number = 0;
		protected var __volume:Number = VOLUME_DEFAULT;

		public function get volume():Number {
			return __volume;
		}

		public function set volume(_volume:Number):void {
			if (_volume < 0){
				_volume = 0;
			} else if (_volume > 1){
				_volume = 1;
			}
			if (__volume == _volume){
				return;
			}
			__volume = _volume;
			if (hasEventListener(MediaEvent.VOLUME_CHANGE)){
				dispatchEvent(new MediaEvent(MediaEvent.VOLUME_CHANGE));
			}
		}

		public function get mute():Boolean {
			return volume == 0;
		}

		public function set mute(_mute:Boolean):void {
			if (_mute && (volume == 0)){
				return;
			}
			if (_mute){
				volumeLast = volume;
				volume = 0;
			} else {
				if (volumeLast < 0.004){
					volumeLast = VOLUME_DEFAULT;
				}
				volume = volumeLast;
			}
		}

		override protected function init():void {
			super.init();
			timer = new Timer(TIMER_INTERVAL);
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			stop();
			timer.stop();
			timer = null;
			playContent = null;
			playItem = null;
		}

		public function load(_item:*):void {
			stop();
			if (_item is PlayItem){
				playItem = _item;
			} else if (_item){
				playItem = new PlayItem(_item);
			}
			setPlayState(PlayState.CONNECT, loadHandler);
			setPlayState(PlayState.WAIT, waitHandler);
		}

		public function play(_startTime:int = -1):void {
			setPlayState(PlayState.PLAY, playHandler, Math.min(_startTime, totalTime));
		}

		public function pause():void {
			setPlayState(PlayState.PAUSE, pauseHandler);
		}

		public function stop():void {
			setPlayState(PlayState.STOP, stopHandler);
		}

		protected function setPlayState(_playState:String, _callBack:Function = null, ... args):void {
			if (__playState == _playState){
				return;
			}
			switch (_playState){
				case PlayState.SEEK:
					break;
				case PlayState.CONNECT:
					timer.reset();
					timer.start();
					break;
				case PlayState.WAIT:
					break;
				case PlayState.RECONNECT:
					timer.reset();
					timer.start();
					break;
				case PlayState.PLAY:
					timer.start();
					timer.addEventListener(TimerEvent.TIMER, onPlayProgressHander);
					break;
				case PlayState.COMPLETE:
					timer.stop();
				case PlayState.READY:
				case PlayState.PAUSE:
				case PlayState.STOP:
					timer.removeEventListener(TimerEvent.TIMER, onPlayProgressHander);
					break;
			}
			__playState = _playState;
			if (_callBack != null){
				_callBack.apply(this, args);
			}
			//
			lM.info(this, "playStateChange:" + __playState + "====>>>>\n" + providerInfo());
			if (hasEventListener(MediaEvent.STATE_CHANGE)){
				dispatchEvent(new MediaEvent(MediaEvent.STATE_CHANGE));
			}
		}

		protected function loadHandler():void {
		}

		protected function waitHandler():void {
		}

		protected function playHandler(_startTime:int = -1):void {
		}

		protected function pauseHandler():void {
		}

		protected function stopHandler():void {
		}
		
		protected function providerInfo():String {
			var _str:String = "";
			_str += "loadProgress:" + loadProgress + " (" + position + "/" + totalTime + ")" +"\n" +
				"bufferProgress:" + bufferProgress + "\n" +
				"playProgress:" + playProgress;
			return _str;
		}

		//
		protected function onLoadErrorHandler(_evt:* = null):void {
			stop();
			lM.error(this, "loadError:" + playItem);
			if (hasEventListener(MediaEvent.LOAD_ERROR)){
				dispatchEvent(new MediaEvent(MediaEvent.LOAD_ERROR));
			}
		}

		protected function onLoadProgressHandler(_evt:* = null):void {
			if (hasEventListener(MediaEvent.LOAD_PROGRESS)){
				dispatchEvent(new MediaEvent(MediaEvent.LOAD_PROGRESS));
			}
		}

		protected function onLoadCompleteHandler(_evt:* = null):void {
			lM.info(this, "loadComplete" + "====>>>>\n" + providerInfo());
			if (hasEventListener(MediaEvent.LOAD_COMPLETE)){
				dispatchEvent(new MediaEvent(MediaEvent.LOAD_COMPLETE));
			}
		}

		protected function onPlayProgressHander(_evt:* = null):void {
			if (hasEventListener(MediaEvent.PLAY_PROGRESS)){
				dispatchEvent(new MediaEvent(MediaEvent.PLAY_PROGRESS));
			}
		}

		protected function onBufferProgressHandler(_evt:* = null):void {
			if (hasEventListener(MediaEvent.BUFFER_PROGRESS)){
				dispatchEvent(new MediaEvent(MediaEvent.BUFFER_PROGRESS));
			}
		}

		protected function onPlayCompleteHandler(_evt:* = null):void {
			setPlayState(PlayState.COMPLETE);
			lM.info(this, "playComplete" + "====>>>>\n" + providerInfo());
			if (hasEventListener(MediaEvent.PLAY_COMPLETE)){
				dispatchEvent(new MediaEvent(MediaEvent.PLAY_COMPLETE));
			}
		}
	}

}