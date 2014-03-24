/***
ProgressMovie
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年1月9日 10:41:34
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.utils.*;
	
	public class ProgressMovie extends Sprite{
		
		public var txt:TextField;
		
		public var progressClip:MovieClip;
		
		private var onHideComplete:Function;
		
		public function ProgressMovie(){
			this.mouseEnabled=this.mouseChildren=false;
			this.alpha=0;
			txt.autoSize=TextFieldAutoSize.CENTER;
			
			stopAll(progressClip);
		}
		
		private var __value:Number;
		public function get value():Number{
			return __value;
		}
		public function set value(_value:Number):void{
			__value=_value;
			txt.text=int(__value*100)+" %";
			//trace("txt.text="+txt.text);
		}
		
		public function setValue(_value:Number):void{
			value=_value;
		}
		
		public function show(_value:Number=0):void{
			value=_value;
			this.removeEventListener(Event.ENTER_FRAME,hideRun);
			this.addEventListener(Event.ENTER_FRAME,showRun);
			playAll(progressClip);
		}
		private function showRun(event:Event):void{
			if((this.alpha+=0.1)>0.95){
				this.alpha=1;
				this.removeEventListener(Event.ENTER_FRAME,showRun);
			}
		}
		public function hide(_onHideComplete:Function):void{
			onHideComplete=_onHideComplete;
			this.removeEventListener(Event.ENTER_FRAME,showRun);
			this.addEventListener(Event.ENTER_FRAME,hideRun);
			stopAll(progressClip);
		}
		private function hideRun(event:Event):void{
			if((this.alpha-=0.1)<0.05){
				this.alpha=0;
				this.removeEventListener(Event.ENTER_FRAME,hideRun);
				if(onHideComplete==null){
				}else{
					onHideComplete();
					onHideComplete=null;
				}
			}
		}
	}
}