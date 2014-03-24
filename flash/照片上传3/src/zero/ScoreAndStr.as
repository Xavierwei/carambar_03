/***
ScoreAndStr 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月17日 16:36:32
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class ScoreAndStr{
		public static function score2str(score:int):String{
			var str:String="";
			for each(var c:String in score.toString().split("")){
				str+=c;
				var i:int=int(Math.random()*3)+1;
				while(--i>=0){
					str+="\x01";
				}
			}
			return str;
		}
	}
}

