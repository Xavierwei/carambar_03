/***
GroupStringTests
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月25日 14:33:54
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class GroupStringTests extends BaseTests{
		public function GroupStringTests(){
			var str:String;
			
			str="param0:[Multiname][\\[\\[\\[,yyy,zzz].DisplayObject,param1:flash.display.DisplayObject";
			var arr:Array=GroupString.separate(GroupString.escape(str));
			check(arr[0],"param0:[Multiname][\\x5b\\x5b\\x5b,yyy,zzz].DisplayObject");
			check(arr[1],"param1:flash.display.DisplayObject");
			
			str="[]<>(){}\t\\[\\]\\<\\>\\(\\)\\{\\}";
			check(str,"[]<>(){}	\\[\\]\\<\\>\\(\\)\\{\\}");
			str=GroupString.escape(str);
			check(str,"[]<>(){}	\\x5b\\x5d\\x3c\\x3e\\x28\\x29\\x7b\\x7d");
			str=GroupString.escape(str);
			check(str,"[]<>(){}	\\x5b\\x5d\\x3c\\x3e\\x28\\x29\\x7b\\x7d");
			str=GroupString.unescape(str);
			check(str,"[]<>(){}	\\[\\]\\<\\>\\(\\)\\{\\}");
			str=GroupString.unescape(str);
			check(str,"[]<>(){}	\\[\\]\\<\\>\\(\\)\\{\\}");
			
			str="\b\t\n\v\f\r";
			check(str,"	\n\r");
			str=GroupString.escape(str);
			check(str,"	\n\r");
			str=GroupString.escape(str);
			check(str,"	\n\r");
			str=GroupString.unescape(str);
			check(str,"	\n\r");
			str=GroupString.unescape(str);
			check(str,"	\n\r");
			
			str="\\\\[";
			str=GroupString.escape(str);
			check(str,"\\\\[");
			str="\\\\x5b";
			str=GroupString.unescape(str);
			check(str,"\\\\x5b");
		}
	}
}
		