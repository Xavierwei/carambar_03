/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq.api.broadcast
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
	 * Microblogs api - DoBroadcast
	 * ---
	 * QQ微博《微博相关》API实现。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoBroadcast extends DoAPI
	{
		/**
		 * 获取指定微博URL
		 * */
		public const T_SHOW:String = "http://open.t.qq.com/api/t/show";
		/**
		 * 发表一条微博URL
		 * */
		public const ADD_T:String = "http://open.t.qq.com/api/t/add";
		/**
		 * 删除一条微博URL
		 * */
		public const DEL_T:String = "http://open.t.qq.com/api/t/del";
		/**
		 * 转播一条微博URL
		 * */
		public const RE_ADD_T:String = "http://open.t.qq.com/api/t/re_add";
		/**
		 * 回复一条微博URL
		 * */
		public const REPLY_T:String = "http://open.t.qq.com/api/t/reply";
		/**
		 * 发表一条带图片的微博URL
		 * */
		public const ADD_PIC:String = "http://open.t.qq.com/api/t/add_pic";
		/**
		 * 转播数或点评数URL
		 * */
		public const RE_COUNT:String = "http://open.t.qq.com/api/t/re_count";
		/**
		 * 获取单条微博的转发或点评列表URL
		 * */
		public const RE_LIST:String = "http://open.t.qq.com/api/t/re_list";
		/**
		 * 点评一条微博URL
		 * */
		public const COMMENT:String = "http://open.t.qq.com/api/t/comment";
		/**
		 * 发表音乐微博URL
		 * */
		public const ADD_MUSIC:String = "http://open.t.qq.com/api/t/add_music";
		/**
		 * 发表视频微博URL
		 * */
		public const ADD_VIDEO:String = "http://open.t.qq.com/api/t/add_video";
		/**
		 * 获取视频信息URL
		 * */
		public const GET_VIDEO_INFO:String = "http://open.t.qq.com/api/t/getvideoinfo";
		
		
		
		/**
		 * 获取指定微博回调command
		 * */
		public static const CMD_T_SHOW:String = "CMD_T_SHOW";
		/**
		 * 发表一条微博回调command
		 * */
		public static const CMD_ADD_T:String = "CMD_ADD_T";
		/**
		 * 删除一条微博回调command
		 * */
		public static const CMD_DEL_T:String = "CMD_DEL_T";
		/**
		 * 转播一条微博回调command
		 * */
		public static const CMD_RE_ADD_T:String = "CMD_RE_ADD_T";
		/**
		 * 回复一条微博回调command
		 * */
		public static const CMD_REPLY_T:String = "CMD_REPLY_T";
		/**
		 * 发表一条带图片的微博回调command
		 * */
		public static const CMD_ADD_PIC:String = "CMD_ADD_PIC";
		/**
		 * 转播数或点评数回调command
		 * */
		public static const CMD_RE_COUNT:String = "CMD_T_RE_COUNT";
		/**
		 * 获取单条微博的转发或点评列表回调command
		 * */
		public static const CMD_RE_LIST:String = "CMD_RE_LIST";
		/**
		 * 点评一条微博回调command
		 * */
		public static const CMD_COMMENT:String = "CMD_COMMENT";
		/**
		 * 发表音乐微博回调command
		 * */
		public static const CMD_ADD_MUSIC:String = "CMD_ADD_MUSIC";
		/**
		 * 发表视频微博回调command
		 * */
		public static const CMD_ADD_VIDEO:String = "CMD_ADD_VIDEO";
		/**
		 * 获取视频信息回调command
		 * */
		public static const CMD_GET_VIDEO_INFO:String = "CMD_GET_VIDEO_INFO";
		
		public function DoBroadcast(dataHandler:Function, errorHandler:Function)
		{
			super(dataHandler, errorHandler);
		}
		
		/**
		 * 
		 * 1.t/show 获取一条微博数据
		 * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * PageTime：本页起始时间（第一页 时填0，继续翻页：填上一次请求返回的最后一条记录时间，）
		 * Reqnum：每次请求记录的条数（1-20条）
		 * 
		 **/
		public function getTShow(id:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("id", id));
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(T_SHOW,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getTShowHandler, url);
			
			function getTShowHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_T_SHOW, params);
			}
		}

		/**
		 * 
		 * 2.t/add 发表一条微博
		 * content: 微博内容 必填项
		 * clientip: 用户IP 必填项，请带上用户浏览器带过来的IP地址，否则会被消息过滤策略拒绝掉
		 * jing: 经度（可以填空）
		 * wei: 纬度（可以填空）
		 * 
		 **/
		public function addT(content:String, clientip:String, jing:String = null, wei:String = null, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("content", encodeURI(content)));
			paras.push(new HttpParameter("clientip", clientip));
			if(jing != null)
				paras.push(new HttpParameter("jing", jing));
			if(wei != null)
				paras.push(new HttpParameter("wei", wei));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(ADD_T,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			
			_httpConn.sendRequest(addTHandler, ADD_T, URLRequestMethod.POST, postParas);
			
			function addTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_ADD_T, params);
			}
		}
		
		/**
		 * 
		 * 3.t/del 删除一条微博
		 * id: 微博ID
		 * 
		 **/
		public function delT(id:String, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("id", id));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(DEL_T,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			_httpConn.sendRequest(delTHandler, DEL_T, URLRequestMethod.POST, postParas);
			
			function delTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_DEL_T, params);
			}
		}
		
		/**
		 * 
		 * 4.t/re_add 转播一条微博
		 * content: 微博内容 必填项
		 * clientip: 用户IP 必填项，请带上用户浏览器带过来的IP地址，否则会被消息过滤策略拒绝掉
		 * jing: 经度（可以填空）
		 * wei: 纬度（可以填空）
		 * reid: 转播父结点微博ID 必填项
		 * 
		 **/
		public function reAddT(content:String, clientip:String, reid:String, jing:String = null, wei:String = null, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("content", encodeURI(content)));
			paras.push(new HttpParameter("clientip", clientip));
			paras.push(new HttpParameter("reid", reid));
			if(jing != null)
				paras.push(new HttpParameter("jing", jing));
			if(wei != null)
				paras.push(new HttpParameter("wei", wei));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(RE_ADD_T,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			_httpConn.sendRequest(reAddTHandler, RE_ADD_T, URLRequestMethod.POST, postParas);
			
			function reAddTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_RE_ADD_T, params);
			}
		}
		
		/**
		 * 
		 * 5.t/reply 回复一条微博
		 * content: 微博内容 必填项
		 * clientip: 用户IP 必填项，请带上用户浏览器带过来的IP地址，否则会被消息过滤策略拒绝掉
		 * jing: 经度（可以填空）
		 * wei: 纬度（可以填空）
		 * reid: 回复父结点微博ID 必填项
		 * 
		 **/
		public function replyT(content:String, clientip:String, reid:String, jing:String = null, wei:String = null, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("content", encodeURI(content)));
			paras.push(new HttpParameter("clientip", clientip));
			paras.push(new HttpParameter("reid", reid));
			if(jing != null)
				paras.push(new HttpParameter("jing", jing));
			if(wei != null)
				paras.push(new HttpParameter("wei", wei));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(REPLY_T,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			_httpConn.sendRequest(replyTHandler, REPLY_T, URLRequestMethod.POST, postParas);
			
			function replyTHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_REPLY_T, params);
			}
		}
		
		/**
		 * 
		 * 6.t/add_pic 发表一条带图片的微博
		 * content: 微博内容 必填项
		 * clientip: 用户IP 必填项，请带上用户浏览器带过来的IP地址，否则会被消息过滤策略拒绝掉
		 * jing: 经度（可以填空）
		 * wei: 纬度（可以填空）
		 * pic: 文件域表单名 本字段不要签名的参数中，不然请求时会出现签名错误
		 * 
		 **/
		public function addPic(content:String, clientip:String, jing:String = null, wei:String = null, format:String = "json"):void{
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
				paras.push(new HttpParameter("content", encodeURI(content)));
				paras.push(new HttpParameter("clientip", clientip));
				paras.push(new HttpParameter("Upload", "Submit Query"));
				paras.push(new HttpParameter("Filename", fr.name));
				if(jing != null)
					paras.push(new HttpParameter("jing", jing));
				if(wei != null)
					paras.push(new HttpParameter("wei", wei));
				
				Oauth.currentAccountKey.httpMethod = "POST";
				paras = OauthUrlUtil.getOauthPostParas(ADD_PIC,
					Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
					Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
					Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
					Oauth.currentAccountKey.callbackUrl, paras);
				
				var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
				_httpConn.sendRequest(addPicHandler, ADD_PIC, URLRequestMethod.POST, postParas, fr);
				
				function addPicHandler(data:String):void{
					var params:Object = executeResponse(format, data);
					onHttpDataHandler(CMD_ADD_PIC, params);
				}
			}
		}
		
		/**
		 * 
		 * 7.t/re_count 转播数或点评数
		 * Ids: 微博ID的列表
		 * Flag:0 获取转发计数，1点评计数 2 两者都取
		 * 
		 **/
		public function getReCount(ids:String, flag:int = 2, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("ids", encodeURI(ids)));
			paras.push(new HttpParameter("flag", flag.toString()));
			
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(RE_COUNT,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getReCountHandler, url);
			
			function getReCountHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_RE_COUNT, params);
			}
		}
		
		/**
		 * 
		 * 8.t/re_list 获取单条微博的转发或点评列表
		 * Flag:标识0 转播列表，1点评列表 2 点评与转播列表
		 * RootId：转发或者回复根结点ID（源微博ID）；
		 * Pageflag 分页标识（0：第一页，1：向下翻页，2向上翻页）
		 * PageTime：本页起始时间（第一页 时填0，继续翻页：填上一次请求返回的最后一条记录时间，）
		 * Reqnum：每次请求记录的条数（1-20条）
		 * TwitterId: 第一页 时填0,继续向下翻页，填上一次请求返回的最后一条记录ID，翻页用
		 * 
		 **/
		public function getReList(rootId:String, flag:int = 2, pageFlag:int = 0, pageTime:Number = 0, reqnum:int = 20, broadcastId:String = "0", format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("rootid", rootId));
			paras.push(new HttpParameter("flag", flag.toString()));
			paras.push(new HttpParameter("pageflag", pageFlag.toString()));
			paras.push(new HttpParameter("pagetime", pageTime.toString()));
			paras.push(new HttpParameter("reqnum", reqnum.toString()));
			paras.push(new HttpParameter("twitterid", broadcastId));
			
			Oauth.currentAccountKey.httpMethod = "GET";
			var url:String = OauthUrlUtil.getOauthUrl(RE_LIST,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			_httpConn.sendRequest(getReListHandler, url);
			
			function getReListHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_RE_LIST, params);
			}
		}
		
		/**
		 * 
		 * 9.t/comment 点评一条微博
		 * content: 微博内容 必填项
		 * clientip: 用户IP 必填项，请带上用户浏览器带过来的IP地址，否则会被消息过滤策略拒绝掉
		 * jing: 经度（可以填空）
		 * wei: 纬度（可以填空）
		 * reid: 转播父结点微博ID 必填项
		 * 
		 **/
		public function comment(content:String, clientip:String, reid:String, jing:String = null, wei:String = null, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("content", encodeURI(content)));
			paras.push(new HttpParameter("clientip", clientip));
			paras.push(new HttpParameter("reid", reid));
			if(jing != null)
				paras.push(new HttpParameter("jing", jing));
			if(wei != null)
				paras.push(new HttpParameter("wei", wei));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(COMMENT,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			_httpConn.sendRequest(reCommentHandler, COMMENT, URLRequestMethod.POST, postParas);
			
			function reCommentHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_COMMENT, params);
			}
		}
		
		/**
		 * 
		 * 10.t/add_music发表音乐微博
		 * content: 微博内容 必填项
		 * clientip: 用户IP 必填项，请带上用户浏览器带过来的IP地址，否则会被消息过滤策略拒绝掉
		 * jing: 经度（可以填空）
		 * wei: 纬度（可以填空）
		 * Url:音乐地址
		 * Title:音乐名
		 * Author:演唱者
		 * 
		 **/
		public function addMusic(content:String, clientip:String, url:String, title:String, author:String, jing:String = null, wei:String = null, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("content", encodeURI(content)));
			paras.push(new HttpParameter("clientip", clientip));
			paras.push(new HttpParameter("url", OauthUrlUtil.executeString(url)));
			paras.push(new HttpParameter("title", OauthUrlUtil.executeString(title)));
			paras.push(new HttpParameter("author", OauthUrlUtil.executeString(author)));
			if(jing != null)
				paras.push(new HttpParameter("jing", jing));
			if(wei != null)
				paras.push(new HttpParameter("wei", wei));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(ADD_MUSIC,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			_httpConn.sendRequest(addMusicHandler, ADD_MUSIC, URLRequestMethod.POST, postParas);
			
			function addMusicHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_ADD_MUSIC, params);
			}
		}
		
		/**
		 * 
		 * 11.t/add_video发表视频微博
		 * content: 微博内容 必填项
		 * clientip: 用户IP 必填项，请带上用户浏览器带过来的IP地址，否则会被消息过滤策略拒绝掉
		 * jing: 经度（可以填空）
		 * wei: 纬度（可以填空）
		 * Url:视频地址，后台自动分析视频信息，支持youku,tudou,ku6
		 * 
		 **/
		public function addVideo(content:String, clientip:String, url:String, jing:String = null, wei:String = null, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("content", encodeURI(content)));
			paras.push(new HttpParameter("clientip", clientip));
			paras.push(new HttpParameter("url", OauthUrlUtil.executeString(url)));
			if(jing != null)
				paras.push(new HttpParameter("jing", jing));
			if(wei != null)
				paras.push(new HttpParameter("wei", wei));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(ADD_VIDEO,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			_httpConn.sendRequest(addVideoHandler, ADD_VIDEO, URLRequestMethod.POST, postParas);
			
			function addVideoHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_ADD_VIDEO, params);
			}
		}
		
		/**
		 * 
		 * 12.t/getvideoinfo 获取视频信息
		 * content: 微博内容 必填项
		 * clientip: 用户IP 必填项，请带上用户浏览器带过来的IP地址，否则会被消息过滤策略拒绝掉
		 * jing: 经度（可以填空）
		 * wei: 纬度（可以填空）
		 * Url:视频地址，后台自动分析视频信息，支持youku,tudou,ku6
		 * 
		 **/
		public function getVideoInfo(url:String, jing:String = null, wei:String = null, format:String = "json"):void{
			var paras:Array = [];
			paras.push(new HttpParameter("format", format));
			paras.push(new HttpParameter("url", OauthUrlUtil.executeString(url)));
			if(jing != null)
				paras.push(new HttpParameter("jing", jing));
			if(wei != null)
				paras.push(new HttpParameter("wei", wei));
			Oauth.currentAccountKey.httpMethod = "POST";
			paras = OauthUrlUtil.getOauthPostParas(GET_VIDEO_INFO,
				Oauth.currentAccountKey.httpMethod, Oauth.currentAccountKey.customKey,
				Oauth.currentAccountKey.customSecrect, Oauth.currentAccountKey.tokenKey,
				Oauth.currentAccountKey.tokenSecrect, Oauth.currentAccountKey.verify,
				Oauth.currentAccountKey.callbackUrl, paras);
			
			var postParas:String = OauthUrlUtil.normalizeRequestParameters(paras);
			_httpConn.sendRequest(addVideoHandler, GET_VIDEO_INFO, URLRequestMethod.POST, postParas);
			
			function addVideoHandler(data:String):void{
				var params:Object = executeResponse(format, data);
				onHttpDataHandler(CMD_GET_VIDEO_INFO, params);
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