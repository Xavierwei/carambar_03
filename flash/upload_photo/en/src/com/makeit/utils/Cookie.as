package com.makeit.utils{
	import flash.net.SharedObject;

	/**
	 * Cookie Cookie类
	 * @author kinglong
	 * @since 2012-1-9
	 */
	public class Cookie {
		private var _expires : uint;
		private var _name : String;
		private var _so : SharedObject;

		/**
		 * 构造
		 * @param name Cookie名称
		 * @param expires 过期值（单位小时）
		 */
		public function Cookie(name : String, expires : uint = 24*30) {
			_name = name;
			_expires = Math.max(expires, 1);
			_so = SharedObject.getLocal(name, "/");
			
			//clearAllExpires
			for (var key : String in _so.data) {
				if (_so.data[key] is Object) {
					var data : Object = _so.data[key];
					if (data.hasOwnProperty("expires") && data.hasOwnProperty("value")) {
						var nowTime : Number = new Date().getTime();
						if (Number(data["expires"]) > nowTime) {
							continue;
						}
					}
				}
				delete _so.data[key];
			}
		}

		/**
		 * Cookie名称
		 */
		public function get name() : String {
			return _name;
		}

		/**
		 * Cookie过期值（单位小时）
		 */
		public function get expires() : uint {
			return _expires;
		}

		/**
		 * 清除所有
		 */
		public function removeAll() : void {
			_so.clear();
		}

		/**
		 * 清除指定属性
		 * @param key Cookie属性
		 */
		public function remove(key : String) : * {
			var result : * = get(key);
			if (result != null) {
				delete _so.data[key];
				_so.flush();
			}
			return result;
		}

		/**
		 * 获取Cookie属性值
		 * @param key Cookie属性
		 * @return Cookie属性值
		 */
		public function get(key : String) : * {
			return contains(key) ? _so.data[key]["value"] : null;
		}

		/**
		 * 添加Cookie属性
		 * @param key Cookie属性
		 * @param value Cookie属性值
		 * @return 旧的Cookie属性值
		 */
		public function put(key : String, value : *) : * {
			var day : Date = new Date();
			var result : * = get(key);
			_so.data[key] = {expires:day.getTime() + expires * 1000 * 60 * 60, value:value};
			return result;
		}

		/**
		 * Cookie属性是否存在
		 * @param key Cookie属性
		 */
		public function contains(key : String) : Boolean {
			if (_so.data.hasOwnProperty(key)) {
				if (_so.data[key] is Object) {
					var data : Object = _so.data[key];
					if (data.hasOwnProperty("expires") && data.hasOwnProperty("value")) {
						var nowTime : Number = new Date().getTime();
						if (Number(data["expires"]) > nowTime) {
							return true;
						}
					}
				}
				delete _so.data[key];
				_so.flush();
			}
			return false;
		}
	}
}