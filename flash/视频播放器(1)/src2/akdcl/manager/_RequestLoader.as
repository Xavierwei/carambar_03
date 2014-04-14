package akdcl.manager {
	import flash.display.AVM1Movie;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;

	import flash.net.URLRequest;

	/**
	 * ...
	 * @author akdcl
	 */
	final internal class _RequestLoader extends Loader {
		private static const LOADER_CONTEXT:LoaderContext = new LoaderContext(true);

		internal var url:String;
		internal var params:Array;

		private var errorHandlers:Dictionary;
		private var progressHandlers:Dictionary;
		private var completeHandlers:Dictionary;

		public function _RequestLoader(){
			errorHandlers = new Dictionary();
			progressHandlers = new Dictionary();
			completeHandlers = new Dictionary();
		}

		override public function load(request:URLRequest, context:LoaderContext = null):void {
			url = request.url;
			super.load(request, context || LOADER_CONTEXT);
		}

		internal function clear():Boolean {
			var _fun:Function;
			for each (_fun in errorHandlers){
				delete errorHandlers[_fun];
			}
			for each (_fun in progressHandlers){
				contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _fun);
				delete progressHandlers[_fun];
			}
			for each (_fun in completeHandlers){
				delete completeHandlers[_fun];
			}
			if (content is Bitmap){
				url = null;
				params = null;
				unload();
				unloadAndStop();
				return true;
			}else {
				//content不是bitmap而是DisplayObject，则不回收Loader;
				return false;
			}
		}

		internal function addEvents(_onProgressHandler:Function, _onErrorHandler:Function, _onCompleteHandler:Function):void {
			if (_onErrorHandler != null){
				errorHandlers[_onErrorHandler] = _onErrorHandler;
			}
			if (_onProgressHandler != null){
				progressHandlers[_onProgressHandler] = _onProgressHandler;
				contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
			}
			if (_onCompleteHandler != null){
				completeHandlers[_onCompleteHandler] = _onCompleteHandler;
			}
		}

		internal function removeEvents(_onProgressHandler:Function, _onErrorHandler:Function, _onCompleteHandler:Function):void {
			if (_onErrorHandler != null){
				delete errorHandlers[_onErrorHandler];
			}
			if (_onProgressHandler != null){
				contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
				delete progressHandlers[_onProgressHandler];
			}
			if (_onCompleteHandler != null){
				delete completeHandlers[_onCompleteHandler];
			}
		}

		internal function onErrorHandler(_evt:Event):void {
			for each (var _onError:Function in errorHandlers){
				switch (_onError.length){
					case 0:
						_onError();
						break;
					case 1:
						_onError(_evt);
						break;
					case 2:
						_onError(_evt, url);
						break;
					case 3:
						_onError(_evt, url, params);
						break;
				}
			}
		}

		internal function onCompleteHandler():void {
			var _content:*;
			if (content is Bitmap){
				_content = (content as Bitmap).bitmapData;
			} else {
				_content = this;
			}
			for each (var _onComplete:Function in completeHandlers){
				switch (_onComplete.length){
					case 0:
						_onComplete();
						break;
					case 1:
						_onComplete(_content);
						break;
					case 2:
						_onComplete(_content, url);
						break;
					case 3:
						_onComplete(_content, url, params);
						break;
				}
			}
		}
	}

}