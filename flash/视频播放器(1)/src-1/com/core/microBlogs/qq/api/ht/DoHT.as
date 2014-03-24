/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.ht
{
	import com.core.microBlogs.standard.DoAPI;
	import com.core.microBlogs.standard.Oauth;
	import com.util.OauthUrlUtil;
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	import com.util.http.HttpParameter;
	
	import com.adobe.serialization.json.JSON;
	
	/**
	 * Microblogs api - DoHT
	 * ---
	 * QQ微博《话题相关》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoHT extends DoAPI
	{
		/**
		 * 根据话题ID获取话题相关信息 URL
		 * */
		public const HT_IDS:String = "http://open.t.qq.com/api/ht/ids";
		/**
		 * 根据话题ID获取话题相关微博 URL
		 * */
		public const HT_INFO:String = "http://open.t.qq.com/api/ht/info";
		
		
		/**
		 * 根据话题ID获取话题相关信息 回调Command
		 * */
		public static const CMD_HT_IDS:String = "CMD_HT_IDS";
		/**
		 * 根据话题ID获取话题相关微博 回调Command
		 * */
		public static const CMD_HT_INFO:String = "CMD_HT_INFO";
		
		public function DoHT(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.ht/ids 根据话题名称查询话题ID
		 * httexts: 话题名字列表（abc,efg,）
		 * 
		 **/
		public function getHtIdsByHtName(httexts:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("httexts", encodeURI(httexts)));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(HT_IDS, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getHtIdsByHtNameHandler, url);
			
			function getHtIdsByHtNameHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_HT_IDS, params);
			}
		}
		
		/**
		 * 
		 * 2.ht/info 根据话题ID获取话题相关微博
		 * ids: 话题ID列表（12345,12345,）最多15个
		 * 
		 **/
		public function getHtInfoByHtIDs(ids:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("ids", encodeURI(ids)));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(HT_INFO, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getHtInfoByHtIDsHandler, url);
			
			function getHtInfoByHtIDsHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_HT_INFO, params);
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