package com.makeit.display 
{
	import flash.display.*;
	import flash.events.*
	import flash.geom.Rectangle;
	import com.greensock.*
	public class slider extends EventDispatcher
	{
		public static const SLIDER_CHANGE:String="slider_change";
		public static const SLIDER_CHANGE_COMPLETE:String="slider_change_complete";
		private var startX:Number = 0;
		private var startY:Number = 0;
		private var dis:Number = 0;
		private var min:Number = 0;
		private var max:Number = 2;
		private var prop:Number;
		
		public var value:Number = 1;
		
		private var _stage:Stage;
		public var dragMC:MovieClip;
		public var barMC:MovieClip;
		private var rect:Rectangle;
		private var type:String;
		public function slider($stage:Stage,$dragMC:MovieClip,$barMC:MovieClip,$rect:Rectangle) 
		{
			_stage=$stage;
			dragMC = $dragMC;
			barMC = $barMC;
			rect=$rect;
			if (rect.width == 0) {
				type = "V";
				dis =rect.height;
			}else {
				type = "H";
				dis =rect.width;
			}
			startX = rect.x;
			startY = rect.y;
			
			init();
			
		}
		public function setDelta(value:Number):void {

			if (type == "H") {
				var _x:Number = dragMC.x + value;
				
				setH(_x);
			}else {
				var _y:Number =dragMC.y+value;
				setV(_y);
			}
		}
		/**
		 * 回到初始位置
		 */
		public function goStartPos():void {
			dragMC.x = startX;
			dragMC.y = startY;
			enterHandler();
		}
		/**
		 * 移动到相应比例的位置
		 * @param	value 0-1
		 */
		public function setPropPos(value:Number):void {
			var temp:Number = dis * value;
	
			if(type=="H"){
				TweenLite.to(dragMC,.3,{x:startX+temp,onUpdate:enterHandler});
			}else {
				TweenLite.to(dragMC,.3,{y:startY+temp,onUpdate:enterHandler});
			}
			
		}
		/**
		 * 回到结束位置
		 */
		public function goEndPos():void {
			if(type=="H"){
				dragMC.x = startX + dis;
			}else {
				dragMC.y = startY + dis;
			}
			enterHandler();
		}
		/**
		 * 回到中间位置
		 */
		public function goCenter():void {
			if(type=="H"){
				dragMC.x = startX + dis / 2;
			}else {
				dragMC.y = startY + dis / 2;
			}
			enterHandler();
		}
		/**
		 * 设置位置
		 */
		public function setPos(value:Number):void {
			if (type == "H") {
				var _x:Number=value;
				var _y:Number=dragMC.y;
				
				if (_x< startX) {
					//TweenLite.to(dragMC,.3,{x:startX,onUpdate:enterHandler});
					moveDrag(startX,_y);
				}else if (_x> startX+dis) {
					//TweenLite.to(dragMC,.3,{x:startX+dis,onUpdate:enterHandler});
					moveDrag(startX+dis,_y);
				}else {
					//TweenLite.to(dragMC,.3,{x:_x,onUpdate:enterHandler});
					moveDrag(_x,_y);
				}
			}else {
				var _y:Number=value;
				var _x:Number=dragMC.x;
				if (_y< startY) {
					//TweenLite.to(dragMC,.3,{y:startY,onUpdate:enterHandler});
					moveDrag(_x,startY);
				}else if (_y > startY+dis) {
					//TweenLite.to(dragMC,.3,{y:startY+dis,onUpdate:enterHandler});
					moveDrag(_x,startY+dis);
				}else {
					//TweenLite.to(dragMC,.3,{y:_y,onUpdate:enterHandler});
					moveDrag(_x,_y);
				}
			}
			
		}
		private function moveDrag(x:Number,y:Number):void{
			TweenLite.to(dragMC,.3,{x:x,y:y,onUpdate:enterHandler,onComplete:dragMoveComplete});
		}
		/**
		 * 初始化
		 */
		private function init():void {
			prop = (max - min) / dis;
			
			dragMC.buttonMode = true;
			dragMC.addEventListener(MouseEvent.MOUSE_DOWN, dragDownHandler);
			barMC.addEventListener(MouseEvent.CLICK, barClickHandler);
			
			
		}
		/**
		 * 点击bar
		 */
		private function barClickHandler(e:MouseEvent):void {
			
			if (type == "H") {
				var _x:Number = MovieClip(barMC.parent).mouseX;
				setH(_x);
				
			}else {
				var _y:Number = MovieClip(barMC.parent).mouseY;
				setV(_y);
				
			}
			
		}
		private function setH(_x:Number):void {
			if (_x< startX) {
				//TweenLite.to(dragMC,.3,{x:startX,onComplete:setComplete});
				moveDrag(startX, dragMC.y);
			}else if (_x> startX+dis) {
			//	TweenLite.to(dragMC,.3,{x:startX+dis,onComplete:setComplete});
				moveDrag(startX+dis, dragMC.y);
			}else {
				//TweenLite.to(dragMC,.3,{x:_x,onComplete:setComplete});
				moveDrag(_x, dragMC.y);
			}
			//_stage.addEventListener(Event.ENTER_FRAME,enterHandler);
		}
		private function setV(_y:Number):void {
			if (_y< startY) {
				//TweenLite.to(dragMC,.3,{y:startY,onComplete:setComplete});
				moveDrag(dragMC.x, startY);
			}else if (_y > startY+dis) {
				//TweenLite.to(dragMC,.3,{y:startY+dis,onComplete:setComplete});
				moveDrag(dragMC.x, startY+dis);
			}else {
				//TweenLite.to(dragMC,.3,{y:_y,onComplete:setComplete});
				moveDrag(dragMC.x, _y);
			}
			//_stage.addEventListener(Event.ENTER_FRAME,enterHandler);
		}
		private function setComplete():void{
			_stage.removeEventListener(Event.ENTER_FRAME,enterHandler);
		}
		/**
		 * 拖动drag
		 */
		private function dragDownHandler(e:MouseEvent):void {
			dragMC.startDrag(false, rect);
			_stage.addEventListener(Event.ENTER_FRAME,enterHandler);
			_stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		private function mouseUpHandler(e:MouseEvent):void {
			dragMC.stopDrag();
			dragMoveComplete();
			_stage.removeEventListener(Event.ENTER_FRAME,enterHandler);
			_stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			
		}
		/**
		 * 移动比例
		 */
		private function enterHandler(e:Event = null):void {
			if(type=="H"){
				value = (dragMC.x - startX) * prop+min;
			}else {
				value = (dragMC.y - startY) * prop+min;
			}
			
			this.dispatchEvent(new Event(SLIDER_CHANGE));
		}
		private function dragMoveComplete():void{
			trace("complete");
			this.dispatchEvent(new Event(SLIDER_CHANGE_COMPLETE));
		}
		public function destroy():void{
			if(_stage){
				_stage.removeEventListener(Event.ENTER_FRAME,enterHandler);
				_stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			}
			dragMC.removeEventListener(MouseEvent.MOUSE_DOWN, dragDownHandler);
			barMC.removeEventListener(MouseEvent.CLICK, barClickHandler);
			TweenLite.killTweensOf(dragMC);;
		
		}
		//======================
		public function get minValue():Number {
			return min ;
		}
		public function get maxValue():Number {
			return max;
		}
		
		public function set minValue(value:Number):void {
			min = value;
			prop = (max - min) / dis;
		}
		public function set maxValue(value:Number):void {
			max = value;
			prop = (max - min) / dis;
		}
	}

}