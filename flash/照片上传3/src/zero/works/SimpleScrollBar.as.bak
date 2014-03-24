/***
SimpleScrollBar 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年2月27日 17:00:24
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	
	public class SimpleScrollBar extends Sprite{
		private var content:DisplayObject;
		public var thumb:Sprite;
		public var btnUp:Sprite;
		public var btnDown:Sprite;
		public var bar:Sprite;
		public function SimpleScrollBar(){
			thumb.addEventListener(MouseEvent.MOUSE_DOWN,startDragThumb);
			btnUp.addEventListener(MouseEvent.MOUSE_DOWN,startGoUp);
			btnDown.addEventListener(MouseEvent.MOUSE_DOWN,startGoDown);
			this.mouseEnabled=false;
			setContent(null);
		}
		public function setContent(_content:DisplayObject,_thumbY:Number=NaN):void{
			content=_content;
			if(content){
				if(content.height>this.height){
					this.mouseChildren=true;
					thumb.visible=true;
					thumb.height=this.height/content.height*bar.height;
					if(isNaN(_thumbY)){
					}else{
						thumb.y=_thumbY;
					}
					updateThumb();
				}else{
					content.y=this.y;
					this.mouseChildren=false;
					thumb.visible=false;
				}
				
			}else{
				this.mouseChildren=false;
				thumb.visible=false;
			}
		}
		private function startDragThumb(event:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_UP,stopDragThumb);
			this.addEventListener(Event.ENTER_FRAME,updateThumb);
			thumb.startDrag(false,new Rectangle(0,bar.y,0,bar.height-thumb.height));
		}
		private function updateThumb(...args):void{
			if(thumb.y<bar.y){
				thumb.y=bar.y;
			}
			if(thumb.y+thumb.height>bar.y+bar.height){
				thumb.y=bar.y+bar.height-thumb.height;
			}
			content.y=this.y-(thumb.y-bar.y)/bar.height*content.height;
		}
		private function stopDragThumb(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopDragThumb);
			this.removeEventListener(Event.ENTER_FRAME,updateThumb);
			stopDrag();
		}
		private function startGoUp(event:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_UP,stopGoUp);
			this.addEventListener(Event.ENTER_FRAME,goUp);
		}
		private function goUp(event:Event):void{
			thumb.y-=5;
			updateThumb();
		}
		private function stopGoUp(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopGoUp);
			this.removeEventListener(Event.ENTER_FRAME,goUp);
		}
		private function startGoDown(event:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_UP,stopGoDown);
			this.addEventListener(Event.ENTER_FRAME,goDown);
		}
		private function goDown(event:Event):void{
			thumb.y+=5;
			updateThumb();
		}
		private function stopGoDown(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopGoDown);
			this.removeEventListener(Event.ENTER_FRAME,goDown);
		}
	}
}

