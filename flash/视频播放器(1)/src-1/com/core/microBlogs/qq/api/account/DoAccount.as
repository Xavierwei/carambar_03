/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.account
{
	import com.core.microBlogs.standard.DoAPI;
	import com.core.microBlogs.standard.Oauth;
	import com.util.OauthUrlUtil;
	import com.util.http.Clear;
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	import com.util.http.HttpParameter;
	
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	
	import com.adobe.serialization.json.JSON;

	/**
	 * Microblogs api - DoAccount
	 * ---
	 * QQ微博《账户相关》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoAccount extends DoAPI
	{
		/**
		 * 获取自己的详细资料URL
		 * */
		public const USER_INFO:String = "http://open.t.qq.com/api/user/info";
		/**
		 * 更新用户信息URL
		 * */
		public const USER_UPDATE:String = "http://open.t.qq.com/api/user/update";
		/**
		 * 更新用户头像URL
		 * */
		public const USER_UPDATE_HEAD:String = "http://open.t.qq.com/api/user/update_head";
		/**
		 * 获取其他人资料URL
		 * */
		public const OTHER_USER_INFO:String = "http://open.t.qq.com/api/user/other_info";
		
		
		
		/**
		 * 获取自己的详细资料回调Command
		 * */
		public static const CMD_USER_INFO:String = "CMD_USER_INFO";
		/**
		 * 更新用户信息回调Command
		 * */
		public static const CMD_USER_UPDATE:String = "CMD_USER_UPDATE";
		/**
		 * 更新用户头像回调Command
		 * */
		public static const CMD_USER_UPDATE_HEAD:String = "CMD_USER_UPDATE_HEAD";
		/**
		 * 获取其他人资料回调Command
		 * */
		public static const CMD_OTHER_USER_INFO:String = "CMD_OTHER_USER_INFO";
		
		public function DoAccount(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.User/info获取自己的详细资料
		 * 
		 **/
		public function getUserInfo(format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(USER_INFO, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			Oauth.currentAccountKey.callbackUrl = null;
			
			_httpConn.sendRequest(getUserInfoHandler, url);
			
			function getUserInfoHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_USER_INFO, params);
			}
		}
		
		/**
		 * 
		 * 2.user/update 更新用户信息
		 * nick: 昵称
		 * Sex: 性别 0 ，1：男2：女
		 * Year:出生年 1900-2010
		 * Month:出生月 1-12
		 * Day:出生日 1-31
		 * Countrycode:国家码
		 * Provincecode:地区码
		 * Citycode:城市码
		 * Introduction: 个人介绍
		 * 
		 **/
		public function updateUserInfo(nick:String, sex:int, year:int, month:int, day:int, 
									   countrycode:int, provincecode:int, citycode:int, 
									   introduction:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("nick", encodeURI(nick)));
			paras.push(new HttpParameter("sex", sex.toString()));
			paras.push(new HttpParameter("year", year.toString()));
			paras.push(new HttpParameter("month", month.toString()));
			paras.push(new HttpParameter("day", day.toString()));
			paras.push(new HttpParameter("countrycode", countrycode.toString()));
			paras.push(new HttpParameter("provincecode", provincecode.toString()));
			paras.push(new HttpParameter("citycode", citycode.toString()));
			paras.push(new HttpParameter("introduction", encodeURI(introduction)));
			
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(USER_UPDATE,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(getUserInfoHandler, USER_UPDATE, URLRequestMethod.POST, postParas);
			
			function getUserInfoHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_USER_UPDATE, params);
			}
		}
		
		/**
		 * 
		 * 3.user/update_head 更新用户头像信息
		 * pic: 文件域表单名 本字段不要签名的参数中，不然请求时会出现签名错误
		 * 
		 **/
		public function updateUserHeadImg(format:String = "json"):void{
			var fileFilter:FileFilter = new FileFilter("图片文件", "*.jpg;*.gif;*.png");
			var file:FileReference = new FileReference();
			file.addEventListener(Event.SELECT, selectHandler);
			file.browse([fileFilter]);
			function selectHandler(e:Event):void
			{
				Clear.removeEvent(e.currentTarget, Event.SELECT, selectHandler);
				var tmpFR:FileReference = FileReference(e.target);
				setup(tmpFR);
			}
			
			function setup(fr:FileReference):void
			{
				var paras:Array = [];
				paras.push(new HttpParameter("format", format));
				paras.push(new HttpParameter("Upload", "Submit Query"));
				paras.push(new HttpParameter("Filename", fr.name));
				
				Oauth.currentAccountKey.httpMethod = "POST";
				paras = OauthUrlUtil.getOauthPostParas(USER_UPDATE_HEAD,
					Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
					Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
					Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
					Oauth.currentAccountKey.callbackUrl, paras);
				
				var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
				_httpConn.sendRequest(addPicHandler, USER_UPDATE_HEAD, URLRequestMethod.POST, postParas, fr);
				
				function addPicHandler(data:String):void{
					var params:Object = executeResponse(format, data);
					onHttpDataHandler(CMD_USER_UPDATE_HEAD, params);
				}
			}
		}
		
		/**
		 * 
		 * 4.user/other_info 获取其他人资料
		 * 
		 **/
		public function getOtherUserInfo(name:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("name", encodeURI(name)));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(OTHER_USER_INFO, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getOtherUserInfoHandler, url);
			
			function getOtherUserInfoHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_OTHER_USER_INFO, params);
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