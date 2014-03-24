package akdcl.net.action {
	import flash.events.FocusEvent;
	import flash.text.TextFieldAutoSize;

	import fl.controls.RadioButton;

	import akdcl.net.action.Field;
	import akdcl.utils.stringToBoolean;

	/**
	 * ...
	 * @author ...
	 */
	public class RadioButtonField extends Field {
		private static const OFFY:int = 2;

		//>=0(selectedIndex)
		override public function get data():* {
			var _radio:RadioButton;
			for (var _i:uint = 0; _i < view.length; _i++){
				_radio = view[_i];
				if (_radio.selected){
					return _i;
				}
			}
			return VALUE_UNSELECT;
		}

		public function RadioButtonField(_name:String) {
			super(_name);
		}
		
		override public function clear():void {
			//view[0].group.selectedData = null;
			super.clear();
		}

		override protected function setView():void {
			super.setView();
			if (view){

			} else {
				view = new Array();
			}
			var _idY:uint = 0;
			for each (var _eachXML:XML in options.elements(RemoteAction.E_CASE)){
				var _id:uint = _eachXML.childIndex();
				var _radio:RadioButton;
				
				if (view[_id]){
					_radio = view[_id];
				} else {
					_radio = new RadioButton();
					view[_id] = _radio;
				}
				_radio.groupName = String(options.attribute(RemoteAction.A_NAME));
				_radio.label = String(_eachXML.attribute(RemoteAction.A_LABEL));
				_radio.textField.autoSize = TextFieldAutoSize.LEFT;
				_radio.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
				_radio.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);

				container.addChild(_radio);
				_radio.drawNow();
				_idY = setEachItem(_radio, _id, _idY);
				_radio.height = style.height;
			}
			height = _radio.y + _radio.height - view[0].y;

			setViewStyle();
		}
	}

}