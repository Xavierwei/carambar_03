/***
GotoURL 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月27日 21:25:27
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.external.*;
	
	import akdcl.net.gotoURL;
	public class GotoURL{
		public static function goto(xml:XML,replaceStrObj:Object=null):void{
			var jsStr:String=xml.@js.toString();
			if(jsStr){
				ExternalInterface.call("eval",ReplaceVars.replace(jsStr,replaceStrObj));
				return;
			}
			var urlStr:String=xml.@url.toString()||xml.@href.toString();
			if(urlStr){
				gotoURL(ReplaceVars.replace(urlStr,replaceStrObj),xml.@target.toString());
			}
		}
	}
}

