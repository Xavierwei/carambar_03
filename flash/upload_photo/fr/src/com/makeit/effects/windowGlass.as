package com.makeit.effects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * @author Happy
	 */
	public class windowGlass extends Bitmap {
		private var _blur:Number=4.0;
		private var _quality:uint=4;
		private var _color:uint=0x000000;
		private var _colorAlpha:Number=0.3;
		private var _visible:Boolean;
		private var bd:BitmapData;
		private var tar:DisplayObject;
		private var hideObjects:Array = [];
		private var fps:uint;
		private var count:uint=0;
		private var px:Number = 0;
		private var py:Number = 0;
		
		public function windowGlass(width:uint,height:uint)
		{
			bd = new BitmapData(width,height,true);
			this.bitmapData = bd;
		}
		/**
		 * 模糊的程度1-50
		 */
		public function set blur(value:Number):void{
			_blur = value;
		}
		/**
		 * 玻璃蒙版的色彩，默认为黑色，要实现玻璃效果，将此值设为白?xFFFFFF
		 */
		public function set color(value:uint):void{
			_color = value;
			this.opaqueBackground = _color;	
		}
		/**
		 * 玻璃蒙版的色彩的百分比，0-100,默认30
		*/
		public function set colorAlpha(value:Number):void{
			_colorAlpha = value/100;
		}
		/**
		 * 模糊质量 1-15
		 */
		public function set quality(value:uint):void{
			_quality = value;
		}
		public function set needHideObjects(value:Array):void{
			hideObjects = value;
		}
		public function set updateFPS(value:uint):void{
			fps = value;
			if(fps == 0 ){
				this.removeEventListener(Event.ENTER_FRAME,checkUpdate);
			}else{
				//this.addEventListener(Event.ENTER_FRAME,checkUpdate);
			}
		}
		public function setDrawLocation(localX:Number,localY:Number):void{
			px = -localX;
			py = -localY;
		}
		public function draw(target:DisplayObject=null,updateFPS:uint=10):void{
			tar = target;
			if(updateFPS>0){
				redraw();
			}
			this.addEventListener(Event.ENTER_FRAME,checkUpdate);
		}
		/**
		 * 立即重绘、更新显?
		 */
		public function redraw():void{
			setDisplaysHide(true);
			var mat:Matrix = new Matrix(1, 0, 0, 1, px, py);
			bd.fillRect(new Rectangle(0, 0, bd.width, bd.height), 0x00FFFFFF);
			bd.draw(tar,mat,null,null,new Rectangle(0,0,bd.width,bd.height));
			//bd.draw(tar);
			var blur:BlurFilter = new BlurFilter(_blur,_blur,_quality);
			this.filters = [blur];
			setDisplaysHide(false);
		}
		public function dispose():void{
			this.removeEventListener(Event.ENTER_FRAME,checkUpdate);
			//setDisplaysHide(true);
			//bd.dispose();
			
		}
		private function setDisplaysHide(needHide:Boolean):void{
			for(var i:int = 0;i<hideObjects.length;i++){
				try{
					hideObjects[i].visible = !needHide;
				}catch(error:Error){
					trace("玻璃效果，目标不是显示对象：",hideObjects[i]);
				}
			}
		}
		private function checkUpdate(event:Event):void{
			count++;
			if(count == fps){
				count = 0;
				redraw();
			}
		}
	}
}
