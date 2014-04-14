/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.infoUpdate
{
	import com.core.microBlogs.standard.DoAPI;
	import com.core.microBlogs.standard.Oauth;
	import com.util.OauthUrlUtil;
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	import com.util.http.HttpParameter;
	
	import com.adobe.serialization.json.JSON;

	/**
	 * Microblogs api - DoInfoUpdate
	 * ---
	 * QQ微博《数据更新相关》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10 
	 * @author 毛业兴
	 * 
	 */
	public class DoInfoUpdate extends DoAPI
	{
		/**
		 * 查看数据更新条数URL
		 * */
		public const INFO_UPDATE:String = "http://open.t.qq.com/api/info/update";
		
		/**
		 * 查看数据更新条数 回调Command
		 * */
		public static const CMD_INFO_UPDATE:String = "CMD_INFO_UPDATE";
		
		public function DoInfoUpdate(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.info/update 查看数据更新条数
		 * op :请求类型 0：只请求更新数，不清除更新数，1：请求更新数，并对更新数清零
		 * type：5 首页未读消息记数，6 @页消息记数 7 私信页消息计数 8 新增听众数 9 首页广播数（原创的）
		 * 
		 **/
		public function getInfoUpdate(op:int = 0, type:int = 5, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("type", type.toString()));
			paras.push(new HttpParameter("op", op.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(INFO_UPDATE, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getInfoUpdateHandler, url);
			
			function getInfoUpdateHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_INFO_UPDATE, params);
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