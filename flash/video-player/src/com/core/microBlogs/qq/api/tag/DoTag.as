/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.tag
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
	 * Microblogs api - DoTag
	 * ---
	 * QQ微博《标签相关》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10 
	 * @author 毛业兴
	 * 
	 */
	public class DoTag extends DoAPI
	{
		/**
		 * 添加标签URL
		 * */
		public const TAG_ADD:String = "http://open.t.qq.com/api/tag/add";
		/**
		 * 删除标签URL
		 * */
		public const TAG_DEL:String = "http://open.t.qq.com/api/tag/del";
		
		/**
		 * 添加标签回调command
		 * */
		public static const CMD_TAG_ADD:String = "CMD_TAG_ADD";
		/**
		 * 删除标签回调command
		 * */
		public static const CMD_TAG_DEL:String = "CMD_TAG_DEL";
		
		public function DoTag(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.tag/add 添加标签
		 * tag: 标签内容
		 * 
		 **/
		public function addTag(tag:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("tag", encodeURI(tag)));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(TAG_ADD,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(addTagHandler, TAG_ADD, URLRequestMethod.POST, postParas);
			
			function addTagHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_TAG_ADD, params);
			}
		}
		
		/**
		 * 
		 * 2.tag/del 删除标签
		 * tagid: 标签ID
		 * 
		 **/
		public function delTag(id:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("tagid", encodeURI(id)));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(TAG_DEL,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(delTagHandler, TAG_DEL, URLRequestMethod.POST, postParas);
			
			function delTagHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_TAG_DEL, params);
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