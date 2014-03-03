package com.makeit.media
{
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.*
	import com.greensock.plugins.*;
	import com.greensock.*;
	public class bgMusic extends EventDispatcher
	{
		private var mySound:Sound
		private var channel:SoundChannel
		private var url:String
		private var volume:Number=1
		public function bgMusic($url:String) 
		{
			TweenPlugin.activate([VolumePlugin]);
			url=$url
		}
		public function play():void {
			var urlRequest:URLRequest=new URLRequest(url)
			mySound = new Sound()
			mySound.load(urlRequest)
			channel = mySound.play()
			channel.soundTransform=new SoundTransform(volume)
			channel.addEventListener(Event.SOUND_COMPLETE,soundCompleteHandler)
		}
		public function muted(time:Number=1):void {
			if (channel) {
				volume=0
				TweenLite.to(channel,time, { volume:0 } );
			}
		}
		public function unMuted(time:Number=1):void {
			if (channel) {
				volume=1
				TweenLite.to(channel,time, { volume:volume } );
			}
		}
		public function setVolume(value:Number, time:Number = 0) {
			volume=value
			TweenLite.to(channel,time, { volume:volume } );
		}
		private function soundCompleteHandler(e:Event):void {
			play()
		}
	}

}