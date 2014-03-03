package com.makeit.managers 
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.*;
	
	import com.makeit.utils.objectPool;
	import flash.display.AVM1Movie;
	import flash.display.ActionScriptVersion;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.CapsStyle;
	import flash.display.ColorCorrection;
	import flash.display.ColorCorrectionSupport;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsGradientFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsPathWinding;
	import flash.display.GraphicsShaderFill;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.GraphicsTrianglePath;
	import flash.display.IBitmapDrawable;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsPath;
	import flash.display.IGraphicsStroke;
	import flash.display.InteractiveObject;
	import flash.display.InterpolationMethod;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MorphShape;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.SWFVersion;
	import flash.display.Scene;
	import flash.display.Shader;
	import flash.display.ShaderData;
	import flash.display.ShaderInput;
	import flash.display.ShaderJob;
	import flash.display.ShaderParameter;
	import flash.display.ShaderParameterType;
	import flash.display.ShaderPrecision;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.sampler.NewObjectSample;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.IME;
	import flash.system.IMEConversionMode;
	import flash.system.JPEGLoaderContext;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.system.SecurityPanel;
	import flash.system.System;
	import flash.system.fscommand;
	import flash.utils.getDefinitionByName;
	public class popManage extends EventDispatcher
	{
		public static const LOAD_POP_WINDOW_STRAT:String = "load_pop_window_strat";
		public static const LOAD_POP_WINDOW_COMPLETE:String = "load_pop_window_complete";
		
		private static var maskBg:Sprite;
		private static var popMC:MovieClip;
		private static var _stage:Stage;
		private static var _container:DisplayObjectContainer;
		private static var _width:Number;
		private static var _height:Number;
		private static var _alpha:Number;
		private static var _color:Number;
		private static var containSprite:Sprite;
		
		private static var className:String;
		private static var popClass:Class;
		
		private static var instance:popManage;
		
		private static var _progressFunc:Function;
		private static var _loadCompleteFunc:Function;
		private static var _onStartLoad:Function;
			
		/**
		 * 
		 * @param	$container 添加到的容器
		 * @param	$color 背景颜色
		 * @param	$alpha 背景透明度
		 * @param	$width 舞台大小
		 * @param	$height
		 */
		public function popManage($stage:Stage,$container:DisplayObjectContainer,$color:Number=0xFF,$alpha:Number=1,$width:Number=500,$height:Number=500):void {
			_stage = $stage;
			_container=$container;
			_width =$width;
			_height=$height;
			_color = $color;
			_alpha = $alpha;
			
			maskBg = new Sprite();
			containSprite = new Sprite();
			
			containSprite.x = _width / 2;
			containSprite.y = _height / 2;
		}
		/**
		 * 添加弹出窗口
		 * @param	c 弹出窗口class
		 * @param	url 
		 */
		public function popWindow(c:String, url:String = "", loaderInfo:LoaderInfo = null):void {
			removeWindow();
			className=c;
			addMask();
			containSprite.addChild(maskBg);
			if (url != "") {
				var popLoader:SWFLoader = LoaderMax.getLoader(url) as SWFLoader;
				
				if (popLoader==null) {
					var context:LoaderContext = new LoaderContext();
					context.applicationDomain =new ApplicationDomain(ApplicationDomain.currentDomain);
					popLoader = new SWFLoader(url, { name:url,context:context, onProgress:progressPopHandler, onComplete:completePopHandler } );
					popLoader.load();
			
					dispatchEvent(new Event(popManage.LOAD_POP_WINDOW_STRAT));
					
					if(_onStartLoad!=null){
						_onStartLoad.call(null);
					}
				}else {
					popClass=popLoader.getClass(className) as Class;
					popContent();
				}
			}else {
				if(loaderInfo==null){
					
					popClass = ApplicationDomain.currentDomain.getDefinition(className) as Class;
				}else {
					popClass=loaderInfo.applicationDomain.getDefinition(className) as Class;
				}
				popContent();
			}
			
			_container.addChild(containSprite);

			_stage.addEventListener(Event.RESIZE, resizeHandler);
			resizeHandler(null);
			TweenLite.from(maskBg, .3, { alpha:0 } );
		}
		
		private function popContent():void {
			if(_loadCompleteFunc!=null){
				_loadCompleteFunc.call(null);
			}
			popMC = objectPool.CheckOut(popClass) as MovieClip;
			containSprite.addChild(popMC);
			
		}
		
		private function progressPopHandler(e:LoaderEvent):void {
			//var prop:Number = e.target.progress;
			if(_progressFunc!=null){
				_progressFunc.call(null, e.target.progress);
			}
		}
		
		private function completePopHandler(e:LoaderEvent):void {	
		
			dispatchEvent(new Event(popManage.LOAD_POP_WINDOW_COMPLETE));	
			var popLoader:SWFLoader = e.target as SWFLoader;
			popClass = popLoader.getClass(className) as Class;
			popContent();
		}
		public function onStartLoad(func:Function):void{
			_onStartLoad=func;
		}
		public function onLoadProgress(func:Function):void{
			_progressFunc=func;

		}
		public function onLoadComplete(func:Function):void{
			_loadCompleteFunc=func;
	
		}
		/**
		 * 删除弹出窗口
		 */
		public function removePopWindow():void {
			if(popMC){
				objectPool.CheckIn(popMC);
				maskBg.removeEventListener(MouseEvent.CLICK,maskClickHandler);
				TweenLite.to(containSprite, .3, { alpha:0,onComplete:removeWindow} );
			}
			
		
		}
		private function removeWindow():void {
			TweenMax.killChildTweensOf(containSprite);
		
			maskBg.graphics.clear();
			
			while (containSprite.numChildren > 0) {
				containSprite.removeChildAt(0);
			}
			popMC = null;
			containSprite.alpha = 1;
			if(containSprite.parent){
				_container.removeChild(containSprite);
				_stage.removeEventListener(Event.RESIZE, resizeHandler);
			}
		}
		/**
		 * 增加mask
		 */
		private function addMask():void {
			maskBg.graphics.clear();
			maskBg.graphics.beginFill(_color, _alpha);
			maskBg.graphics.moveTo( -_width / 2, -_height / 2);
			maskBg.graphics.lineTo(_width / 2, -_height / 2);
			maskBg.graphics.lineTo(_width / 2, _height / 2);
			maskBg.graphics.lineTo( -_width / 2, _height / 2);
			maskBg.graphics.lineTo( -_width / 2, -_height / 2);
			maskBg.graphics.endFill();
			
			//maskBg.addEventListener(MouseEvent.CLICK,maskClickHandler)
			
		}
		private function maskClickHandler(e:MouseEvent):void {
			removePopWindow();
		}
		private function resizeHandler(e:Event):void {
			maskBg.width = _stage.stageWidth;
			maskBg.height = _stage.stageHeight;
			
		}
		
		public function get popDisplay():Sprite{
			return containSprite;
		}
		
	}
}