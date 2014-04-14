package akdcl.net{
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author ...
	 */
	public class URLFormater{
		private var username:String;
		private var password:String;
		private var port:String;
		private var path:String;
		
		private var queryString:String;
		
		private var __query:Object;
		public function get query():Object {
			if (__query) {
			}else if (queryString) {
				__query = new URLVariables(queryString);
			}
			return __query;
		}
		public function set query(_query:Object):void {
			query;
			for(var _i:String in _query){
				query[_i] = _query[_i];
			}
			queryString = __query.toString();
		}
		
		private var __urlRaw:String;
		public function get urlRaw():String {
			return __urlRaw;
		}
		
		private var __url:String;
		public function get url():String {
			return __url?__url:__urlRaw;
		}
		
		private var __scheme:String;
		public function get scheme():String {
			return __scheme;
		}
		
		private var __authority:String;
		public function get authority():String {
			return __authority;
		}
		
		private var __type:String;
		public function get type():String {
			return __type;
		}
		
		private var __fragment:String;
		public function get fragment():String {
			return __fragment;
		}
		
		private var __nonHierarchical:String;
		public function get nonHierarchical():String {
			return nonHierarchical;
		}
		
		private var __relative:Boolean;
		public function get relative():Boolean {
			return __relative;
		}
		
		public function URLFormater(_url:String = null) {
			if (_url) {
				setURL(_url);
			}
		}
		
		private function reset():void {
			username = "";
			password = "";
			port = "";
			path = "";
			queryString = "";
			__query = null;
			
			__relative = false;
			__scheme = "";
			__authority = "";
			__type = "";
			__fragment = "";
		}
		
		public function setURL(_url:String):void {
			reset();
			
			var _index:int;
			var _index2:int;
			var _length:uint;
			var _baseURI:String;
			
			__urlRaw = _url;
			_baseURI = _url;
			
			_index = _baseURI.indexOf("#");
			if (_index >= 0) {
				if (_baseURI.length > (_index + 1)) {
					__fragment = _baseURI.substr(_index + 1, _baseURI.length - (_index + 1)); 
				}
				_baseURI = _baseURI.substr(0, _index);
			}
			
			_index = _baseURI.indexOf("?");
			if (_index >= 0){
				if (_baseURI.length > (_index + 1)) {
					queryString = _baseURI.substr(_index + 1, _baseURI.length - (_index + 1));
				}
				_baseURI = _baseURI.substr(0, _index);
			}
			
			_index = _baseURI.indexOf(":");
			_index2 = _baseURI.indexOf("/");
			
			if (_index >= 0 && (_index2 < 0 || _index < _index2)) {
				__scheme = _baseURI.substr(0, _index).toLowerCase();
				_baseURI = _baseURI.substr(_index + 1);
				if (_baseURI.substr(0, 2) == "//"){
					__nonHierarchical = "";
					_baseURI = _baseURI.substr(2, _baseURI.length - 2);
				}else{
					//This is a non-hierarchical URI like "mailto:bob@mail.com"
					__nonHierarchical = _baseURI;
					return;
				}
			}else {
				__relative = true;
				__scheme = "";
				__nonHierarchical = "";
			}
			
			if (__relative) {
				__authority = "";
				port = "";
				path = _baseURI;
			}else {
				if (_baseURI.substr(0, 2) == "//") {
					while (_baseURI.charAt(0) == "/") {
						_baseURI = _baseURI.substr(1, _baseURI.length - 1);
					}
				}
				
				_index = _baseURI.indexOf('/');
				if (_index < 0) {
					__authority = _baseURI;
					path = "";
				}else {
					__authority = _baseURI.substr(0, _index);
					path = _baseURI.substr(_index, _baseURI.length - _index);
					
					_index = path.indexOf(".");
					if (_index >= 0) {
						__type = path.substr(_index + 1, path.length - (_index + 1));
					}
				}
			
				//ftp://username:password@server.com
				_index = __authority.indexOf('@');
				if (_index >= 0) {
					username = __authority.substr(0, _index);
					__authority = __authority.substr(_index + 1);
					_index = username.indexOf(':');
					if (_index >= 0) {
						password = username.substring(_index + 1, username.length);
						username = username.substr(0, _index);
					}else {
						password = "";
					}
				}else{
					username = "";
					password = "";
				}
				
				// with the ':' in the 'username:password' if one exists.
				_index = __authority.indexOf(':');
				if (_index >=0){
					port = __authority.substring(_index + 1, __authority.length);
					__authority = __authority.substr(0, _index);
				}else {
					port = "";
				}
				
				__authority = __authority.toLowerCase();
			}
		}
		
		public function update():void {
			if (__nonHierarchical) {
				__url = __scheme + ":" + __nonHierarchical;
			}else {
				__url = "";
				if (!__relative) {
					if (__scheme){
						__url += __scheme + ":";
					}
					if (__authority.length) {
						__url += "//";
						if (username) {
							__url += username;
							if (password){
								__url += ":" + password;
							}
							__url += "@";
						}
						__url += __authority;
						if (port) {
							__url += ":" + port;
						}
					}
				}
				__url += path;
			}
			
			if (queryString) {
				__url += "?" + queryString;
			}
		
			if (__fragment) {
				__url += "#" + __fragment;
			}
		}
	}
	
}