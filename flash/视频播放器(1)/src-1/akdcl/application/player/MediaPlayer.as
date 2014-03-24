package akdcl.application.player{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import akdcl.events.UIEventDispatcher;
	
	import akdcl.utils.PageID;
	/**
	 * ...
	 * @author Akdcl
	 */
	/// @eventType	akdcl.application.player.MediaEvent.LIST_CHANGE
	[Event(name = "listChange", type = "akdcl.application.player.MediaEvent")]
	
	/// @eventType	akdcl.application.player.MediaEvent.VOLUME_CHANGE
	[Event(name = "volumeChange", type = "akdcl.application.player.MediaEvent")]

	/// @eventType	akdcl.application.player.MediaEvent.STATE_CHANGE
	[Event(name = "stateChange", type = "akdcl.application.player.MediaEvent")]

	/// @eventType	akdcl.application.player.MediaEvent.PLAY_PROGRESS
	[Event(name = "playProgress", type = "akdcl.application.player.MediaEvent")]

	/// @eventType	akdcl.application.player.MediaEvent.PLAY_COMPLETE
	[Event(name = "playComplete", type = "akdcl.application.player.MediaEvent")]
	
	/// @eventType	akdcl.application.player.MediaEvent.LOAD_ERROR
	[Event(name = "loadError", type = "akdcl.application.player.MediaEvent")]

	/// @eventType	akdcl.application.player.MediaEvent.LOAD_PROGRESS
	[Event(name = "loadProgress", type = "akdcl.application.player.MediaEvent")]
	
	/// @eventType	akdcl.application.player.MediaEvent.BUFFER_PROGRESS
	[Event(name = "bufferProgress", type = "akdcl.application.player.MediaEvent")]
	
	/// @eventType	akdcl.application.player.MediaEvent.LOAD_COMPLETE
	[Event(name = "loadComplete", type = "akdcl.application.player.MediaEvent")]
	
	/// @eventType	akdcl.application.player.MediaEvent.PLAY_ID_CHANGE
	[Event(name = "playIDChange", type = "akdcl.application.player.MediaEvent")]
	
	public class MediaPlayer extends UIEventDispatcher {
		public static const STATE_PLAY:String = "play";
		public static const STATE_PAUSE:String = "pause";
		public static const STATE_STOP:String = "stop";
		public static const STATE_READY:String = "ready";
		public static const STATE_CONNECT:String = "connect";
		public static const STATE_WAIT:String = "wait";
		public static const STATE_BUFFER:String = "buffer";
		public static const STATE_RECONNECT:String = "reconnect";
		
		private static const NAME_LIST:Object = { };
		NAME_LIST[STATE_PLAY] = "播放";
		NAME_LIST[STATE_PAUSE] = "暂停";
		NAME_LIST[STATE_STOP] = "停止";
		NAME_LIST[STATE_READY] = "就绪";
		NAME_LIST[STATE_CONNECT] = "连接";
		NAME_LIST[STATE_WAIT] = "等待";
		NAME_LIST[STATE_BUFFER] = "缓冲";
		NAME_LIST[STATE_RECONNECT] = "重新连接";
		
		public static function getStateName(_state:String):String {
			return NAME_LIST[_state] || _state;
		}
		
		public static const VALUE_PERCENTAGE:Number = 0.004;
		public static const VOLUME_DEFAULT:Number = 0.8;
		public static var SOURCE_ID:String = "source";
		//根据提供的数据源获取播放列表
		public static function createList(_list:*):XMLList {
			var _xml:XML;
			if ((_list is String) || (_list is Array)) {
				if (_list is String) {
					//将字符串按"|"格式成数组
					_list = _list.split("|");
				}
				_xml =<root/>;
				for each (var _each:String in _list) {
					_xml.appendChild(<list source={_each}/>);
				}
				_list = _xml.list;
			}else if (_list is XMLList || _list is XML) {
				if (_list is XML) {
					//取XML中的"list"列表
					_list = _list.list;
				}
				if (_list.attribute(SOURCE_ID).length()==0) {
					return null;
				}
			}else {
				return null;
			}
			return _list;
		}
		
		//加载进度0~1
		public function get loadProgress():Number {
			return 0;
		}
		//缓冲进度0~1
		public function get bufferProgress():Number {
			return 0;
		}
		//媒体长度(时间:毫秒为单位)
		public function get totalTime():uint {
			return 0;
		}
		//播放长度(时间:毫秒为单位)
		public function get position():uint {
			return 0;
		}
		public function set position(_position:uint):void {
		}
		//播放进度0~1
		public function get playProgress():Number {
			return position / totalTime;
		}
		public function set playProgress(value:Number):void {
			position = totalTime * value;
		}
		//音量0~1
		private var __volume:Number = VOLUME_DEFAULT;
		public function get volume():Number {
			return __volume;
		}
		public function set volume(_volume:Number):void {
			if (_volume < 0) {
				_volume = 0;
			}else if (_volume > 1) {
				_volume = 1;
			}
			__volume = _volume;
			dispatchEvent(new MediaEvent(MediaEvent.VOLUME_CHANGE));
		}
		//静音
		private var volumeLast:Number = 0;
		public function get mute():Boolean {
			return volume == 0;
		}
		public function set mute(_mute:Boolean):void {
			if (_mute && (volume == 0)) {
				return;
			}
			if (_mute) {
				volumeLast = volume;
				volume = 0;
			}else{
				if (volumeLast < VALUE_PERCENTAGE) {
					volumeLast = VOLUME_DEFAULT;
				}
				volume = volumeLast;
			}
		}
		//当前播放列表位置
		public function get playID():int {
			return idPart.id;
		}
		public function set playID(_playID:int):void {
			if (idPart.length == 1 && _playID == 1) {
				idPart.setID( -1);
			}
			idPart.id = _playID;
		}
		//0:不循环，1:单首循环，2:顺序循环(全部播放完毕后停止)，3:顺序循环，4:随机播放
		private var __repeat:uint = 3;
		public function get repeat():uint {
			return __repeat;
		}
		public function set repeat(_repeat:uint):void {
			__repeat = _repeat;
		}
		//是否处于播放状态
		public function get isPlaying():Boolean {
			return playState == STATE_PLAY;
		}
		//当前播放状态
		private var __playState:String = STATE_STOP;
		public function get playState():String{
			return __playState;
		}
		protected function setPlayState(_playState:String):Boolean {
			if (__playState == _playState) {
				return false;
			}
			switch(_playState) {
				case STATE_PLAY:
					onPlayProgressHander(null);
					timer.addEventListener(TimerEvent.TIMER, onPlayProgressHander);
					break;
				case STATE_PAUSE:
					if (__playState == STATE_STOP) {
						return false;
					}
				case STATE_STOP:
					onPlayProgressHander(null);
					timer.removeEventListener(TimerEvent.TIMER, onPlayProgressHander);
					break;
			}
			__playState = _playState;
			dispatchEvent(new MediaEvent(MediaEvent.STATE_CHANGE));
			return true;
		}
		//
		private var __contentWidth:uint;
		public function get contentWidth():uint {
			return __contentWidth;
		}
		public function set contentWidth(value:uint):void {
			__contentWidth = value;
		}
		private var __contentHeight:uint;
		public function get contentHeight():uint {
			return __contentHeight;
		}
		public function set contentHeight(value:uint):void {
			__contentHeight = value;
		}
		protected var __content:*;
		public function get content():* {
			return __content;
		}
		private var __container:*;
		public function get container():*{
			return __container;
		}
		public function set container(_cotainer:*):void {
			if (_cotainer == __container) {
				return;
			}
			__container = _cotainer;
		}
		//播放列表
		private var __playlist:XMLList;
		public function get playlist():XMLList {
			return __playlist;
		}
		public function set playlist(_playlist:*):void{
			_playlist = createList(_playlist);
			if (!_playlist) {
				return;
			}
			stop();
			__playlist = _playlist;
			idPart.length = __playlist.length();
			idPart.setID( -1);
			dispatchEvent(new MediaEvent(MediaEvent.LIST_CHANGE));
			if (autoPlay) {
				playID = 0;
			}
			autoPlay = true;
		}
		//
		public var autoPlay:Boolean = true;
		public var autoRewind:Boolean = true;
		public var updateInterval:uint = 30;
		protected var timer:Timer;
		protected var idPart:PageID;
		//
		override protected function init():void {
			super.init();
			timer = new Timer(updateInterval);
			idPart = new PageID();
			idPart.onIDChange = onPlayIDChangeHandler;
		}
		
		override protected function onRemoveHandler():void 
		{
			stop();
			timer = null;
			idPart.remove();
			idPart = null;
			playlist = null;
			container = null;
			if ("remove" in __content) {
				__content.remove();
			}
			__content = null;
			super.onRemoveHandler();
		}
		//
		public function getMediaByID(_playID:int):String {
			return playlist?String(playlist[_playID].attribute(SOURCE_ID)):null
		}
		//
		public function play():void {
			timer.start();
			if (playID<0) {
				playID = 0;
				return;
			}
			setPlayState(STATE_PLAY);
		}
		public function pause():void {
			setPlayState(STATE_PAUSE);
		}
		public function stop():void {
			setPlayState(STATE_STOP);
		}
		public function playOrPause():Boolean {
			if (playState== STATE_PLAY) {
				pause();
				return false;
			}else {
				play();
				return true;
			}
		}
		public function playOrStop():Boolean {
			if (playState == STATE_PLAY) {
				stop();
				return false;
			}else {
				play();
				return true;
			}
		}
		public function next():void {
			playID++;
		}
		public function prev():void {
			playID--;
		}
		//
		public function hideContent():void {
		}
		//
		protected function onPlayIDChangeHandler(_playID:int):void {
			timer.start();
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_ID_CHANGE));
		}
		//
		protected function onLoadErrorHandler(_evt:*= null):void {
			if (playlist.length() == 1) {
				//如果播放列表只有一个源，则停止播放
				stop();
			}else {
				//根据repeat的值执行下一步
				onPlayCompleteHandler();
			}
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_ERROR));
		}
		protected function onBufferProgressHandler(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.BUFFER_PROGRESS));
		}
		protected function onLoadProgressHandler(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_PROGRESS));
		}
		protected function onLoadCompleteHandler(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.LOAD_COMPLETE));
		}
		//
		protected function onPlayCompleteHandler(_evt:*= null):void {
			timer.reset();
			timer.stop();
			switch(repeat) {
				case 0:
					stop();
					break;
				case 1:
					stop();
					play();
					break;
				case 2:
					if (playID == idPart.length - 1) {
						stop();
					}else {
						next();
					}
					break;
				case 3:
					if (idPart.length == 1) {
						stop();
						play();
					}else {
						next();
					}
					break;
				case 4:
					//待完善
					stop();
					break;
				case 5:
					pause();
					break;
			}
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_COMPLETE));
		}
		protected function onPlayProgressHander(_evt:*= null):void {
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_PROGRESS));
		}
	}
	
}