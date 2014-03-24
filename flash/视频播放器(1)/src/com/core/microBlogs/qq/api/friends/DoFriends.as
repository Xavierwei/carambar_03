/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.friends
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
	 * Microblogs api - DoFriends
	 * ---
	 * QQ微博《关系链相关》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoFriends extends DoAPI
	{
		/**
		 * 我的听众列表URL
		 * */
		public const FRIENDS_FANSLIST:String = "http://open.t.qq.com/api/friends/fanslist";
		/**
		 * 我收听的列表URL
		 * */
		public const FRIENDS_IDOLLIST:String = "http://open.t.qq.com/api/friends/idollist";
		/**
		 * 黑名单列表URL
		 * */
		public const FRIENDS_BLACKLIST:String = "http://open.t.qq.com/api/friends/blacklist";
		/**
		 * 特别收听列表URL
		 * */
		public const FRIENDS_SPECIALLIST:String = "http://open.t.qq.com/api/friends/speciallist";
		/**
		 * 收听某个用户URL
		 * */
		public const FRIENDS_ADD:String = "http://open.t.qq.com/api/friends/add";
		/**
		 * 取消收听某个用户URL
		 * */
		public const FRIENDS_DEL:String = "http://open.t.qq.com/api/friends/del";
		/**
		 * 特别收听某个用户URL
		 * */
		public const FRIENDS_ADD_SPECIAL:String = "http://open.t.qq.com/api/friends/addspecial";
		/**
		 * 取消特别收听某个用户URL
		 * */
		public const FRIENDS_DEL_SPECIAL:String = "http://open.t.qq.com/api/friends/delspecial";
		/**
		 * 添加某个用户到黑名单URL
		 * */
		public const FRIENDS_ADD_BLACKLIST:String = "http://open.t.qq.com/api/friends/addblacklist";
		/**
		 * 从黑名单删除某个用户URL
		 * */
		public const FRIENDS_DEL_BLACKLIST:String = "http://open.t.qq.com/api/friends/delblacklist";
		/**
		 * 检测是否我的听众或收听的人URL
		 * */
		public const FRIENDS_CHECK:String = "http://open.t.qq.com/api/friends/check";
		/**
		 * 其他帐户听众列表URL
		 * */
		public const FRIENDS_USER_FANSLIST:String = "http://open.t.qq.com/api/friends/user_fanslist";
		/**
		 * 其他帐户收听的人列表URL
		 * */
		public const FRIENDS_USER_IDOLLIST:String = "http://open.t.qq.com/api/friends/user_idollist";
		/**
		 * 其他帐户特别收听的人列表URL
		 * */
		public const FRIENDS_USER_SPECIALLIST:String = "http://open.t.qq.com/api/friends/user_speciallist";
		
		
		/**
		 * 我的听众列表 回调Command
		 * */
		public static const CMD_FRIENDS_FANSLIST:String = "CMD_FRIENDS_FANSLIST";
		/**
		 * 我收听的列表 回调Command
		 * */
		public static const CMD_FRIENDS_IDOLLIST:String = "CMD_FRIENDS_IDOLLIST";
		/**
		 * 黑名单列表 回调Command
		 * */
		public static const CMD_FRIENDS_BLACKLIST:String = "CMD_FRIENDS_BLACKLIST";
		/**
		 * 特别收听列表 回调Command
		 * */
		public static const CMD_FRIENDS_SPECIALLIST:String = "CMD_FRIENDS_SPECIALLIST";
		/**
		 * 收听某个用户 回调Command
		 * */
		public static const CMD_FRIENDS_ADD:String = "CMD_FRIENDS_ADD";
		/**
		 * 取消收听某个用户 回调Command
		 * */
		public static const CMD_FRIENDS_DEL:String = "CMD_FRIENDS_DEL";
		/**
		 * 特别收听某个用户 回调Command
		 * */
		public static const CMD_FRIENDS_ADD_SPECIAL:String = "CMD_FRIENDS_ADD_SPECIAL";
		/**
		 * 取消特别收听某个用户 回调Command
		 * */
		public static const CMD_FRIENDS_DEL_SPECIAL:String = "CMD_FRIENDS_DEL_SPECIAL";
		/**
		 * 添加某个用户到黑名单 回调Command
		 * */
		public static const CMD_FRIENDS_ADD_BLACKLIST:String = "CMD_FRIENDS_ADD_BLACKLIST";
		/**
		 * 从黑名单删除某个用户 回调Command
		 * */
		public static const CMD_FRIENDS_DEL_BLACKLIST:String = "CMD_FRIENDS_DEL_BLACKLIST";
		/**
		 * 检测是否我的听众或收听的人 回调Command
		 * */
		public static const CMD_FRIENDS_CHECK:String = "CMD_FRIENDS_FRIENDS_CHECK";
		/**
		 * 其他帐户听众列表 回调Command
		 * */
		public static const CMD_FRIENDS_USER_FANSLIST:String = "CMD_FRIENDS_USER_FANSLIST";
		/**
		 * 其他帐户收听的人列表 回调Command
		 * */
		public static const CMD_FRIENDS_USER_IDOLLIST:String = "CMD_FRIENDS_USER_IDOLLIST";
		/**
		 * 其他帐户特别收听的人列表 回调Command
		 * */
		public static const CMD_FRIENDS_USER_SPECIALLIST:String = "CMD_FRIENDS_USER_SPECIALLIST";
		
		public function DoFriends(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.friends/fanslist 我的听众列表
		 * reqnum: 请求个数(1-30)
		 * startindex: 起始位置（第一页填0，继续向下翻页：填：【reqnum*（page-1）】）
		 * 
		 **/
		public function getFansList(reqnum:int, page:int = 1, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 30) reqnum = 30;
			if(page < 1) page = 1;
			
			var startindex:int = reqnum * (page - 1);
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("startindex", startindex.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FRIENDS_FANSLIST, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getFansListHandler, url);
			
			function getFansListHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_FANSLIST, params);
			}
		}
		
		/**
		 * 
		 * 2.friends/idollist 我收听的人列表
		 * reqnum: 请求个数(1-30)
		 * startindex: 起始位置（第一页填0，继续向下翻页：填：【reqnum*（page-1）】）
		 * 
		 **/
		public function getIdolList(reqnum:int, page:int = 1, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 30) reqnum = 30;
			if(page < 1) page = 1;
			
			var startindex:int = reqnum * (page - 1);
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("startindex", startindex.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FRIENDS_IDOLLIST, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getIdolListHandler, url);
			
			function getIdolListHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_IDOLLIST, params);
			}
		}
		
		/**
		 * 
		 * 3.Friends/blacklist 黑名单列表
		 * reqnum: 请求个数(1-30)
		 * startindex: 起始位置（第一页填0，继续向下翻页：填：【reqnum*（page-1）】）
		 * 
		 **/
		public function getBlackList(reqnum:int, page:int = 1, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 30) reqnum = 30;
			if(page < 1) page = 1;
			
			var startindex:int = reqnum * (page - 1);
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("startindex", startindex.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FRIENDS_BLACKLIST, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getBlackListHandler, url);
			
			function getBlackListHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_BLACKLIST, params);
			}
		}
		
		/**
		 * 
		 * 4.Friends/speciallist 特别收听列表
		 * reqnum: 请求个数(1-30)
		 * startindex: 起始位置（第一页填0，继续向下翻页：填：【reqnum*（page-1）】）
		 * 
		 **/
		public function getSpecialList(reqnum:int, page:int = 1, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 30) reqnum = 30;
			if(page < 1) page = 1;
			
			var startindex:int = reqnum * (page - 1);
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("startindex", startindex.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FRIENDS_SPECIALLIST, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getSpecialListHandler, url);
			
			function getSpecialListHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_SPECIALLIST, params);
			}
		}
		
		/**
		 * 
		 * 5.friends/add 收听某个用户
		 * name: 他人的帐户名
		 * 
		 **/
		public function addIdol(name:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", name));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FRIENDS_ADD,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(addIdolHandler, FRIENDS_ADD, URLRequestMethod.POST, postParas);
			
			function addIdolHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_ADD, params);
			}
		}
		
		/**
		 * 
		 * 6.friends/del取消收听某个用户
		 * name: 他人的帐户名
		 * 
		 **/
		public function delIdol(name:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", name));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FRIENDS_DEL,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(getAddIdolHandler, FRIENDS_DEL, URLRequestMethod.POST, postParas);
			
			function getAddIdolHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_DEL, params);
			}
		}
		
		/**
		 * 
		 * 7.friends/addspecial 特别收听某个用户
		 * name: 他人的帐户名
		 * 
		 **/
		public function addSpecialIdol(name:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", name));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FRIENDS_ADD_SPECIAL,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(addSpecialIdolHandler, FRIENDS_ADD_SPECIAL, URLRequestMethod.POST, postParas);
			
			function addSpecialIdolHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_ADD_SPECIAL, params);
			}
		}
		
		/**
		 * 
		 * 8.friends/delspecial 取消特别收听某个用户
		 * name: 他人的帐户名
		 * 
		 **/
		public function delSpecialIdol(name:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", name));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FRIENDS_DEL_SPECIAL,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(delSpecialIdolHandler, FRIENDS_DEL_SPECIAL, URLRequestMethod.POST, postParas);
			
			function delSpecialIdolHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_DEL_SPECIAL, params);
			}
		}
		
		/**
		 * 
		 * 9.friends/addblacklist 添加某个用户到黑名单
		 * name: 他人的帐户名
		 * 
		 **/
		public function addBlack(name:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", name));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FRIENDS_ADD_BLACKLIST,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(addBlackHandler, FRIENDS_ADD_BLACKLIST, URLRequestMethod.POST, postParas);
			
			function addBlackHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_ADD_BLACKLIST, params);
			}
		}
		
		/**
		 * 
		 * 10.friends/delblacklist 从黑名单中删除某个用户
		 * name: 他人的帐户名
		 * 
		 **/
		public function delBlack(name:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", name));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(FRIENDS_DEL_BLACKLIST,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(delBlackHandler, FRIENDS_DEL_BLACKLIST, URLRequestMethod.POST, postParas);
			
			function delBlackHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_DEL_BLACKLIST, params);
			}
		}
		/**
		 * 
		 * 11.friends/check 检测是否我的听众或收听的人
		 * name: 他人的帐户名
		 * 
		 **/
		public function checkFriend(name:String, flag:int = 2, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("flag", flag.toString()));
			paras.push(new HttpParameter("names", name));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FRIENDS_CHECK, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(checkFriendHandler, url);
			
			function checkFriendHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_CHECK, params);
			}
		}
		
		/**
		 * 
		 * 12.friends/user_fanslist 其他帐户听众列表
		 * reqnum: 请求个数(1-30)
		 * startindex: 起始位置（第一页填0，继续向下翻页：填：【reqnum*（page-1）】）
		 * Name: 用户帐户名
		 * 
		 **/
		public function getUserFansList(name:String, reqnum:int, page:int = 1, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 30) reqnum = 30;
			if(page < 1) page = 1;
			
			var startindex:int = reqnum * (page - 1);
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", name));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("startindex", startindex.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FRIENDS_USER_FANSLIST, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getUserFansListHandler, url);
			
			function getUserFansListHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_USER_FANSLIST, params);
			}
		}
		
		/**
		 * 
		 * 13.friends/user_idollist 其他帐户收听的人列表
		 * reqnum: 请求个数(1-30)
		 * startindex: 起始位置（第一页填0，继续向下翻页：填：【reqnum*（page-1）】）
		 * Name: 用户帐户名
		 * 
		 **/
		public function getUserIdolList(name:String, reqnum:int, page:int = 1, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 30) reqnum = 30;
			if(page < 1) page = 1;
			
			var startindex:int = reqnum * (page - 1);
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", name));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("startindex", startindex.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FRIENDS_USER_IDOLLIST, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getUserIdolListHandler, url);
			
			function getUserIdolListHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_USER_IDOLLIST, params);
			}
		}
		
		/**
		 * 
		 * 14.friends/user_speciallist 其他帐户特别收听的人列表
		 * reqnum: 请求个数(1-30)
		 * startindex: 起始位置（第一页填0，继续向下翻页：填：【reqnum*（page-1）】）
		 * Name: 用户帐户名
		 * 
		 **/
		public function getUserSpecialList(name:String, reqnum:int, page:int = 1, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 30) reqnum = 30;
			if(page < 1) page = 1;
			
			var startindex:int = reqnum * (page - 1);
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", name));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("startindex", startindex.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(FRIENDS_USER_SPECIALLIST, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getUserSpecialListHandler, url);
			
			function getUserSpecialListHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_FRIENDS_USER_SPECIALLIST, params);
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