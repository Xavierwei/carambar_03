package ui.manager {
	import fl.managers.StyleManager;

	import fl.controls.listClasses.CellRenderer;
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.Label;
	import fl.controls.RadioButton;
	import fl.controls.TextArea;
	import fl.controls.TextInput;

	import flash.text.TextFormat;

	/**
	 * ...
	 * @author Akdcl
	 */
	final public class FLManager {
		private static const TEXT_FORMAT:String = "textFormat";
		private static var textFormat:TextFormat = new TextFormat();
		private static var textFormatDic:Object = { };

		public static function setTextFormat(_size:uint, _color:uint = 0x000000, _font:String = "宋体", _leading:uint = 3):void {
			textFormat.font = _font;
			textFormat.size = _size;
			textFormat.color = _color;
			textFormat.leading = _leading;

			StyleManager.setComponentStyle(CellRenderer, TEXT_FORMAT, textFormat);
			
			StyleManager.setComponentStyle(Button, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(CheckBox, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(ComboBox, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(Label, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(RadioButton, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(TextArea, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(TextInput, TEXT_FORMAT, textFormat);
		}

		public static function setTextFormatTo(_class:String, _size:uint, _color:uint = 0x000000, _font:String = "宋体", _leading:uint = 3):void {
			var _textFormat:TextFormat = textFormatDic[_class];
			if (!textFormatDic[_class]) {
				_textFormat = new TextFormat();
				textFormatDic[_class] = _textFormat;
			}
			_textFormat.font = _font;
			_textFormat.size = _size;
			_textFormat.color = _color;
			_textFormat.leading = _leading;

			switch (_class){
				case "Label":
					StyleManager.setComponentStyle(Label, TEXT_FORMAT, _textFormat);
					break;
				case "Button":
					StyleManager.setComponentStyle(Button, TEXT_FORMAT, _textFormat);
					break;
				case "ComboBox":
					//StyleManager.setComponentStyle(CellRenderer, TEXT_FORMAT, _textFormat);
					StyleManager.setComponentStyle(ComboBox, TEXT_FORMAT, _textFormat);
					StyleManager.setComponentStyle(TextInput, TEXT_FORMAT, _textFormat);
					break;
				case "CheckBox":
					StyleManager.setComponentStyle(CheckBox, TEXT_FORMAT, _textFormat);
					break;
				case "RadioButton":
					StyleManager.setComponentStyle(RadioButton, TEXT_FORMAT, _textFormat);
					break;
				case "TextArea":
					StyleManager.setComponentStyle(TextArea, TEXT_FORMAT, _textFormat);
					break;
				case "TextInput":
					StyleManager.setComponentStyle(TextInput, TEXT_FORMAT, _textFormat);
					break;
			}
		}
	}

}