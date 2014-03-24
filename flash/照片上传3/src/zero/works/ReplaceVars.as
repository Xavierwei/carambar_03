/***
ReplaceVars 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月16日 09:42:54
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class ReplaceVars{
		public static function replace(str:String,replaceStrObj:Object):String{
			for(var i:String in replaceStrObj){
				//trace("i="+i);
				str=str.split("${"+i+"}").join(replaceStrObj[i]);
			}
			//trace("--------------------");
			//trace("str="+str);
			return str;
		}
	}
}

