package ui{
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	import akdcl.display.UISprite;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ProgressBar extends UISprite {
		public var change:Function;
		public var labelFunction:Function;
		
		public var txt:TextField;
		public var thumb:DisplayObject;
		public var bar:DisplayObject;
		public var maskClip:DisplayObject;
		public var track:DisplayObject;
		
		protected var offXThumb:Number=0;
		protected var offWidthMaskClip:Number=0;
		protected var offWidthTrack:Number=0;
		
		protected var __rounded:Boolean=true;
		public function get rounded():Boolean{
			return __rounded;
		}
		public function set rounded(_roundShow:Boolean):void{
			__rounded = _roundShow;
			setMaskStyle();
			setTrackStyle();
			setStyle();
		}
		
		protected var __length:Number;
		public function get length():Number {
			return __length;
		}
		public function set length(_length:Number):void {
			__length = _length;
			setMaskStyle();
			setTrackStyle();
			setStyle();
		}
		
		protected var __value:Number = 0;
		public function get value():Number {
			return __value;
		}
		public function set value(_value:Number):void {
			_value = formatValue(_value);
			if (__value == _value) {
				return;
			}
			__value = _value;
			if (change != null) {
				change(__value);
			}
			setStyle();
		}
		
		override protected function init():void {
			super.init();
			if (track) {
				if (bar) {
					offWidthTrack = track.width - bar.width;
				}else {
					offWidthTrack = track.width - thumb.x;
				}
			}
			if (maskClip) {
				if (bar) {
					offWidthMaskClip = maskClip.width - bar.width;
					maskClip.cacheAsBitmap = true;
					bar.cacheAsBitmap = true;
					maskClip.mask = bar;
				}else {
					maskClip.cacheAsBitmap = true;
					thumb.cacheAsBitmap = true;
					thumb.mask = maskClip;
				}
			}
			if (thumb && bar) {
				offXThumb = thumb.x - bar.width - bar.x;
				length = (thumb.x - bar.x + offXThumb) * scaleX;
			}else if (bar) {
				length = bar.width * scaleX;
			}else {
				length = thumb.x  * scaleX;
			}
			scaleX = 1;
			value = 0;
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			labelFunction = null;
			change = null;
			txt = null;
			thumb = null;
			bar = null;
			maskClip = null;
			track = null;
		}
		public function setStyle():void {
			var _value:Number = getClipsValue();
			if (thumb && bar) {
				setThumbStyle(_value + bar.x - offXThumb);
				setBatStyle(Math.max(0, _value - 2 * offXThumb));
			}else {
				setThumbStyle(_value);
				setBatStyle(_value);
			}
			setTxtStyle();
		}
		protected function formatValue(_value:Number):Number {
			if (isNaN(_value)) {
				_value = 0;
			}
			if (_value < 0) {
				_value = 0;
			} else if (_value > 1) {
				_value = 1;
			}
			return _value;
		}
		protected function getClipsValue():Number {
			return __value * __length;
		}
		
		protected function setThumbStyle(_x:Number):void {
			if (thumb) {
				thumb.x = _x;
				if (__rounded) {
					thumb.x = Math.round(thumb.x);
				}
			}
		}
		
		protected function setBatStyle(_w:Number):void {
			if (bar) {
				bar.width = _w;
				if (__rounded) {
					bar.width = Math.round(bar.width);
				}
			}
		}
		
		protected function setTxtStyle():void {
			if (txt) {
				txt.text = (labelFunction!=null)?labelFunction(__value):defaultLabelFunction(__value);
			}
		}
		
		protected function setMaskStyle():void {
			if (maskClip && bar) {
				maskClip.width = offWidthMaskClip +__length;
				if (__rounded) {
					maskClip.width = Math.round(maskClip.width);
				}
			}
		}
		
		protected function setTrackStyle():void {
			if (track) {
				track.width = offWidthTrack +__length - offXThumb * 2;
				if (__rounded) {
					track.width = Math.round(track.width);
				}
			}
		}
		
		protected function defaultLabelFunction(_value:Number):String {
			return Math.round(value * 100) + " %";
		}
	}
}