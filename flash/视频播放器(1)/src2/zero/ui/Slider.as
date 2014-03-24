/***
Slider
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月10日 14:22:09
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
	
	import ui.Btn;
	
	public class Slider extends Sprite{
		
		public var wid0:Number;
		private var bottomWid0:Number;
		
		private var __value:Number;
		private var __value2:Number;
		private var __wid:Number;
		
		public var bottom:Sprite;
		public var bar:Btn;
		public var line:Sprite;
		public var line2:Sprite;
		public var thumb:Btn;
		
		public var onUpdate:Function;
		
		public var ctrling:Boolean;
		
		public var immediately:Boolean;
		private var timeoutId:int;
		
		public function get value():Number{
			return __value;
		}
		public function set value(_value:Number):void{
			__value=_value;
			if(__value>=0&&__value<=1){
			}else if(__value>1){
				__value=1;
			}else{
				__value=0;
			}
			thumb.x=line.width=int(bar.width*__value);
		}
		
		public function get value2():Number{
			return __value2;
		}
		public function set value2(_value2:Number):void{
			__value2=_value2;
			if(line2){
				line2.width=int(bar.width*_value2);
			}
		}
		
		public function get wid():Number{
			//trace("__wid="+__wid);
			return __wid;
		}
		public function set wid(_wid:Number):void{
			//trace("_wid="+_wid);
			bar["gra"].gra.width=_wid;
			if(bottom){
				bottom.width=bottomWid0+_wid-wid0;
			}
			__wid=_wid;
			value2=value2;
		}
		
		public function Slider(){
			immediately=true;
			value=0;
			value2=0;
			wid0=__wid=bar["gra"].gra.width;
			if(bottom){
				bottomWid0=bottom.width;
			}
			bar.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			thumb.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			line.mouseEnabled=line.mouseChildren=false;
			if(line2){
				line2.mouseEnabled=line2.mouseChildren=false;
			}
			this.mouseEnabled=false;
		}
		public function clear():void{
			clearTimeout(timeoutId);
			mouseUp();
			bar.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			thumb.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			onUpdate=null;
		}
		private function mouseDown(event:MouseEvent):void{
			if(event.target==thumb){
			}else{
				thumb.x=this.mouseX;
			}
			thumb.startDrag(false,new Rectangle(0,thumb.y,bar.width,0));
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			this.addEventListener(Event.ENTER_FRAME,update);
			ctrling=true;
			updateDelay();
		}
		private function mouseUp(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			this.removeEventListener(Event.ENTER_FRAME,update);
			stopDrag();
			updateDelay(true);
			ctrling=false;
		}
		private function update(...args):void{
			var oldValue:Number=value;
			value=thumb.x/bar.width;
			if(oldValue==value){
			}else{
				if(immediately){
					updateDelay();
				}else{
					clearTimeout(timeoutId);
					timeoutId=setTimeout(updateDelay,100);
				}
			}
		}
		private function updateDelay(isRelease:Boolean=false):void{
			clearTimeout(timeoutId);
			if(onUpdate==null){
			}else{
				if(onUpdate.length==1){
					onUpdate(isRelease);
				}else{
					onUpdate();
				}
			}
		}
		
	}
}