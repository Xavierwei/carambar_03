/***
isClass
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年01月30日 11:54:21
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	//import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;

	public function isClass(value:*,classOrClassName:*,getDefinitionFun:Function):Boolean{
		if(classOrClassName is Class){
			var clazz:Class=classOrClassName;
		}else if(classOrClassName is String){
			try{
				clazz=getDefinitionFun(classOrClassName) as Class;
			}catch(e:Error){
				return false;
			}
		}else{//Array 或  Vector
			for each(classOrClassName in classOrClassName){
				if(isClass(value,classOrClassName,getDefinitionFun)){
					return true;
				}
			}
			return false;
		}
		value=getDefinitionFun(getQualifiedClassName(value));
		while(value!=clazz){
			var className:String=getQualifiedSuperclassName(value);
			if(className=="Object"){
				return false;
			}
			value=getDefinitionFun(className);
		}
		return true;
	}
}