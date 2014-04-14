/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.timeline
{
	import com.core.microBlogs.standard.DoAPI;
	import com.core.microBlogs.qq.api.oauth.OauthKeyQQ;
	import com.core.microBlogs.standard.Oauth;
	import com.util.OauthUrlUtil;
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	import com.util.http.HttpParameter;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import com.adobe.serialization.json.JSON;

	/**
	 * Microblogs api - DoTimeline
	 * ---
	 * QQ微博《时间线相关》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10 
	 * @author 毛业兴
	 * 
	 */
	public class DoTimeline extends DoAPI
	{
		/**
		 * 主页时间线URL
		 * */
		public const HOME_TIMELINE:String = "http://open.t.qq.com/api/statuses/home_timeline";
		/**
		 * 广播大厅时间线URL
		 * */
		public const PUBLIC_TIMELINE:String = "http://open.t.qq.com/api/statuses/public_timeline";
		/**
		 * 其他用户时间线URL
		 * */
		public const USER_TIMELINE:String = "http://open.t.qq.com/api/statuses/user_timeline";
		/**
		 * @提到我的时间线URL
		 * */
		public const MENTIONS_TIMELINE:String = "http://open.t.qq.com/api/statuses/mentions_timeline";
		/**
		 * 话题时间线URL
		 * */
		public const HT_TIMELINE:String = "http://open.t.qq.com/api/statuses/ht_timeline";
		/**
		 * 我发表的时间线URL
		 * */
		public const BROADCAST_TIMELINE:String = "http://open.t.qq.com/api/statuses/broadcast_timeline";
		/**
		 * 特别收听到人时间线URL
		 * */
		public const SPECIAL_TIMELINE:String = "http://open.t.qq.com/api/statuses/special_timeline";
		
		
		/**
		 * 主页时间线回调command
		 * */
		public static const CMD_HOME_TIMELINE:String = "CMD_HOME_TIMELINE";
		/**
		 * 广播大厅时间线回调command
		 * */
		public static const CMD_PUBLIC_TIMELINE:String = "CMD_PUBLIC_TIMELINE";
		/**
		 * 其他用户时间线回调command
		 * */
		public static const CMD_USER_TIMELINE:String = "CMD_USER_TIMELINE";
		/**
		 * @提到我的时间线回调command
		 * */
		public static const CMD_MENTIONS_TIMELINE:String = "CMD_MENTIONS_TIMELINE";
		/**
		 * 话题时间线回调command
		 * */
		public static const CMD_HT_TIMELINE:String = "CMD_HT_TIMELINE";
		/**
		 * 我发表的时间线回调command
		 * */
		public static const CMD_BROADCAST_TIMELINE:String = "CMD_BROADCAST_TIMELINE";
		/**
		 * 特别收听到人时间线回调command
		 * */
		public static const CMD_SPECIAL_TIMELINE:String = "CMD_SPECIAL_TIMELINE";
		
		public function DoTimeline(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.Statuses/home_timeline 主页时间线
		 * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * PageTime：本页起始时间（第一页 时填0，继续翻页：填上一次请求返回的最后一条记录时间，）
		 * Reqnum：每次请求记录的条数（1-20条）
		 * 
		**/
		public function getHomeTimeline(pageFlag:int, pageTime:int, reqnum:int, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(pageFlag == 0) pageTime = 0;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pageflag", pageFlag.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("pagetime", pageTime.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(HOME_TIMELINE, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getHomeTimelineHandler, url);
			
			function getHomeTimelineHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_HOME_TIMELINE, params);
			}
		}
		
		/**
		 * 
		 * 2.Statuses/public_timeline 广播大厅时间线
		 * Pos: 记录的起始位置（第一次请求是填0，继续请求进填上次返回的Pos）
		 * Reqnum: 每次请求记录的条数（1-20条）
		 * 
		 **/
		public function getPublicTimeline(pos:int, reqnum:int, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(pos < 0) pos = 0;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pos", pos.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(PUBLIC_TIMELINE, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getPublicTimelineHandler, url);
			
			function getPublicTimelineHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_PUBLIC_TIMELINE, params);
			}
		}
		
		/**
		 * 
		 * 3.Statuses/user_timeline 其他用户发表时间线
		 * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * PageTime: 本页起始时间（第第一页 时填0，继续翻页：填上一次请求返回的最后一条记录时间
		 * Reqnum: 每次请求记录的条数（1-20条）
		 * Lastid: 第一页 时填0,继续向下翻页，填上一次请求返回的最后一条记录ID，翻页用
		 * Name : 你需要读取该用户的用户名
		 * 
		 **/
		public function getUserTimeline(pageFlag:int, pageTime:int, reqnum:int, lastId:int, name:String, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(lastId < 0) lastId = 0;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pageflag", pageFlag.toString()));
			paras.push(new HttpParameter("pagetime", pageTime.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("lastid", lastId.toString()));
			paras.push(new HttpParameter("name", name));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(USER_TIMELINE, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getUserTimelineHandler, url);
			
			function getUserTimelineHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_USER_TIMELINE, params);
			}
		}
		
		/**
		 * 
		 * 4.Statuses/mentions_timeline @提到我的时间线
		 * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * PageTime: 本页起始时间（第第一页 时填0，继续翻页：填上一次请求返回的最后一条记录时间
		 * Reqnum: 每次请求记录的条数（1-20条）
		 * Lastid: 第一页 时填0,继续向下翻页，填上一次请求返回的最后一条记录ID，翻页用
		 * 
		 **/
		public function getMentionsTimeline(pageFlag:int, pageTime:int, reqnum:int, lastId:int, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(lastId < 0) lastId = 0;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pageflag", pageFlag.toString()));
			paras.push(new HttpParameter("pagetime", pageTime.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("lastid", lastId.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(MENTIONS_TIMELINE, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getMentionsTimelineHandler, url);
			
			function getMentionsTimelineHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_MENTIONS_TIMELINE, params);
			}
		}
		
		/**
		 * 
		 * 5.Statuses/ht_timeline 话题时间线
		 * Httext: 话题名字
		 * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * pageinfo: 分页标识（第一页 填空，继续翻页：填上上次返回的 pageinfo）
		 * Reqnum: 每次请求记录的条数（1-20条）
		 * 
		 **/
		public function getHTTimeline(httext:String, pageFlag:int, pageinfo:String, reqnum:int, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("httext", encodeURI(httext)));
			if(pageFlag != 0)
				paras.push(new HttpParameter("pageflag", pageFlag.toString()));
			if(pageinfo != null)
				paras.push(new HttpParameter("pageinfo", pageinfo));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(HT_TIMELINE, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getHTTimelineHandler, url);
			
			function getHTTimelineHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_HT_TIMELINE, params);
			}
		}
		
		/**
		 * 
		 * 6.Statuses/broadcast_timeline 我发表时间线
		  * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * PageTime: 本页起始时间（第第一页 时填0，继续翻页：填上一次请求返回的最后一条记录时间
		 * Reqnum: 每次请求记录的条数（1-20条）
		 * Lastid: 第一页 时填0,继续向下翻页，填上一次请求返回的最后一条记录ID，翻页用
		 * 
		 **/
		public function getBroadcastTimeline(pageFlag:int, pageTime:int, reqnum:int, lastId:int, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(lastId < 0) lastId = 0;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pageflag", pageFlag.toString()));
			paras.push(new HttpParameter("pagetime", pageTime.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("lastid", lastId.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(BROADCAST_TIMELINE, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getBroadcastTimelineHandler, url);
			
			function getBroadcastTimelineHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_BROADCAST_TIMELINE, params);
			}
		}
		
		/**
		 * 
		 * 7.Statuses/special_timeline 特别收听的人发表时间线
		 * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * PageTime：本页起始时间（第一页 时填0，继续翻页：填上一次请求返回的最后一条记录时间，）
		 * Reqnum：每次请求记录的条数（1-20条）
		 * 
		 **/
		public function getSpecialTimeline(pageFlag:int, pageTime:int, reqnum:int, format:String = "json"):void{
			if(reqnum < 1) reqnum = 1;
			if(reqnum > 20) reqnum = 20;
			if(pageFlag == 0) pageTime = 0;
			
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("pageflag", pageFlag.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("pagetime", pageTime.toString()));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(SPECIAL_TIMELINE, 
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey, 
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey, 
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify, 
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getSpecialTimelineHandler, url);
			
			function getSpecialTimelineHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_SPECIAL_TIMELINE, params);
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