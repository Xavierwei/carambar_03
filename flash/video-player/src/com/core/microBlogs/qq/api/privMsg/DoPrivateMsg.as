/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.privMsg
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
	 * Microblogs api - DoPrivateMsg
	 * ---
	 * QQ微博《私信相关》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoPrivateMsg extends DoAPI
	{
		/**
		 * 发私信URL
		 * */
		public const PRIVATE_ADD:String = "http://open.t.qq.com/api/private/add";
		/**
		 * 删除一条私信URL
		 * */
		public const PRIVATE_DEL:String = "http://open.t.qq.com/api/private/del";
		/**
		 * 收件箱URL
		 * */
		public const PRIVATE_RECV:String = "http://open.t.qq.com/api/private/recv";
		/**
		 * 发件箱URL
		 * */
		public const PRIVATE_SEND:String = "http://open.t.qq.com/api/private/send";
		
		/**
		 * 发私信回调command
		 * */
		public static const CMD_PRIVATE_ADD:String = "CMD_PRIVATE_ADD";
		/**
		 * 删除一条私信回调command
		 * */
		public static const CMD_PRIVATE_DEL:String = "CMD_PRIVATE_DEL";
		/**
		 * 收件箱回调command
		 * */
		public static const CMD_PRIVATE_RECV:String = "CMD_PRIVATE_RECV";
		/**
		 * 发件箱回调command
		 * */
		public static const CMD_PRIVATE_SEND:String = "CMD_PRIVATE_SEND";
		

		public function DoPrivateMsg(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.private/add 发私信
		 * content: 微博内容 必填项
		 * clientip: 用户IP 必填项，请带上用户浏览器带过来的IP地址，否则会被消息过滤策略拒绝掉
		 * jing: 经度（可以填空）
		 * wei: 纬度（可以填空）
		 * name:对方用户名
		 * 
		 **/
		public function addPrivMsg(content:String, clientip:String, name:String, jing:String = null, wei:String = null, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("content", encodeURI(content)));
			paras.push(new HttpParameter("clientip", clientip));
			paras.push(new HttpParameter("name", name));
			if(jing != null)
				paras.push(new HttpParameter("jing", jing));
			if(wei != null)
				paras.push(new HttpParameter("wei", wei));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(PRIVATE_ADD,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(addPrivMsgHandler, PRIVATE_ADD, URLRequestMethod.POST, postParas);
			
			function addPrivMsgHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_PRIVATE_ADD, params);
			}
		}
		
		/**
		 * 
		 * 2.private/del 删除一条私信
		 * id: 微博ID
		 * 
		 **/
		public function delPrivMsg(id:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("id", id));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(PRIVATE_DEL,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			_httpConn.sendRequest(delPrivMsgHandler, PRIVATE_DEL, URLRequestMethod.POST, postParas);
			
			function delPrivMsgHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_PRIVATE_DEL, params);
			}
		}
		
		/**
		 * 
		 * 3.private/recv 收件箱
		 * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * PageTime：本页起始时间（第一页 时填0，继续翻页：填上一次请求返回的最后一条记录时间，）
		 * Reqnum：每次请求记录的条数（1-20条）
		 * Lastid: 第一页 时填0,继续向下翻页，填上一次请求返回的最后一条记录ID，翻页用
		 * 
		**/
		public function getPrivateRecv(pageFlag:int, pageTime:int, reqnum:int, lastid:int, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(pageFlag == 0) 
			{
				pageTime = 0;
				lastid = 0;
			}
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pageflag", pageFlag.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("pagetime", pageTime.toString()));
			paras.push(new HttpParameter("lastid", lastid.toString()));
			
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(PRIVATE_RECV, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getPrivateRecvHandler, url);
			
			function getPrivateRecvHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_PRIVATE_RECV, params);
			}
		}
		
		/**
		 * 
		 * 4.private/send 发件箱
		 * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * PageTime：本页起始时间（第一页 时填0，继续翻页：填上一次请求返回的最后一条记录时间，）
		 * Reqnum：每次请求记录的条数（1-20条）
		 * Lastid: 第一页 时填0,继续向下翻页，填上一次请求返回的最后一条记录ID，翻页用
		 * 
		 **/
		public function getPrivateSend(pageFlag:int, pageTime:int, reqnum:int, lastid:int, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(pageFlag == 0) 
			{
				pageTime = 0;
				lastid = 0;
			}
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pageflag", pageFlag.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("pagetime", pageTime.toString()));
			paras.push(new HttpParameter("lastid", lastid.toString()));
			
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(PRIVATE_SEND, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getPrivateSendHandler, url);
			
			function getPrivateSendHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_PRIVATE_SEND, params);
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