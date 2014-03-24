/***
GetAndSetValue 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月29日 20:39:50
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	//部分实现了 as2 的 eval 功能
	public class GetAndSetValue{
		public static function getValue(objName:String,thisObj:*=null):*{
			//GetAndSetValue.getValue("XML")//获取类
			//GetAndSetValue.getValue("flash.filesystem.File")//获取类
			//GetAndSetValue.getValue("XML.prettyIndent")//获取静态属性
			//GetAndSetValue.getValue("flash.filesystem.File.applicationDirectory.nativePath")//获取静态属性
			//GetAndSetValue.getValue("loaderInfo.url",this)//获取属性
			return getObj(objName.split("."),thisObj);
		}
		public static function setValue(objName:String,value:*,thisObj:*=null):void{
			//GetAndSetValue.setValue("XML.prettyIndent",1)//设置静态属性
			//GetAndSetValue.setValue("x",0,this)//设置属性
			
			var objNameArr:Array=objName.split(".");
			if(objNameArr.length){
				var valueName:String=objNameArr.pop();
				var obj:Object=getObj(objNameArr,thisObj);
				if(obj){
					obj[valueName]=value;
				}
			}
		}
		public static function getObj(objNameArr:Array,thisObj:*):*{
			if(objNameArr.length){
				var obj:Object;
				if(thisObj){
					obj=thisObj[objNameArr.shift()];
				}else{
					var defCache:String="";
					while(objNameArr.length){
						var defStr:String=objNameArr.shift();
						try{
							obj=getDefinitionByName(defCache+defStr);
						}catch(e:Error){
							defCache+=defStr+".";
							continue;
						}
						break;
					}
				}
				if(obj){
					while(objNameArr.length){
						obj=obj[objNameArr.shift()];
					}
				}
				return obj;
			}
			if(thisObj){
				return thisObj;
			}
			return null;
		}
	}
}

