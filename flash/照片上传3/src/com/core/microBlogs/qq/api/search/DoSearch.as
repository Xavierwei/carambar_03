/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.search
{
	import com.core.microBlogs.standard.DoAPI;
	import com.core.microBlogs.standard.Oauth;
	import com.util.OauthUrlUtil;
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	import com.util.http.HttpParameter;
	
	import com.adobe.serialization.json.JSON;

	/**
	 * Microblogs api - DoSearch
	 * ---
	 * QQ微博《搜索相关》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoSearch extends DoAPI
	{
		/**
		 * 搜索用户URL
		 * */
		public const SEARCH_USER:String = "http://open.t.qq.com/api/search/user";
		/**
		 * 搜索微博URL
		 * */
		public const SEARCH_T:String = "http://open.t.qq.com/api/search/t";
		/**
		 * 通过标签搜索用户URL
		 * */
		public const SEARCH_USER_BY_TAG:String = "http://open.t.qq.com/api/search/userbytag";
		
		/**
		 * 搜索用户回调command
		 * */
		public static const CMD_SEARCH_USER:String = "CMD_SEARCH_USER";
		/**
		 * 搜索微博回调command
		 * */
		public static const CMD_SEARCH_T:String = "CMD_SEARCH_T";
		/**
		 * 通过标签搜索用户回调command
		 * */
		public static const CMD_SEARCH_USER_BY_TAG:String = "CMD_SEARCH_USER_BY_TAG";
		
		public function DoSearch(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.Search/user 搜索用户
		 * Keyword:搜索关键字
		 * pagesize: 每页大小
		 * Page: 页码
		 * 
		 **/
		public function searchUser(keyword:String, pagesize:int, page:int, format:String = "json"):void{
			if(page < 1) page = 1;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("keyword", encodeURI(keyword)));
			paras.push(new HttpParameter("pagesize", pagesize.toString()));
			paras.push(new HttpParameter("page", page.toString()));
			
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(SEARCH_USER, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(searchUserHandler, url);
			
			function searchUserHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_SEARCH_USER, params);
			}
		}
		
		/**
		 * 
		 * 2.Search/t 搜索微博
		 * Keyword:搜索关键字
		 * pagesize: 每页大小
		 * Page: 页码
		 * 
		 **/
		public function searchT(keyword:String, pagesize:int, page:int, format:String = "json"):void{
			if(page < 1) page = 1;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("keyword", encodeURI(keyword)));
			paras.push(new HttpParameter("pagesize", pagesize.toString()));
			paras.push(new HttpParameter("page", page.toString()));
			
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(SEARCH_T, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(searchTHandler, url);
			
			function searchTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_SEARCH_T, params);
			}
		}
		
		/**
		 * 
		 * 3.Search/userbytag 通过标签搜索用户
		 * Keyword:搜索关键字
		 * pagesize: 每页大小
		 * Page: 页码
		 * 
		 **/
		public function searchUserByTag(keyword:String, pagesize:int, page:int, format:String = "json"):void{
			if(page < 1) page = 1;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("keyword", encodeURI(keyword)));
			paras.push(new HttpParameter("pagesize", pagesize.toString()));
			paras.push(new HttpParameter("page", page.toString()));
			
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(SEARCH_USER_BY_TAG, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(searchUserByTagHandler, url);
			
			function searchUserByTagHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_SEARCH_USER_BY_TAG, params);
			}
		}
		
		private function onHttpDataHandler(cmd:String, params:Object):void{
			
			_dataHandler(cmd, params);
		}
		
		private function executeResponse(format:String, data:String):Object
		{
			//json
			var params:Object;
			if(format == "json")
				params = com.adobe.serialization.json.JSON.decode(data);
				//xml
			else if(format == "xml")
				params = new XML(data);
			return params;
		}
	}
}