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
	public class CheckBoxField extends Field {
		private static const OFFY:int = 2;

		//Array(uint or String)
		override public function get data():* {
			var _check:CheckBox;
			var _list:Array = [];
			for (var _i:uint = 0; _i < view.length; _i++){
				_check = view[_i];
				if (_check.selected){
					//还要判断自定义字符串的情况
					_list.push(_i);
				}
			}
			return _list.length > 0 ? _list : VALUE_UNSELECT;
		}
		
		public function CheckBoxField(_name:String) {
			super(_name);
		}

		override public function clear():void {
			for each(var _check:CheckBox in view) {
				_check.selected = false;
			}
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
				var _check:CheckBox;

				if (view[_id]){
					_check = view[_id];
				} else {
					_check = new CheckBox();
					view[_id] = _check;
				}
				_check.label = String(_eachXML.attribute(RemoteAction.A_LABEL));
				_check.textField.autoSize = TextFieldAutoSize.LEFT;
				_check.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
				_check.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);

				container.addChild(_check);
				_check.drawNow();
				_idY = setEachItem(_check, _id, _idY);
				_check.height = style.height;
			}
			height = _check.y + _check.height - view[0].y;

			setViewStyle();
		}
	}

}