package com.makeit.display 
{
	import flash.display.*;
	import flash.events.*
	import flash.geom.Rectangle;
	import com.greensock.*
	import com.greensock.easing.*
	
	public class scroll extends EventDispatcher
	{
		/**
		 * 滚动条配合 silder类
		 * @param	$silderDispatcher  滚动条
		 * @param	$contentMC  滚动的内容
		 * @param	$maskHeight  可视高度
		 */
		private var silderDispatcher:slider;
		private var contentMC:MovieClip;
		private var startY:Number;
		private var maskHeight:Number;
		
		public function scroll($silderDispatcher:slider,$contentMC:MovieClip,$startY:Number,$maskHeight:Number) 
		{
			contentMC = $contentMC;
			startY = $startY;
			maskHeight = $maskHeight;
			
			silderDispatcher = $silderDispatcher;
			silderDispatcher.addEventListener(slider.SLIDER_CHANGE, silderChangeHandler);

			contentMC.addEventListener(MouseEvent.ROLL_OVER, contentRollOverHandler);
			contentMC.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			contentMC.addEventListener(MouseEvent.ROLL_OUT, contentRollOutHandler);
			silderVisible();
		}
		private function contentRollOverHandler(e:MouseEvent):void {
			contentMC.stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}
		private function contentRollOutHandler(e:MouseEvent):void {
			contentMC.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}
		private function mouseWheelHandler(e:MouseEvent):void {
			if(contentMC.height>maskHeight){
				silderDispatcher.setDelta( -e.delta * 10);
			}
		}
		
		
		public function silderVisible():Boolean {

			if (contentMC.height < maskHeight) {
				silderDispatcher.dragMC.visible = false;
				silderDispatcher.barMC.visible=false;
			}else {
				silderDispatcher.dragMC.visible = true;
				silderDispatcher.barMC.visible=true;
			}
			return silderDispatcher.dragMC.visible;
		}
		private function silderChangeHandler(e:Event):void {
			var dis:Number = contentMC.height - maskHeight;
	
			if (dis < 0) {
				throw new Error("滚动内容小于滚动区域");
				return;
			}
			var prop:Number=silderDispatcher.value/silderDispatcher.maxValue;
			
			TweenLite.to(contentMC,.5,{y:startY-prop*dis});
		}
		
		public function destroy():void{
			silderDispatcher.removeEventListener(silder.SILDER_CHANGE, silderChangeHandler);

			contentMC.removeEventListener(MouseEvent.ROLL_OVER, contentRollOverHandler);
			contentMC.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			contentMC.removeEventListener(MouseEvent.ROLL_OUT, contentRollOutHandler);
			TweenLite.killTweensOf(contentMC);
		
		}
	}

}