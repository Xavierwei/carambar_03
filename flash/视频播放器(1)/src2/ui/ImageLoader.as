package ui {
	
	import flash.display.MovieClip;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import flash.events.ContextMenuEvent;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
	import flash.system.ApplicationDomain;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.ImageLoader;
	
	import akdcl.utils.addContextMenu;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  ImageLoader extends Btn {
		
		private static var contextMenuImageLoader:ContextMenu;
		private static var contextMenuItemImageLoader:ContextMenuItem;
		private static function createMenu(_target:*):ContextMenu {
			if (!contextMenuImageLoader) {
				contextMenuItemImageLoader = addContextMenu(_target, "");
				contextMenuImageLoader = _target.contextMenu;
				contextMenuImageLoader.addEventListener(ContextMenuEvent.MENU_SELECT, onImageMenuShowHandler);
			}
			return contextMenuImageLoader;
		}
		
		private static function onImageMenuShowHandler(_evt:ContextMenuEvent):void {
			var _imageLoader:*=_evt.contextMenuOwner as ImageLoader;
			var _source:String = _imageLoader.source;
			if (_source) {
				_source = _source.split("/").pop();
			}else {
				_source = "--";
			}
			_source = _source + ":" + _imageLoader.areaWidth + " x " + _imageLoader.areaHeight;
			contextMenuItemImageLoader.caption = _source;
		}
		
		public var progressClip:*;
		public var container:*;
		public var foreground:*;
		public var background:*;
		public var content:Bitmap;
		
		public var limitSize:Boolean;
		
		protected var areaRect:Rectangle;
		protected var eventComplete:Event = new Event(Event.COMPLETE);
		protected var eventProgress:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
		
		
		protected var __loadProgress:Number = 0;
		public function get loadProgress():Number {
			return __loadProgress;
		}
		private var __imageGroup:String;
		public function get imageGroup():String{
			return __imageGroup;
		}
		public function set imageGroup(_imageGroup:String):void{
			__imageGroup = _imageGroup;
		}
		public function get maxConnections():uint{
			return createManager(imageGroup).maxConnections;
		}
		public function set maxConnections(_maxConnections:uint):void{
			createManager(imageGroup).maxConnections = _maxConnections;
		}
		public function get noCache():Boolean{
			return createManager(imageGroup).vars.noCache;
		}
		public function set noCache(_noCache:Boolean):void{
			createManager(imageGroup).vars.noCache = _noCache;
		}
		private var __areaWidth:int = 0;
		public function get areaWidth():int {
			return __areaWidth;
		}
		public function set areaWidth(_areaWidth:int):void {
			__areaWidth = _areaWidth;
			if (content) {
				//updateArea(content);
			}
		}
		private var __areaHeight:int = 0;
		public function get areaHeight():int {
			return __areaHeight;
		}
		public function set areaHeight(_areaHeight:int):void {
			__areaHeight = _areaHeight;
			if (content) {
				//updateArea(content);
			}
		}
		protected var __source:String;
		public function get source():String {
			return __source;
		}
		protected var bmdNow:BitmapData;
		public function get bitmapData():BitmapData {
			return bmdNow;
		}
		override protected function init():void {
			super.init();
			imageGroup = getQualifiedClassName(this);
			if (!container) {
				container = this;
			}
			if (background) {
				areaWidth = background.width;
				areaHeight = background.height;
				areaRect = getBounds(background);
			}else if (container.width * container.height > 0) {
				areaWidth = container.width;
				areaHeight = container.height;
				areaRect = container.getBounds(container);
			}else {
				areaRect = getBounds(this);
			}
			setProgressClip(false);
			content = new Bitmap();
			content.alpha = 0;
			contextMenu = createMenu(this);
		}
		override protected function onRemoveHandler():void {
			TweenMax.killChildTweensOf(this);
			TweenMax.killTweensOf(content);
			super.onRemoveHandler();
			if (container != this && container.contains(content)) {
				container.removeChild(content);
			}
			content.bitmapData = null;
			bmdNow = null;
			deregister(__source, this);
			__source = null;
			progressClip = null;
			container = null;
			foreground = null;
			background = null;
		}
		protected var tweenMode:uint;
		public function load(_source:*, _index:uint = 0, _tweenMode:* = 2):void {
			if (_source && _source is String && __source == _source) {
				//这是为了干什么来着?
				//trace("//这是为了干什么来着");
				onImageLoadingHandler(null);
				onImageLoadedHandler(null);
				return;
			}
			if (_tweenMode === true) {
				_tweenMode = 1;
			}else if (_tweenMode === false) {
				_tweenMode = 2;
			}
			tweenMode = _tweenMode;
			if (_source is BitmapData) {
				onImageLoadingHandler(null);
				onImageLoadedHandler(_source);
				deregister(__source, this);
				__source = null;
			}else {
				if (tweenMode == 0 && getProgress(_source) < 1) {
					//tweenMode = 1;
				}
				loadBMD(_source, this, _index);
			}
			//loadBMD后再更新__source，因为dic需要依靠__source来注销上一个监听
			__source = _source;
		}
		public function unload(_changeImmediately:Boolean = true):void {
			TweenMax.killTweensOf(content);
			content.alpha = 0;
			deregister(__source, this);
			__source = null;
			content.bitmapData = null;
			bmdNow = null;
		}
		protected var isHideTweening:Boolean;
		protected function hideBMP(_content:*, onHideComplete:Function = null):void {
			if (isHideTweening) {
				return;
			}
			isHideTweening = true;
			TweenMax.killTweensOf(content);
			TweenMax.to(content, (tweenMode == 2)?10:0, { alpha:0, useFrames:true, ease:Sine.easeInOut, onComplete:onHideComplete } );
		}
		private function onHideEndHandler():void {
			isHideTweening = false;
			setBMP(bmdNow);
		}
		protected function setBMP(_content:*):void {
			if (!_content || isHideTweening) {
				return;
			}
			content.bitmapData = _content;
			content.smoothing = true;
			if (container != this) {
				container.addChild(content);
			}else if (foreground) {
				container.addChildAt(content, getChildIndex(foreground));
			}else if (background) {
				container.addChildAt(content, getChildIndex(background) + 1);
			}else if (progressClip) {
				container.addChildAt(content, getChildIndex(progressClip));
			}else {
				container.addChild(content);
			}
			TweenMax.killTweensOf(content);
			TweenMax.to(content, (tweenMode == 0)?0:12, { alpha:1, useFrames:true, ease:Sine.easeInOut } );
			updateArea(content);
		}
		protected function updateArea(_content:*):void {
			if (areaWidth + areaHeight <= 0) {
				//原始大小显示
			}else {
				var _areaAspectRatio:Number = areaWidth / areaHeight;
				var _contentAspectRatio:Number = _content.width / _content.height;
				if (_areaAspectRatio > _contentAspectRatio) {
					_content.height = areaHeight;
					_content.scaleX = _content.scaleY;
					_content.y = areaRect.y;
					_content.x = areaRect.x + (areaWidth - _content.width) * 0.5;
				}else {
					_content.width = areaWidth;
					_content.scaleY = _content.scaleX;
					_content.x = areaRect.x;
					_content.y = areaRect.y + (areaHeight - _content.height) * 0.5;
				}
			}
		}
		protected function onImageErrorHandler(_evt:*):void {
			setProgressClip(false);
			//dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		protected function onImageLoadingHandler(_evt:*):void {
			if (_evt) {
				__loadProgress = _evt.target.progress;
				setProgressClip(__loadProgress);
			}
			eventProgress.bytesLoaded = _evt?_evt.target.bytesLoaded:1;
			eventProgress.bytesTotal = _evt?_evt.target.bytesTotal:1;
			dispatchEvent(eventProgress);
		}
		protected function onImageLoadedHandler(_evt:*):void {
			
			var _isReady:Boolean = !Boolean(bmdNow);
			if (_evt is LoaderEvent) {
				bmdNow = _evt.target.rawContent.bitmapData;
			}else if (_evt is BitmapData) {
				bmdNow = _evt as BitmapData;
			}
			if (_evt && bmdNow) {
				__loadProgress = 1;
				if (_isReady) {
					setBMP(bmdNow);
				}else {
					hideBMP(content, onHideEndHandler);
				}
			}
			setProgressClip(false);
			
			dispatchEvent(eventComplete);
		}
		protected function setProgressClip(_progress:*):void {
			if (!progressClip) {
				return;
			}
			if (_progress is Number) {
				progressClip.visible = true;
				if (progressClip.hasOwnProperty("text")) {
					progressClip.text = Math.round(_progress * 100) + " %";
				}else if (progressClip.hasOwnProperty("value")) {
					progressClip.value = _progress;
				}else if (progressClip is MovieClip) {
					progressClip.play();
				}
			}else {
				progressClip.visible = _progress;
				if (progressClip is MovieClip) {
					if (_progress) {
						progressClip.play();
					}else {
						progressClip.stop();
					}
				}
			}
		}
		
		
		private static var loaderMaxDic:Object = { };
		private static var imageLoaderDic:Object = { };
		private static var registeredDic:Object = { };
		private static var loaderMax:LoaderMax;
		private static var allContainer:Sprite = new Sprite();
		private static var imageLoader:com.greensock.loading.ImageLoader;
		private static var imageLoaderParams:Object = {container:allContainer};
		protected static function createManager(_imageGroup:String):LoaderMax {
			if (!loaderMaxDic[_imageGroup]) {
				loaderMax = new LoaderMax( { name:_imageGroup,
											noCache:false,
											onChildFail:onChildFailHandler,
											onChildProgress:onChildProgressHandler,
											onChildComplete:onChildCompleteHandler,
											onProgress:onProgressHandler,
											onComplete:onCompleteHandler,
											onError:onErrorHandler
											} );
				loaderMaxDic[_imageGroup] = loaderMax;
			}
			return loaderMaxDic[_imageGroup];
		}
		public static var onGroupLoading:Function;
		public static var onGroupLoaded:Function;
		public static function getProgress(_source:String):Number {
			imageLoader = imageLoaderDic[_source];
			if (imageLoader) {
				return imageLoader.progress;
			}else {
				//NaN?
				return 0;
			}
		}
		public static function getBMD(_source:String):BitmapData {
			imageLoader = imageLoaderDic[_source];
			if (imageLoader) {
				if (imageLoader.progress == 1 && imageLoader.rawContent && imageLoader.rawContent.bitmapData) {
					//已经加载完图片
					return imageLoader.rawContent.bitmapData;
				}
			}
			return null;
		}
		
		protected static function loadBMD(_source:String, _imageLoader:ui.ImageLoader, _index:uint = 0):void {
			imageLoader = imageLoaderDic[_source];
			if (imageLoader) {
				if (imageLoader.progress == 1 && imageLoader.rawContent && imageLoader.rawContent.bitmapData) {
					//已经加载完图片
					_imageLoader.onImageLoadingHandler(null);
					_imageLoader.onImageLoadedHandler(imageLoader.rawContent.bitmapData);
					return;
				}else {
					register(_source, _imageLoader);
					//将正在加载的图片加载优先级提前或退后
					loaderMax = createManager(_imageLoader.imageGroup);
					if (imageLoader == loaderMax.getLoader(_source)) {
						//同组请求图片的情况
						if (imageLoader.progress == 0) {
							loaderMax.insert(imageLoader, _index);
						}
					}else {
						//异组请求图片的情况,要找到imageLoader属于哪个loaderMax
					}
					return;
				}
			}
			//添加新的加载
			register(_source, _imageLoader);
			loaderMax = createManager(_imageLoader.imageGroup);
			
			imageLoaderParams.name = _source;
			imageLoaderParams.noCache = loaderMax.vars.noCache;
			imageLoader = new com.greensock.loading.ImageLoader(String(_source), imageLoaderParams);
			imageLoaderDic[_source] = imageLoader;
			
			loaderMax.insert(imageLoader, _index);
			loaderMax.load();
			return;
		}
		private static function register(_source:String, _imageLoader:ui.ImageLoader):void {
			deregister(_imageLoader.source, _imageLoader);
			if (!registeredDic[_source]) {
				registeredDic[_source] = new Dictionary();
			}
			registeredDic[_source][_imageLoader] = _imageLoader;
		}
		private static function deregister(_source:String, _imageLoader:ui.ImageLoader):void {
			if (registeredDic[_source]) {
				delete registeredDic[_source][_imageLoader];
			}
		}
		private static function onChildFailHandler(_evt:LoaderEvent):void {
			var _dic:Dictionary = registeredDic[_evt.target.url];
			if (!_dic) {
				return;
			}
			for each(var _imageLoader:ui.ImageLoader in _dic) {
				_imageLoader.onImageErrorHandler(_evt);
			}
		}
		private static function onChildProgressHandler(_evt:LoaderEvent):void {
			var _dic:Dictionary = registeredDic[_evt.target.url];
			if (!_dic) {
				return;
			}
			for each(var _imageLoader:ui.ImageLoader in _dic) {
				_imageLoader.onImageLoadingHandler(_evt);
			}
		}
		private static function onChildCompleteHandler(_evt:LoaderEvent):void {
			var _dic:Dictionary = registeredDic[_evt.target.url];
			if (!_dic) {
				return;
			}
			for each(var _imageLoader:ui.ImageLoader in _dic) {
				_imageLoader.onImageLoadedHandler(_evt);
				deregister(_evt.target.url,_imageLoader);
			}
			/*for each(imageLoader in imageLoaderDic) {
				if (imageLoader.progress == 1) {
					_evt.currentTarget.remove(imageLoader);
				}
			}*/
		}
		private static function onErrorHandler(_evt:LoaderEvent):void {
			//removeLoaderFormDic
			trace(_evt.toString());
		}
		private static function onProgressHandler(_evt:LoaderEvent):void{
			if (onGroupLoading!=null) {
				onGroupLoading(_evt.currentTarget.name, _evt.currentTarget.progress);
			}
		}
		private static function onCompleteHandler(_evt:LoaderEvent):void{
			if (onGroupLoaded!=null) {
				onGroupLoaded(_evt.currentTarget.name);
			}
		}
	}
}