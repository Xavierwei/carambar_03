/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.trends
{
	import com.core.microBlogs.standard.DoAPI;
	import com.core.microBlogs.standard.Oauth;
	import com.util.OauthUrlUtil;
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	import com.util.http.HttpParameter;
	
	import com.adobe.serialization.json.JSON;

	/**
	 * Microblogs api - DoTrends
	 * ---
	 * QQ微博《热度/趋势》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoTrends extends DoAPI
	{
		/**
		 * 话题热榜URL
		 * */
		public const HT:String = "http://open.t.qq.com/api/trends/ht";
		
		/**
		 * 话题热榜回调Command
		 * */
		public static const CMD_HT:String = "CMD_HT";
		
		public function DoTrends(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.trends/ht 话题热榜
		 * Type: 请求类型 1 话题名，2 搜索关键字 3 两种类型都有
		 * Pos: 记录的起始位置（第一次请求是填0，继续请求进填上次返回的Pos）
		 * Reqnum: 每次请求记录的条数（1-20条）
		 * 
		 **/
		public function getTrendsHT(pos:int, reqnum:int, type:int = 3, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(pos < 0) pos = 0;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("type", type.toString()));
			paras.push(new HttpParameter("pos", pos.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(HT, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getTrendsHTHandler, url);
			
			function getTrendsHTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_HT, params);
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