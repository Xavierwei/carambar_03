package ui {
	import flash.events.Event;
	import ui.Slider;

	/**
	 * ...
	 * @author akdcl
	 */
	public class SliderCircle extends Slider {
		private static const RTA:Number = 180 / Math.PI;

		public var radius:uint;
		public var angleOffset:int;

		public var rotThumb:Boolean;

		override protected function init():void {
			super.init();
			radius = thumb.x;
		}

		override protected function formatValue(_value:Number):Number {
			if (_value > maximum){
				if (timeHolded == 0){
					if ((_value - maximum) / maximum / 360 * (360 - length) > 0.5){
						_value = minimum;
					} else {
						_value = maximum;
					}
				} else if (value < minimum + (maximum - minimum) / 2){
					_value = minimum;
				} else {
					_value = maximum;
				}
			}
			return _value;
		}

		override protected function getClipsValue():Number {
			scale = length * snapInterval / (maximum - minimum);
			return scale * (value - minimum) / snapInterval - angleOffset;
		}
		override protected function setThumbStyle(_x:Number):void 
		{
			if (rotThumb){
				thumb.rotation = _value;
			}
			thumb.x = Math.cos(_value / RTA) * radius;
			thumb.y = Math.sin(_value / RTA) * radius;
		}
		
		override protected function onHoldingHandler(_evt:Event):void {
			var _radian:Number = Math.atan2(mouseY, mouseX);
			if (_radian < -angleOffset / RTA){
				_radian += 2 * Math.PI;
			}
			value = Math.round((_radian * RTA + angleOffset) / scale) * snapInterval + minimum;
			timeHolded++;
		}
	}

}