package ui.manager
{
	import flash.text.Font;
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class FontManager 
	{
		public static function getFontList(_enumerateDeviceFonts:Boolean = true):Array {
			var _fontList:Array = Font.enumerateFonts(_enumerateDeviceFonts);
			_fontList.sortOn("fontName", Array.CASEINSENSITIVE);
			return _fontList;
		}
	}
	
}