package akdcl.net.action {
	import flash.events.FocusEvent;

	import fl.controls.TextArea;

	import akdcl.net.action.Field;
	import akdcl.utils.stringToBoolean;

	/**
	 * ...
	 * @author ...
	 */
	public class TextAreaField extends Field {
		private static const OFFY:int = 2;

		override public function get data():* {
			return stringToBoolean(view.text) ? view.text : VALUE_UNINPUT;
		}

		public function TextAreaField(_name:String) {
			super(_name);
		}

		override public function clear():void {
			view.text = "";
			super.clear();
		}

		override protected function setView():void {
			super.setView();

			if (view){

			} else {
				view = new TextArea();
			}
			view.maxChars = int(options.attribute(A_MOST));
			if (stringToBoolean(options.attribute(A_RESTRICT))){
				view.restrict = String(options.attribute(A_RESTRICT));
			} else {
				view.restrict = null;
			}
			view.displayAsPassword = stringToBoolean(options.attribute(A_PASSWORD));

			view.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
			view.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);

			view.x = x + style.widthLabel + 1;
			view.y = y;
			view.width = style.width;
			view.height = int(options.style.@height) || style.height * 2;
			height = view.height;
			container.addChild(view);

			setViewStyle();
		}

		override protected function fixComponentTextY():void {
			super.fixComponentTextY();
			if (view){
				view.textField.y = OFFY;
			}
		}
	}

}