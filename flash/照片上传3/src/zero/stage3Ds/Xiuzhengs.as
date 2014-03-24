/***
Xiuzhengs
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月19日 10:49:33
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class Xiuzhengs{
		
		public static const d:int=1;//给左上右下至少留d像素的透明像素，以便 clamp 取样到达边界时能正确的获取透明像素
		
		//uv修正，以便对付当 u=1 或 v=1 时的一些情况
		//public static const uvxiuzheng:Number=0;//不修正
		//public const uvxiuzheng:Number=-0.00001;//公司的电脑没问题，家里的电脑不行
		public static const uvxiuzheng:Number=-0.01;//家里的电脑没问题
		
	}
}