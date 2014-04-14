package akdcl.media {

	/**
	 * ...
	 * @author ...
	 */
	public class Playlist {
		public static function createList(_list:*):Playlist {
			var _playlist:Playlist = new Playlist();
			if ((_list is String) || (_list is Array)){
				if (_list is String){
					//将字符串按"|"格式成数组
					_list = _list.split("|");
				}
				for each (var _each:String in _list){
					_playlist.insertItem(new PlayItem(_each));
				}
			} else if (_list is XMLList || _list is XML){
				if (_list is XML){
					//取XML中的"item"列表
					if (_list.item.length() > 0) {
						_list = _list.item;
					}
				}
				for each (var _xml:XML in _list){
					_playlist.insertItem(new PlayItem(_xml));
				}
			} else {
				return null;
			}
			return _playlist;
		}

		private var list:Vector.<PlayItem>;

		public function get length():uint {
			return list.length;
		}

		public function Playlist(){
			list = new Vector.<PlayItem>();
		}

		public function insertItem(_item:PlayItem, _index:int = -1):void {
			//list
			if (_index < 0){
				list.push(_item);
			} else {

			}
		}

		public function removeItemAt(_index:int):void {
			if (_index < 0){
				_index = length - 1;
			}
			list.splice(_index, 1);
		}

		public function getItem(_index:int):PlayItem {
			if (_index < 0){
				_index = length - 1;
			}
			return list[_index];
		}
	}

}