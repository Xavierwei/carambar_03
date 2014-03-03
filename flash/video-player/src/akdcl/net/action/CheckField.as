package akdcl.net.action {
	import flash.events.FocusEvent;
	import flash.text.TextFieldAutoSize;

	import fl.controls.CheckBox;

	import akdcl.net.action.Field;
	import akdcl.utils.stringToBoolean;

	/**
	 * ...
	 * @author ...
	 */
	public class CheckField extends Field {
		private static const OFFY:int = 2;

		//Boolean
		override public function get data():* {
			return view.selected;
		}

		public function CheckField(_name:String) {
			super(_name);
		}

		override public function clear():void {
			view.selected = false;
			super.clear();
		}

		override protected function setView():void {
			super.setView();
			if (view){

			} else {
				view = new CheckBox();
			}

			if (options.attribute(RemoteAction.A_CONTENT).length() > 0){
				view.label = options.attribute(RemoteAction.A_CONTENT);
			} else if (options.elements(RemoteAction.A_CONTENT).length() > 0){
				view.label = options.elements(RemoteAction.A_CONTENT);
			} else {
				view.label = options.attribute(RemoteAction.A_LABEL);
			}

			view.textField.autoSize = TextFieldAutoSize.LEFT;

			view.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
			view.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);

			label.visible = false;
			view.x = x + style.widthLabel + 1;
			view.y = y;
			//view.height = style.height;
			height = style.height;
			container.addChild(view);

			setViewStyle();
		}
	}
}