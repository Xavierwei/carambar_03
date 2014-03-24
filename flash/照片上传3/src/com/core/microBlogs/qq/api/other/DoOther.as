/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.other
{
	import com.core.microBlogs.standard.DoAPI;
	import com.core.microBlogs.standard.Oauth;
	import com.util.OauthUrlUtil;
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	import com.util.http.HttpParameter;
	
	import com.adobe.serialization.json.JSON;
	
	/**
	 * Microblogs api - DoOther
	 * ---
	 * QQ微博《其他》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10 
	 * @author 毛业兴
	 * 
	 */
	public class DoOther extends DoAPI
	{
		/**
		 * 我可能认识到人URL
		 * */
		public const OTHER_KOWNPERSON:String = "http://open.t.qq.com/api/other/kownperson";
		
		/**
		 * 我可能认识到人回调Command
		 * */
		public static const CMD_OTHER_KOWNPERSON:String = "CMD_OTHER_KOWNPERSON";
		
		public function DoOther(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.other/kownperson 我可能认识的人
		 * Ip:相同IP的人（用户的IP） 必填
		 * Country_code：国家码 可以不填
		 * Province_code: 省份码 可以不填
		 * City_code: 城市码 可以不填
		 * 
		 **/
		public function getOtherKownPersons(ip:String, country_code:String = null, province_code:String = null, city_code:String = null, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("ip", ip));
			if(country_code)
				paras.push(new HttpParameter("country_code", country_code));
			if(province_code)
				paras.push(new HttpParameter("province_code", province_code));
			if(city_code)
				paras.push(new HttpParameter("city_code", city_code));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(OTHER_KOWNPERSON, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getOtherKownPersonsHandler, url);
			
			function getOtherKownPersonsHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_OTHER_KOWNPERSON, params);
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