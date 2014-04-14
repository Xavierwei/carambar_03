/***
VideoListPlayer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月27日 09:55:21
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	
	import flash.display.Sprite;
	
	internal class VideoListPlayer extends Sprite implements IPlayer{
		
		internal static const sourceReg:RegExp=/^(.*[\/\\])?(.*?\|.*?)(\.\w+)(\?[^\?]*)?$/;
		
		private var videoObjV:Vector.<VideoObj>;
		private var currObj:VideoObj;
		private var wid:int;
		private var hei:int;
		private var isInit:Boolean;
		
		internal var scaleMode:String;
		
		private var playheadIsMovingOrIsGoingToMove:Boolean;
		
		public function VideoListPlayer(){
			/*import flash.events.Event;
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(...args):void{
			if(videoObjV){
				Object["statusTxt"].text=new Date()+"\n"+
					"bytesLoaded="+bytesLoaded+"\n";
				for each(var videoObj:VideoObj in videoObjV){
					Object["statusTxt"].text+="videoObj.bytesLoaded="+videoObj.bytesLoaded+"\n";
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
			if(currObj){
				return currObj.loader.bufferProgress;
			}
			return 0;
		}
		
		public function get bytesLoaded():int{
			if(isInit){
				var _bytesLoaded:int=0;
				//trace("=================");
				for each(var videoObj:VideoObj in videoObjV){
					//trace("xx",currObj==videoObj);
					if(currObj==videoObj){
						//trace(videoObj.bytesLoaded<videoObj.bytesTotal);
						if(videoObj.bytesLoaded<videoObj.bytesTotal){
							_bytesLoaded+=videoObj.bytesLoaded;
							break;
						}
						var currFlag:Boolean=true;
					}else{
						if(currFlag){
							if(videoObj.bytesLoaded<videoObj.bytesTotal){
								_bytesLoaded+=videoObj.bytesLoaded;
								break;
							}
						}
					}
					//trace("videoObj.bytesTotal="+videoObj.bytesTotal);
					_bytesLoaded+=videoObj.bytesTotal;
				}
				return _bytesLoaded;
			}
			return 0;
		}
		private var __bytesTotal:int;
		public function get bytesTotal():int{
			return __bytesTotal;
		}
		
		public function clearCurr():void{
			isInit=false;
			if(videoObjV){
				for each(var videoObj:VideoObj in videoObjV){
					this.removeChild(videoObj.loader.content);
					videoObj.clear();
				}
			}
			currObj=null;
			__totalTime=0;
			__bytesTotal=0;
		}
		public function load(_source:String):void{
			if(__source==_source){
			}else{
				clearCurr();
				
				__source=_source;
				
				var execResult:Array=sourceReg.exec(__source);
				if(execResult[1]){
				}else{
					execResult[1]="";
				}
				if(execResult[4]){
				}else{
					execResult[4]="";
				}
				var i:int=-1;
				var nameArr:Array=execResult[2].split("|");
				videoObjV=new Vector.<VideoObj>();
				trace("VideoListPlayer加载：");
				for each(var name:String in nameArr){
					i++;
					videoObjV[i]=new VideoObj(
						this,
						execResult[1]+name+execResult[3]+execResult[4],__bufferTime,scaleMode,
						loadVideoInit,loadVideoComplete,playVideoComplete,loadVideoError
					);
					trace("videoObjV["+i+"].source="+videoObjV[i].source);
					//break;
				}
				videoObjV.fixed=true;
				//this.dispatchEvent(new PlayerEvent(PlayerState.LOADING));
			}
		}
		
		public function play():void{
			playheadIsMovingOrIsGoingToMove=true;
			if(currObj){
				currObj.loader.playVideo();
				//trace("currObj.loader.playVideo();");
				this.dispatchEvent(new PlayerEvent(PlayerState.PLAY));
			}
		}
		public function stop():void{
			playheadIsMovingOrIsGoingToMove=false;
			if(currObj){
				currObj.loader.pauseVideo();
				this.dispatchEvent(new PlayerEvent(PlayerState.STOPPED));
			}
		}
		public function pause():void{
			playheadIsMovingOrIsGoingToMove=false;
			if(currObj){
				currObj.loader.pauseVideo();
				//trace("currObj.loader.pauseVideo();");
				this.dispatchEvent(new PlayerEvent(PlayerState.PAUSED));
			}
		}
		
		public function getPlayheadTime():Number{
			if(isInit){
				if(currObj){
					var playheadTime:Number=0;
					for each(var videoObj:VideoObj in videoObjV){
						if(currObj==videoObj){
							playheadTime+=videoObj.loader.videoTime;
							
							//当前视频片段播放到接近末尾时，启动下一个视频片段的加载
							//trace(videoObj.duration-videoObj.loader.videoTime,__bufferTime*2);
							if(videoObj.duration-videoObj.loader.videoTime<__bufferTime*2){
								var i:int=videoObjV.indexOf(videoObj);
								if(i==videoObjV.length-1){
								}else{
									var nextVideoObj:VideoObj=videoObjV[i+1];
									//trace("nextVideoObj.loader.paused="+nextVideoObj.loader.paused);
									if(nextVideoObj.loader.paused){
										nextVideoObj.loader.resume();
									}
								}
							}
							
							return playheadTime;
						}
						playheadTime+=videoObj.duration;
					}
				}
			}
			return 0;
		}
		private function getVideoObj(_playheadTime:Number):VideoObj{
			if(_playheadTime>0){
				var sum:Number=0;
				for each(var videoObj:VideoObj in videoObjV){
					sum+=videoObj.duration;
					if(sum>_playheadTime){
						return videoObj;
					}
				}
				return videoObjV[videoObjV.length-1];
			}
			return videoObjV[0];
		}
		public function setPlayheadTime(_playheadTime:Number,_playheadIsMovingOrIsGoingToMove:Boolean):void{
			if(isInit){
				var _videoObj:VideoObj=getVideoObj(_playheadTime);
				for each(var videoObj:VideoObj in videoObjV){
					if(_videoObj==videoObj){
						break;
					}
					_playheadTime-=videoObj.duration;
				}
				if(currObj){
					currObj.loader.pauseVideo();
					currObj.loader.content.visible=false;
				}
				playheadIsMovingOrIsGoingToMove=_playheadIsMovingOrIsGoingToMove;
				setCurrObj(_videoObj,_playheadTime);
			}
		}
		private function setCurrObj(videoObj:VideoObj,_playheadTime:Number):void{
			//trace("setCurrObj()，videoObj.source="+videoObj.source);
			currObj=videoObj;
			currObj.loader.content.visible=true;
			if(currObj.loader.paused){
				currObj.loader.resume();
			}
			currObj.loader.videoTime=_playheadTime;
			if(playheadIsMovingOrIsGoingToMove){
				currObj.loader.playVideo();
			}else{
				currObj.loader.pauseVideo();
			}
		}
		
		private var __totalTime:Number;
		public function get totalTime():Number{
			return __totalTime;
		}
		
		private var __volume:Number;
		public function get volume():Number{
			return __volume;
		}
		public function set volume(_volume:Number):void{
			__volume=_volume;
			if(videoObjV){
				for each(var videoObj:VideoObj in videoObjV){
					videoObj.loader.volume=__volume;
					//trace("videoObj.loader.volume="+videoObj.loader.volume);
				}
			}
		}
		
		public function setSize(_wid:int,_hei:int):void{
			wid=_wid;
			hei=_hei;
			if(isInit){
				for each(var videoObj:VideoObj in videoObjV){
					videoObj.setSize(wid,hei);
				}
			}
		}
		
		private function loadVideoInit(videoObj:VideoObj):void{
			__totalTime+=videoObj.duration;
			__bytesTotal+=videoObj.bytesTotal;
			if(videoObj==videoObjV[0]){
			}else{
				videoObj.loader.pause();
				//trace("videoObj.loader.paused="+videoObj.loader.paused);
			}
			for each(videoObj in videoObjV){
				if(videoObj.duration){
				}else{
					return;
				}
			}
			isInit=true;
			setSize(wid,hei);
			setCurrObj(videoObjV[0],0);
		}
		private function loadVideoComplete(videoObj:VideoObj):void{
			if(videoObj==videoObjV[videoObjV.length-1]){
				this.dispatchEvent(new PlayerEvent(PlayerState.LOAD_COMPLETE));
			}
		}
		private function playVideoComplete(videoObj:VideoObj):void{
			if(videoObj==videoObjV[videoObjV.length-1]){
				this.dispatchEvent(new PlayerEvent(PlayerState.PLAY_COMPLETE));
			}else{
				setCurrObj(videoObjV[videoObjV.indexOf(videoObj)+1],0);
			}
		}
		private function loadVideoError(videoObj:VideoObj):void{
			this.dispatchEvent(new PlayerEvent(PlayerState.LOAD_ERROR));
		}
		
	}
}
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.VideoLoader;

import flash.display.Sprite;

class VideoObj{
	
	public var duration:Number;
	public var bytesTotal:int;
	public var source:String;
	public var loader:VideoLoader;
	private var onLoadVideoInit:Function;
	private var onLoadVideoComplete:Function;
	private var onPlayVideoComplete:Function;
	private var onLoadVideoError:Function;
	
	public function VideoObj(
		container:Sprite,
		_source:String,
		_bufferTime:Number,
		_scaleMode:String,
		_onLoadVideoInit:Function,
		_onLoadVideoComplete:Function,
		_onPlayVideoComplete:Function,
		_onLoadVideoError:Function
	){
		duration=0;
		bytesTotal=0;
		source=_source;
		onLoadVideoInit=_onLoadVideoInit;
		onLoadVideoComplete=_onLoadVideoComplete;
		onPlayVideoComplete=_onPlayVideoComplete;
		onLoadVideoError=_onLoadVideoError;
		loader=new VideoLoader(
			_source,{
				autoAdjustBuffer:false,//20131126
				bufferTime:_bufferTime,
				scaleMode:_scaleMode
			}
		);
		container.addChild(loader.content);
		loader.content.visible=false;
		loader.addEventListener(LoaderEvent.INIT,loadVideoInit);
		//loader.addEventListener(LoaderEvent.PROGRESS,loadVideoProgress);
		loader.addEventListener(LoaderEvent.COMPLETE,loadVideoComplete);
		loader.addEventListener(VideoLoader.VIDEO_COMPLETE,playVideoComplete);
		loader.addEventListener(LoaderEvent.IO_ERROR,loadVideoError);
		loader.load();
		loader.pauseVideo();
	}
	public function clear():void{
		loader.pauseVideo();
		loader.videoTime=0;
		loader.clearVideo();
		loader.removeEventListener(LoaderEvent.INIT,loadVideoInit);
		//loader.removeEventListener(LoaderEvent.PROGRESS,loadVideoProgress);
		loader.removeEventListener(LoaderEvent.COMPLETE,loadVideoComplete);
		loader.removeEventListener(VideoLoader.VIDEO_COMPLETE,playVideoComplete);
		loader.removeEventListener(LoaderEvent.IO_ERROR,loadVideoError);
		loader.pause();
		loader=null;
		onLoadVideoInit=null;
		onLoadVideoComplete=null;
		onPlayVideoComplete=null;
		onLoadVideoError=null;
	}
	
	public function setSize(_wid:int,_hei:int):void{
		loader.content.fitWidth=_wid;
		loader.content.fitHeight=_hei;
	}
	
	private function loadVideoInit(...args):void{
		if(duration){
			return;
		}
		//trace("loadVideoInit");
		//trace("loader.bytesTotal="+loader.bytesTotal);
		//if(loader.bytesTotal==LoaderMax.defaultEstimatedBytes){
		//	return;
		//}
		
		//loader.pause()后可能会无法正确获取这些值：
		duration=loader.duration;
		bytesTotal=loader.bytesTotal==LoaderMax.defaultEstimatedBytes?loader.netStream.bytesTotal:loader.bytesTotal;
		
		if(onLoadVideoInit==null){
		}else{
			onLoadVideoInit(this);
		}
	}
	public function get bytesLoaded():int{
		return loader.bytesLoaded;
	}
	//private function loadVideoProgress(...args):void{
	//	if(loader.bufferProgress<1){
	//		this.dispatchEvent(new PlayerEvent(PlayerState.BUFFERING));
	//	}else{
	//		this.dispatchEvent(new PlayerEvent(PlayerState.LOADING));
	//	}
	//}
	private function loadVideoComplete(...args):void{
		if(onLoadVideoComplete==null){
		}else{
			onLoadVideoComplete(this);
		}
	}
	private function playVideoComplete(...args):void{
		if(onPlayVideoComplete==null){
		}else{
			onPlayVideoComplete(this);
		}
	}
	private function loadVideoError(...args):void{
		//trace("loadVideoError："+source);
		if(onLoadVideoError==null){
		}else{
			onLoadVideoError(this);
		}
	}
	
}