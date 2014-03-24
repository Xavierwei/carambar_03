/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.standard
{
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * Microblogs api - Oauth
	 * ---
	 * 微博《授权管理类》，使用API时请给currentAccountKey赋值，所有接口会从这个变量中取值。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class Oauth
	{
		private static var _oauths:Object;
		
		private static var _oauthingKey:OauthKey;
		private static var _currentAccountKey:OauthKey;
		
		public function Oauth()
		{
			
		}

		public static function get currentAccountKey():OauthKey
		{
			return _currentAccountKey;
		}

		public static function set currentAccountKey(value:OauthKey):void
		{
			_currentAccountKey = value;
		}

		public static function get oauthingKey():OauthKey
		{
			return _oauthingKey;
		}

		public static function set oauthingKey(value:OauthKey):void
		{
			_oauthingKey = value;
		}

		public static function addOauth(key:OauthKey):void{
			if(_oauths[key.tokenKey] == null){
				_oauths[key.tokenKey] = key;
			}
		}
		
		public static function getOauth(tokenKey:String):OauthKey{
			return _oauths[tokenKey];
		}
	}
}