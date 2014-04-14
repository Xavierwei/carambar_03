package akdcl.utils {
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenuBuiltInItems;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function addContextMenu(obj:*, caption:String, onSelect:Function = null):ContextMenuItem {
		var menu:ContextMenu = obj ? obj.contextMenu : null;
		if (!menu){
			//trace("新建menu");
			menu = new ContextMenu();
			menu.hideBuiltInItems();
		}
		var item:ContextMenuItem = new ContextMenuItem(caption);
		if (onSelect != null){
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onSelect);
		}
		if (menu.customItems) {
			menu.customItems.push(item);
			if (obj){
				obj.contextMenu = menu;
			}
			return item;
		}
		return null
	}
}