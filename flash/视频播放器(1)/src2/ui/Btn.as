package ui {
	import flash.events.Event;
	import flash.external.ExternalInterface;

	import akdcl.manager.ButtonManager;
	import akdcl.net.gotoURL;
	
	import akdcl.events.UIEvent;
	import akdcl.display.UIMovieClip;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Btn extends UIMovieClip {
		private static const bM:ButtonManager = ButtonManager.getInstance();
		
		public var rollOver:Function;
		public var rollOut:Function;
		public var press:Function;
		public var release:Function;
		public var select:Function;

		public var area:*;
		public var hrefTarget:String = "_blank";
		
		private var __href:Object;
		public function get href():Object 
		{
			return __href;
		}
		public function set href(_value:Object):void {
			__href = _value;
			if (__href) {
				addEventListener(UIEvent.RELEASE, onReleaseHandler);
			}else {
				removeEventListener(UIEvent.RELEASE, onReleaseHandler);
			}
		}

		private var __group:String;
		public function get group():String {
			return __group;
		}
		public function set group(_group:String):void {
			if (__group && _group == __group){
				return;
			}
			if (__group){
				bM.removeFromGroup(__group, this);
			}
			__group = _group;
			if (__group){
				bM.addToGroup(__group, this);
			}
		}

		private var __selected:Boolean;
		public function get selected():Boolean {
			return __selected;
		}
		public function set selected(_selected:Boolean):void {
			if (__selected == _selected){
				return;
			}
			__selected = _selected;
			if (__group){
				if (__selected){
					if (bM.selectItem(__group, this)){
					} else {
						return;
					}
				} else {
					bM.unselectItem(__group, this);
				}
			}
			bM.setButtonStyle(this);
			if (select != null){
				select();
			}
		}

		override public function set enabled(_enabled:Boolean):void {
			__enabled = _enabled;
			buttonMode = mouseEnabled = __enabled;
		}

		override protected function init():void {
			super.init();
			buttonMode = true;
			stop();
		}

		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			bM.addButton(this);
			if (area){
				var _length:uint = area.numChildren;
				for (var _i:uint; _i < _length; _i++){
					area.getChildAt(_i).visible = false;
				}
				hitArea = area;
			}
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			group = null;
			bM.removeButton(this);
			
			rollOver = null;
			rollOut = null;
			press = null;
			release = null;
			select = null;

			hrefTarget = null;
			area = null;
			__href = null;
		}

		private function onReleaseHandler(_e:UIEvent):void {
			if (__href) {
				gotoURL(__href, hrefTarget);
			}
		}
	}

}