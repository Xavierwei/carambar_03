package com.util.http
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	/**
	 * HttpConnection class.
	 * 
	 * @version	1.0.0
	 * 
	 * @author	The gotoAndPlay() Team
	 * 			{@link http://www.smartfoxserver.com}
	 * 			{@link http://www.gotoandplay.it}
	 * 
	 * @exclude
	 */
	public class HttpConnection extends EventDispatcher
	{
		private var _urlRequest:URLRequest;
		
		function HttpConnection()
		{
			
		}
		
		public function sendRequest(responseHandler:Function, url:String, method:String = URLRequestMethod.GET, paras:String = null, file:FileReference = null):void
		{
//			trace(url);
			_urlRequest = new URLRequest(url);
			_urlRequest.method = method;
			
			if(method == URLRequestMethod.POST){
				var vars:URLVariables = new URLVariables(paras);
				_urlRequest.data = vars;
			}
			
			if(file != null)
			{
				//文件上传完毕后，获取服务端返回的数据
				file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadDataHandler);
				file.upload(_urlRequest, "pic");
			}else
			{
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.addEventListener(Event.COMPLETE, dataHandler);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
				urlLoader.load(_urlRequest);
			}
			function uploadDataHandler(de:DataEvent):void
			{
				Clear.removeEvent(de.currentTarget, DataEvent.UPLOAD_COMPLETE_DATA, uploadDataHandler);
				responseHandler(de.data);
			}
			function dataHandler(e:Event):void
			{
				Clear.removeEvent(e.currentTarget, Event.COMPLETE, dataHandler);
				responseHandler(e.currentTarget.data);
			}
		}
		
		private function handleIOError(error:IOErrorEvent):void
		{
			trace("http response error:", error.currentTarget.data);
			var event:HttpEvent = new HttpEvent(HttpEvent.onHttpError, error.currentTarget);
			dispatchEvent(event);
		}
	}
}