/***
EnabledAll 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年3月18日 19:16:15
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	//用于 flex 项目中批量设置一些 IVisualElement 的 enabled 值
	public class EnabledAll{
		public static function enables(container:*,...notCtrlList):void{
			var i:int=container.numElements;
			while(--i>=0){
				var element:*=container.getElementAt(i);
				if(notCtrlList){
					if(notCtrlList.indexOf(element)==-1){
					}else{
						continue;
					}
				}
				element.enabled=true;
			}
		}
		public static function disables(container:*,...notCtrlList):void{
			var i:int=container.numElements;
			while(--i>=0){
				var element:*=container.getElementAt(i);
				if(notCtrlList){
					if(notCtrlList.indexOf(element)==-1){
					}else{
						continue;
					}
				}
				element.enabled=false;
			}
		}
	}
}

