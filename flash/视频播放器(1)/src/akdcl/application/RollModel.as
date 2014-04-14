package akdcl.application{
	import akdcl.display.UISprite;
	import flash.utils.Dictionary;
	public class RollModel extends UISprite {
		public var isRound:Boolean;
		public var isScale:Boolean;
		public var isAlpha:Boolean;
		public var isXY:Boolean;
		public var radiusX:int = 300;
		public var radiusY:int = 50;
		public var viewXOff:Number = Math.PI * 0.5;
		
		protected var rollDic:Dictionary;
		protected var rollList:Array;
		protected var rollDepth:Array;
		
		override protected function init():void {
			super.init();
			rollDic = new Dictionary();
			rollList = [];
			rollDepth = [];
			length = 10;
		}
		private var __length:uint = 10;
		public function get length():uint {
			return __length;
		}
		public function set length(_length:uint):void {
			__length = _length;
			__rotatePer = Math.PI * 2 / length;
		}
		private var __rotatePer:Number;
		public function get rotatePer():Number {
			return __rotatePer;
		}
		public var scaleK:Number=0.2;
		protected function getK(_n:Number):Number {
			_n = _n*(1-scaleK)+scaleK;
			return _n;
		}
		public var scaleA:Number=0.2;
		protected function getA(_n:Number):Number {
			_n = _n*(1-scaleA)+scaleA;
			return _n;
		}
		public var scaleOffY:Number = 0.0002;
		public function get viewRotationX():Number {
			return viewX * 180 / Math.PI;
		}
		public function set viewRotationX(_viewRotationX:Number):void {
			viewX = _viewRotationX / 180 * Math.PI;
		}
		protected var addX:Number=0;
		protected var __viewX:Number=0;
		public function set viewX(_viewX:Number):void {
			addX = _viewX - __viewX;
			__viewX = radianFloor(_viewX);
			render();
		}
		public function get viewX():Number {
			return __viewX;
		}
		protected var __viewY:Number=0;
		public function get viewY():Number {
			return __viewY;
		}
		public function set viewY(_viewY:Number):void {
			__viewY = _viewY;
		}
		public function getRoll(_id:int):* {
			_id %= rollList.length;
			if (_id<0) {
				_id = rollList.length + _id;
			}
			return rollList[_id];
		}
		public function getRollRadian(_roll:*):Number{
			return rollDic[_roll];
		}
		public function getRollRadianByID(_id:uint):Number{
			return rollDic[getRoll(_id)];
		}
		public function addRoll(_roll:*, _id:uint, _list:Array=null, _radian:Number = NaN):void {
			rollDic[_roll]=_radian||radianFloor(-rotatePer*_id);
			rollList.push(_roll);
			rollDepth.push(_roll);
		}
		public function addRollList(_list:Array):void {
			length = _list.length;
			_list.forEach(addRoll);
		}
		protected function radianFloor(_radian:Number):Number {
			if (_radian>=Math.PI) {
				_radian-=2*Math.PI;
			}
			if (_radian<=- Math.PI) {
				_radian+=2*Math.PI;
			}
			return _radian;
		}
		protected function render():void {
			var _scale:Number;
			var _cos:Number;
			var _sin:Number;
			for each(var _roll:* in rollList) {
				_cos = Math.cos(rollDic[_roll] + viewX + viewXOff);
				_sin = Math.sin(rollDic[_roll] + viewX + viewXOff);
				_roll.x = _cos * radiusX;
				_roll.y = _sin * (radiusY + viewY);
				
				
				if (isXY) {
					_roll.y += _roll.x * (radiusY + viewY) * scaleOffY;
					//* addX
				}
				if (isRound) {
					_roll.x = Math.round(_roll.x);
					_roll.y = Math.round(_roll.y);
				}
				_scale = getK((_sin + 1) * 0.5);
				if (isScale) {
					_roll.scaleY = _roll.scaleX = _scale;
				}
				if (isAlpha) {
					_roll.alpha = Math.max(Math.min(getA((_sin + 1) * 0.5), 1), 0);
					_roll.visible = _roll.alpha>0;
				}
			}
			rollDepth.sort(depthSort);
			rollDepth.forEach(setIndex);
		}
		protected function setIndex(_element:*, _index:int, _arr:Array):void{
			if(_element.stage){
				_element.parent.setChildIndex(_element,_index);
			}
		}
		private static const DY:uint = 1002;
		protected function depthSort(_clip_0:*, _clip_1:*):int {
			if (radiusY>0) {
				if (_clip_0.x + _clip_0.y * DY < _clip_1.x + _clip_1.y * DY) {
					return -1;
				}else{
					return 1;
				}
			}else {
				if (_clip_0.x + _clip_0.y * DY < _clip_1.x + _clip_1.y * DY) {
					return 1;
				}else{
					return -1;
				}
			}
		}
	}
}