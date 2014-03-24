/***
Menus
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年10月7日 23:48:16
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.utils.*;
	
	public class Menus{
		public var menu:NativeMenu;
		private var onSelectItem:Function;
		public var items:Object;
		public function Menus(xml:XML,_onSelectItem:Function){
			items=new Object();
			menu=getMenuByXML(xml);
			onSelectItem=_onSelectItem;
		}
		private function getMenuByXML(xml:XML):NativeMenu{
			var menu:NativeMenu=new NativeMenu();
			for each(var subMenuXML:XML in xml.menu){
				if(subMenuXML.children().length()){
					menu.addSubmenu(getMenuByXML(subMenuXML),subMenuXML.@label.toString());
				}else{
					var item:NativeMenuItem=new NativeMenuItem(subMenuXML.@label.toString());
					item.data=subMenuXML;
					
					var keyEquivalentModifiers:Array=new Array();
					if(subMenuXML.@ctrlKey.toString()=="true"){
						keyEquivalentModifiers.push(Keyboard.CONTROL);
					}
					if(subMenuXML.@shiftKey.toString()=="true"){
						keyEquivalentModifiers.push(Keyboard.SHIFT);
					}
					if(subMenuXML.@altKey.toString()=="true"){
						keyEquivalentModifiers.push(Keyboard.ALTERNATE);
					}
					item.keyEquivalentModifiers=keyEquivalentModifiers;
					
					item.keyEquivalent=subMenuXML.@keyEquivalent.toString();//如果为 keyEquivalent 属性分配一个大写字母，则会自动将 Shift 键用作修饰符。将 keyEquivalentModifier 设置为一个空数组不会撤消将 Shift 键用作修饰符。
					
					menu.addItem(item);
					item.addEventListener(Event.SELECT,selectItem);
					if(subMenuXML.@checked.toString()=="true"){
						item.checked=true;
					}
					
					items[item.label]=item;
				}
			}
			return menu;
		}
		private function selectItem(event:Event):void{
			if(onSelectItem==null){
			}else{
				onSelectItem(event.target);
			}
		}
	}
}