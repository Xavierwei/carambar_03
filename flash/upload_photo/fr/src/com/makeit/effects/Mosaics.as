package com.makeit.effects 
{
	import flash.events.EventDispatcher
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Matrix
	public class Mosaics
	{
		private var _picMC:MovieClip
		private var _mini:Number
		private var _max:Number
		private var bmp:BitmapData
		public var bm:Bitmap
		private var _pixSize:Number
		private var _speed:Number
		public function Mosaics(mc:MovieClip,speed:Number=1.1,mini:Number=1,max:Number=30) 
		{
			_picMC = mc
			_mini = mini
			_max = max
			_speed=speed
			_pixSize=1
			bm=new Bitmap()
			
		}
		public function set speed(value:Number):void {
			_speed=value
		}
		public function start():void {
			_picMC.removeEventListener(Event.ENTER_FRAME, enterHandler)
			_picMC.addEventListener(Event.ENTER_FRAME,enterHandler)
		}
		private function enterHandler(e:Event):void {
			bmp = new BitmapData(_picMC.width / _pixSize, _picMC.height / _pixSize)
			var tempMat:Matrix = new Matrix();
			tempMat.scale(1 / _pixSize, 1 / _pixSize);
			bmp.draw(_picMC,tempMat)
			bm.bitmapData = bmp
			bm.width = _picMC.width
			bm.height = _picMC.height
			if(_speed>1){
				if (_pixSize * _speed < _max) {
					_pixSize *= _speed
				}else {
					_picMC.removeEventListener(Event.ENTER_FRAME, enterHandler)
				}
				
			}else {
				if (_pixSize * _speed > _mini) {
					_pixSize *= _speed
				}else {
					_picMC.removeEventListener(Event.ENTER_FRAME, enterHandler)
				}	
			}
			
		}
		public function dispose():void {
			_picMC.removeEventListener(Event.ENTER_FRAME, enterHandler)
			bmp.dispose()
			if (bm.parent) {
				MovieClip(bm.parent).removeChild(bm)
			}
			
		}
	}

}