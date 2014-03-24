/***
LayoutMode
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月22日 09:12:50
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	
	/**
	 * 
	 * 布局模式们
	 * 
	 */	
	public class LayoutMode{
		
		/**
		 * 固定；初始，调整窗口，全屏，退出全屏时都为初始布局 ，适用于音乐播放器
		 */		
		public static const FIXED:String="fixed";
		
		/**
		 * 嵌入；初始，调整窗口时为初始布局 ，全屏时撑满屏幕，退出全屏时为初始布局，适用于嵌入到其它项目中的视频播放器
		 */		
		public static const EMBEDDED:String="embedded";
		
		/**
		 * 独立；初始，调整窗口，全屏，退出全屏时都撑满屏幕 ，适用于独立播放器
		 */		
		public static const STAND_ALONE:String="standAlone";
		
	}
}