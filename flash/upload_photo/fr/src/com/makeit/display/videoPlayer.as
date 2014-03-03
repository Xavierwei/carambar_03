package com.makeit.display
{
	import flash.events.FullScreenEvent;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.events.Event;

	public class videoPlayer extends MovieClip
	{
	
	
		private var _posMC:MovieClip;
		private var _psBtn:MovieClip;
		private var _stopBtn:MovieClip;
		private var _mute_btn:MovieClip;
		private var _my_video:Video;
		
		private var videoURL:String ="";
		private var duration:Number = 0;
		private var currentPos:Number = 0;
		private var isClose:Boolean = false;
		private var length:Number = 180;
		private var startX:Number;
		private var startY:Number;
        private var connection:NetConnection;
        private var _stream:NetStream;
		//
		public function videoPlayer()
		{
			
			//init();
		}
		protected function init():void {
			connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            connection.connect(null);
           
			eventHandler();
			
			startX=_posMC.x;
			startY = _posMC.y;
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeStageHandler);
		}
		private function removeStageHandler(e:Event):void{
			dispose();
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeStageHandler);
		}
		protected function netStatusHandler(event:NetStatusEvent):void {
            switch (event.info.code) {
            	 case "NetStream.Play.Start":
            	 	isClose=false;
            		_psBtn.gotoAndStop(1);
            		break;
                case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    trace("Stream not found: " + videoURL);
                    break;
				case "NetStream.Play.Stop":
					_stream.play(videoURL);
					_stream.seek(0);
					_posMC.x = startX;
					_stream.pause();
					isClose=true;
					_psBtn.gotoAndStop(2);
					break;
            }
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
		private function eventHandler():void {
			_stopBtn.buttonMode=_psBtn.buttonMode=_mute_btn.buttonMode=_posMC.buttonMode=true;
			_stopBtn.addEventListener(MouseEvent.CLICK, stopClickHandler);
			_psBtn.addEventListener(MouseEvent.CLICK, psClickHandler);
			_mute_btn.addEventListener(MouseEvent.CLICK,muteClickHandler);
			_posMC.addEventListener(MouseEvent.MOUSE_DOWN,posDownHandler);
		}
		
		public function stopClickHandler(e:MouseEvent):void {
			_stream.seek(0);
			_stream.pause();
			_psBtn.gotoAndStop(2);
			isClose = true;
			_posMC.x=startX;
		}
		public function psClickHandler(e:MouseEvent):void {
			var target:MovieClip = e.currentTarget as MovieClip;
			target.gotoAndStop(3 - target.currentFrame);
			if (isClose) {
				isClose = false;
				_stream.resume();
			} else {
				isClose=true;
				_stream.pause();
			}
		}
		private function muteClickHandler(e:MouseEvent):void {
			var target:MovieClip=e.currentTarget as MovieClip;
			target.gotoAndStop(3-target.currentFrame);
			if (target.currentFrame == 1) {
				_stream.soundTransform=new SoundTransform(1,0);
				//mysound.setVolume(100);
			} else {
				_stream.soundTransform=new SoundTransform(0,0);
				//mysound.setVolume(0);
			}
			
		}
		private function posDownHandler(e:MouseEvent):void {
			this.removeEventListener(Event.ENTER_FRAME,enterFunc);
			_posMC.addEventListener(MouseEvent.MOUSE_UP, posUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,posUpHandler);
			_posMC.startDrag(false,new Rectangle(startX,startY,length,0));
		}
		private function posUpHandler(e:MouseEvent):void {
			_posMC.stopDrag();
			_posMC.removeEventListener(MouseEvent.MOUSE_UP, posUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, posUpHandler);
			this.addEventListener(Event.ENTER_FRAME, enterFunc);
			
			var pos:Number = (_posMC.x-startX)/length*duration;
			_stream.seek(pos);
		}
		function enterFunc(e:Event):void {
			currentPos = _stream.time;
			var temp:Number = currentPos/duration;
			_posMC.x = startX+length*temp;
		}
        private function connectStream():void {
			
			var customClient:Object = new Object();
			customClient.onMetaData = onMetaDataHandler;
			customClient.onCuePoint=onCuePointHandler;
			//
            _stream = new NetStream(connection);
            _stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
            _stream.client = customClient;
			//
	
            _my_video.attachNetStream(_stream);
           // setPlay(videoURL)
        }
		
		public function onMetaDataHandler(info:Object):void {

			duration = info.duration;
			this.addEventListener(Event.ENTER_FRAME,enterFunc);
		}
		public function onCuePointHandler(info:Object):void{
			
		}
		//
		
		//
		public function dispose():void{
			this.removeEventListener(Event.ENTER_FRAME,enterFunc);
			if(connection){
				connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
           	 	connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
           	 	connection.close();
           	 	connection=null;
			}
			if(_stream){
				_stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				_stream.close();
           	 	_stream=null;
			}
			_stopBtn.removeEventListener(MouseEvent.CLICK, stopClickHandler);
			_psBtn.removeEventListener(MouseEvent.CLICK, psClickHandler);
			_mute_btn.removeEventListener(MouseEvent.CLICK,muteClickHandler);
			_posMC.removeEventListener(MouseEvent.MOUSE_DOWN,posDownHandler);
			_stopBtn=_psBtn=_mute_btn=_posMC=null;
		}
		public function get currentTime():Number{
			return _stream.time;
		}
		public function set posMovieClip(mc:MovieClip):void{
			_posMC=mc;
		}
		public function set playStopButton(mc:MovieClip):void{
			_psBtn=mc;
		}
		public function set stopButton(mc:MovieClip):void{
			_stopBtn=mc;
		}
		public function set mutedButton(mc:MovieClip):void{
			_mute_btn=mc;
		}
		public function set videoContainer(value:Video):void{
			_my_video=value;
			
		}
		public function set source(value:String):void{
			videoURL=value;
		}
		public function set posStartX(value:Number):void{
			startX=value;
		}
		public function set posStartY(value:Number):void{
			startY=value;
		}
		public function set posDistance(value:Number):void{
			length=value;
		}
		public function get stream():NetStream{
			return _stream;
		}
		public function playVideo(url:String=""):void {
			if(url!=""){
				videoURL=url;
			}
			_stream.play(videoURL);
			
		}

		
	}

}