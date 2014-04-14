package akdcl.utils {
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function copyObject(_src:Object, _deep:Boolean = false):* {
		if (_deep) {
			//获取全名
			var _typeName:String = getQualifiedClassName(_src);
			//切出包名
			var _packageName:String = _typeName.split("::")[0];
			//获取Class
			var _class:Class = getDefinitionByName(_typeName) as Class;
			//注册Class
			registerClassAlias(_packageName, _class);
		}
		//复制对象
		var _copy:ByteArray = new ByteArray();
		_copy.writeObject(_src);
		_copy.position = 0;
		return _copy.readObject();
	}
}