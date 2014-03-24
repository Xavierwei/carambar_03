/***
SoundView
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月10日 12:13:18
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	import akdcl.utils.copyInstanceToArray;
	
	public class SoundView extends Sprite{
		
		private static const COUNTS_LINE:uint=7;
		//private static const DX_LINE:uint=2;
		
		public var clip_0:SoundViewLine;
		
		private var clipList:Array;
		private var moveDir:int;
		public var getMove:Function;
		
		public function SoundView(){
			clipList=[clip_0];
			moveDir=-4;
			copyInstanceToArray(clip_0,COUNTS_LINE,clipList,setLine);
		}
		private function onEnterFrameHandle(_evt:Event):void {
			if (getMove==null) {
			}else{
				moveDir=getMove();
			}
			for each (var _clip:SoundViewLine in clipList) {
				_clip.runStep(moveDir);
			}
		}
		public function run():void {
			addEventListener(Event.ENTER_FRAME,onEnterFrameHandle);
		}
		private function setLine(_line:SoundViewLine, _id:uint, ...args):void {
			addChild(_line);
			//_line.x=_id*DX_LINE;
			_line.x=_id*_line.width*2;//20130509
		}
	}
}