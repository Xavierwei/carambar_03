package akdcl.manager{
	import flash.events.EventDispatcher;
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class BaseManager extends EventDispatcher {
		/*baseManager static var instance:EventManager;
		public static function getInstance():EventManager {
			return createConstructor(EventManager) as EventManager;
		}*/
		
		private static const ABSTRACT_ERROR:String = "Abstract class did not receive reference to self. BaseManager cannot be instantiated directly.";
		private static const SINGLETON_ERROR:String = "Singleton already constructed!";
		private static const CONSTRUCTOR:String = "constructor";
		private static const INIT:String = "init";
		
		protected static var lM:LoggerManager;
		
		protected namespace baseManager;
		
		public function BaseManager(_self:BaseManager) {
			var _constructor:Class=this[CONSTRUCTOR];
			if (_self != this) {
				throw new IllegalOperationError(ABSTRACT_ERROR);
				if (lM) {
					lM.fatal(_constructor, ABSTRACT_ERROR);
				}
			}
			
			if (_constructor.baseManager::instance) {
				throw new IllegalOperationError(SINGLETON_ERROR);
				if (lM) {
					lM.fatal(_constructor, SINGLETON_ERROR);
				}
			}
			_constructor.baseManager::instance = this;
			
			lM = LoggerManager.getInstance();
			lM.info(_constructor, INIT);
		}
		
		protected static function createConstructor(_constructor:Class):BaseManager {
			if (_constructor.baseManager::instance) {
			} else {
				new _constructor();
			}
			return _constructor.baseManager::instance;
		}
	}
	
}