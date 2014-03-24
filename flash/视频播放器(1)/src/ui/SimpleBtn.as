package ui {
	import flash.events.Event;
	
	import akdcl.manager.ButtonManager;

	import akdcl.display.UISprite

	/**
	 * ...
	 * @author Akdcl
	 */
	public class SimpleBtn extends UISprite {
		private static const bM:ButtonManager = ButtonManager.getInstance();
		
		public var rollOver:Function;
		public var rollOut:Function;
		public var press:Function;
		public var release:Function;

		override public function set enabled(_enabled:Boolean):void {
			super.enabled = _enabled;
			buttonMode = _enabled;
		}
		
		override protected function init():void 
		{
			super.init();
			buttonMode = true;
		}

		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			bM.addButton(this);
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			bM.removeButton(this);
			rollOver = null;
			rollOut = null;
			press = null;
			release = null;
		}
	}

}