package akdcl.display {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import flash.events.Event;
	
	import akdcl.interfaces.IBaseObject;
	
	import akdcl.manager.LoggerManager;
	import akdcl.manager.EventManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class UISprite extends Sprite implements IBaseObject {
		protected static const lM:LoggerManager = LoggerManager.getInstance();
		protected static const evtM:EventManager = EventManager.getInstance();
		
		public static var stageInstance:Stage;
		
		public var userData:Object;
		
		private var __enabled:Boolean;
		public function get enabled():Boolean {
			return __enabled;
		}
		public function set enabled(_enabled:Boolean):void {
			__enabled = _enabled;
			mouseEnabled = mouseChildren = __enabled;
		}
		
		private var __autoRemove:Boolean;
		public function get autoRemove():Boolean {
			return __autoRemove;
		}
		public function set autoRemove(_autoRemove:Boolean):void {
			if (__autoRemove == _autoRemove){
				return;
			}
			__autoRemove = _autoRemove;
			
			if (__autoRemove){
				addEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			} else {
				removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			}
			setChildrenAutoRemove(__autoRemove);
		}
		
		private var removed:Boolean;

		public function UISprite() {
			super();
			init();
		}

		protected function init():void {
			__enabled = true;
			__autoRemove = true;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}

		protected function onAddedToStageHandler(_evt:Event):void {
			lM.info(this, Event.ADDED_TO_STAGE + " parent is " + parent + parent.name);
			if (!stageInstance) {
				stageInstance = stage;
			}
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			if (autoRemove){
				addEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			}
		}

		private function onRemoveToStageDelayHandler(_evt:Event):void {
			if (stage && stage.focus == this) {
				stage.focus = null;
			}
			addEventListener(Event.EXIT_FRAME, onRemoveToStageDelayHandler);
			if (_evt.type == Event.EXIT_FRAME){
				removeEventListener(Event.EXIT_FRAME, onRemoveToStageDelayHandler);
				if (stage){
					return;
				}
				onRemoveHandler();
			}
		}

		protected function onRemoveHandler():void {
			lM.info(this, "remove");
			removed = true;
			//removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveToStageDelayHandler);
			evtM.removeTargetEvents(this);
			__removeChildren();
			scrollRect = null;
			mask = null;
			hitArea = null;
			contextMenu = null;
			userData = null;
		}

		public final function remove():void {
			if (removed) {
				return;
			}
			if (!stage) {
				removed = true;
				visible = false;
				stageInstance.addChild(this);
			}
			autoRemove = true;
			parent.removeChild(this);
		}

		private function __removeChildren():void {
			var _length:uint = numChildren;
			var _children:*;
			for (var _i:int = _length; _i >= 0; _i--){
				try {
					_children = getChildAt(_i);
				} catch (_ero:*){
				}
				if (_children && contains(_children)){
					if (_children is MovieClip){
						_children.stop();
					}
					removeChild(_children);
				}
			}
		}

		private function setChildrenAutoRemove(_autoRemove:Boolean):void {
			var _displayContent:*;
			for (var _i:uint = 0; _i < numChildren; _i++){
				_displayContent = getChildAt(_i);
				if ("autoRemove" in _displayContent){
					_displayContent["autoRemove"] = _autoRemove;
				}
			}
		}

		override public function addEventListener(_type:String, _listener:Function, _useCapture:Boolean = false, _priority:int = 0, _useWeakReference:Boolean = false):void {
			super.addEventListener(_type, _listener, _useCapture, _priority, false);
			evtM.addEvent(_type, _listener, this);
		}

		override public function removeEventListener(_type:String, _listener:Function, _useCapture:Boolean = false):void {
			super.removeEventListener(_type, _listener, _useCapture);
			evtM.removeEvent(_type, _listener, this);
		}
	}
}