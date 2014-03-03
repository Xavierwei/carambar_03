package akdcl.manager {
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;

	import com.adobe.serialization.json.JSON;

	import akdcl.manager.RequestManager;

	/**
	 * ...
	 * @author akdcl
	 */
	final internal class _RequestURLLoader extends URLLoader {
		internal var url:String;
		internal var params:Array;

		private var errorHandlers:Dictionary;
		private var progressHandlers:Dictionary;
		private var completeHandlers:Dictionary;

		public function _RequestURLLoader(){
			errorHandlers = new Dictionary();
			progressHandlers = new Dictionary();
			completeHandlers = new Dictionary();
		}

		override public function load(request:URLRequest):void {
			url = request.url;
			if (dataFormat){
			} else {
				var _type:String = url.split("?").shift().split(".").pop().toLowerCase();
				switch (_type){
					case "jpg":
					case "png":
					case "gif":
					case "swf":
					case "bmp":
						dataFormat = URLLoaderDataFormat.BINARY;
						break;
					case "xml":
						dataFormat = RequestManager.DATAFORMAT_XML;
						break;
				}
			}
			super.load(request);
		}

		internal function clear():void {
			var _fun:Function;
			for each (_fun in errorHandlers){
				delete errorHandlers[_fun];
			}
			for each (_fun in progressHandlers){
				removeEventListener(ProgressEvent.PROGRESS, _fun);
				delete progressHandlers[_fun];
			}
			for each (_fun in completeHandlers){
				delete completeHandlers[_fun];
			}
			url = null;
			data = null;
			dataFormat = null;
		}

		internal function getFormatData():* {
			switch (dataFormat){
				case RequestManager.DATAFORMAT_XML:
					try {
						return XML(data);
					} catch (_e:*){
					}
					return null;
				case RequestManager.DATAFORMAT_JSON:
					try {
						//去掉json不支持的字符串
						var _dataFotmat:String = data.replace(/[\x00-\x1f]/g, "");
						return com.adobe.serialization.json.JSON.decode(_dataFotmat);
					} catch (_e:*){
					}
					return null;
				case RequestManager.DATAFORMAT_AMF3:
					try {
						var _bytes:ByteArray = data as ByteArray;
						//if (_compressed){
						//_bytes.uncompress();
						//}
						return _bytes.readObject();
					} catch (_e:*){
					}
					return null;
				case URLLoaderDataFormat.BINARY:
				case URLLoaderDataFormat.VARIABLES:
					return data;
				case URLLoaderDataFormat.TEXT:
				default:
					//去掉多余换行空格字符
					data = String(data).replace(/^\s*|\s*$/g, "");
					return data;
			}
		}

		internal function addEvents(_onProgressHandler:Function, _onErrorHandler:Function, _onCompleteHandler:Function):void {
			if (_onErrorHandler != null){
				errorHandlers[_onErrorHandler] = _onErrorHandler;
			}
			if (_onProgressHandler != null){
				progressHandlers[_onProgressHandler] = _onProgressHandler;
				addEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
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
				removeEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
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
			var _data:* = getFormatData();
			for each (var _onComplete:Function in completeHandlers){
				switch (_onComplete.length){
					case 0:
						_onComplete();
						break;
					case 1:
						_onComplete(_data);
						break;
					case 2:
						_onComplete(_data, url);
						break;
					case 3:
						_onComplete(_data, url, params);
						break;
				}
			}
		}
	}

}