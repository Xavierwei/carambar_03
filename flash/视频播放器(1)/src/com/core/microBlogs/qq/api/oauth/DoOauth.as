/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.oauth
{
	import com.core.microBlogs.standard.DoAPI;
	import com.core.microBlogs.standard.Oauth;
	import com.util.OauthUrlUtil;
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import com.adobe.serialization.json.JSON;
	
	/**
	 * Microblogs api - DoOauth
	 * 
	 * ---QQ微博《Oauth授权》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10 
	 * @author 毛业兴
	 * 
	 */
	public class DoOauth extends DoAPI
	{
		/**
		 * 获取request_token URL
		 * */
		public static const REQUEST_TOKEN_URL:String = "https://open.t.qq.com/cgi-bin/request_token";
		/**
		 * 用户授权request_token URL
		 * */
		public static const OAUTH_TOKEN_URL:String = "http://open.t.qq.com/cgi-bin/authorize";
		/**
		 * 交换access_token URL
		 * */
		public static const ACCESS_TOKEN_URL:String = "https://open.t.qq.com/cgi-bin/access_token";
		
		
		/**
		 * 获取request_token 回调Command
		 * */
		public static const CMD_REQUEST_TOKEN:String = "CMD_REQUEST_TOKEN";
		/**
		 * 交换access_token 回调Command
		 * */
		public static const CMD_ACCESS_TOKEN:String = "CMD_ACCESS_TOKEN";
		
		
		public function DoOauth(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 获取request_token
		 * 
		 * appKey：申请应用的app_key
		 * appSecret：申请应用的app_secret
		 * callback：回调地址，如果是桌面应用程序则不需要赋值，默认值null
		 * */
		public function getRequestToken(appKey:String, appSecret:String, callBack:String = null):void{
			var key:OauthKeyQQ = new OauthKeyQQ();
			key.customKey = appKey;
			key.customSecrect = appSecret;
			if(callBack == null)
				callBack = "null";
			key.callbackUrl = OauthUrlUtil.executeString(callBack);
			
			Oauth.oauthingKey = key;
			Oauth.oauthingKey.httpMethod = "GET";
			var paras:Array = [];
			var url:String = OauthUrlUtil.getOauthUrl(REQUEST_TOKEN_URL, key.httpMethod, key.customKey, 
								key.customSecrect, key.tokenKey, key.tokenSecrect, 
									key.verify, callBack, paras);
			
			_httpConn.sendRequest(requestTokenHandler, url);
			
			function requestTokenHandler(data:String):void{
				var params:Object = executeResponse(CMD_REQUEST_TOKEN, data);
				onHttpDataHandler(CMD_REQUEST_TOKEN, params);
			}
		}
		
		/**
		 * 用户授权request_token，跳转到微博官方网站
		 * */
		public function authRequestToken():void{
			var url:String = OAUTH_TOKEN_URL + "?" + "oauth_token=" + Oauth.oauthingKey.tokenKey;
			var urlRequest:URLRequest = new URLRequest(url);
			navigateToURL(urlRequest);
		}
		
		/**
		 * 交换access_token，获取最后的授权token，获取后请自行在应用程序中做持久化，建议与应用账户系统进行绑定。
		 * */
		public function getAccessToken():void{
			var paras:Array = [];
			Oauth.oauthingKey.callbackUrl = null;
			Oauth.oauthingKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(ACCESS_TOKEN_URL, 
				Oauth.oauthingKey.httpMethod, Oauth.oauthingKey.customKey, 
				Oauth.oauthingKey.customSecrect, Oauth.oauthingKey.tokenKey, 
				Oauth.oauthingKey.tokenSecrect, Oauth.oauthingKey.verify, 
				Oauth.oauthingKey.callbackUrl, paras);
			
			_httpConn.sendRequest(accessTokenHandler, url);
			
			function accessTokenHandler(data:String):void{
				var params:Object = executeResponse(CMD_ACCESS_TOKEN, data);
				onHttpDataHandler(CMD_ACCESS_TOKEN, params);
			}
		}
		
		private function onHttpDataHandler(cmd:String, params:Object):void{
			switch(cmd)
			{
				case DoOauth.CMD_REQUEST_TOKEN:
				{
					Oauth.oauthingKey.tokenKey = params.oauth_token;
					Oauth.oauthingKey.tokenSecrect = params.oauth_token_secret;
					break;
				}
				case DoOauth.CMD_ACCESS_TOKEN:
				{
					Oauth.currentAccountKey = Oauth.oauthingKey;
					Oauth.currentAccountKey.accountName = params.name;
					Oauth.currentAccountKey.tokenKey = params.oauth_token;
					Oauth.currentAccountKey.tokenSecrect = params.oauth_token_secret;
					Oauth.currentAccountKey.verify = null;
					break;
				}
				default:
				{
					break;
				}
			}
			_dataHandler(cmd, params);
		}
		
		private function executeResponse(cmd:String, data:String):Object
		{
			var params:Object = {};
			var datas:Array = data.split("&");
			for(var i:int = 0; i < datas.length; i++){
				var key:String = datas[i].split("=")[0];
				var value:String = datas[i].split("=")[1];
				params[key] = value;
			}
			return params;
		}
	}
}