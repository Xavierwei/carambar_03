/***
BtnFullScreen
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月10日 12:31:40
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
	
	public class BtnFullScreen extends Btn{
		public function BtnFullScreen(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		public function clear():void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			stage.removeEventListener(FullScreenEvent.FULL_SCREEN,updateSelectedByDisplayState);
		}
		private function added(...args):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			release=clickThis;
			updateSelectedByDisplayState();
			stage.addEventListener(FullScreenEvent.FULL_SCREEN,updateSelectedByDisplayState);
		}
		private function clickThis():void{
			selected=!selected;
			updateDisplayStateBySelected();
		}
		private function updateDisplayStateBySelected():void{
			if(selected){
				stage.displayState=StageDisplayState.FULL_SCREEN;
			}else{
				stage.displayState=StageDisplayState.NORMAL;
			}
		}
		private function updateSelectedByDisplayState(...ARGS):void{
			switch(stage.displayState){
				case StageDisplayState.FULL_SCREEN:
				case StageDisplayState.FULL_SCREEN_INTERACTIVE:
					selected=true;
				break;
				default:
					selected=false;
				break;
			}
		}
	}
}