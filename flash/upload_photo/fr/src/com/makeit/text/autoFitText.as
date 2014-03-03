package com.makeit.text
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author ...
	 */
	public class autoFitText
	{
		public static var myWidth:int=0;
		public static var myHeight:int = 0;
		private static var textField:TextField;
		public function autoFitText()
		{
		}
		public static function autoTextField(_w:Number, _h:Number, txt:TextField):Boolean
		{
			var ifDisplayAll:Boolean = true;
			myWidth = _w;
			myHeight = _h;
			textField = txt;
			var _text:String = textField.text;
			if (myHeight > textField.textHeight)
			{
				ifDisplayAll = false;
			}
			else
			{
				textField.width = myWidth;
				textField.autoSize = "left";
				textField.wordWrap = true;
				textField.multiline=true
				ifDisplayAll = true;
				var percent:Number = myHeight / textField.textHeight;
				var displayLength = Math.floor(textField.text.length * percent);
				var showText:String = textField.text.slice(0, (displayLength - 3) < 0?0:(displayLength - 3));
				showText += "...";
				textField.text = showText;
			}
			return(ifDisplayAll);
		}
	}
}