package akdcl.layout {
	import flash.events.Event;

	/**
	 * ...
	 * @author akdcl
	 */
	public class Group extends Rect {
		public static function createGroup(_xml:XML, _index:int = 0):Object {
			var _rect:Object;
			switch (_xml.localName()){
				case "Group":
				case "HGroup":
				case "VGroup":
					_rect = new Group(0, 0, Number(_xml.@width), Number(_xml.@height), Number(_xml.@alignX), Number(_xml.@alignY));
					_rect.interval = Number(_xml.@interval);
					_rect.border = Number(_xml.@border);
					_rect.type = GROUP_VALUES[_xml.localName()];
					_rect.userData = {xml: _xml};
					break;
				case "Display":
					_rect = new Display(0, 0, Number(_xml.@width), Number(_xml.@height), Number(_xml.@alignX), Number(_xml.@alignY), _xml.@scaleMode.length() > 0?Number(_xml.@scaleMode):NaN);
					_rect.border = Number(_xml.@border);
					_rect.userData = {xml: _xml};
					return _rect;
				case "Rect":
					_rect = new Rect(0, 0, Number(_xml.@width), Number(_xml.@height), Number(_xml.@alignX), Number(_xml.@alignY));
					_rect.border = Number(_xml.@border);
					_rect.userData = {xml: _xml};
					return _rect;
				default:
					return null;
			}
			var _childRect:Object;
			for each (var _xml:XML in _xml.children()) {
				_childRect = createGroup(_xml, _index + 1);
				if (_childRect) {
					_rect.addChild(_childRect);
				}
			}
			return _rect;
		}

		private static const GROUP:int = 0;
		private static const HGROUP:int = 1;
		private static const VGROUP:int = -1;

		private static const GROUP_VALUES:Object = {Group: GROUP, HGroup: HGROUP, VGroup: VGROUP};

		public var interval:int;
		public var type:int;

		override public function get width():Number {
			return Math.max(__width, childrenWidth);
		}

		override public function get height():Number {
			return Math.max(__height, childrenHeight);
		}

		private var childrenWidth:int;
		private var childrenHeight:int;
		private var numChildren:uint;
		private var children:Array;
		
		private var isUpdateSize:Boolean;
		private var isUpdatePoint:Boolean;

		public function Group(_x:Number, _y:Number, _width:Number, _height:Number, _alignX:Number = 0, _alignY:Number = 0){
			super(_x, _y, _width, _height, _alignX, _alignY);
		}

		override protected function init():void {
			super.init();
			childrenWidth = 0;
			childrenHeight = 0;
			numChildren = 0;
			interval = 0;
			children = [];
		}

		override protected function onRemoveHandler():void {
			super.onRemoveHandler();
			for each (var _child:Rect in children){
				_child.remove();
			}
			children = null;
		}

		public function addChild(_child:Rect):void {
			_child.addEventListener(Event.RESIZE, onChildResizeHandler);
			if (!_child.name) {
				_child.name = "child" + numChildren;
			}
			children.push(_child);
			numChildren = children.length;
			if (autoUpdate){
				updateSize(false);
			}
		}
		
		public function getChildByName(_name:String):Rect {
			for each (var _child:Rect in children) {
				if (_child.name == _name) {
					return _child;
				}
			}
			return null;
		}

		public function removeChild(_child:Rect):void {
			var _id:int = children.indexOf(_child);
			if (_id>=0) {
				_child.removeEventListener(Event.RESIZE, onChildResizeHandler);
				children.splice(_id, 1);
				numChildren = children.length;
				if (autoUpdate){
					updateSize(false);
				}
			}
		}

		public function forEachGroup(_fun:Function, ... args):void{
			var _arr1:Array = args.concat();
			_arr1.unshift(this);
			_fun.apply(this, _arr1);

			var _arrn:Array = args.concat();
			_arrn.unshift(_fun);

			for each (var _child:Rect in children){
				if (_child is Group){
					(_child as Group).forEachGroup.apply(_child, _arrn);
				}
			}
		}

		public function forEachChild(_fun:Function, ... args):void{
			var _arr1:Array;

			var _arrn:Array = args.concat();
			_arrn.unshift(_fun);

			for each (var _child:Rect in children){
				if (_child is Group){
					(_child as Group).forEachChild.apply(_child, _arrn);
				} else {
					_arr1 = args.concat();
					_arr1.unshift(_child);
					_fun.apply(_child, _arr1);
				}
			}
		}

		override protected function updatePoint(_dispathEvent:Boolean = true):void {
			if (isUpdatePoint) {
				return;
			}
			isUpdatePoint = true;
			var _x:Number;
			var _y:Number;
			var _child:Rect;
			var _prevChild:Rect;
			var _off:int;
			var _i:uint = 0;

			if (type == HGROUP) {
				//使用width而不是__width来计算对齐偏移量，目的是保证width - childrenWidth>=0
				_off = border + (width - border * 2 - childrenWidth) * __alignX;
			} else if (type == VGROUP){
				//同上
				_off = border + (height - border * 2 - childrenHeight) * __alignY;
			}

			for (; _i < numChildren; _i++){
				_child = children[_i];
				if (type == HGROUP){
					_x = _i == 0 ? __x + _off : _prevChild.__x + _prevChild.width + interval;
				} else {
					_x = int(__x + (__width - _child.width) * __alignX - (__alignX * 2 - 1) * border);
				}
				if (type == VGROUP){
					_y = _i == 0 ? __y + _off : _prevChild.__y + _prevChild.height + interval;
				} else {
					_y = int(__y + (__height - _child.height) * __alignY - (__alignY * 2 - 1) * border);
				}
				_child.setPoint(_x, _y);
				_prevChild = _child;
			}
			isUpdatePoint = false;
			super.updatePoint(_dispathEvent);
		}

		override protected function updateSize(_dispathEvent:Boolean = true):void {
			if (isUpdateSize) {
				return;
			}
			isUpdateSize = true;
			var _child:Rect;
			var _width:Number;
			var _height:Number;
			var _unX:Boolean;
			var _unY:Boolean;
			var _percent:Number = 0;
			var _averageCount:Number = 0;
			var _i:uint = 0;
			
			var _value:Number;
			var _valueD:Number;
			var _widthD:Number = __width - border * 2;
			var _heightD:Number = __height - border * 2;
			_value = _valueD = (numChildren - 1) * interval;

			childrenWidth = 0;
			childrenHeight = 0;
			switch (type){
				case GROUP:
					for each (_child in children) {
						_unX = true;
						_unY = true;
						if (_child.isAverageWidth) {
							//未设置
							_width = _widthD;
						} else if (_child.percentWidth) {
							//百分比
							_width = _child.percentWidth * (_widthD);
						} else {
							//预设
							_width = _child.width;
							_unX = false;
						}
						if (_child.isAverageHeight){
							//未设置
							_height = _heightD;
						} else if (_child.percentHeight){
							//百分比
							_height = _child.percentHeight * (_heightD);
						} else {
							//预设
							_height = _child.height;
							_unY = false;
						}
						if (_unX || _unY) {
							//未设置或百分比
							_child.setSize(_width, _height);
						}
						childrenWidth = Math.max(_child.width, childrenWidth);
						childrenHeight = Math.max(_child.height, childrenHeight);
					}
					break;
				case HGROUP:
					for each (_child in children){
						if (_child.isAverageWidth){
							//未设置
							_averageCount++;
						} else if (_child.percentWidth > 0){
							//百分比
							_percent += _child.percentWidth;
						} else {
							//预设
							_width = _child.width;
							//_percent += _width / _widthD;
							_value += _width;
						}
						childrenHeight = Math.max(_child.height, childrenHeight);
					}
					if (_percent < 1){
						if (_averageCount > 0){
							_averageCount = (1 - _percent) / _averageCount;
						}
						_percent = 1;
					}
					_value = Math.max(0, _widthD - _value);
					for (_i = 0; _i < numChildren; _i++){
						_unX = true;
						_unY = true;
						_child = children[_i];
						if (_child.isAverageHeight){
							//未设置
							_height = _heightD;
						} else if (_child.percentHeight){
							//百分比
							_height = _child.percentHeight * (_heightD);
						} else {
							//预设
							_height = _child.height;
							_unY = false;
						}
						if (_child.isAverageWidth||_child.percentWidth){
							//未设置
							if (_i == numChildren - 1) {
								//最后一个需要取整
								_width = _widthD - childrenWidth - _valueD;
							} else {
								_width = _value * (_child.isAverageWidth ? _averageCount : _child.percentWidth) / _percent;
							}
						} else {
							//预设
							_width = _child.width;
							_unX = false;
						}
						if (_unX || _unY) {
							//未设置或百分比
							_child.setSize(_width, _height);
						}
						childrenWidth += _child.width;
					}
					childrenWidth += _valueD;
					break;
				case VGROUP:
					for each (_child in children){
						if (_child.isAverageHeight){
							//未设置
							_averageCount++;
						} else if (_child.percentHeight > 0){
							//百分比
							_percent += _child.percentHeight;
						} else {
							//预设
							_value += _child.height;
						}
						childrenWidth = Math.max(_child.width, childrenWidth);
					}
					if (_percent < 1){
						if (_averageCount > 0){
							_averageCount = (1 - _percent) / _averageCount;
						}
						_percent = 1;
					}
					_value = Math.max(0, _heightD - _value);
					for (_i = 0; _i < numChildren; _i++){
						_unX = true;
						_unY = true;
						_child = children[_i];
						if (_child.isAverageWidth){
							//未设置
							_width = _widthD;
						} else if (_child.percentWidth){
							//百分比
							_width = _child.percentWidth * (_widthD);
						} else {
							//预设
							_width = _child.width;
							_unX = false;
						}

						if (_child.isAverageHeight||_child.percentHeight){
							//未设置
							if (_i == numChildren - 1){
								_height = _heightD - childrenHeight - _valueD;
							} else {
								_height = _value * (_child.isAverageHeight ? _averageCount : _child.percentHeight) / _percent;
							}
						} else {
							//预设
							_height = _child.height;
							_unY = false;
						}
						if (_unX || _unY) {
							//未设置或百分比
							_child.setSize(_width, _height);
						}
						childrenHeight += _child.height;
					}
					childrenHeight += _valueD;
					break;
			}
			isUpdateSize = false;
			updatePoint(_dispathEvent);
			super.updateSize(_dispathEvent);
		}

		private function onChildResizeHandler(e:Event):void {
			if (autoUpdate){
				updateSize(true);
			}
		}

		override public function toString():String {
			var _str:String = super.toString();
			for each (var _child:Rect in children){
				_str += "\n";
				_str += _child.toString();
			}
			return _str;
		}
	}
}