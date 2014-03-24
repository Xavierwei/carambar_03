package akdcl.manager {
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	import akdcl.events.UIEvent;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class ButtonManager extends BaseManager {
		baseManager static var instance:ButtonManager;
		public static function getInstance():ButtonManager {
			return createConstructor(ButtonManager) as ButtonManager;
		}
		
		public function ButtonManager() {
			super(this);
			
			buttonDic = new Dictionary();
			buttonInDic = new Dictionary();
			buttonDownDic = new Dictionary();
			
			intervalID = setInterval(checkStage, 300);
		}
		
		private static const ROLL_OVER:String = "rollOver";
		private static const ROLL_OUT:String = "rollOut";
		private static const PRESS:String = "press";
		private static const RELEASE:String = "release";
		private static const RELEASE_OUTSIDE:String = "releaseOutside";
		private static const DRAG_OVER:String = "dragOver";
		private static const DRAG_OUT:String = "dragOut";
		
		public static var mobileMode:Boolean;
		public static var moveAccuracy:int = 0;
		
		private var buttonDic:Dictionary;
		private var buttonInDic:Dictionary;
		private var buttonDownDic:Dictionary;
		
		private var intervalID:uint;
		private var buttonTarget:InteractiveObject;
		
		public var stage:Stage;
		public var startX:int;
		public var startY:int;
		public var lastX:int;
		public var lastY:int;
		public var speedX:Number = 0;
		public var speedY:Number = 0;
		public var isDraged:Boolean;
		
		private function checkStage():void {
			for each(buttonTarget in buttonDic) {
				if (buttonTarget.stage) {
					stage = buttonTarget.stage;
					stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUpHandler);
					stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDownHandler);
					clearInterval(intervalID);
					break;
				}
			}
		}
		//ROLL_OVER;ROLL_OUT;PRESS==MOUSE_DOWN;RELEASE==CLICK;RELEASE_OUTSIDE;DRAG_OVER;DRAG_OUT;
		public function addButton(_button:*):void {
			if (_button is MovieClip) {
				_button.mouseChildren = false;
			}
			_button.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			buttonDic[_button] = _button;
			setButtonStyle(_button);
		}
		
		
		public function removeButton(_button:*):void {
			_button.removeEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			_button.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
			delete buttonDic[_button];
			delete buttonInDic[_button];
			delete buttonDownDic[_button];
		}
		
		public function removeFromDown(_container:DisplayObjectContainer):void {
			var _parent:DisplayObjectContainer
			for each(buttonTarget in buttonDownDic) {
				_parent = buttonTarget.parent;
				do {
					if (!_parent || _parent == _container) {
						delete buttonDownDic[buttonTarget];
						setButtonStyle(buttonTarget);
						break;
					}
					_parent = _parent.parent;
				}while (_parent);
			}
		}
		
		private function onStageMouseDownHandler(_e:Event):void {
			lastX = startX = stage.mouseX;
			lastY = startY = stage.mouseY;
			stage.addEventListener(Event.ENTER_FRAME, onMouseMoveHandler);
			for each(buttonTarget in buttonInDic) {
				if (buttonDownDic[buttonTarget]) {
					
				}else {
					buttonDownDic[buttonTarget] = buttonTarget;
					buttonTarget.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
					if (buttonTarget.hasEventListener(UIEvent.PRESS)) {
						buttonTarget.dispatchEvent(new UIEvent(UIEvent.PRESS));
					}
					buttonCallBack(buttonTarget, PRESS);
					setButtonStyle(buttonTarget);
				}
			}
			if (mobileMode) {
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMoveHandler);
			}
		}
		
		private function onStageMouseUpHandler(_e:Event):void {
			if (mobileMode) {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMoveHandler);
			}
			stage.removeEventListener(Event.ENTER_FRAME, onMouseMoveHandler);
			
			//trace(_e.target, _e.currentTarget, buttonTarget);
			//var _parent:DisplayObjectContainer;
			if (!mobileMode && _e && _e.target != stage) {
				buttonTarget = _e.target as InteractiveObject;
				while (buttonTarget) {
					if (buttonInDic[buttonTarget] && !buttonDownDic[buttonTarget]) {
						delete buttonInDic[buttonTarget];
						onRollOverHandler(buttonTarget);
						//trace("releaseInOtherButton");
					}
					buttonTarget = buttonTarget.parent;
				}
			}
			for each(buttonTarget in buttonDownDic) {
				delete buttonDownDic[buttonTarget];
				if (buttonInDic[buttonTarget]) {
					if (buttonTarget.hasEventListener(UIEvent.RELEASE)) {
						buttonTarget.dispatchEvent(new UIEvent(UIEvent.RELEASE, true, _e?_e.target:buttonTarget));
					}
					buttonCallBack(buttonTarget, RELEASE);
				}else {
					if (buttonTarget.hasEventListener(UIEvent.RELEASE_OUTSIDE)) {
						buttonTarget.dispatchEvent(new UIEvent(UIEvent.RELEASE_OUTSIDE, true, _e?_e.target:buttonTarget));
					}
					buttonCallBack(buttonTarget, RELEASE_OUTSIDE);
					/*
					var _isActive:Boolean = true;
					_parent = buttonTarget.parent;
					while (_parent) {
						if (_parent.mouseChildren) {
							_parent = _parent.parent;
						}else {
							_isActive = false;
							break;
						}
					}
					if (_isActive) {
					}
					*/
				}
				
				setButtonStyle(buttonTarget, mobileMode);
			}
			isDraged = false;
		}
		
		private function onStageMouseMoveHandler(_e:MouseEvent):void {
			if (_e.stageX > stage.stageWidth || _e.stageX < 0 || _e.stageY > stage.stageHeight || _e.stageY < 0) {
				onStageMouseUpHandler(null);
			}
		}
		
		
		private function onRollOverHandler(_e:Object):void {
			buttonTarget = (_e is MouseEvent)?_e.currentTarget:_e as InteractiveObject;
			
			if (buttonInDic[buttonTarget]) {
				
			}else {
				buttonInDic[buttonTarget] = buttonTarget;
				buttonTarget.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
				if (_e is MouseEvent?_e.buttonDown:false) {
					
					if (buttonTarget.hasEventListener(UIEvent.DRAG_OVER)) {
						buttonTarget.dispatchEvent(new UIEvent(UIEvent.DRAG_OVER));
					}
					buttonCallBack(buttonTarget, DRAG_OVER);
				}else {
					if (buttonTarget.hasEventListener(UIEvent.ROLL_OVER)) {
						buttonTarget.dispatchEvent(new UIEvent(UIEvent.ROLL_OVER));
					}
					buttonCallBack(buttonTarget, ROLL_OVER);
					setButtonStyle(buttonTarget);
				}
			}
		}
		private function onRollOutHandler(_e:MouseEvent):void {
			buttonTarget = _e.currentTarget as InteractiveObject;
			if (buttonInDic[buttonTarget]) {
				delete buttonInDic[buttonTarget];
				buttonTarget.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
				if (_e.buttonDown) {
					if (buttonTarget.hasEventListener(UIEvent.DRAG_OUT)) {
						buttonTarget.dispatchEvent(new UIEvent(UIEvent.DRAG_OUT));
					}
					buttonCallBack(buttonTarget, DRAG_OUT);
				}else {
					if (buttonTarget.hasEventListener(UIEvent.ROLL_OUT)) {
						buttonTarget.dispatchEvent(new UIEvent(UIEvent.ROLL_OUT));
					}
					buttonCallBack(buttonTarget, ROLL_OUT);
				}
				
				setButtonStyle(buttonTarget);
			}
		}
		
		private function onMouseMoveHandler(_e:Event):void {
			speedX = stage.mouseX - lastX;
			speedY = stage.mouseY - lastY;
			lastX = stage.mouseX;
			lastY = stage.mouseY;
			if (Math.abs(speedX) > moveAccuracy || Math.abs(speedY) > moveAccuracy) {
				for each(buttonTarget in buttonDownDic) {
					if (buttonTarget.hasEventListener(UIEvent.DRAG_MOVE)) {
						buttonTarget.dispatchEvent(new UIEvent(UIEvent.DRAG_MOVE));
					}
				}
				isDraged = true;
			}
		}
		private function buttonCallBack(_button:Object, _method:*):void {
			var _methodName:String;
			try {
				if (_method is String && (_method in _button)) {
					_methodName = _method;
					_method = _button[_method];
				}
			}catch (_error:Error) {
				
			}
			if (_method is Function) {
				if (_methodName) {
					_button[_methodName]();
				}else {
					_method();
				}
			}
		}
		
		public function setButtonStyle(_button:Object, _isMobileMouseUp:Boolean = false):void {
			var _isDown:Boolean = buttonDownDic[_button] != null;
			var _isIn:Boolean = _isMobileMouseUp?false:(buttonInDic[_button] != null);
			var _isSelected:Boolean = _button.hasOwnProperty("selected") && _button.selected;
			var _isActive:Boolean = _isDown || _isIn || _isSelected;
			var _frameTo:uint;
			if (_button is MovieClip) {
				if (_button.totalFrames > 8) {
					setButtonClipPlay(_button as MovieClip, _isActive);
				}else {
					if (_isIn) {
						_frameTo = _isDown?4:2;
					}else {
						_frameTo = _isDown?3:1;
					}
					_frameTo += _isSelected?4:0;
					if (_button.currentFrame == _frameTo) {
						_button.stop();
					}else {
						_button.gotoAndStop(_frameTo);
					}
				}
			}
			
			if (_button.hasOwnProperty("aniClip")) {
				setButtonClipPlay(_button.aniClip, _isActive);
			}
			if (_button.hasEventListener(UIEvent.UPDATE_STYLE)) {
				_button.dispatchEvent(new UIEvent(UIEvent.UPDATE_STYLE, _isActive));
			}
		}
		public function setButtonClipPlay(_buttonClip:Object, _nextFrame:Boolean):void {
			if (_buttonClip is MovieClip && _buttonClip.totalFrames > 1) {
				if (_nextFrame) {
					_buttonClip.removeEventListener(Event.ENTER_FRAME, onEnterFramePrevHandler);
					_buttonClip.addEventListener(Event.ENTER_FRAME, onEnterFrameNextHandler);
				}else {
					_buttonClip.removeEventListener(Event.ENTER_FRAME, onEnterFrameNextHandler);
					_buttonClip.addEventListener(Event.ENTER_FRAME, onEnterFramePrevHandler);
				}
			}
		}
		private function onEnterFrameNextHandler(_e:Event):void {
			var _target:MovieClip = _e.target as MovieClip;
			if (_target.currentFrame == _target.totalFrames) {
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFrameNextHandler);
			} else {
				_target.nextFrame();
			}
		}
		private function onEnterFramePrevHandler(_e:Event):void {
			var _target:MovieClip = _e.target as MovieClip;
			if (_target.currentFrame == 1) {
				_target.stop();
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFramePrevHandler);
			} else {
				_target.prevFrame();
			}
		}
		//
		private var groupItemDic:Object = { };
		private var groupSelectedDic:Object = { };
		private var groupParamsDic:Object = { };
		private static const KEY_LIMIT:String = "limit";
		private static const KEY_RADIO_UNSELECT_FUN:String = "radioUnselectFun";
		public function addToGroup(_groupName:String, _item:*):void {
			if (!groupItemDic[_groupName]) {
				groupItemDic[_groupName] = new Array();
				groupSelectedDic[_groupName] = new Array();
				setLimit(_groupName, 0);
			}
			/*if (_n != 0 && obGroup[_s+"_limit"]<_n) {
				obGroup[_s+"_limit"] = _n;
			}*/
			groupItemDic[_groupName].push(_item);
		}
		public function removeFromGroup(_groupName:String, _item:*):void {
			removeFromArray(groupItemDic[_groupName], _item);
			removeFromArray(groupSelectedDic[_groupName], _item);
		}
		public function selectItem(_groupName:String, _item:*):Boolean {
			var _limit:uint = getLimit(_groupName);
			var _groupSelected:Array = groupSelectedDic[_groupName];
			if (_limit == 0) {
				if (_groupSelected[0]) {
					getRadioUnselectFun(_groupName)(_groupSelected[0]);
					unselectItem(_groupName, _groupSelected[0]);
				}
				_groupSelected.push(_item);
				return true;
			}else if (_limit > _groupSelected.length) {
				_groupSelected.push(_item);
				return true;
			} else {
				return false;
			}
		}
		public function unselectItem(_groupName:String, _item:*):void {
			removeFromArray(groupSelectedDic[_groupName], _item);
		}
		public function unselectGroup(_groupName:String):void {
			var _groupSelected:Array = groupSelectedDic[_groupName];
			for each(var _selected:* in _groupSelected) {
				getRadioUnselectFun(_groupName)(_selected);
				unselectItem(_groupName, _selected);
			}
		}
		public function getRadioUnselectFun(_groupName:String):Function {
			return groupParamsDic[_groupName + KEY_RADIO_UNSELECT_FUN];
		}
		public function setRadioUnselectFun(_groupName:String, _fun:Function):void {
			groupParamsDic[_groupName + KEY_RADIO_UNSELECT_FUN] = _fun;
		}
		public function getLimit(_groupName:String):uint {
			return int(groupParamsDic[_groupName + KEY_LIMIT]);
		}
		public function setLimit(_groupName:String, _limit:uint, _auto:Boolean = true):void {
			if (_auto?(getLimit(_groupName)< _limit):true) {
				groupParamsDic[_groupName + KEY_LIMIT] = _limit;
			}else {
				
			}
			if (_limit==0) {
				setRadioUnselectFun(_groupName,unSelectItemFun);
			}
		}
		private function unSelectItemFun(_item:*):void {
			_item.selected = false;
		}
		private function removeFromArray(_a:Array,_ai:*):* {
			var _i:int=_a.indexOf(_ai);
			if (_i>=0) {
				return _a.splice(_i,1);
			}
		}
	}
}