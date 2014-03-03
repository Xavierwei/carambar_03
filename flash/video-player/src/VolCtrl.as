/***
VolCtrl
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月04日 12:03:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	import ui.Slider;
	
	public class VolCtrl extends Sprite{
		
		private var volMaskShapeWid0:int;
		
		private var onUpdateVol:Function;
		
		public var laba:Btn;
		public var volBtn:Slider;
		private var volume:Number;
		
		internal var on:Boolean;
		private var oldVolume:Number;
		
		public function VolCtrl()
		{
			on=true;
			init(1,null);
		}
		
		public function init(_volume:Number,_onUpdateVol:Function):void{
			volume=_volume;
			clear();
			laba.release=clickLaba;
			if(volMaskShapeWid0>0){
			}else{
				if(volBtn)
				{
					volBtn.maximum = 1;
					volBtn.snapInterval = 0.01;
					volBtn.change = ctrlVol;
				}
			}
			updateBtnVol();
			onUpdateVol=_onUpdateVol;
		}
		
		public function clear():void
		{
			onUpdateVol=null;
		}
		
		internal function _ctrlVol(value:Number):void{
			volume = value;
			
			if(volBtn){
				if(volBtn.isHold)
				{
					on=true;
				}
			}
			
			updateBtnVol();
		}
		
		private function ctrlVol(value:Number):void
		{
			_ctrlVol(value);
			
			if(onUpdateVol==null){
			}else{
				onUpdateVol(volume);
			}
		}
		
		private function updateBtnVol():void{
			if(volBtn)
			{
				volBtn.value = volume;
			}
			
			if(laba.hasOwnProperty("gra")){
				if(laba["gra"].totalFrames>1){
					if(volume>0){
						laba["gra"].gotoAndStop(2+int((laba["gra"].totalFrames-2)*volume));
					}else{
						laba["gra"].gotoAndStop(1);
					}
				}
			}
		}
		
		private function clickLaba():void{
			if(on){
				oldVolume=volume;
				volume=0;
				on=false;
			}else{
				volume=oldVolume;
				on=true;
			}
			//trace("on="+on);
			//trace("oldVolume="+oldVolume);
			//trace("volume="+volume);
			updateBtnVol();
			if(onUpdateVol==null){
			}else{
				onUpdateVol(volume);
			}
		}
		
	}
}