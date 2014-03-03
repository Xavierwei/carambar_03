package com.makeit.managers {
	import flash.events.EventDispatcher;
	/**
	 * @author quhuan
	 */
	public class SingletonBase extends EventDispatcher {
		private static var _instance:SingletonBase;
		public function SingletonBase($single:single):void{
			if($single==null){
				trace("单例不能实例化");
			}
		}
		public static function getInstance():SingletonBase{
			if(_instance==null){
				_instance=new SingletonBase(new single());
			}
			return _instance;
		}
	}
}
class single{}
