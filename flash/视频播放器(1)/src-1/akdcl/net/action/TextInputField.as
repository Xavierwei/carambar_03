package akdcl.net.action {
	import flash.events.FocusEvent;

	import fl.controls.TextInput;

	import akdcl.net.action.Field;
	import akdcl.utils.stringToBoolean;

	/**
	 * ...
	 * @author ...
	 */
	public class TextInputField extends Field {
		private static const OFFY:int = 2;
		
		override public function get data():* {
			return stringToBoolean(view.text) ? view.text : VALUE_UNINPUT;
		}
		
		override public function set data(_data:*):void{
			view.text=_data;
		}

		public function TextInputField(_name:String) {
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
				view = new TextInput();
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
			view.height = style.height;
			height = style.height;
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