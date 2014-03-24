/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.qq
{
	import com.core.microBlogs.qq.api.account.DoAccount;
	import com.core.microBlogs.qq.api.fav.DoFav;
	import com.core.microBlogs.qq.api.friends.DoFriends;
	import com.core.microBlogs.qq.api.ht.DoHT;
	import com.core.microBlogs.qq.api.infoUpdate.DoInfoUpdate;
	import com.core.microBlogs.qq.api.oauth.DoOauth;
	import com.core.microBlogs.qq.api.oauth.OauthKeyQQ;
	import com.core.microBlogs.qq.api.other.DoOther;
	import com.core.microBlogs.qq.api.privMsg.DoPrivateMsg;
	import com.core.microBlogs.qq.api.search.DoSearch;
	import com.core.microBlogs.qq.api.tag.DoTag;
	import com.core.microBlogs.qq.api.timeline.DoTimeline;
	import com.core.microBlogs.qq.api.trends.DoTrends;
	import com.core.microBlogs.qq.api.broadcast.DoBroadcast;
	import com.core.microBlogs.standard.Oauth;

	/**
	 * Microblogs api - QQWeiboAPI
	 * ---
	 * QQ微博API service。
	 * 可以使用本类进行总的调用，也可以按照本类调用各API实现类的方式自行调用。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class QQWeiboAPI
	{
		public static const NAME:String = "qq";
		
		private var _dataHandler:Function;
		private var _errorHandler:Function;
		private var _doOauth:DoOauth;
		private var _doAccount:DoAccount;
		private var _doFriends:DoFriends;
		private var _doTimeline:DoTimeline;
		private var _doBroadcast:DoBroadcast;
		private var _doPrivMsg:DoPrivateMsg;
		private var _doSearch:DoSearch;
		private var _doTrends:DoTrends;
		private var _doInfoUpdate:DoInfoUpdate;
		private var _doHT:DoHT;
		private var _doTag:DoTag;
		private var _doOther:DoOther;
		private var _doFav:DoFav;
		
		public function QQWeiboAPI(dataHandler:Function, errorHandler:Function)
		{
			this._dataHandler = dataHandler;
			this._errorHandler = errorHandler;
			
			_doOauth = new DoOauth(preDataHandler, preErrorHandler);
			_doTimeline = new DoTimeline(preDataHandler, preErrorHandler);
			_doBroadcast = new DoBroadcast(preDataHandler, preErrorHandler);
			_doAccount = new DoAccount(preDataHandler, preErrorHandler);
			_doFriends = new DoFriends(preDataHandler, preErrorHandler);
			_doPrivMsg = new DoPrivateMsg(preDataHandler, preErrorHandler);
			_doSearch = new DoSearch(preDataHandler, preErrorHandler);
			_doTrends = new DoTrends(preDataHandler, preErrorHandler);
			_doInfoUpdate = new DoInfoUpdate(preDataHandler, preErrorHandler);
			_doHT = new DoHT(preDataHandler, preErrorHandler);
			_doFav = new DoFav(preDataHandler, preErrorHandler);
			_doTag = new DoTag(preDataHandler, preErrorHandler);
			_doOther = new DoOther(preDataHandler, preErrorHandler);
		}
		
		//申请授权
		public function getRequestToken(appKey:String, appSecret:String, callBack:String = null):void {
			_doOauth.getRequestToken(appKey, appSecret, callBack);
		}
		
		//跳转到授权页面
		public function authRequestToken():void{
			_doOauth.authRequestToken();
		}
		
		//交换access_token
		public function getAccessToken():void{
			_doOauth.getAccessToken();
		}
		
		//时间线
		//主页时间线
		public function getHomeTimeline(pageFlag:int, pageTime:int, reqnum:int, format:String = "json"):void{
			_doTimeline.getHomeTimeline(pageFlag, pageTime, reqnum, format);
		}
		//广播大厅时间线
		public function getPublicTimeline(pos:int, reqnum:int, format:String = "json"):void{
			_doTimeline.getPublicTimeline(pos, reqnum, format);
		}
		//其他用户时间线
		public function getUserTimeline(pageFlag:int, pageTime:int, reqnum:int, lastId:int, name:String, format:String = "json"):void{
			_doTimeline.getUserTimeline(pageFlag, pageTime, reqnum, lastId, name, format);
		}
		//@提到我的时间线
		public function getMentionsTimeline(pageFlag:int, pageTime:int, reqnum:int, lastId:int, format:String = "json"):void{
			_doTimeline.getMentionsTimeline(pageFlag, pageTime, reqnum, lastId, format);
		}
		//话题时间线
		public function getHTTimeline(httext:String, pageFlag:int, pageinfo:String, reqnum:int, format:String = "json"):void{
			_doTimeline.getHTTimeline(httext, 0, pageinfo, reqnum, format);
		}
		//我发表的时间线
		public function getBroadcastTimeline(pageFlag:int, pageTime:int, reqnum:int, lastId:int, format:String = "json"):void{
			_doTimeline.getBroadcastTimeline(pageFlag, pageTime, reqnum, lastId, format);
		}
		//特别收听到人发表时间线
		public function getSpecialTimeline(pageFlag:int, pageTime:int, reqnum:int, format:String = "json"):void{
			_doTimeline.getSpecialTimeline(pageFlag, pageTime, reqnum, format);
		}
		
		//微博相关
		//获取指定微博
		public function getTShow(id:String, format:String = "json"):void{
			_doBroadcast.getTShow(id, format);
		}
		//发表一条新微博
		public function addT(content:String, clientip:String, jing:String = null, wei:String = null, format:String = "json"):void{
			_doBroadcast.addT(content, clientip, jing, wei, format);
		}
		//删除一条微博
		public function delT(id:String, format:String = "json"):void{
			_doBroadcast.delT(id, format);
		}
		//转播一条微博
		public function reAddT(content:String, clientip:String, reid:String, jing:String = null, wei:String = null, format:String = "json"):void{
			_doBroadcast.reAddT(content, clientip, reid, jing, wei, format);
		}
		//回复一条微博
		public function replyT(content:String, clientip:String, reid:String, jing:String = null, wei:String = null, format:String = "json"):void{
			_doBroadcast.replyT(content, clientip, reid, jing, wei, format);
		}
		//发布图片微博
		public function addPic(content:String, clientip:String, jing:String = null, wei:String = null, format:String = "json"):void{
			_doBroadcast.addPic(content, clientip, jing, wei, format);
		}
		//获取转播或点评数 
		//ids:各ID之间用","连接
		//Flag:0 获取转发计数，1点评计数 2 两者都取
		public function getReCount(ids:String, flag:int = 2, format:String = "json"):void{
			_doBroadcast.getReCount(ids, flag, format);
		}
		//获取指定微博的转播或评论列表
		public function getReList(rootId:String, flag:int = 2, pageFlag:int = 0, pageTime:Number = 0, reqnum:int = 20, broadcastId:String = "0", format:String = "json"):void{
			_doBroadcast.getReList(rootId, flag, pageFlag, pageTime, reqnum, broadcastId, format);
		}
		//点评一条微博
		public function comment(content:String, clientip:String, reid:String, jing:String = null, wei:String = null, format:String = "json"):void{
			_doBroadcast.comment(content, clientip, reid, jing, wei, format);
		}
		//发表音乐微博
		public function addMusic(content:String, clientip:String, url:String, title:String, author:String, jing:String = null, wei:String = null, format:String = "json"):void{
			_doBroadcast.addMusic(content, clientip, url, title, author, jing, wei, format);
		}
		//发表视频微博
		public function addVideo(content:String, clientip:String, url:String, jing:String = null, wei:String = null, format:String = "json"):void{
			_doBroadcast.addVideo(content, clientip, url, jing, wei, format);
		}
		//获取视频信息
		public function getVideoInfo(url:String, jing:String = null, wei:String = null, format:String = "json"):void{
			_doBroadcast.getVideoInfo(url, jing, wei, format);
		}
		
		//账户相关
		//获取用户信息
		public function getUserInfo(format:String = "json"):void{
			_doAccount.getUserInfo(format);
		}
		//更新用户信息
		public function updateUserInfo(nick:String, sex:int, year:int, month:int, day:int, 
									   countrycode:int, provincecode:int, citycode:int, 
									   introduction:String, format:String = "json"):void{
			_doAccount.updateUserInfo(nick, sex, year, month, day, countrycode, provincecode, citycode, introduction, format);
		}							   
		//更新用户头像
		public function updateUserHeadImg(format:String = "json"):void{
			_doAccount.updateUserHeadImg(format);
		}
		//获取其他人资料
		public function getOtherUserInfo(name:String, format:String = "json"):void{
			_doAccount.getOtherUserInfo(name, format);
		}
		
		//关系链相关
		//我的听众列表
		public function getFansList(reqnum:int, page:int = 1, format:String = "json"):void{
			_doFriends.getFansList(reqnum, page, format);
		}
		//我收听的列表
		public function getIdolList(reqnum:int, page:int = 1, format:String = "json"):void{
			_doFriends.getIdolList(reqnum, page, format);
		}
		//黑名单
		public function getBlackList(reqnum:int, page:int = 1, format:String = "json"):void{
			_doFriends.getBlackList(reqnum, page, format);
		}
		//特别收听到列表
		public function getSpecialList(reqnum:int, page:int = 1, format:String = "json"):void{
			_doFriends.getSpecialList(reqnum, page, format);
		}
		//收听用户
		public function addIdol(name:String, format:String = "json"):void{
			_doFriends.addIdol(name, format);
		}
		//删除收听到用户
		public function delIdol(name:String, format:String = "json"):void{
			_doFriends.delIdol(name, format);
		}
		//添加特别收听用户
		public function addSpecialIdol(name:String, format:String = "json"):void{
			_doFriends.addSpecialIdol(name, format);
		}
		//删除特别收听到用户
		public function delSpecialIdol(name:String, format:String = "json"):void{
			_doFriends.delSpecialIdol(name, format);
		}
		//添加到黑名单
		public function addBlack(name:String, format:String = "json"):void{
			_doFriends.addBlack(name, format);
		}
		//删除黑名单
		public function delBlack(name:String, format:String = "json"):void{
			_doFriends.delBlack(name, format);
		}
		//检查用户是否收听了我或是我收听到
		public function checkFriend(name:String, flag:int = 2, format:String = "json"):void{
			_doFriends.checkFriend(name, flag, format);
		}
		//获取其他用户的Fans列表
		public function getUserFansList(name:String, reqnum:int, page:int = 1, format:String = "json"):void{
			_doFriends.getUserFansList(name, reqnum, page, format);
		}
		//获取其他用户的收听列表
		public function getUserIdolList(name:String, reqnum:int, page:int = 1, format:String = "json"):void{
			_doFriends.getUserIdolList(name, reqnum, page, format);
		}
		//获取其他用户的特别收听列表
		public function getUserSpecialList(name:String, reqnum:int, page:int = 1, format:String = "json"):void{
			_doFriends.getUserSpecialList(name, reqnum, page, format);
		}
		
		
		//私信相关
		//发送私信
		public function addPrivMsg(content:String, clientip:String, name:String, jing:String = null, wei:String = null, format:String = "json"):void{
			_doPrivMsg.addPrivMsg(content, clientip, name, jing, wei, format);
		}
		//删除私信
		public function delPrivMsg(id:String, format:String = "json"):void{
			_doPrivMsg.delPrivMsg(id, format);
		}
		//收件箱
		public function getPrivateRecv(pageFlag:int, pageTime:int, reqnum:int, lastid:int, format:String = "json"):void{
			_doPrivMsg.getPrivateRecv(pageFlag, pageTime, reqnum, lastid, format);
		}
		//发件箱
		public function getPrivateSend(pageFlag:int, pageTime:int, reqnum:int, lastid:int, format:String = "json"):void{
			_doPrivMsg.getPrivateSend(pageFlag, pageTime, reqnum, lastid, format);
		}
		
		//搜索相关
		//搜索用户
		public function searchUser(keyword:String, pagesize:int, page:int, format:String = "json"):void{
			_doSearch.searchUser(keyword, pagesize, page, format);
		}
		//搜索微博
		public function searchT(keyword:String, pagesize:int, page:int, format:String = "json"):void{
			_doSearch.searchT(keyword, pagesize, page, format);
		}
		//搜索用户通过标签
		public function searchUserByTag(keyword:String, pagesize:int, page:int, format:String = "json"):void{
			_doSearch.searchUserByTag(keyword, pagesize, page, format);
		}
		
		//热度，趋势
		//话题热榜
		public function getTrendsHT(pos:int, reqnum:int, type:int = 3, format:String = "json"):void{
			_doTrends.getTrendsHT(pos, reqnum, type, format);
		}
		
		//数据更新相关
		//查看数据更新条数
		public function getInfoUpdate(op:int = 0, type:int = 5, format:String = "json"):void{
			_doInfoUpdate.getInfoUpdate(op, type, format);
		}
		
		//数据收藏相关
		//增加一条收藏
		public function addFavT(id:String, format:String = "json"):void{
			_doFav.addFavT(id, format);
		}
		
		//删除一条收藏
		public function delFavT(id:String, format:String = "json"):void{
			_doFav.delFavT(id, format);
		}
		
		//获取收藏列表
		public function getFavListT(pageflag:int = 0, nexttime:Number = 0, prevtime:Number = 0, reqnum:int = 20, lastid:Number = 0, format:String = "json"):void{
			_doFav.getFavListT(pageflag, nexttime, prevtime, reqnum, lastid, format);
		}
		
		//订阅话题
		public function addFavHT(id:String, format:String = "json"):void{
			_doFav.addFavHT(id, format);
		}
		
		//删除订阅到话题
		public function delFavHT(id:String, format:String = "json"):void{
			_doFav.delFavHT(id, format);
		}
		
		//获取订阅话题列表
		public function getFavListHT(pageflag:int = 0, reqnum:int = 20, pagetime:Number = 0, lastid:Number = 0, format:String = "json"):void{
			_doFav.getFavListHT(pageflag, reqnum, pagetime, lastid, format);
		}
		
		//话题相关
		//根据话名查话题ID
		public function getHtIdsByHtName(httexts:String, format:String = "json"):void{
			_doHT.getHtIdsByHtName(httexts, format);
		}
		
		//根据话题ID获取话题相关微博
		public function getHtInfoByHtIDs(ids:String, format:String = "json"):void{
			_doHT.getHtInfoByHtIDs(ids, format);
		}
		
		//标签相关
		//添加标签
		public function addTag(tag:String, format:String = "json"):void{
			_doTag.addTag(tag, format);
		}
		
		//删除标签
		public function delTag(id:String, format:String = "json"):void{
			_doTag.delTag(id, format);
		}
		
		//其他
		public function getOtherKownPersons(ip:String, country_code:String = null, province_code:String = null, city_code:String = null, format:String = "json"):void{
			_doOther.getOtherKownPersons(ip, country_code, province_code, city_code, format);
		}
		
		private function preDataHandler(cmd:String, params:Object):void{
			_dataHandler(cmd, params);
		}
		
		private function preErrorHandler(errorParams:Object):void{
			_errorHandler(errorParams);
		}
	}
}