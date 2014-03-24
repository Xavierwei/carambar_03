/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.fav
{
	import com.core.microBlogs.standard.DoAPI;
	import com.core.microBlogs.standard.Oauth;
	import com.util.OauthUrlUtil;
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	import com.util.http.HttpParameter;
	
	import flash.net.URLRequestMethod;
	
	import com.adobe.serialization.json.JSON;
	
	/**
	 * Microblogs api - DoFav
	 * ---
	 * QQ微博《数据收藏》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoFav extends DoAPI
	{
		/**
		 * 收藏一条微博URL
		 * */
		public const FAV_ADD_T:String = "http://open.t.qq.com/api/fav/addt";
		/**
		 * 删除一条微博从收藏URL
		 * */
		public const FAV_DEL_T:String = "http://open.t.qq.com/api/fav/delt";
		/**
		 * 收藏的微博列表URL
		 * */
		public const FAV_LIST_T:String = "http://open.t.qq.com/api/fav/list_t";
		/**
		 * 订阅话题URL
		 * */
		public const FAV_ADD_HT:String = "http://open.t.qq.com/api/fav/addht";
		/**
		 * 删除订阅话题URL
		 * */
		public const FAV_DEL_HT:String = "http://open.t.qq.com/api/fav/delht";
		/**
		 * 订阅的话题列表URL
		 * */
		public const FAV_LIST_HT:String = "http://open.t.qq.com/api/fav/list_ht";
		
		
		
		/**
		 * 收藏一条微博回调Command
		 * */
		public static const CMD_FAV_ADD_T:String = "CMD_FAV_ADD_T";
		/**
		 * 删除一条微博从收藏回调Command
		 * */
		public static const CMD_FAV_DEL_T:String = "CMD_FAV_DEL_T";
		/**
		 * 收藏的微博列表回调Command
		 * */
		public static const CMD_FAV_LIST_T:String = "CMD_FAV_LIST_T";
		/**
		 * 订阅话题回调Command
		 * */
		public static const CMD_FAV_ADD_HT:String = "CMD_FAV_ADD_HT";
		/**
		 * 删除订阅话题回调Command
		 * */
		public static const CMD_FAV_DEL_HT:String = "CMD_FAV_DEL_HT";
		/**
		 * 订阅的话题列表回调Command
		 * */
		public static const CMD_FAV_LIST_HT:String = "CMD_FAV_LIST_HT";
		
		
		public function DoFav(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.fav/addt 收藏一条微博
		 * id: 微博ID
		 * 
		 **/
		public function addFavT(id:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("id", encodeURI(id)));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FAV_ADD_T,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(addFavTHandler, FAV_ADD_T, URLRequestMethod.POST, postParas);
			
			function addFavTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FAV_ADD_T, params);
			}
		}
		
		/**
		 * 
		 * 2.fav/delt 删除一条微博从收藏
		 * id: 微博ID
		 * 
		 **/
		public function delFavT(id:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("id", encodeURI(id)));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FAV_DEL_T,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(delFavTHandler, FAV_DEL_T, URLRequestMethod.POST, postParas);
			
			function delFavTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FAV_DEL_T, params);
			}
		}
		
		/**
		 * 
		 * 3.fav/list_t 收藏的微博列表
		 * Pageflag：分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * nextTime： 向下翻页起始时间（第一页 时填0，继续翻页：填上一次请求返回的nexttime时间，）
		 * Prevtime： 向下翻
		 * Reqnum：每次请求记录的条数（1-20条）
		 * Lastid：第一页 时填0,继续向下翻页，填上一次请求返回的最后一条记录ID，翻页用
		 * 
		 **/
		public function getFavListT(pageflag:int = 0, nexttime:Number = 0, prevtime:Number = 0, reqnum:int = 20, lastid:Number = 0, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pageflag", pageflag.toString()));
			paras.push(new HttpParameter("nexttime", nexttime.toString()));
			paras.push(new HttpParameter("prevtime", prevtime.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("lastid", lastid.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FAV_LIST_T, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getFavListTHandler, url);
			
			function getFavListTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FAV_LIST_T, params);
			}
		}
		
		/**
		 * 
		 * 1.fav/addt 订阅话题
		 * id: 微博ID
		 * 
		 **/
		public function addFavHT(id:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("id", encodeURI(id)));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FAV_ADD_HT,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(addFavHTHandler, FAV_ADD_HT, URLRequestMethod.POST, postParas);
			
			function addFavHTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FAV_ADD_HT, params);
			}
		}
		
		/**
		 * 
		 * 2.fav/delt 删除D订阅到话题
		 * id: 微博ID
		 * 
		 **/
		public function delFavHT(id:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("id", encodeURI(id)));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FAV_DEL_HT,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(delFavHTHandler, FAV_DEL_HT, URLRequestMethod.POST, postParas);
			
			function delFavHTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FAV_DEL_HT, params);
			}
		}
		
		/**
		 * 
		 * 3.fav/list_t 订阅到话题列表
		 * Pageflag：分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * Reqnum：每次请求记录的条数（1-20条）
		 * Pagetime:翻页时间戳0
		 * Lastid：第一页 时填0,继续向下翻页，填上一次请求返回的最后一条记录ID，翻页用
		 * 
		 **/
		public function getFavListHT(pageflag:int = 0, reqnum:int = 20, pagetime:Number = 0, lastid:Number = 0, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(pageflag == 0) pagetime = 0;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pageflag", pageflag.toString()));
			paras.push(new HttpParameter("pagetime", pagetime.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("lastid", lastid.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FAV_LIST_HT, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getFavListHTHandler, url);
			
			function getFavListHTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FAV_LIST_HT, params);
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