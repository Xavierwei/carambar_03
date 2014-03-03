/***
Skin
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月21日 18:30:55
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	
	import ui.Btn;
	
	import zero.ui.Slider;

	public class Skin extends Sprite{
		
		public var bottom:Sprite;
		public var buffClip:MovieClip;
		public var btnPlay:Btn;
		public var btnPause:Btn;
		public var btnStop:Btn;
		public var slider:Slider;
		public var timeTxt:Sprite;
		public var volCtrl:VolCtrl;
		public var btnFullScreen:Btn;
		
		private var timeTxt_x0:int;
		private var volCtrl_x0:int;
		private var btnFullScreen_x0:int;
		
		public var ty:Number;
		public function Skin(){
			
			if(buffClip){
				buffClip.stop();
			}
			
			if(timeTxt){
				timeTxt["txt"].autoSize=TextFieldAutoSize.RIGHT;
			}
			
			if(btnFullScreen){
				btnFullScreen["gra"].gotoAndStop(1);
			}
			
			if(timeTxt){
				timeTxt_x0=timeTxt.x;
			}
			if(volCtrl){
				volCtrl_x0=volCtrl.x;
			}
			if(btnFullScreen){
				btnFullScreen_x0=btnFullScreen.x;
			}
			
		}
		
		public function clear():void{
			
			if(buffClip){
				buffClip.stop();
			}
			
			if(slider){
				slider.clear();
			}
			
			if(volCtrl){
				volCtrl.clear();
			}
			
		}
		
		public function setWid(wid0:int,wid:int):void{
			if(bottom){
				bottom.width=wid;
			}
			if(slider){
				var sliderDWid:int=0;
				if(volCtrl){
					if(wid<360){
						if(volCtrl.volBtn){
							volCtrl.volBtn.visible=false;
							sliderDWid+=volCtrl.volBtn.width+6;
						}
					}else{
						if(volCtrl.volBtn){
							volCtrl.volBtn.visible=true;
						}
					}
				}
				if(timeTxt){
					if(wid<200){
						timeTxt.visible=false;
						sliderDWid+=timeTxt.width+6;
					}else{
						timeTxt.visible=true;
					}
				}
				
				if(btnFullScreen){
					btnFullScreen.x=wid-(wid0-btnFullScreen_x0);
				}
				if(volCtrl){
					if(volCtrl.volBtn){
						if(volCtrl.volBtn.visible){
							volCtrl.x=wid-(wid0-volCtrl_x0);
						}else{
							volCtrl.x=wid-(wid0-volCtrl_x0)+volCtrl.volBtn.width+6;
						}
					}else{
						volCtrl.x=wid-(wid0-volCtrl_x0);
					}
				}
				if(timeTxt){
					if(volCtrl){
						timeTxt.x=volCtrl.x-(volCtrl_x0-timeTxt_x0);
					}else{
						timeTxt.x=wid-(wid0-timeTxt_x0);
					}
				}
				slider.wid=slider.wid0+(wid-wid0)+sliderDWid;
				if(slider.wid<20){
					slider.visible=false;
				}else{
					slider.visible=true;
				}
			}
		}
		
	}
}