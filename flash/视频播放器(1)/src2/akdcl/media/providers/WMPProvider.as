package akdcl.media.providers {
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	
	import akdcl.media.PlayState;
	import akdcl.media.PlayItem;

	/**
	 * ...
	 * @author ...
	 */
	final public class WMPProvider extends MediaProvider {
		private static const WMP_JS:XML = <script><![CDATA[
			if(!pwrd){
				var pwrd={};
			}
			pwrd.getBrowserName=function(){
				var _browserAgent=window.navigator.userAgent;
				var _browserName;
				if(_browserAgent){
					if(_browserAgent.indexOf("Firefox")>=0){
						_browserName="Firefox";
					}else if(_browserAgent.indexOf("Safari")>=0){
						_browserName="Safari";
					}else if(_browserAgent.indexOf("MSIE")>=0){
						_browserName="IE";
					}else if(_browserAgent.indexOf("Opera")>=0){
						_browserName="Opera";
					}else{
						_browserName="Unknown";
					}
				}else{
					_browserName="Unknown";
				}
				return _browserName;
			}
			pwrd.getSWFByID=function(_swfID){
				var _swf;
				if(navigator.appName.indexOf("Microsoft")>=0){
					_swf=window[_swfID];
				}else{
					_swf=document[_swfID];
				}
				return _swf;
			}
			pwrd.createItem=function(_itemName,_object,_type){
				if(_type==undefined){
					_type=typeof(_object);
				}
				switch(_type){
					case "object":
						var _attStr="";
						var _childXMLList="";
						for(var _subVarName in _object){
							var subObj=_object[_subVarName];
							if(subObj instanceof Array){
								var subType="array";
							}else{
								var subType=typeof(subObj);
							}
							var subXML=pwrd.createItem(_subVarName,subObj,subType);
							switch(subType){
								case "object":
								case "array":
									_childXMLList+=subXML;
								break;
								default:
									_attStr+=subXML;
								break;
							}
						}
						if(_childXMLList){
							return "<"+_itemName+_attStr+">"+_childXMLList+"</"+_itemName+">";
						}
						return "<"+_itemName+_attStr+"/>";
					break;
					case "array":
						var _xmlStr="";
						for(var _i in _object){
							_xmlStr+=pwrd.createItem(_itemName,_object[_i]);
						}
						return _xmlStr;
					break;
					default:
						return " "+_itemName+"='"+_object.toString()+"'";
					break;
				}
				return null;
			}
			if(!pwrd.wmpPlayer){pwrd.wmpPlayer={};pwrd.wmpPlayer.player={};pwrd.wmpPlayer.swf={};pwrd.wmpPlayer.mediaLast={};pwrd.wmpPlayer.listener={};}
			pwrd.wmpPlayer.createWMPContainer=function(){
				if(pwrd.wmpPlayer.playerContainer){return;}
				var _wmpContainer = document.createElement("div");
				_wmpContainer.style.height = 0;
				_wmpContainer.style.width = 0;
				_wmpContainer.style.overflow = "hidden";
				document.body.appendChild(_wmpContainer);
				pwrd.wmpPlayer.playerContainer = _wmpContainer;
			}
			pwrd.wmpPlayer.getPlayerID=function(_swfID){
				return _swfID+"_wmp";
			}
			pwrd.wmpPlayer.getPlayer=function(_swfID){
				return pwrd.wmpPlayer.player[pwrd.wmpPlayer.getPlayerID(_swfID)];
			}
			pwrd.wmpPlayer.createWMPPlayer=function(_swfID, _listener,_mediaSource){
				var _wmpPlayerID=pwrd.wmpPlayer.getPlayerID(_swfID);
				var _object={};
				var _player;
				var _swf=pwrd.getSWFByID(_swfID);
				pwrd.wmpPlayer.swf[_swfID] = _swf;
				if (_listener) {
					_listener=_swf[_listener];
					pwrd.wmpPlayer.listener[_swfID]=_listener;
				}
				switch(pwrd.getBrowserName()){
					case "IE":
						pwrd.wmpPlayer.isWMPNow=true;
						_object.id=_wmpPlayerID;
						_object.width=0;
						_object.height=0;
						_object.classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6";
						_object.param=[
							{name:"uiMode",value:"invisible"},
							{name:"autoStart",value:"false"},
							{name:"enableErrorDialogs",value:"false"}
						];
						pwrd.wmpPlayer.playerContainer.innerHTML=pwrd.createItem("object",_object);
						_player = document.getElementById(_wmpPlayerID);
						if (_listener) {
							if(_player.addEventListener){
								_player.addEventListener('PlayStateChange',_listener,false);
							}else if(_player.attachEvent){
								_player.attachEvent('PlayStateChange',_listener);
							}else{
								_player.PlayStateChange=_listener;
							}
						}
					break;
					default:
						pwrd.wmpPlayer.isWMPNow=false;
						if (_mediaSource) {
							_object.id=_wmpPlayerID;
							_object.name=_wmpPlayerID;
							_object.pluginspage="http://microsoft.com/windows/mediaplayer/en/download/";
							_object.type="application/x-mplayer2";
							//_object.type="application/x-ms-wmp";
							_object.showControls=false;
							_object.showstatusbar=false;
							_object.width=0;
							_object.height=0;
							_object.src=_mediaSource;
							pwrd.wmpPlayer.playerContainer.innerHTML=pwrd.createItem("embed",_object);
							_player = document.getElementById(_wmpPlayerID);
						}
					break;
				}
				if (_player) {
					pwrd.wmpPlayer.player[_wmpPlayerID]=_player;
				}
				return true;
			}
			pwrd.wmpPlayer.removeWMPPlayer = function(_swfID) {
				if (pwrd.wmpPlayer.playerContainer) {
					pwrd.wmpPlayer.playerContainer.innerHTML = "<div></div>";
				}
			}
			pwrd.wmpPlayer.play=function(_swfID,_positionTo){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if (pwrd.wmpPlayer.isWMPNow) {
					if(_positionTo!=undefined){
						_player.controls.currentPosition=_positionTo;
					}
					_player.controls.play();
				}else {
					pwrd.wmpPlayer.createWMPPlayer(_swfID,null,pwrd.wmpPlayer.mediaLast[_swfID]);
					pwrd.wmpPlayer.listener[_swfID](3);
				}
			}
			pwrd.wmpPlayer.pause=function(_swfID){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if (pwrd.wmpPlayer.isWMPNow) {
					_player.controls.pause();
				}else{
					pwrd.wmpPlayer.removeWMPPlayer(_swfID);
					pwrd.wmpPlayer.listener[_swfID](2);
				}
			}
			pwrd.wmpPlayer.stop=function(_swfID){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					_player.controls.stop();
				}else{
					pwrd.wmpPlayer.removeWMPPlayer(_swfID);
					pwrd.wmpPlayer.listener[_swfID](1);
				}
			}
			pwrd.wmpPlayer.setVolume=function(_swfID,_volume){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					_player.settings.volume=_volume;
				}
			}
			pwrd.wmpPlayer.openList=function(_swfID,_mediaSource){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					_player.URL=_mediaSource;
				}else {
					pwrd.wmpPlayer.mediaLast[_swfID]=_mediaSource;
					//
				}
			}
			pwrd.wmpPlayer.getWMPInfo=function(_swfID){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					var _info={};
					var _content=_player.currentMedia;
					_info.title=_content.getItemInfo("Title");
					_info.author=_content.getItemInfo("Author");
					_info.copyright=_content.getItemInfo("Copyright");
					_info.description=_content.getItemInfo("Description");
					_info.fileSize=_content.getItemInfo("FileSize");
					_info.fileType=_content.getItemInfo("FileType");
					_info.sourceURL=_content.getItemInfo("sourceURL");
					_info.duration=_content.getItemInfo("Duration");
					_info.durationString=_content.durationString;
					return _info;
				}
			}
			pwrd.wmpPlayer.getWMPPlayingInfo=function(_swfID){
				var _player=pwrd.wmpPlayer.getPlayer(_swfID);
				if(pwrd.wmpPlayer.isWMPNow){
					var _info={};
					_info.positionString=_player.controls.currentPositionString;
					_info.position=_player.controls.currentPosition;
					_info.bufferProgress=_player.network.bufferingProgress;
					_info.loadProgress=_player.network.downloadProgress;
					return _info;
				}
			}
		]]></script>
		private static var isPlugin:Boolean = false;
		
		private var isPlayComplete:Boolean = false;
		private var isLoadComplete:Boolean = false;

		override public function get loadProgress():Number {
			var _loadProgress:Number;
			if (isPlugin){
				var _playingInfo:Object = getWMPPlayingInfo();
				if (_playingInfo){
					_loadProgress = int(_playingInfo.loadProgress) * 0.01;
				} else {
					_loadProgress = 1;
				}
			} else {
				_loadProgress = 0;
			}
			return _loadProgress;
		}

		override public function get totalTime():uint {
			if (isPlugin && playContent){
				return playContent.duration * 1000;
			}
			return 0;
		}

		override public function get bufferProgress():Number {
			var _bufferProgress:Number;
			if (isPlugin){
				var _playingInfo:Object = getWMPPlayingInfo();
				if (_playingInfo){
					_bufferProgress = int(_playingInfo.bufferProgress) * 0.01;
				} else {
					_bufferProgress = 1;
				}
			} else {
				_bufferProgress = 0;
			}
			return _bufferProgress;
		}

		override public function get position():uint {
			if (isPlugin){
				var _playingInfo:Object = getWMPPlayingInfo();
				if (_playingInfo){
					return int(_playingInfo.position) * 1000;
				}
			}
			return 0;
		}
		
		override public function set volume(value:Number):void {
			super.volume = value;
			if (isPlugin){
				ExternalInterface.call("pwrd.wmpPlayer.setVolume", ExternalInterface.objectID, volume * 100);
			}
		}

		override protected function init():void {
			super.init();
			name = "wmpProvider";
			if (ExternalInterface.available){
				ExternalInterface.call("eval", WMP_JS.toString());
				ExternalInterface.call("pwrd.wmpPlayer.createWMPContainer");
				ExternalInterface.addCallback("playStateChange", playStateChange);
				isPlugin = ExternalInterface.call("pwrd.wmpPlayer.createWMPPlayer", ExternalInterface.objectID, "playStateChange");
			}
		}
		
		override protected function onRemoveHandler():void 
		{
			timer.removeEventListener(TimerEvent.TIMER, onLoadProgressHandler);
			timer.removeEventListener(TimerEvent.TIMER, onBufferProgressHandler);
			super.onRemoveHandler();
		}

		override public function load(_item:*):void {
			stop();
			if (_item is PlayItem){
				playItem = _item;
			} else if (_item){
				playItem = new PlayItem(_item);
			}
			isLoadComplete = false;
			if (isPlugin){
				ExternalInterface.call("pwrd.wmpPlayer.openList", ExternalInterface.objectID, playItem.source);
			}
		}

		override public function play(_startTime:int = -1):void {
			if (isPlugin){
				if (_startTime < 0){
					ExternalInterface.call("pwrd.wmpPlayer.play", ExternalInterface.objectID);
				} else {
					ExternalInterface.call("pwrd.wmpPlayer.play", ExternalInterface.objectID, _startTime * 0.001);
				}
				ExternalInterface.call("pwrd.wmpPlayer.setVolume", ExternalInterface.objectID, volume * 100);
			}
		}

		override public function pause():void {
			if (isPlugin){
				ExternalInterface.call("pwrd.wmpPlayer.pause", ExternalInterface.objectID);
			}
		}

		override public function stop():void {
			if (isPlugin){
				ExternalInterface.call("pwrd.wmpPlayer.stop", ExternalInterface.objectID);
			}
		}

		override protected function onLoadProgressHandler(_evt:* = null):void {
			if (loadProgress >= 1 && !isLoadComplete) {
				isLoadComplete = true;
				timer.removeEventListener(TimerEvent.TIMER, onLoadProgressHandler);
				onLoadCompleteHandler();
			}else {
				super.onLoadProgressHandler(_evt);
			}
		}

		private function getWMPPlayingInfo():Object {
			if (isPlugin){
				return ExternalInterface.call("pwrd.wmpPlayer.getWMPPlayingInfo", ExternalInterface.objectID);
			}
			return null;
		}

		private function playStateChange(_id:uint, ... args):uint {
			switch (_id){
				case 0:
					//连接超时
					onLoadErrorHandler();
					break;
				case 1:
					//停止
					if (isPlayComplete){
						isPlayComplete = false;
						onPlayCompleteHandler();
					} else {
						setPlayState(PlayState.STOP);
					}
					break;
				case 2:
					//暂停
					setPlayState(PlayState.PAUSE);
					break;
				case 3:
					//播放
					timer.addEventListener(TimerEvent.TIMER, onLoadProgressHandler);
					playContent = ExternalInterface.call("pwrd.wmpPlayer.getWMPInfo", ExternalInterface.objectID);
					setPlayState(PlayState.PLAY);
					break;
				case 4:
					//向前
					break;
				case 5:
					//向后
					break;
				case 6:
					//缓冲
					//缓冲时间过长唤醒
					setPlayState(PlayState.BUFFER);
					break;
				case 7:
					//等待
					setPlayState(PlayState.WAIT);
					break;
				case 8:
					//完毕
					//完毕后windowsmediaplayer会触发stop事件，而此player不会在complete触发stop事件，故不在此设置playComplete事件
					isPlayComplete = true;
					break;
				case 9:
					//连接
					setPlayState(PlayState.CONNECT);
					break;
				case 10:
					//就绪
					setPlayState(PlayState.READY);
					break;
				case 11:
					//重新连接
					setPlayState(PlayState.RECONNECT);
					break;
			}
			if (_id == 6){
				timer.addEventListener(TimerEvent.TIMER, onBufferProgressHandler);
			} else {
				timer.removeEventListener(TimerEvent.TIMER, onBufferProgressHandler);
			}
			return _id;
		}
	}
}