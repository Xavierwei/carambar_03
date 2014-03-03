package akdcl.manager {

	import akdcl.interfaces.Iselect;

	/**
	 * ...
	 * @author ...
	 */
	final public class SelectManager extends BaseManager {
		baseManager static var instance:SelectManager;
		public static function getInstance():SelectManager {
			return createConstructor(SelectManager) as SelectManager;
		}
		
		public function SelectManager() {
			super(this);
			itemsGroup = {};
		}

		private var itemsGroup:Object;

		public function addItem(_item:Iselect, _groupID:String):void {
			var _items:Items = itemsGroup[_groupID];
			if (!_items){
				_items = new Items();
				itemsGroup[_groupID] = _items;
			}
			_items.addItem(_item);
		}

		public function removeItem(_item:Iselect):void {
			for each (var _items:Items in itemsGroup){
				_items.removeItem(_item);
			}
		}

		public function selectItem(_item:Iselect):void {
			for each (var _items:Items in itemsGroup){
				_items.selectItem(_item);
			}
		}

		public function unselectItem(_item:Iselect):void {
			for each (var _items:Items in itemsGroup){
				_items.unselectItem(_item);
			}
		}
		
		public function removeItems(_groupID:String):void {
			var _items:Items = itemsGroup[_groupID];
			if (_items){
				_items.removeAllItem();
			}
		}

		public function unselectItems(_groupID:String):void {
			var _items:Items = itemsGroup[_groupID];
			if (_items){
				_items.unselectAllItem();
			}
		}
		
		public function removeAllItems():void {
			for each (var _items:Items in itemsGroup){
				_items.removeAllItem();
			}
		}
	}

}
import flash.utils.Dictionary;

import akdcl.interfaces.Iselect;

class Items {
	public var limit:int;
	private var selectedCount:int;
	private var itemDic:Dictionary;

	public function Items(_limit:int = -1):void {
		limit = _limit;
		itemDic = new Dictionary();
	}

	public function addItem(_item:Iselect):void {
		itemDic[_item] = _item;
	}

	public function removeItem(_item:Iselect):void {
		unselectItem(_item);
		delete itemDic[_item];
	}

	public function selectItem(_item:Iselect):void {
		if (contains(_item) && !_item.selected) {
			if (limit < 0){
				selectedCount++;
				_item.selected = true;
			} else if (limit == 0){
				unselectAllItem();
				selectedCount = 1;
				_item.selected = true;
			} else if (_limit > selectedCount){
				selectedCount++;
				_item.selected = true;
			} else {
				//limit
			}
		} else {
			//未包含或已经选取
		}
	}

	public function unselectItem(_item:Iselect):void {
		if (contains(_item) && _item.selected) {
			selectedCount--;
			_item.selected = false;
		}
	}
	
	public function removeAllItem():void {
		for each (var _item:Iselect in itemDic){
			removeItem(_item);
		}
	}

	public function unselectAllItem():void {
		for each (var _item:Iselect in itemDic){
			unselectItem(_item);
		}
	}

	public function contains(_item:Iselect):Boolean {
		return (itemDic[_item] == _item) ? true : false;
	}
}