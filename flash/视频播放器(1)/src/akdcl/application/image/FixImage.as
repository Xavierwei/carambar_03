package akdcl.application.image {
	
	import akdcl.events.UIEventDispatcher;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.BlendMode;
	import flash.utils.ByteArray;

	import flash.events.Event;

	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import akdcl.layout.Display;
	import akdcl.display.UISprite;
	import akdcl.display.UIDisplay;

	import ui.transformTool.TransformTool;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class FixImage extends UIEventDispatcher {
		private static const MATRIX:Matrix = new Matrix();

		public var backgroundColor:uint = 0xffffff;

		protected var imageWidth:uint;
		protected var imageHeight:uint;

		protected var container:DisplayObjectContainer;
		protected var frameArea:DisplayObject;
		protected var frameIcon:DisplayObject;

		protected var frameBorder:uint = 0;
		protected var iconWidth:uint;
		protected var iconHeight:uint;

		protected var areaWidth:uint;
		protected var areaHeight:uint;

		protected var displayArea:UIDisplay;
		protected var proxyIcon:Display;

		protected var shapeMask:Shape;
		//shapeMove需要鼠标事件不能用Shape
		protected var shapeMove:UISprite;
		protected var shapesContainer:UISprite;

		protected var transformTool:TransformTool;
		protected var bitmap:Bitmap;
		protected var bitmapData:BitmapData;
		protected var rawBitmapData:BitmapData;

		override protected function init():void {
			super.init();
			shapesContainer = new UISprite();
			shapeMask = new Shape();
			shapeMove = new UISprite();
			shapeMove.blendMode = BlendMode.ERASE;
			
			shapesContainer.addChild(shapeMask);
			shapesContainer.addChild(shapeMove);
			
			bitmap = new Bitmap();
			
			
			transformTool = new TransformTool(shapesContainer);
			transformTool.onChanging = updateBMD;
			transformTool.area = new Rectangle(0, 0, areaWidth, areaHeight);
			
			shapesContainer.enabled = false;
		}
		
		public function setContainer(_container:DisplayObjectContainer):void {
			var _frameArea:DisplayObject = _container.getChildByName("frameArea");
			var _frameIcon:DisplayObject = _container.getChildByName("frameIcon");
			if (!_frameArea || !_frameIcon) {
				
				return;
			}
			container = _container;
			frameArea = _frameArea;
			frameIcon = _frameIcon;
			
			updateDisplays();
			
			container.addChildAt(displayArea, container.getChildIndex(frameArea) + 1);
			container.addChildAt(shapesContainer, container.getChildIndex(displayArea) + 1);
			container.addChildAt(bitmap, container.getChildIndex(frameIcon) + 1);
			
			transformTool.Init();
		}
		
		public function setFrameBorder(_border:uint):void {
			frameBorder = _border;
			updateDisplays();
		}
		
		protected function updateDisplays():void {
			areaWidth = frameArea.width - frameBorder * 2;
			areaHeight = frameArea.height - frameBorder * 2;

			iconWidth = frameIcon.width - frameBorder * 2;
			iconHeight = frameIcon.height - frameBorder * 2;
			
			
			if (displayArea) {
				displayArea.proxy.setSize(areaWidth, areaHeight);
			}else {
				displayArea = new UIDisplay(areaWidth, areaHeight, -1);
			}
			
			if (proxyIcon) {
				proxyIcon.setSize(iconWidth, iconHeight);
				proxyIcon.setPoint(frameIcon.x + frameBorder, frameIcon.y + frameBorder);
			}else {
				proxyIcon = new Display(frameIcon.x + frameBorder, frameIcon.y + frameBorder, iconWidth, iconHeight);
				proxyIcon.roundWH = true;
			}
			
			shapeMask.graphics.clear();
			shapeMask.graphics.beginFill(0x000000, 0.5);
			shapeMask.graphics.drawRect(0, 0, areaWidth, areaHeight);

			displayArea.x = shapesContainer.x = frameArea.x + frameBorder;
			displayArea.y = shapesContainer.y = frameArea.y + frameBorder;
			
			transformTool.area.width = areaWidth;
			transformTool.area.height = areaHeight;
			shapesContainer.scrollRect = transformTool.area;
		}

		public function setImageSize(_width:uint, _height:uint):void {
			imageWidth = _width;
			imageHeight = _height;

			shapeMove.graphics.clear();
			shapeMove.graphics.beginFill(backgroundColor);
			shapeMove.graphics.drawRect(0, 0, imageWidth, imageHeight);

			proxyIcon.setContent(shapeMove, 0, 0, 11);
			
			iconWidth = proxyIcon.getScaleWidth();
			iconHeight = proxyIcon.getScaleHeight();
			
			frameIcon.width = iconWidth + frameBorder * 2;
			frameIcon.height = iconHeight + frameBorder * 2;
			
			shapeMove.x = int((areaWidth - iconWidth) * 0.5);
			shapeMove.y = int((areaHeight - iconHeight) * 0.5);
			
			//
			transformTool.RemoveControl(shapeMove);
			transformTool.AddControl(shapeMove, true);
			transformTool.SetStyle(shapeMove, { eqScale: true, enSetMidPoint: false, enSkewX:false, enSkewY:false } );
		}

		override protected function onRemoveHandler():void {
			super.onRemoveHandler();
			clear();
			transformTool.Clear();
			frameArea = null;
			frameIcon = null;
			displayArea = null;
			shapeMask = null;
			shapeMove = null;
			shapesContainer = null;
			transformTool = null;
			bitmap = null;
			bitmapData = null;
			rawBitmapData = null;
		}

		public function clear():void {
			reset();
			transformTool.ArrowClear();
			if (bitmapData){
				bitmapData.dispose();
				bitmapData = null;
			}
		}

		public function reset():void {
			transformTool.selectedItem = null;
			transformTool.SetInfo(shapeMove);
			transformTool.selectedItem = shapeMove;
			updateBMD();
		}

		public function getRawBitmapData():BitmapData {
			return rawBitmapData;
		}

		//设置 width 和 height 后注意回收bitmapData;
		public function getFixBitmapData(_width:Number = 0, _height:Number = 0):BitmapData {
			if (!bitmapData){
				return null;
			}
			if (_width == 0 && _height == 0){
				return bitmapData;
			}
			var _bmd:BitmapData;

			var _aspectRatio:Number = _width / _height;
			var _aspectRatioRaw:Number = imageWidth / imageHeight;

			if (_width * _height > 0 ? (_aspectRatio < _aspectRatioRaw) : (_width > 0)){
				if (_width <= 1){
					_width = imageWidth * _width;
				}
				_height = _width / _aspectRatioRaw;
				MATRIX.d = MATRIX.a = _width / imageWidth;
			} else {
				if (_height <= 1){
					_height = imageHeight * _height;
				}
				_width = _height * _aspectRatioRaw;
				MATRIX.d = MATRIX.a = _height / imageHeight;
			}
			
			_bmd = new BitmapData(_width, _height, false, backgroundColor);
			_bmd.draw(bitmapData, MATRIX);
			//_bmd.dispose();
			return _bmd;
		}

		public function setImage(_bmd:BitmapData):void {
			shapesContainer.enabled = true;
			shapesContainer.blendMode = BlendMode.LAYER;
			if (rawBitmapData) {
				rawBitmapData.dispose();
			}
			
			rawBitmapData = _bmd;
			displayArea.setContent(rawBitmapData, 0);
			reset();
			proxyIcon.setContent(bitmap, 0, 0, 11);
		}

		protected function updateBMD():void {
			if (bitmapData){
				bitmapData.dispose();
			}
			bitmapData = getContainBmd(shapeMove, displayArea, backgroundColor);

			bitmap.bitmapData = bitmapData;
			bitmap.smoothing = true;
		}

		private static function getContainBmd(_obj:*, _bg:*, _bgColor:uint = 0):BitmapData {
			var _rect:Rectangle = _obj.getBounds(_obj);
			var _bmd:BitmapData = new BitmapData(_rect.width, _rect.height, false, _bgColor);
			var _m:Matrix = _bg.transform.concatenatedMatrix;
			var _objM:Matrix = new Matrix(1, 0, 0, 1, _rect.x, _rect.y);

			var _m2:Matrix = _obj.transform.concatenatedMatrix;
			_objM.concat(_m2);
			_objM.invert();
			_m.concat(_objM);
			_bmd.draw(_bg, _m);
			return _bmd;
		}
	}

}