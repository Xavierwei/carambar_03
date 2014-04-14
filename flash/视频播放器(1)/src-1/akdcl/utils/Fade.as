package akdcl.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class Fade extends Sprite {
		public static var interval:uint = 20;
		public static var backgroundColor:uint = 0x000000;
		
		private static var instance:Fade;
		public static function getInstance():Fade {
			if (instance) {
			} else {
				instance = new Fade();
			}
			return instance;
		}
		
		private var stage:Stage;
		private var container:Sprite;
		private var maskShape:Shape;
		private var bmp:Bitmap;
		private var bmd:BitmapData;
		
		public function Fade() {
			super();
			if (instance) {
				throw new Error("[ERROR]:Fade Singleton already constructed!");
			}
			instance = this;
			init();
		}
		
		private function init():void {
			bmp = new Bitmap();
			maskShape = new Shape();
			bmp.mask = maskShape;
			
			addChild(bmp);
			addChild(maskShape);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
		}
		
		private function onAddToStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStageHandler);
			stage.addEventListener(Event.RESIZE, onStageResizeHandler);
			onStageResizeHandler(null);
		}
		
		private function onStageResizeHandler(e:Event):void {
			if (bmd) {
				bmd.dispose();
			}
			bmd = new BitmapData(stage.stageWidth, stage.stageHeight, false, _bgColor);
			bmp.bitmapData = bmd;
		}
		
		public function start():Void {
			if (!stage) {
				
				return;
			}
			bmd.draw(stage);

			switch (int(Math.random() * 4)) {
				case 0 :
					mClip_root.nRdm = random(2);
					mClip_root.m_0 = createClip("m_", mClip_mask, 0, 0);
					mClip_root.m_1 = createClip("m_", mClip_mask, 0, 1, {_x:10, _y:10, _rotation:180});
					mClip_root.onEnterFrame = function() {
						this.nTime++;
						this.nTemp = 50-trigonometric(this.nTime, this.nT, 50);
						if (this.nRdm>0) {
							this.m_0._yscale = this.m_1._yscale=this.nTemp;
						} else {
							this.m_0._xscale = this.m_1._xscale=this.nTemp;
						}
						if (this.nTime == this.nT/2) {
							this.finish();
						}
						this.switchDepth();
					};
					break;
				case 1 :
					mClip_root.nRdm = random(3);
					mClip_root.nRdm_2 = random(4);
					mClip_root.m_0 = createClip("m_", mClip_mask, 1, 0, {_x:5, _y:5});
					mClip_root.onEnterFrame = function() {
						this.nTime++;
						this.nTemp = 100-trigonometric(this.nTime, this.nT, 100);
						switch (this.nRdm) {
							case 0 :
								this.m_0._xscale=150, this.m_0._yscale=this.nTemp;
								break;
							case 1 :
								this.m_0._xscale=this.nTemp, this.m_0._yscale=150;
								break;
							case 2 :
								this.m_0._xscale = this.m_0._yscale=this.nTemp;
								break;
						}
						if (this.nRdm_2 == 3) {
							this.m_0._rotation = 180-trigonometric(this.nTime, this.nT, 180);
						} else if (this.nRdm_2 == 2) {
							this.m_0._rotation = trigonometric(this.nTime, this.nT, 180);
						}
						if (this.nTime == this.nT/2) {
							this.finish();
						}
						this.switchDepth();
					};
					break;
				case 2 :
					mClip_root.nRdm = random(5);
					mClip_root.m_0 = createClip("m_", mClip_mask, 2, 0);
					mClip_root.m_1 = createClip("m_", mClip_mask, 2, 1, {_x:10, _y:10, _rotation:180});
					mClip_root.onEnterFrame = function() {
						this.nTime++;
						this.nTemp = 100-trigonometric(this.nTime, this.nT, 100);
						switch (this.nRdm) {
							case 0 :
								this.m_0._yscale = this.m_1._yscale=this.nTemp;
								break;
							case 1 :
								this.m_0._xscale = this.m_1._yscale=this.nTemp;
								break;
							case 2 :
								this.m_0._yscale = this.m_1._xscale=this.nTemp;
								break;
							case 3 :
								this.m_0._xscale = this.m_1._xscale=this.nTemp;
								break;
							case 4 :
								this.m_0._xscale = this.m_1._xscale=this.nTemp;
								this.m_0._yscale = this.m_1._yscale=this.nTemp;
								break;
						}
						if (this.nTime == this.nT/2) {
							this.finish();
						}
						this.switchDepth();
					};
					break;
				case 3 :
					mClip_root.nRdm = random(2);
					mClip_root.m_0 = createClip("m_", mClip_mask, 2, 0);
					mClip_root.m_1 = createClip("m_", mClip_mask, 2, 1, {_x:10, _y:10, _rotation:180});
					mClip_root.m_2 = createClip("m_", mClip_mask, 2, 2, {_x:0, _y:10, _rotation:-90});
					mClip_root.m_3 = createClip("m_", mClip_mask, 2, 3, {_x:10, _y:0, _rotation:90});
					mClip_root.onEnterFrame = function() {
						this.nTime++;
						this.nTemp = 100-trigonometric(this.nTime, this.nT, 100);
						if (this.nRdm>0) {
							this.m_0._yscale = this.m_1._yscale=this.m_2._yscale=this.m_3._yscale=this.nTemp;
						} else {
							this.m_0._xscale = this.m_1._xscale=this.m_2._xscale=this.m_3._xscale=this.nTemp;
						}
						if (this.nTime == this.nT/2) {
							this.finish();
						}
						this.switchDepth();
					};
					break;
				default :
					break;
			}
			maskShape.width = stageWidth;
			maskShape.height = stageHeight;
			//maskShape.x = offX
			//maskShape.y = offY;
		}
	}
	
}
/*import flash.display.*;
import flash.geom.*;
class Fade {
	public static var nColor:Number=0x000000;
	public static var nInterval:Number = 20;
	public static function start():Void {
		var bDisBtn:Boolean = false;
		var nWidth:Number = Stage.width;
		var nHeight:Number = Stage.height;
		var nOffx:Number = 0;
		var nOffy:Number = 0;
		var _bmpRoot:BitmapData = new BitmapData(nWidth, nHeight, false, nColor);
		_bmpRoot.draw(_root);
		var _nDepth:Number=_root.getNextHighestDepth();
		var mClip_root:MovieClip = _root.createEmptyMovieClip("mClip_root"+_nDepth,_nDepth);
		var mClip_mask:MovieClip = mClip_root.createEmptyMovieClip("mClip_mask", 0);
		var mClip_bmp:MovieClip = mClip_root.createEmptyMovieClip("mClip_bmp", 1);
		mClip_bmp.attachBitmap(_bmpRoot,0);
		mClip_root.nT = nInterval;
		bDisBtn && disableBtn(mClip_root);
		mClip_root.bmpRoot = _bmpRoot;
		mClip_root.nTime = 0;
		mClip_root.finish = function() {
			this.bmpRoot.dispose();
			this.removeMovieClip();
		};
		mClip_root.switchDepth = function() {
			if (this.getDepth() != _root.getNextHighestDepth()-1) {
				this.swapDepths(_root.getNextHighestDepth()-1);
			}
		};
		switch (random(4)) {
			case 0 :
				mClip_root.nRdm = random(2);
				mClip_root.m_0 = createClip("m_", mClip_mask, 0, 0);
				mClip_root.m_1 = createClip("m_", mClip_mask, 0, 1, {_x:10, _y:10, _rotation:180});
				mClip_root.onEnterFrame = function() {
					this.nTime++;
					this.nTemp = 50-trigonometric(this.nTime, this.nT, 50);
					if (this.nRdm>0) {
						this.m_0._yscale = this.m_1._yscale=this.nTemp;
					} else {
						this.m_0._xscale = this.m_1._xscale=this.nTemp;
					}
					if (this.nTime == this.nT/2) {
						this.finish();
					}
					this.switchDepth();
				};
				break;
			case 1 :
				mClip_root.nRdm = random(3);
				mClip_root.nRdm_2 = random(4);
				mClip_root.m_0 = createClip("m_", mClip_mask, 1, 0, {_x:5, _y:5});
				mClip_root.onEnterFrame = function() {
					this.nTime++;
					this.nTemp = 100-trigonometric(this.nTime, this.nT, 100);
					switch (this.nRdm) {
						case 0 :
							this.m_0._xscale=150, this.m_0._yscale=this.nTemp;
							break;
						case 1 :
							this.m_0._xscale=this.nTemp, this.m_0._yscale=150;
							break;
						case 2 :
							this.m_0._xscale = this.m_0._yscale=this.nTemp;
							break;
					}
					if (this.nRdm_2 == 3) {
						this.m_0._rotation = 180-trigonometric(this.nTime, this.nT, 180);
					} else if (this.nRdm_2 == 2) {
						this.m_0._rotation = trigonometric(this.nTime, this.nT, 180);
					}
					if (this.nTime == this.nT/2) {
						this.finish();
					}
					this.switchDepth();
				};
				break;
			case 2 :
				mClip_root.nRdm = random(5);
				mClip_root.m_0 = createClip("m_", mClip_mask, 2, 0);
				mClip_root.m_1 = createClip("m_", mClip_mask, 2, 1, {_x:10, _y:10, _rotation:180});
				mClip_root.onEnterFrame = function() {
					this.nTime++;
					this.nTemp = 100-trigonometric(this.nTime, this.nT, 100);
					switch (this.nRdm) {
						case 0 :
							this.m_0._yscale = this.m_1._yscale=this.nTemp;
							break;
						case 1 :
							this.m_0._xscale = this.m_1._yscale=this.nTemp;
							break;
						case 2 :
							this.m_0._yscale = this.m_1._xscale=this.nTemp;
							break;
						case 3 :
							this.m_0._xscale = this.m_1._xscale=this.nTemp;
							break;
						case 4 :
							this.m_0._xscale = this.m_1._xscale=this.nTemp;
							this.m_0._yscale = this.m_1._yscale=this.nTemp;
							break;
					}
					if (this.nTime == this.nT/2) {
						this.finish();
					}
					this.switchDepth();
				};
				break;
			case 3 :
				mClip_root.nRdm = random(2);
				mClip_root.m_0 = createClip("m_", mClip_mask, 2, 0);
				mClip_root.m_1 = createClip("m_", mClip_mask, 2, 1, {_x:10, _y:10, _rotation:180});
				mClip_root.m_2 = createClip("m_", mClip_mask, 2, 2, {_x:0, _y:10, _rotation:-90});
				mClip_root.m_3 = createClip("m_", mClip_mask, 2, 3, {_x:10, _y:0, _rotation:90});
				mClip_root.onEnterFrame = function() {
					this.nTime++;
					this.nTemp = 100-trigonometric(this.nTime, this.nT, 100);
					if (this.nRdm>0) {
						this.m_0._yscale = this.m_1._yscale=this.m_2._yscale=this.m_3._yscale=this.nTemp;
					} else {
						this.m_0._xscale = this.m_1._xscale=this.m_2._xscale=this.m_3._xscale=this.nTemp;
					}
					if (this.nTime == this.nT/2) {
						this.finish();
					}
					this.switchDepth();
				};
				break;
			default :
				break;
		}
		mClip_mask._width=nWidth, mClip_mask._height=nHeight;
		mClip_mask._x=nOffx, mClip_mask._y=nOffy;
		mClip_bmp.setMask(mClip_mask);
	}
	private static function disableBtn(_m:MovieClip):Void {
		_m.onPress = null;
		_m.enabled = false;
		_m.hitArea = _root;
	}
	private static function trigonometric(x:Number, T:Number, A:Number, P:Number):Number {
		var _offx:Number = 0;
		var _nT:Number = Math.PI/T*x;
		if (!isNaN(P)) {
			_offx = P-_nT;
		}
		return A*Math.sin(_nT+_offx);
	}
	private static function createClip(_s:String, _m:MovieClip, _nType:Number, _nDepth:Number, _ob:Object):MovieClip {
		isNaN(_nDepth) && (_nDepth=_m.getNextHighestDepth());
		isNaN(_nType) && (_nType=0);
		_m.createEmptyMovieClip(_s+_nDepth,_nDepth);
		_m[_s+_nDepth].beginFill(0x000000);
		switch (_nType) {
			case 0 :
				_m[_s+_nDepth].lineTo(10,0);
				_m[_s+_nDepth].lineTo(10,10);
				_m[_s+_nDepth].lineTo(0,10);
				_m[_s+_nDepth].lineTo(0,0);
				break;
			case 1 :
				_m[_s+_nDepth].moveTo(-5,-5);
				_m[_s+_nDepth].lineTo(-5,5);
				_m[_s+_nDepth].lineTo(5,5);
				_m[_s+_nDepth].lineTo(5,-5);
				_m[_s+_nDepth].lineTo(-5,-5);
				break;
			case 2 :
				_m[_s+_nDepth].lineTo(10,0);
				_m[_s+_nDepth].lineTo(0,10);
				_m[_s+_nDepth].lineTo(0,0);
				break;
			default :
				break;
		}
		_m[_s+_nDepth].endFill();
		for (var i in _ob) {
			_m[_s+_nDepth][i] = _ob[i];
		}
		return _m[_s+_nDepth];
	}
}*/