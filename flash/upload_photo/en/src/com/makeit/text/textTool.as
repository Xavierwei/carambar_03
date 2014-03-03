package com.makeit.text
{
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author ...
	 */
	public class textTool
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
				textField.multiline=true;
				ifDisplayAll = true;
				var percent:Number = myHeight / textField.textHeight;
				var displayLength = Math.floor(textField.text.length * percent);
				var showText:String = textField.text.slice(0, (displayLength - 3) < 0?0:(displayLength - 3));
				showText += "...";
				textField.text = showText;
			}
			return(ifDisplayAll);
		}
		public static function setMaxChars(txtField:TextField, maxlimit:uint,callBack:Function=null):void {
			txtField.addEventListener(Event.CHANGE,function() {	
						getTXTChars(txtField);
					}
				);
			var count:uint=getTXTChars(txtField);
			var str:String=txtField.text;
			if (count >= maxlimit) {
					txtField.text = str.substring(0,maxlimit);
			}
		}
		public static function getTXTChars(txtField:TextField,callBack:Function=null):uint{
			var counts:Number = 0;
			var str:String = txtField.text;
			var length:uint=0;
			for (var i = 0; i < str.length; i++) {
				var strTemp:String = escape(str.charAt(i));
				if(strTemp.indexOf("%u",0) == -1){
					counts+=.5;
				}else{
					counts+=1;
				}
				length=txtField.length;
				/*
				if (counts >= maxlimit) {
						txtField.text = str.substring(0,i+1);
						break;
				}
				 * 
				 */
			}	
//			if(callBack!=null){
//				callBack.call(null,counts);
//			}
			return counts;
		
		}
		public static function setMaxLine(txtField:TextField, maxLine:uint):void {
			var str:String;
			txtField.addEventListener(Event.CHANGE,function() {	
						if (txtField.numLines > maxLine) {
							txtField.text =str;
							return;
						}
						str=txtField.text;
					}
				)
			
			
		}
	}
}