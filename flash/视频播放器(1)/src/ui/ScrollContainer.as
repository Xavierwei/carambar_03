package ui {
	import flash.events.Event;

	import akdcl.manager.ButtonManager;
	import akdcl.display.UILoader;
	
	import akdcl.events.UIEvent;

	/**
	 * ...
	 * @author akdcl
	 */
	public class ScrollContainer extends UILoader {
		protected static const btnM:ButtonManager = ButtonManager.getInstance();

		public var lockX:Boolean = true;
		public var lockY:Boolean;

		private var startScrollX:int = 0;
		private var startScrollY:int = 0;
		private var speedX:Number = 0;
		private var speedY:Number = 0;
		private var needMouseChildren:Boolean;

		public function ScrollContainer(_rectWidth:uint = 0, _rectHeight:uint = 0, _bgColor:int = -1):void {
			super(_rectWidth, _rectHeight, _bgColor);
		}

		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			addEventListener(UIEvent.PRESS, onPressHandler);
			addEventListener(UIEvent.DRAG_MOVE, onDragMoveHandler);
			addEventListener(UIEvent.RELEASE, onReleaseHandler);
			addEventListener(UIEvent.RELEASE_OUTSIDE, onReleaseHandler);
			btnM.addButton(this);
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			btnM.removeButton(this);
		}

		/*override public function updateRect():void {
			super.updateRect();
			scaleWidth = Math.max(scaleWidth, rect.width * 0.99999999);
			scaleHeight = Math.max(scaleHeight, rect.height * 0.99999999);
		}*/

		private function onPressHandler(_e:UIEvent):void {
			if (!lockX){
				startScrollX = proxy.scrollX;
			}
			if (!lockY){
				startScrollY = proxy.scrollY;
			}
			removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}

		private function onDragMoveHandler(_e:UIEvent):void {
			if (!lockX){
				var _dx:int = btnM.lastX - btnM.startX;
				proxy.scrollX = _dx + startScrollX;
			}

			if (!lockY){
				var _dy:int = btnM.lastY - btnM.startY;
				proxy.scrollY = _dy + startScrollY;
			}
			if (mouseChildren){
				needMouseChildren = true;
				mouseChildren = false;
			}
		}

		private function onReleaseHandler(_e:UIEvent):void {
			if (!lockX){
				speedX = btnM.speedX * 2;
			}
			if (!lockY){
				speedY = btnM.speedY * 2;
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}

		private function onEnterFrameHandler(_e:Event):void {
			if (needMouseChildren) {
				needMouseChildren = false;
				mouseChildren = true;
			}
			if (!lockX){
				proxy.scrollX += speedX;
				var _isOutX:Boolean = proxy.alignX < 0 || proxy.alignX > 1;
				if (_isOutX){
					speedX *= 0.5;
				} else {
					speedX *= 0.9;
				}
			}
			if (!lockY){
				proxy.scrollY += speedY;
				var _isOutY:Boolean = proxy.alignY < 0 || proxy.alignY > 1;
				if (_isOutY){
					speedY *= 0.5;
				} else {
					speedY *= 0.9;
				}
			}
			if (_isOutX || _isOutY){
			} else if (Math.abs(speedX) < 1 && Math.abs(speedY) < 1){
				speedX = 0;
				speedY = 0;
				removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			}
		}
	}

}