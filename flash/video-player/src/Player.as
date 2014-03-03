/***
Player
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2014年01月08日 16:57:37
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

/*
视频播放器需求：

1） 自适应窗口大小，可以随着窗口缩放而自动适应。
2） 可通过js通知视频播放、暂停、停止。
3） 默认为停止状态。
4） 播放控件可以设置是否显示。
*/
package{
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	public class Player extends MovieClip {
		
		public var mediaPlayer:MediaPlayer;
		
		public function Player(){
			this.visible=false;
			this.addFrameScript(2,frame3);
		}
		
		private function frame3():void{
			stop();
			
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			
			if(stage.loaderInfo.parameters.fengmian){
				mediaPlayer.startImage=stage.loaderInfo.parameters.fengmian;
			}
			switch(stage.loaderInfo.parameters.autoplay){
				case "true":
				case true:
					mediaPlayer.autoPlay=true;
				break;
				default:
					mediaPlayer.autoPlay=false;
				break;
			}
			
			mediaPlayer.middleBtnAlign=MiddleBtnAlign.MIDDLE;
			
			mediaPlayer.addEventListener("play",_play);
			mediaPlayer.addEventListener("stopped",_stop);
			mediaPlayer.addEventListener("playComplete",_playComplete);
			
			mediaPlayer.init(LayoutMode.STAND_ALONE,null);
			
			//mediaPlayer.source="01.flv";
			
			this.visible=true;
			
		}
		
		private var flag:Boolean;
		private function _play(...args):void{
			if(flag){
			}else{
				flag=true;
				if(stage.loaderInfo.parameters.onPlay){
					ExternalInterface.call("eval",stage.loaderInfo.parameters.onPlay);
				}
			}
		}
		private function _stop(...args):void{
			flag=false;
		}
		private function _playComplete(...args):void{
			flag=false;
			if(stage.loaderInfo.parameters.onPlayComplete){
				ExternalInterface.call("eval",stage.loaderInfo.parameters.onPlayComplete);
			}
		}
		
	}
	
}