/***
VideoPlayer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月20日 09:53:18
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.VideoLoader;
	
	import flash.display.Sprite;
	
	internal class VideoPlayer extends Sprite implements IPlayer{
		
		//internal static const sourceReg:RegExp=/^.*\.(flv|f4v|mp4)(\?[^\?]*)?$/i;
		
		private var videoLoader:VideoLoader;
		private var wid:int;
		private var hei:int;
		
		internal var scaleMode:String;
		
		public function VideoPlayer() {
			
			/*import flash.events.Event;
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(...args):void{
			import flash.net.NetStream;
			if(videoLoader){
				var ns:NetStream=videoLoader.netStream;
				if(ns){
					Object["statusTxt"].text=new Date()+"\n"+
						"ns.bytesLoaded="+ns.bytesLoaded+"\n"+
						"ns.bytesTotal="+ns.bytesTotal+"\n"+
						"ns.bufferLength="+ns.bufferLength+"\n"+
						"ns.bufferTime="+ns.bufferTime+"\n"+
						"ns.time="+ns.time+"\n"+
						"playheadTime="+getPlayheadTime()+"\n";
				}
			}*/
		}
		
		private var __bufferTime:Number;
		public function set bufferTime(_bufferTime:Number):void{
			__bufferTime=_bufferTime;
		}
		
		private var __source:String;
		public function get source():String{
			return __source;
		}
		
		public function clear():void{
			clearCurr();
		}
		
		public function get bufferProgress():Number{
			if(videoLoader){
				return videoLoader.bufferProgress;
			}
			return 0;
		}
		
		public function get bytesLoaded():int{
			if(videoLoader){
				return videoLoader.bytesLoaded;
			}
			return 0;
		}
		private var __bytesTotal:int;
		public function get bytesTotal():int{
			return __bytesTotal;
		}
		
		public function clearCurr():void{
			__bytesTotal=0;
			if(videoLoader){
				this.removeChild(videoLoader.content);
				videoLoader.pauseVideo();
				videoLoader.videoTime=0;
				videoLoader.clearVideo();
				videoLoader.removeEventListener(LoaderEvent.INIT,loadVideoInit);
				//videoLoader.removeEventListener(LoaderEvent.PROGRESS,loadVideoProgress);
				videoLoader.removeEventListener(LoaderEvent.COMPLETE,loadVideoComplete);
				videoLoader.removeEventListener(VideoLoader.VIDEO_COMPLETE,playVideoComplete);
				videoLoader.removeEventListener(LoaderEvent.IO_ERROR,loadVideoError);
				videoLoader.pause();
				videoLoader=null;
			}
		}
		public function load(_source:String):void{
			if(__source==_source){
			}else{
				clearCurr();
				
				__source=_source;
				
				videoLoader=new VideoLoader(
					__source,{
						autoAdjustBuffer:false,//20131126
						bufferTime:__bufferTime,
						scaleMode:scaleMode
					}
				);
				trace("VideoPlayer加载："+__source);
				this.addChild(videoLoader.content);
				videoLoader.content.visible=false;
				videoLoader.addEventListener(LoaderEvent.INIT,loadVideoInit);
				//videoLoader.addEventListener(LoaderEvent.PROGRESS,loadVideoProgress);
				videoLoader.addEventListener(LoaderEvent.COMPLETE,loadVideoComplete);
				videoLoader.addEventListener(VideoLoader.VIDEO_COMPLETE,playVideoComplete);
				videoLoader.addEventListener(LoaderEvent.IO_ERROR,loadVideoError);
				videoLoader.load();
				videoLoader.pauseVideo();
				//this.dispatchEvent(new PlayerEvent(PlayerState.LOADING));
			}
		}
		
		public function play():void {
			
			videoLoader.playVideo();
			//trace("videoLoader.playVideo();");
			this.dispatchEvent(new PlayerEvent(PlayerState.PLAY));
			
			
		}
		public function stop():void{
			videoLoader.pauseVideo();
			this.dispatchEvent(new PlayerEvent(PlayerState.STOPPED));
		}
		public function pause():void{
			videoLoader.pauseVideo();
			//trace("videoLoader.pauseVideo();");
			this.dispatchEvent(new PlayerEvent(PlayerState.PAUSED));
		}
		
		public function getPlayheadTime():Number{
			if(videoLoader){
				return videoLoader.videoTime;
			}
			return 0;
		}
		public function setPlayheadTime(_playheadTime:Number,__playheadIsMovingOrIsGoingToMove:Boolean):void{
			if(videoLoader){
				if(videoLoader.bytesLoaded>0&&videoLoader.bytesTotal>0){
					if(_playheadTime>totalTime*videoLoader.bytesLoaded/videoLoader.bytesTotal){
						_playheadTime=totalTime*videoLoader.bytesLoaded/videoLoader.bytesTotal;
					}
				}else{
					_playheadTime=0;
				}
				videoLoader.videoTime=_playheadTime;
			}
		}
		
		public function get totalTime():Number{
			if(__bytesTotal){
				return videoLoader.duration;
			}
			return 0;
		}
		
		private var __volume:Number;
		public function get volume():Number{
			return __volume;
		}
		public function set volume(_volume:Number):void{
			__volume=_volume;
			if(videoLoader){
				videoLoader.volume=__volume;
				//trace("videoLoader.volume="+videoLoader.volume);
			}
		}
		
		public function setSize(_wid:int,_hei:int):void{
			wid=_wid;
			hei=_hei;
			if (__bytesTotal) {
				
				videoLoader.content.fitWidth=wid;
				videoLoader.content.fitHeight = hei;
			}
		}
		public function setScaleMode(s:String):void {
			videoLoader.content.scaleMode = s;
		}
		private function loadVideoInit(...args):void{
			//trace("videoLoader.netStream.bytesTotal="+videoLoader.netStream.bytesTotal);
			//trace("videoLoader.bytesTotal="+videoLoader.bytesTotal);
			if(__bytesTotal){
				return;
			}
			//trace("loadVideoInit");
			//trace("videoLoader.bytesTotal="+videoLoader.bytesTotal);
			//if(videoLoader.bytesTotal==LoaderMax.defaultEstimatedBytes){
			//	return;
			//}
			__bytesTotal=videoLoader.bytesTotal==LoaderMax.defaultEstimatedBytes?videoLoader.netStream.bytesTotal:videoLoader.bytesTotal;
			videoLoader.content.visible=true;
			setSize(wid,hei);
		}
		//private function loadVideoProgress(...args):void{
		//	if(videoLoader.bufferProgress<1){
		//		this.dispatchEvent(new PlayerEvent(PlayerState.BUFFERING));
		//	}else{
		//		this.dispatchEvent(new PlayerEvent(PlayerState.LOADING));
		//	}
		//}
		private function loadVideoComplete(...args):void{
			this.dispatchEvent(new PlayerEvent(PlayerState.LOAD_COMPLETE));
		}
		private function playVideoComplete(...args):void{
			this.dispatchEvent(new PlayerEvent(PlayerState.PLAY_COMPLETE));
		}
		private function loadVideoError(...args):void{
			trace("loadVideoError："+__source);
			this.dispatchEvent(new PlayerEvent(PlayerState.LOAD_ERROR));
		}
	}
}