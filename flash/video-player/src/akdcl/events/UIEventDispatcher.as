package akdcl.events {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import akdcl.interfaces.IBaseObject;

	import akdcl.manager.LoggerManager;
	import akdcl.manager.EventManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class UIEventDispatcher extends EventDispatcher implements IBaseObject {
		protected static const lM:LoggerManager = LoggerManager.getInstance();
		protected static const evtM:EventManager = EventManager.getInstance();

		public var name:String;
		public var userData:Object;

		private var removed:Boolean;

		public function UIEventDispatcher(){
			super();
			init();
		}

		protected function init():void {
			lM.info(this, "init");
		}

		public final function remove():void {
			if (removed){
				return;
			}
			removed = true;
			onRemoveHandler();
		}

		protected function onRemoveHandler():void {
			lM.info(this, "remove");
			evtM.removeTargetEvents(this);
			userData = null;
			name = null;
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