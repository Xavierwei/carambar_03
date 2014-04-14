/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.standard
{
	import flash.net.URLRequestMethod;

	/**
	 * Microblogs api - Oauth
	 * ---
	 * 微博《授权bean》。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class OauthKey
	{
		private var _accountName:String;
		private var _customKey:String;
		private var _customSecrect:String;
		private var _tokenKey:String;
		private var _tokenSecrect:String;
		private var _verify:String;
		private var _callbackUrl:String;
		private var _httpMethod:String;
		
		public function OauthKey()
		{
			_httpMethod = URLRequestMethod.GET;
			_callbackUrl = null;
			_tokenKey = null;
			_tokenSecrect = null;
			_verify = null;
		}
		
		public function get accountName():String
		{
			return _accountName;
		}
		
		public function set accountName(value:String):void
		{
			_accountName = value;
		}
		
		public function get httpMethod():String
		{
			return _httpMethod;
		}
		
		public function set httpMethod(value:String):void
		{
			_httpMethod = value;
		}
		
		public function get callbackUrl():String
		{
			return _callbackUrl;
		}
		
		public function set callbackUrl(value:String):void
		{
			_callbackUrl = value;
		}
		
		public function get verify():String
		{
			return _verify;
		}
		
		public function set verify(value:String):void
		{
			_verify = value;
		}
		
		public function get tokenSecrect():String
		{
			return _tokenSecrect;
		}
		
		public function set tokenSecrect(value:String):void
		{
			_tokenSecrect = value;
		}
		
		public function get tokenKey():String
		{
			return _tokenKey;
		}
		
		public function set tokenKey(value:String):void
		{
			_tokenKey = value;
		}
		
		public function get customSecrect():String
		{
			return _customSecrect;
		}
		
		public function set customSecrect(value:String):void
		{
			_customSecrect = value;
		}
		
		public function get customKey():String
		{
			return _customKey;
		}
		
		public function set customKey(value:String):void
		{
			_customKey = value;
		}
	}
}