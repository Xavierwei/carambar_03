package akdcl.manager {
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;

	import flash.geom.Point;

	import flash.utils.Timer;

	/**
	 * ...
	 * @author akdcl
	 */

	/// @eventType	flash.events.Event.RESIZE
	[Event(name="resize",type="flash.events.Event")]

	final public class WHManager extends BaseManager {
		baseManager static var instance:WHManager;
		public static function getInstance():WHManager {
			return createConstructor(WHManager) as WHManager;
		}
		
		public function WHManager() {
			super(this);
			
			targetList = [];
			resizeEvent = new Event(Event.RESIZE);
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onShowAllResizeHandler);
		}

		private static function sortAlignByTargetLevel(_align_1:Object, _align_2:Object):int {
			return getTargetLevel(_align_1.target) > getTargetLevel(_align_2.target) ? 1 : -1;
		}

		private static function getTargetLevel(_target:*):int {
			var _parent:* = _target.parent;
			var _level:int = 0;
			while (_parent){
				_parent = _parent.parent;
				_level++;
			}
			return _level;
		}

		public var maxStageWidth:int = int.MAX_VALUE;
		public var maxStageHeight:int = int.MAX_VALUE;

		private var timer:Timer;
		private var resizeEvent:Event;
		private var targetList:Array;
		private var tempPoint:Point = new Point();

		private var __aspectRatio:Number;

		public function get aspectRatio():Number {
			return __aspectRatio;
		}

		private var __originalAspectRatio:Number;

		public function get originalAspectRatio():Number {
			return __originalAspectRatio;
		}

		private var __left:Number;

		public function get left():Number {
			return __left;
		}

		private var __right:Number;

		public function get right():Number {
			return __right;
		}

		private var __top:Number;

		public function get top():Number {
			return __top;
		}

		private var __bottom:Number;

		public function get bottom():Number {
			return __bottom;
		}

		private var __scaleStage:Number;

		public function get scaleStage():Number {
			return __scaleStage;
		}

		private var __stageWidth:Number;

		public function get stageWidth():Number {
			return __stageWidth;
		}

		private var __stageHeight:Number;

		public function get stageHeight():Number {
			return __stageHeight;
		}

		private var __originalWidth:Number;

		public function get originalWidth():Number {
			return __originalWidth;
		}

		private var __originalHeight:Number;

		public function get originalHeight():Number {
			return __originalHeight;
		}

		private var __stage:Stage;

		public function get stage():Stage {
			return __stage;
		}

		public function set stage(_stage:Stage):void {
			if (__stage == _stage){
				return;
			}
			if (__stage){
				__stage.removeEventListener(Event.RESIZE, onNoScaleResizeHandler);
				timer.stop();
			}
			__stage = _stage;
			if (__stage){
				__originalWidth = __stage.getChildAt(0).loaderInfo.width;
				__originalHeight = __stage.getChildAt(0).loaderInfo.height;
				__originalAspectRatio = __originalWidth / __originalHeight;

				switch (__stage.scaleMode){
					case StageScaleMode.NO_SCALE:
						__stage.addEventListener(Event.RESIZE, onNoScaleResizeHandler);
						onNoScaleResizeHandler(null);
						break;
					case StageScaleMode.SHOW_ALL:
						timer.start();
						onShowAllResizeHandler(null);
						break;
					case StageScaleMode.NO_BORDER:
						break;
				}
			} else {
				
			}
		}

		public function register(_target:*, _x:int = 0, _y:int = 0):void {
			var _align:Object;
			var _alignID:int = targetList.indexOf(_target);
			if (_alignID < 0){
				_align = {};
				targetList.push(_align);
			}

			tempPoint.x = 0;
			tempPoint.y = 0;
			tempPoint = _target.localToGlobal(tempPoint);

			if (_x == 0){
				_align.fixX = 0;
			} else if (_x > 0){
				_align.fixX = originalWidth - tempPoint.x;
			} else {
				_align.fixX = 0 - tempPoint.x;
			}

			if (_y == 0){
				_align.fixY = 0;
			} else if (_y > 0){
				_align.fixY = originalHeight - tempPoint.y;
			} else {
				_align.fixY = 0 - tempPoint.y;
			}

			_align.alignX = _x;
			_align.alignY = _y;
			_align.target = _target;

			targetList.sort(sortAlignByTargetLevel);
			updateTarget(_align);
		}

		public function unregister(_target:*):void {
			var _alignID:int = targetList.indexOf(_target);
			if (_alignID >= 0){
				var _align:Object = targetList.splice(_alignID, 1);
				_align.target == null;
			}
		}

		public function updateTargets():void {
			for each (var _align:Object in targetList){
				updateTarget(_align);
			}
		}

		private function updateTarget(_align:Object):void {
			var _target:* = _align.target;

			if (_align.alignX == 0){
				tempPoint.x = 0;
			} else if (_align.alignX > 0) {
				tempPoint.x = __right;
			} else {
				tempPoint.x = __left;
			}

			if (_align.alignY == 0){
				tempPoint.y = 0;
			} else if (_align.alignY > 0){
				tempPoint.y = __bottom;
			} else {
				tempPoint.y = __top;
			}

			if (_target.parent){
				tempPoint = _target.parent.globalToLocal(tempPoint);
			}

			if (_align.alignX == 0){

			} else if (_align.alignX > 0){
				_target.x = tempPoint.x - _align.fixX;
			} else {
				_target.x = tempPoint.x - _align.fixX;
			}

			if (_align.alignY == 0){

			} else if (_align.alignY > 0){
				_target.y = tempPoint.y - _align.fixY;
			} else {
				_target.y = tempPoint.y - _align.fixY;
			}
		}

		private function onNoScaleResizeHandler(_e:Event):void {
			var _sW:uint = __stage.stageWidth;
			var _sH:uint = __stage.stageHeight;
			__aspectRatio = _sW / _sH;
			if (__aspectRatio > __originalAspectRatio){
				__scaleStage = _sH / originalHeight;
			} else {
				__scaleStage = _sW / originalWidth;
			}
			
			__stageWidth = Math.min(_sW, maxStageWidth);
			__stageHeight = Math.min(_sH, maxStageHeight);
			
			switch (__stage.align){
				case StageAlign.TOP_LEFT:
				case StageAlign.LEFT:
				case StageAlign.BOTTOM_LEFT:
					__left = 0;
					break;
				case StageAlign.TOP_RIGHT:
				case StageAlign.RIGHT:
				case StageAlign.BOTTOM_RIGHT:
					__left = originalWidth - stageWidth;
					break;
				default:
					__left = (originalWidth - stageWidth) * 0.5;
					break;
			}
			__right = __left + __stageWidth;

			switch (__stage.align){
				case StageAlign.TOP_LEFT:
				case StageAlign.TOP:
				case StageAlign.TOP_RIGHT:
					__top = 0;
					break;
				case StageAlign.BOTTOM_LEFT:
				case StageAlign.BOTTOM:
				case StageAlign.BOTTOM_RIGHT:
					__top = originalHeight - stageHeight;
					break;
				default:
					__top = (originalHeight - stageHeight) * 0.5;
					break;
			}
			__bottom = __top + __stageHeight;

			dispatchEvent(resizeEvent);
			updateTargets();
		}

		private function onShowAllResizeHandler(_e:Event):void {
			__stage.scaleMode = StageScaleMode.NO_SCALE;
			var _sW:uint = __stage.stageWidth;
			var _sH:uint = __stage.stageHeight;
			__aspectRatio = _sW / _sH;
			if (__aspectRatio > __originalAspectRatio){
				__scaleStage = _sH / originalHeight;
			} else {
				__scaleStage = _sW / originalWidth;
			}
			_sW = _sW / __scaleStage;
			_sH = _sH / __scaleStage;
			if (_sW != stageWidth || _sH != stageHeight){
				__stageWidth = Math.min(_sW, maxStageWidth);
				__stageHeight = Math.min(_sH, maxStageHeight);

				switch (__stage.align){
					case StageAlign.TOP_LEFT:
					case StageAlign.LEFT:
					case StageAlign.BOTTOM_LEFT:
						__left = 0;
						break;
					case StageAlign.TOP_RIGHT:
					case StageAlign.RIGHT:
					case StageAlign.BOTTOM_RIGHT:
						__left = originalWidth - stageWidth;
						break;
					default:
						__left = (originalWidth - stageWidth) * 0.5;
						break;
				}
				__right = __left + __stageWidth;

				switch (__stage.align){
					case StageAlign.TOP_LEFT:
					case StageAlign.TOP:
					case StageAlign.TOP_RIGHT:
						__top = 0;
						break;
					case StageAlign.BOTTOM_LEFT:
					case StageAlign.BOTTOM:
					case StageAlign.BOTTOM_RIGHT:
						__top = originalHeight - stageHeight;
						break;
					default:
						__top = (originalHeight - stageHeight) * 0.5;
						break;
				}
				__bottom = __top + __stageHeight;

				dispatchEvent(resizeEvent);
				updateTargets();
			}
			__stage.scaleMode = StageScaleMode.SHOW_ALL;
		}
	}

}