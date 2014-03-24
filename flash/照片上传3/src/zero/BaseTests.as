/***
BaseTests
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月21日 10:07:40
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class BaseTests{
		public function BaseTests(){
		}
		public function check(result1:*,result2:*):*{
			if(result1===result2){
				trace(result1);
				return result1;
			}
			throw new Error("\nresult1="+result1+"\nresult2="+result2);
		}
	}
}
		