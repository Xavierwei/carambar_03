/***
SoundViewLine
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月10日 12:19:13
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import akdcl.display.UISprite;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class SoundViewLine extends UISprite{
		
		public var maskedClip:Sprite;
		public var maskClip:Sprite;
		public var moveClip:Sprite;
		
		private var time:Number;
		private var sp:Number;
		private var time_delay:Number;
		private var nT:Number;
		
		public function SoundViewLine(){
			time = 0;
			sp = 0;
			time_delay = 10;
			nT = 0;
			maskedClip.mask=maskClip;
			maskClip.scaleY = 0;
			moveClip.y = 0;
		}
		public function runStep(_nT:Number):void {
			nT += _nT;
			if (nT>99) {
				nT = 99;
			} else if (nT<0) {
				nT = 0;
			}
			time>=0 ? time++ : (time=0);
			if (time%2 == 0) {
				maskClip.height = int((Math.random()*nT+1)*0.1);
			}
			if (-maskClip.height<=moveClip.y) {
				sp = 0;
				time_delay = 2;
				moveClip.y = -maskClip.height;
			} else {
				if (time_delay>0) {
					time_delay--;
				} else {
					moveClip.y += sp;
					if (-maskClip.height<=moveClip.y) {
						moveClip.y = -maskClip.height;
					}
					moveClip.y = int(moveClip.y);
					sp += 0.3;
				}
			}
		}
	}
}