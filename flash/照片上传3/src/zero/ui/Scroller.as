/***
Scroller
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年7月18日 18:51:01
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
	
	public class Scroller extends Sprite{
		
		public var bar:Btn;
		public var thumb:Btn;
		public var btnUp:Btn;
		public var btnDown:Btn;
		
		private var d:int;
		private var top:int;
		private var bottom:int;
		private var contentYMin:int;
		private var contentYMax:int;
		
		private var content:DisplayObject;
		private var upDownSpeed:int;
		
		private var mouseWheelClient:DisplayObject;
		
		public function Scroller(){
			d=thumb.y-bar.y;
			this.visible=false;
			this.mouseEnabled=this.mouseChildren=false;
		}
		private function startUp(...args):void{
			upDownSpeed=-5;
			this.addEventListener(Event.ENTER_FRAME,upDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,stopUpDown);
		}
		private function startDown(...args):void{
			upDownSpeed=5;
			this.addEventListener(Event.ENTER_FRAME,upDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,stopUpDown);
		}
		private function upDown(...args):void{
			thumb.y+=upDownSpeed;
			adjustThumb();
		}
		private function stopUpDown(...args):void{
			this.removeEventListener(Event.ENTER_FRAME,upDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopUpDown);
		}
		public function setHei(hei:int):void{
			if(btnUp){
				var b1:Rectangle=btnUp.getBounds(this);
			}else{
				b1=new Rectangle(bar.x,bar.y,bar.width,0);
			}
			if(btnDown){
				var b2:Rectangle=btnDown.getBounds(this);
			}else{
				b2=new Rectangle(bar.x,bar.y+bar.height,bar.width,0);
			}
			bar.y=b1.bottom;
			hei-=b1.height+b2.height;
			bar["gra"].gra.height=hei;
			if(btnDown){
				btnDown.y+=b1.bottom+hei-b2.bottom+b2.height;
			}
		}
		public function setContent(
			_content:DisplayObject,
			_contentYMin:int,
			_contentY:int,
			viewHei:int,
			_contentHei:int,
			_mouseWheelClient:DisplayObject
		):void{
			
			if(_content){
				_content.y=_contentY;
				
				contentYMin=_contentYMin;
				contentYMax=_contentYMin+viewHei-_contentHei;
				
				if(contentYMax>contentYMin){
					unsetContent();
					return;
				}
				
				this.visible=true;
				this.mouseChildren=true;
				
				if(thumb["gra"].hasOwnProperty("gra")){
					thumb["gra"].gra.height=viewHei/_contentHei*(bar.y+bar.height-d*2);
				}
				top=bar.y+d;
				bottom=bar.y+bar.height-(thumb["gra"].hasOwnProperty("gra")?thumb.height:0)-d;
				
				content=_content;
				
				thumb.y=(_contentY-contentYMin)*(bottom-top)/(contentYMax-contentYMin)+top;
				
				mouseWheelClient=_mouseWheelClient||content.stage;
				mouseWheelClient.addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
				bar.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
				thumb.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
				this.addEventListener(Event.ENTER_FRAME,update);
				if(btnUp){
					btnUp.addEventListener(MouseEvent.MOUSE_DOWN,startUp);
				}
				if(btnDown){
					btnDown.addEventListener(MouseEvent.MOUSE_DOWN,startDown);
				}
			}else{
				unsetContent();
			}
		}
		public function unsetContent():void{
			this.visible=false;
			this.mouseChildren=false;
			bar.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			thumb.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			this.removeEventListener(Event.ENTER_FRAME,update);
			if(btnUp){
				btnUp.removeEventListener(MouseEvent.MOUSE_DOWN,startUp);
			}
			if(btnDown){
				btnDown.removeEventListener(MouseEvent.MOUSE_DOWN,startDown);
			}
			if(mouseWheelClient){
				mouseWheelClient.removeEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
				mouseWheelClient=null;
			}
			content=null;
		}
		public function clear():void{
			unsetContent();
		}
		private function mouseWheel(event:MouseEvent):void{
			thumb.y-=event.delta<0?-30:30;
			adjustThumb();
		}
		private function adjustThumb():void{
			if(thumb.y<top){
				thumb.y=top;
			}else if(thumb.y>bottom){
				thumb.y=bottom;
			}
		}
		private function mouseDown(event:MouseEvent):void{
			if(event.target==thumb){
			}else{
				thumb.y=this.mouseY-(thumb["gra"].hasOwnProperty("gra")?thumb.height:0)/2;
				adjustThumb();
			}
			thumb.startDrag(false,new Rectangle(thumb.x,top,0,bottom-top));
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			update();
		}
		private function mouseUp(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			stopDrag();
		}
		private function update(...args):void{
			content.y+=(contentYMin+(contentYMax-contentYMin)*(thumb.y-top)/(bottom-top)-content.y)*0.2;
		}
		public function adjustByContentY(contentY:int):void{
			thumb.y=(contentY-contentYMin)*(bottom-top)/(contentYMax-contentYMin)+top;
			adjustThumb();
		}
	}
}