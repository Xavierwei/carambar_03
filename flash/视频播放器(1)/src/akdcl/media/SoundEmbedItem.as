package akdcl.media {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	import flash.events.Event;

	import com.greensock.TweenNano;
	import com.greensock.easing.Sine;

	import akdcl.manager.ElementManager;

	/**
	 * ...
	 * @author Akdcl
	 */

	final public class SoundEmbedItem {
		private static var eM:ElementManager = ElementManager.getInstance();

		public static function setChannelVolume(_channel:SoundChannel, _volume:Number):void {
			var _soundTransform:SoundTransform = _channel.soundTransform;
			_soundTransform.volume = _volume;
			_channel.soundTransform = _soundTransform;
		}
		public var maxVolume:Number = 1;
		public var tempVolume:Number = 1;

		private var channelList:Array;

		private var sound:Sound;
		private var channelLast:SoundChannel;

		public function get loadProgress():Number {
			var _loadProgress:Number;
			if (sound){
				_loadProgress = sound.bytesLoaded / sound.bytesTotal;
			} else {
				_loadProgress = 0;
			}
			return _loadProgress;
		}

		public function get totalTime():uint {
			var _totalTime:uint;
			if (sound){
				_totalTime = sound.length / loadProgress;
			} else {
				_totalTime = 0;
			}
			return _totalTime;
		}

		public function get playProgress():Number {
			var _playProgress:Number = position / totalTime;
			if (isNaN(_playProgress)){
				_playProgress = 0;
			}
			return _playProgress;
		}

		public function get position():uint {
			if (channelLast && sound.length > 0){
				return channelLast.position;
			} else {
				return 0;
			}
		}

		private var __volume:Number = 1;

		public function get volume():Number {
			return __volume;
		}

		public function set volume(_volume:Number):void {
			if (_volume < 0){
				_volume = 0;
			} else if (_volume > 1){
				_volume = 1;
			}
			__volume = _volume;
			if (channelLast){
				//暂时只修改最后一个通道的音量
				setChannelVolume(channelLast, __volume * maxVolume * tempVolume);
			}
			
		}

		public function SoundEmbedItem(_sound:Sound, _maxVolume:Number = 1){
			maxVolume = _maxVolume;
			channelList = [];
			if (_sound){
				sound = _sound;
			}
		}

		public function play(_startTime:Number = -1, _loops:uint = 0, _tempVolume:Number = 1, _tweenIn:Number = 0, _tweenOut:Number = 0):SoundChannel {
			if (!sound){
				return null;
			}
			if (_startTime < 0){
				_startTime = 0;
			} else if (_startTime <= 1){
				//0~1（playProgress）
				if (_startTime >= loadProgress){
					_startTime = loadProgress * 0.999;
				}
				_startTime = totalTime * _startTime;
			} else {
				//1~XX（playTime毫秒为单位）
				var _loadTime:uint = totalTime * loadProgress;
				if (_startTime >= _loadTime){
					_startTime = _loadTime * 0.999;
				}
			}
			//当调节volume时，所有的通道应该保留自己的tempVolume，暂时未处理
			tempVolume = _tempVolume;

			//try {
			channelLast = sound.play(_startTime, _loops);
			setChannelVolume(channelLast, volume * maxVolume * tempVolume);
			channelLast.addEventListener(Event.SOUND_COMPLETE, onSoundChannelEventHandler);
			channelList.push(channelLast);

			//volume淡入
			if (_tweenIn == 0){

			} else if (_tweenIn <= 1){
				(eM.getElement(TweenObject.ELEMENT_ID) as TweenObject).tweenChannel(this, channelLast, totalTime * _tweenIn * 0.001, 0, 1);
			} else {
				(eM.getElement(TweenObject.ELEMENT_ID) as TweenObject).tweenChannel(this, channelLast, _tweenIn * 0.001, 0, 1);
			}
			//volume淡出
			if (_tweenOut == 0){

			} else if (_tweenOut <= 1){
				(eM.getElement(TweenObject.ELEMENT_ID) as TweenObject).tweenChannel(this, channelLast, totalTime * _tweenOut * 0.001, totalTime * (1 - _tweenOut) * 0.001, 0);
			} else {
				(eM.getElement(TweenObject.ELEMENT_ID) as TweenObject).tweenChannel(this, channelLast, _tweenOut * 0.001, (totalTime - _tweenOut) * 0.001, 0);
			}
			//} catch (_error:*){

			//}
			return channelLast;
		}

		public function stop():void {
			removeAllChannel();
		}

		public function remove():void {
			stop();
			sound = null;
			channelLast = null;
			channelList = null;
		}

		private function removeChannel(_channel:SoundChannel):void {
			if (_channel){
				_channel.stop();
				_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundChannelEventHandler);
				var _id:int = channelList.indexOf(_channel);
				if (_id >= 0){
					channelList.splice(_id, 1);
				}
			}
		}

		private function removeAllChannel():void {
			for each (var _channel:SoundChannel in channelList){
				removeChannel(_channel);
			}
			channelList = [];
			channelLast = null;
		}

		private function onSoundChannelEventHandler(_evt:Event):void {
			var _channel:SoundChannel = _evt.currentTarget as SoundChannel;
			switch (_evt.type){
				case Event.SOUND_COMPLETE:
					removeChannel(_channel);
					break;
			}
		}
	}
}

import flash.media.SoundChannel;

import com.greensock.easing.Sine;
import com.greensock.TweenNano;

import akdcl.manager.ElementManager;

import akdcl.media.SoundEmbedItem;

class TweenObject {
	public static const ELEMENT_ID:String = "TweenObject_SoundEmbedItem";
	ElementManager.getInstance().register(ELEMENT_ID, TweenObject);

	public var volume:Number = 1;

	private var soundItem:SoundEmbedItem;
	private var channel:SoundChannel;
	private var tempVolume:Number = 1;
	private var tweenVars:Object = {volume: 1, overwrite: 0, delay: 0, ease: Sine.easeInOut, onUpdate: onTweenUpdate, onComplete: onTweenComplete};

	public function tweenChannel(_soundItem:SoundEmbedItem, _channel:SoundChannel, _tween:Number, _delay:Number = 0, _tweenVolume:Number = 0):void {
		soundItem = _soundItem;
		channel = _channel;
		tempVolume = soundItem.tempVolume;
		tweenVars.delay = _delay;
		tweenVars.volume = _tweenVolume;

		if (_tweenVolume == 1){
			volume = 0;
			onTweenUpdate();
		} else {
			volume = soundItem.volume;
		}

		TweenNano.to(this, _tween, tweenVars);
	}

	private function onTweenUpdate():void {
		SoundEmbedItem.setChannelVolume(channel, soundItem.maxVolume * soundItem.volume * tempVolume * volume);
	}

	private function onTweenComplete():void {
		TweenNano.killTweensOf(this);
		ElementManager.getInstance().recycle(this);
	}
}