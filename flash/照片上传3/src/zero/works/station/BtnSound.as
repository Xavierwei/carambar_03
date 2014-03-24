/***
BtnSound
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月10日 12:27:51
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	public class BtnSound extends Btn{
		public var soundView:SoundView;
		public function BtnSound(){
			//selected=true;
			if(soundView){
				soundView.getMove=function():int{
					return selected?4:-4;
				}
				soundView.run();
			}
		}
	}
}