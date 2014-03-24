/***
MusicCtrl
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月16日 11:39:36
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import akdcl.events.MediaEvent;
	import akdcl.manager.ExternalInterfaceManager;
	import akdcl.media.MediaPlayer;
	import akdcl.media.PlayerSkin;
	import akdcl.utils.stringToBoolean;
	
	import com.greensock.TweenMax;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	import zero.ui.Slider;

	public class MusicCtrl extends Sprite{
		
		private var so:SharedObject;
		private var player:MediaPlayer;
		
		public var btnSound:BtnSound;
		public var slider:Slider;
		
		
		public function MusicCtrl(){
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
		}
		
		public function init(xml:XML,so_key:String):void{
			
			so=SharedObject.getLocal(so_key,"/");
			if(so.data.hasOwnProperty("playing")){
			}else{
				so.data.playing=true;
			}
			if(so.data.hasOwnProperty("volume")){
			}else{
				if(xml.@defaultVolume.toString()){
					var defaultVolume:Number=Number(xml.@defaultVolume.toString());
					if(defaultVolume>=0&&defaultVolume<=1){
					}else{
						defaultVolume=0.8;
					}
				}else{
					defaultVolume=0.8;
				}
				so.data.volume=defaultVolume;
			}
			
			player=new MediaPlayer();
			player.playlist = xml.@src.toString();
			
			if(so.data.playing){
				player.volume=so.data.volume;
			}else{
				player.volume=0;
			}
			
			if(btnSound){
				btnSound.release = clickBtnSound;
			}
			if(slider){
				slider.onUpdate=updateVolume;
			}
			
			bgMusicOn=ctrlOn;
			bgMusicOff=ctrlOff;
			
			playOrPause(1);
		}
		private function clickBtnSound():void{
			so.data.playing=!so.data.playing;
			playOrPause(1);
		}
		private function ctrlOn():void{
			this.mouseChildren=true;
			playOrPause(1);
		}
		private function ctrlOff():void{
			this.mouseChildren=false;
			player.pause();
			if(btnSound){
				btnSound.selected=false;
			}
		}
		private function playOrPause(duration:Number):void{
			if(btnSound){
				btnSound.selected=so.data.playing;
			}
			TweenMax.killTweensOf(player);
			if(so.data.playing){
				player.play();
				TweenMax.to(player,duration,{volume:so.data.volume,onUpdate:updateSlider});
			}else{
				TweenMax.to(player,duration,{volume:0,onComplete:player.pause,onUpdate:updateSlider});
			}
		}
		private function updateSlider():void{
			if(slider){
				slider.value=player.volume;
			}
		}
		private function updateVolume():void{
			player.volume=so.data.volume=slider.value;
			if(so.data.volume>0){
				if(so.data.playing){
				}else{
					so.data.playing=true;
					playOrPause(0);
				}
			}else{
				if(so.data.playing){
					so.data.playing=false;
					playOrPause(0);
				}
			}
		}
	}
}