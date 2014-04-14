package akdcl.utils {
	import flash.display.DisplayObjectContainer;

	/**
	 * ...
	 * @author Akdcl
	 */
	final public class SortZ {
		public static function createList(_container:DisplayObjectContainer):Vector.<Object> {
			var _i:int = _container.numChildren;
			var _list:Vector.<Object> = new Vector.<Object>(_i);
			while (--_i >= 0){
				_list[_i] = {rootZ: 0, plane: _container.getChildAt(_i)};
			}
			return _list;
		}

		public static function sort(_container:DisplayObjectContainer, _list:Vector.<Object>):void {
			//简单的深度调整
			var _each:Object;
			for each (_each in _list){
				//这里用了 plane 在根系统下的z值作为排序依据,更正确的应该是用 plane 和视点的距离
				_each.rootZ = _each.plane.transform.getRelativeMatrix3D(_container.parent).rawData[14];
			}
			_list.sort(sortByRootZ);
			for each (_each in _list){
				_container.addChild(_each.plane);
			}
		}

		private static function sortByRootZ(obj1:Object, obj2:Object):Number {
			return obj2.rootZ - obj1.rootZ;
		}
	}

}