package akdcl.net.action {
	import flash.events.Event;
	import flash.events.FocusEvent;

	import fl.controls.ComboBox;

	import akdcl.net.action.Field;
	import akdcl.utils.stringToBoolean;

	/**
	 * ...
	 * @author ...
	 */
	public class ComboxField extends Field {
		private static const OFFY:int = 2;

		//>=0(selectedIndex),String(custom)
		override public function get data():* {
			if (view.selectedItem){
				__data = view.selectedIndex;
			} else if (view.editable){
				if (stringToBoolean(view.text) && view.text != view.prompt){
					__data = view.text;
				} else {
					__data = VALUE_UNINPUT;
				}
			} else {
				__data = VALUE_UNSELECT;
			}
			return __data;
		}

		override public function get orgData():* {
			return options.elements(RemoteAction.E_CASE)[view.selectedIndex];
		}

		public function ComboxField(_name:String) {
			super(_name);
		}
		
		override public function clear():void {
			view.selectedItem = null;
			super.clear();
		}

		override protected function setView():void {
			super.setView();
			if (view){

			} else {
				view = new ComboBox();
			}
			view.removeAll();
			view.rowCount = int(options.attribute(A_ROW_COUNT)) || view.rowCount;
			view.prompt = options.attribute(A_PROMPT)[0] || "请选择";
			view.editable = stringToBoolean(options.attribute(A_EDITABLE));
			for each (var _eachXML:XML in options.elements(RemoteAction.E_CASE)){
				view.addItem({label: _eachXML.attribute(RemoteAction.A_LABEL)});
			}

			view.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
			view.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
			view.addEventListener(Event.CHANGE, onChangeHandler);

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

		override protected function onBlendFieldChangeHandler(_e:Event):void {
			options[RemoteAction.E_CASE] = blendField.orgData[RemoteAction.E_CASE];
			setView();
		}
	}

}