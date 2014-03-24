/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.standard
{
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;

	/**
	 * Microblogs api - DoAPI
	 * ---
	 * 微博API实现类的基类。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoAPI
	{
		public function DoAPI(dataHandler:Function, errorHandler:Function)
		{
			this._dataHandler = dataHandler;
			this._errorHandler = errorHandler;
			_httpConn = new HttpConnection();
			initEvents();
		}
		
		/**
		 * 
		 * HTTP链接对象
		 * 
		 * */
		protected var _httpConn:HttpConnection;
		/**
		 * 
		 * 正确数据回调函数
		 * 
		 * */
		protected var _dataHandler:Function;
		/**
		 * 
		 * 发生错误回调函数
		 * 
		 * */
		protected var _errorHandler:Function;
		
		private function onHttpErrorHandler(evt:HttpEvent):void{
			_errorHandler(evt.params);
		}
		private function initEvents():void{
			_httpConn.addEventListener(HttpEvent.onHttpError, onHttpErrorHandler);
		}
	}
}