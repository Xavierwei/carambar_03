/***
StringUtil
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月27日 19:14:02
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class StringUtil{
		public static function formatString(str:String,len:int):String{
			if(getStringLength(str)>len){
				while(getStringLength(str+"…")>len){
					str=str.substr(0,str.length-1);
				}
				return str+"…";
			}
			return str;
		}
		public static function isChinese(char:String):Boolean
		{
			var code:String = char.charCodeAt(0).toString(16);
			var unicode:Number = parseInt(code, 16);
			if (unicode > 0x80)
			{
				return true;
			}
			return false;
		}
		public static function getStringLength(str:String):int
		{
			var len:int = 0;
			var char:String;
			for (var i:int = 0; i < str.length; i++)
			{
				char = str.charAt(i);
				if (isChinese(char))
				{
					len += 2;
				}
				else
				{
					len += 1;
				}
			}
			return len;
		}

	}
}