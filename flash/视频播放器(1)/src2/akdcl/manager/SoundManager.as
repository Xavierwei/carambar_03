package akdcl.manager {
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;

	import akdcl.media.SoundEmbedItem;
	import akdcl.manager.SourceManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	final public class SoundManager extends BaseManager {
		baseManager static var instance:SoundManager;
		public static function getInstance():SoundManager {
			return createConstructor(SoundManager) as SoundManager;
		}
		
		public function SoundManager() {
			super(this);
		}

		private static const SOUND_ITEMS_GROUP:String = "soundItems";
		private static const DEFAULT:String = "soundEffects";

		private static var sM:SourceManager = SourceManager.getInstance();

		public function addSound(_asID:String, _keyID:String = null, _groupID:String = null, _maxVolume:Number = 1):void {
			var _SoundClass:* = getDefinitionByName(_asID);
			var _sound:Sound;
			if (_SoundClass){
				_sound = sM.getSource(SourceManager.SOUND_GROUP, _asID);
				if (!_sound){
					_sound = new _SoundClass() as Sound;
					sM.addSource(SourceManager.SOUND_GROUP, _asID, _sound);
				}
				var _soundItem:SoundEmbedItem = new SoundEmbedItem(_sound, _maxVolume);
				_groupID = _groupID || DEFAULT;
				var _soundItems:SoundItems = sM.getSource(SOUND_ITEMS_GROUP, _groupID);
				if (!_soundItems){
					_soundItems = new SoundItems();
					sM.addSource(SOUND_ITEMS_GROUP, _groupID, _soundItems);
				}
				_soundItems.addSound(_soundItem, _keyID || _asID);
			}
		}

		public function getVolume(_groupID:String = null):Number {
			_groupID = _groupID || DEFAULT;
			var _soundItems:SoundItems = sM.getSource(SOUND_ITEMS_GROUP, _groupID);
			if (_soundItems){
				return _soundItems.getVolume();
			}
			return 0;
		}

		public function setVolume(_volume:Number, _groupID:String = null):void {
			_groupID = _groupID || DEFAULT;
			var _soundItems:SoundItems = sM.getSource(SOUND_ITEMS_GROUP, _groupID);
			if (_soundItems){
				_soundItems.setVolume(_volume);
			}
		}

		public function playSound(_keyID:String, _groupID:String = null, _startTime:Number = 0, _loops:uint = 0, _tempVolume:Number = 1, _tweenIn:Number = 0, _tweenOut:Number = 0):SoundEmbedItem {
			_groupID = _groupID || DEFAULT;
			var _soundItems:SoundItems = sM.getSource(SOUND_ITEMS_GROUP, _groupID);
			if (_soundItems){
				var _sound:SoundEmbedItem = _soundItems.getSound(_keyID);
				if (_sound){
					_sound.play(_startTime, _loops, _tempVolume, _tweenIn, _tweenOut);
					return _sound;
				}
			}
			return null;
		}
	}
}

class SoundItems extends Object {
	private var volume:Number = 1;
	private var soundDic:Object = {};

	public function addSound(_sound:*, _keyID:String):void {
		soundDic[_keyID] = _sound;
		_sound.volume = volume;
	}

	public function getSound(_keyID:String):* {
		var _sound:* = soundDic[_keyID];
		return _sound;
	}

	public function getVolume():Number {
		return volume;
	}

	public function setVolume(_volume:Number):void {
		volume = _volume;
		for each (var _sound:*in soundDic){
			_sound.volume = volume;
		}
	}
}