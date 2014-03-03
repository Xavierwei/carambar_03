package com.makeit.net 
{
	/**
	 * 一键转帖
	 */
	
	import flash.net.*;
	public class repaste
	{
		
		public function repaste() 
		{
			
		}
		public static function kaixin(rurl:String="",rtitle:String="",rcontent:String=""):void {
			var url:String = "http://www.kaixin001.com/repaste/share.php";
			
			var urlVar:URLVariables = new URLVariables();
			urlVar.rurl = rurl;
			//urlVar.rtitle = escape(rtitle)
			urlVar.rtitle = rtitle;
			urlVar.rcontent = rcontent;
			var urlRequest:URLRequest = new URLRequest(url);
			urlRequest.data = urlVar;
			urlRequest.method = URLRequestMethod.GET;
			
			navigateToURL(urlRequest,"_blank");
		}
		public static function renren(link:String="",title:String=""):void {
         
            var url:String = "http://share.renren.com/share/buttonshare.do";
            var urlVar:URLVariables = new URLVariables();
            urlVar.link = link;
            urlVar.title = title;
            var urlRequest:URLRequest = new URLRequest(url);
            urlRequest.data=urlVar;
            urlRequest.method = URLRequestMethod.GET;
            navigateToURL(urlRequest,"_blank");
		}
		public static function sina(link:String = "", content:String = "",picURL:String=""):void {
		
			
			var url:String = "http://v.t.sina.com.cn/share/share.php";
			
			var urlVar:URLVariables = new URLVariables();
            urlVar.title = content;
            urlVar.url = link;
           urlVar.pic=picURL;
			
			
            var urlRequest:URLRequest = new URLRequest(url);
            urlRequest.data=urlVar;
            urlRequest.method = URLRequestMethod.GET;
            navigateToURL(urlRequest, "_blank");
			
		}
		
		public static function douban(link:String = "", content:String = "",pic:String=""):void {

			var url:String = "http://shuo.douban.com/!service/share";
			
			var urlVar:URLVariables = new URLVariables();
            urlVar.href = link;
            urlVar.name= content;
			urlVar.image=pic;
			
            var urlRequest:URLRequest = new URLRequest(url);
            urlRequest.data=urlVar;
            urlRequest.method = URLRequestMethod.GET;
            navigateToURL(urlRequest, "_blank");
			
		}
		public static function faceBook(link:String="",title:String=""):void{
			var url:String =link;
			
			var urlVar:URLVariables = new URLVariables();
            urlVar.u = url;
            urlVar.t = title;
			
			
            var urlRequest:URLRequest = new URLRequest(url);
            urlRequest.data=urlVar;
            urlRequest.method = URLRequestMethod.GET;
            navigateToURL(urlRequest, "_blank");
			
		}
		public static function qqWeibo(link:String,content:String,pic:String=""):void{
			var urlVar:URLVariables = new URLVariables();
            urlVar.url = link;
            urlVar.title = content;
            urlVar.pic=pic;
			var url:String="http://v.t.qq.com/share/share.php";
			var urlRequest:URLRequest = new URLRequest(url);
            urlRequest.data=urlVar;
            urlRequest.method = URLRequestMethod.GET;
            navigateToURL(urlRequest, "_blank");
			
		
		}
		public static function qzone(link:String,title:String="",content:String="",pics:String=""):void{
			var urlVar:URLVariables = new URLVariables();
            urlVar.url = link;
            urlVar.title = title;
            urlVar.pics=pics;
            urlVar.summary=content;
            
			var url:String="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey";
			var urlRequest:URLRequest = new URLRequest(url);
            urlRequest.data=urlVar;
            urlRequest.method = URLRequestMethod.GET;
            navigateToURL(urlRequest, "_blank");
			
		
		}
	}

}