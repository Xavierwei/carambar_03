/***
MP3Player
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年10月24日 15:53:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	internal class MP3Player extends EventDispatcher implements IPlayer{
		
		internal static const sourceReg:RegExp=/^.*\.mp3(\?[^\?]*)?$/i;
		//trace(sourceReg.test("1.mp3"));//true
		//trace(sourceReg.test("1.mp3?1.234&xxx=yyy"));//true
		//trace(sourceReg.test("http://xxx\\1.MP3"));//true
		
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		
		private var currPlayheadTime:Number;
		
		public function MP3Player(){
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
			if(sound){
				if(bytesTotal>0){
					if(totalTime>0){
						if(__bufferTime>0){
							var dTime:Number=totalTime*bytesLoaded/bytesTotal-getPlayheadTime();
							if(dTime>0){
								if(dTime<__bufferTime){
									return dTime/__bufferTime;
								}
								return 1;
							}
						}
					}
				}
			}
			return 0;
		}
		
		public function get bytesLoaded():int{
			if(sound){
				return sound.bytesLoaded;
			}
			return 0;
		}
		public function get bytesTotal():int{
			if(sound){
				return sound.bytesTotal;
			}
			return 0;
		}
		
		public function clearCurr():void{
			currPlayheadTime=0;
			clearSoundChannel();
			if(sound){
				try{
					sound.close();
				}catch(e:Error){}
				//sound.removeEventListener(ProgressEvent.PROGRESS,loadSoundProgress);
				sound.removeEventListener(Event.COMPLETE,loadSoundComplete);
				sound.removeEventListener(IOErrorEvent.IO_ERROR,loadSoundError);
				sound=null;
			}
		}
		public function load(_source:String):void{
			if(__source==_source){
			}else{
				clearCurr();
				
				__source=_source;
				
				sound=new Sound(new URLRequest(__source),new SoundLoaderContext(int(__bufferTime*1000),true));
				trace("MP3Player加载："+__source);
				//sound.addEventListener(ProgressEvent.PROGRESS,loadSoundProgress);
				sound.addEventListener(Event.COMPLETE,loadSoundComplete);
				sound.addEventListener(IOErrorEvent.IO_ERROR,loadSoundError);
				//this.dispatchEvent(new PlayerEvent(PlayerState.LOADING));
			}
		}
		
		public function play():void{
			initSoundChannel(currPlayheadTime);
			this.dispatchEvent(new PlayerEvent(PlayerState.PLAY));
		}
		public function stop():void{
			clearSoundChannel();
			currPlayheadTime=0;
			this.dispatchEvent(new PlayerEvent(PlayerState.STOPPED));
		}
		public function pause():void{
			currPlayheadTime=getPlayheadTime();
			clearSoundChannel();
			this.dispatchEvent(new PlayerEvent(PlayerState.PAUSED));
		}
		
		public function getPlayheadTime():Number{
			if(sound){
				if(soundChannel){
					return soundChannel.position/1000;
				}
				return currPlayheadTime;
			}
			return 0;
		}
		public function setPlayheadTime(_playheadTime:Number,__playheadIsMovingOrIsGoingToMove:Boolean):void{
			if(sound){
				if(sound.bytesLoaded>0&&sound.bytesTotal>0){
					if(_playheadTime>totalTime*sound.bytesLoaded/sound.bytesTotal){
						_playheadTime=totalTime*sound.bytesLoaded/sound.bytesTotal;
					}
				}else{
					_playheadTime=0;
				}
				currPlayheadTime=_playheadTime;
				if(__playheadIsMovingOrIsGoingToMove){
					initSoundChannel(_playheadTime);
				}
			}
		}
		
		public function get totalTime():Number{
			if(sound){
				if(sound.bytesTotal>0){
					if(sound.bytesLoaded>0){
						return sound.length/1000/sound.bytesLoaded*sound.bytesTotal;
					}
				}
			}
			return 0;
		}
		
		private var __volume:Number;
		public function get volume():Number{
			return __volume;
		}
		public function set volume(_volume:Number):void{
			__volume=_volume;
			if(sound){
				if(soundChannel){
					var soundTransform:SoundTransform=soundChannel.soundTransform;
					soundTransform.volume=__volume;
					//trace("soundTransform.volume="+soundTransform.volume);
					soundChannel.soundTransform=soundTransform;
				}
			}
		}
		
		private function initSoundChannel(_playheadTime:Number):void{
			clearSoundChannel();
			//trace("initSoundChannel("+_playheadTime+")");
			soundChannel=sound.play(_playheadTime*1000);
			soundChannel.addEventListener(Event.SOUND_COMPLETE,playSoundComplete);
			volume=volume;
		}
		private function clearSoundChannel():void{
			if(soundChannel){
				//trace("clearSoundChannel()");
				try{
					soundChannel.stop();
				}catch(e:Error){}
				soundChannel.removeEventListener(Event.SOUND_COMPLETE,playSoundComplete);
				soundChannel=null;
			}
		}
		
		//private function loadSoundProgress(...args):void{
		//	if(sound.isBuffering){
		//		this.dispatchEvent(new PlayerEvent(PlayerState.BUFFERING));
		//	}else{
		//		this.dispatchEvent(new PlayerEvent(PlayerState.LOADING));
		//	}
		//}
		private function loadSoundComplete(...args):void{
			this.dispatchEvent(new PlayerEvent(PlayerState.LOAD_COMPLETE));
		}
		private function playSoundComplete(...args):void{
			this.dispatchEvent(new PlayerEvent(PlayerState.PLAY_COMPLETE));
		}
		private function loadSoundError(...args):void{
			trace("loadSoundError："+__source);
			this.dispatchEvent(new PlayerEvent(PlayerState.LOAD_ERROR));
		}
		
	}
	
}