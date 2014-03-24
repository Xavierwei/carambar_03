package akdcl.media {
	
	import akdcl.media.providers.IDiplayProvider;
	import akdcl.utils.PageID;
	import akdcl.events.MediaEvent;
	import akdcl.media.providers.MediaProvider;
	import akdcl.media.providers.ImageProvider;
	import akdcl.media.providers.SoundProvider;
	import akdcl.media.providers.VideoProvider;
	import akdcl.media.providers.WMPProvider;

	/**
	 * ...
	 * @author ...
	 */
	/// @eventType	akdcl.events.MediaEvent.LIST_CHANGE
	[Event(name="listChange",type="akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.PLAY_ITEM_CHANGE
	[Event(name="playItemChange",type="akdcl.events.MediaEvent")]

	/// @eventType	akdcl.events.MediaEvent.DISPLAY_CHANGE
	[Event(name="displayChange",type="akdcl.events.MediaEvent")]

	public class MediaPlayer extends MediaProvider implements IDiplayProvider  {
		public var onDisplayChange:Function;

		private var imagePD:ImageProvider;
		private var soundPD:SoundProvider;
		private var videoPD:VideoProvider;
		private var wmpPD:WMPProvider;

		private var pageID:PageID;
		private var providers:Array;
		
		protected var __displayContent:Object;
		public function get displayContent():Object {
			return __displayContent;
		}
		
		public function get isDisplayProvider():Boolean {
			return playContent[0] is IDiplayProvider
		}

		override public function get loadProgress():Number {
			var _progress:Number = 1;
			for each (var _content:MediaProvider in playContent){
				_progress = Math.min(_content.loadProgress, _progress);
			}
			return _progress;
		}

		override public function get totalTime():uint {
			var _time:uint = 0;
			for each (var _content:MediaProvider in playContent){
				_time = Math.max(_content.totalTime, _time);
			}
			return _time;
		}

		override public function get bufferProgress():Number {
			var _progress:Number = 1;
			for each (var _content:MediaProvider in playContent){
				_progress = Math.min(_content.bufferProgress, _progress);
			}
			return _progress;
		}

		override public function get position():uint {
			var _time:uint = 0;
			for each (var _content:MediaProvider in playContent){
				_time = Math.max(_content.position, _time);
			}
			return _time;
		}

		override public function get volume():Number {
			return super.volume;
		}

		override public function set volume(value:Number):void {
			super.volume = value;
			for each (var _content:MediaProvider in providers){
				_content.volume = volume;
			}
		}

		//播放列表
		private var __playlist:Playlist;

		public function get playlist():Playlist {
			return __playlist;
		}

		public function set playlist(_playlist:*):void {
			_playlist = Playlist.createList(_playlist);
			if (!_playlist){
				return;
			}
			stop();
			pageID.setID(-1);
			__playlist = _playlist;
			pageID.length = __playlist.length;
			dispatchEvent(new MediaEvent(MediaEvent.LIST_CHANGE));
		}

		//当前播放列表位置
		public function get playID():int {
			return pageID.id;
		}

		public function set playID(_playID:int):void {
			pageID.id = _playID;
		}

		//0:不循环，1:单首循环，2:顺序循环(全部播放完毕后停止)，3:顺序循环，4:随机播放
		private var __repeat:uint;

		public function get repeat():uint {
			return __repeat;
		}

		public function set repeat(_repeat:uint):void {
			__repeat = _repeat;
		}

		override protected function init():void {
			super.init();
			__repeat = 3;
			name = "mediaPlayer";
			imagePD = new ImageProvider();
			soundPD = new SoundProvider();
			videoPD = new VideoProvider();
			wmpPD = new WMPProvider();
			providers = [soundPD, videoPD, wmpPD, imagePD];
			playContent = [];
			pageID = new PageID();
			pageID.onIDChange = onPlayIDChangeHandler;
		}
		
		override protected function onRemoveHandler():void 
		{
			imagePD.remove();
			soundPD.remove();
			videoPD.remove();
			wmpPD.remove();
			pageID.remove();
			super.remove();
			//playlist.remove();
			super.onRemoveHandler();
			playlist = null;
			imagePD = null;
			soundPD = null;
			videoPD = null;
			wmpPD = null;
			pageID = null;
			
			__displayContent = null;
			providers = null;
			onDisplayChange = null;
		}

		private function onPlayIDChangeHandler(_id:uint):void {
			if (!playlist) {
				return;
			}
			
			var _content:MediaProvider;
			for each (_content in playContent){
				_content.removeEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				_content.removeEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
				_content.removeEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				_content.removeEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
				_content.removeEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);
				_content.removeEventListener(MediaEvent.DISPLAY_CHANGE, onDisplayChangeHandler);
			}
			if (_content is IDiplayProvider) {
				(_content as IDiplayProvider).hideDisplay();
			}
			stop();
			
			__displayContent = null;

			playItem = playlist.getItem(_id);
			switch (playItem.type){
				case "gif":
				case "jpg":
				case "png":
				case "swf":
					playContent[0] = imagePD;
					break;
				case "mp3":
				case "wav":
					playContent[0] = soundPD;
					break;
				case "flv":
				case "mov":
				case "mp4":
				case "f4v":
					playContent[0] = videoPD;
					break;
				case "wma":
				case "wmv":
				case "mms":
				default:
					playContent[0] = wmpPD;
					break;
			}
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_ITEM_CHANGE));
			for each (_content in playContent){
				_content.addEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				_content.addEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
				_content.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				_content.addEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
				_content.addEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);
				_content.addEventListener(MediaEvent.DISPLAY_CHANGE, onDisplayChangeHandler);
				//
				_content.load(playItem);
			}
			play(-1);
		}

		override public function load(_item:*):void {
			playlist = _item;
		}

		override public function play(_startTime:int = -1):void {
			if (playID < 0){
				playID = 0;
				return;
			}
			super.play(_startTime);
		}
		
		override protected function playHandler(_startTime:int = -1):void 
		{
			for each (var _content:MediaProvider in playContent) {
				//调用play，调整playstate
				_content.position = _startTime;
			}
		}

		override protected function pauseHandler():void 
		{
			for each (var _content:MediaProvider in playContent){
				_content.pause();
			}
		}
		
		override protected function stopHandler():void 
		{
			for each (var _content:MediaProvider in playContent){
				_content.stop();
			}
		}

		public function next():void {
			playID++;
		}

		public function prev():void {
			playID--;
		}

		override protected function onLoadErrorHandler(_evt:* = null):void {
			if (playlist.length == 1){
				//如果播放列表只有一个源，则停止播放
				super.onLoadErrorHandler(_evt);
			} else {
				//根据repeat的值执行下一步
				onPlayCompleteHandler();
			}
		}

		override protected function onPlayCompleteHandler(_evt:* = null):void {
			super.onPlayCompleteHandler(_evt);
			switch (repeat){
				case 0:
					stop();
					break;
				case 1:
					stop();
					play();
					break;
				case 2:
					if (playID == playlist.length - 1){
						//stop();
					} else {
						next();
					}
					break;
				case 3:
					if (playlist.length == 1){
						stop();
						play();
					} else {
						next();
					}
					break;
				case 4:
					//待完善
					//stop();
					break;
			}
		}

		private function onDisplayChangeHandler(_e:MediaEvent):void {
			//加载显示对象
			var _content:IDiplayProvider = _e.target as IDiplayProvider;
			
			if (_content) {
				__displayContent = _content.displayContent;
				if (hasEventListener(MediaEvent.DISPLAY_CHANGE)){
					dispatchEvent(new MediaEvent(MediaEvent.DISPLAY_CHANGE));
				}
				if (onDisplayChange != null) {
					onDisplayChange(__displayContent);
				}
			}
		}
		
		public function showDisplay():void {
		}
		
		public function hideDisplay():void {
		}
	}

}