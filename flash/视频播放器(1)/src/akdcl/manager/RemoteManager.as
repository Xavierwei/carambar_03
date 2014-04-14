package akdcl.manager {
	import flash.events.EventDispatcher;

	/**
	 * ...
	 * @author akdcl
	 */
	final public class RemoteManager extends BaseManager {
		baseManager static var instance:RemoteManager;
		public static function getInstance():RemoteManager {
			return createConstructor(RemoteManager) as RemoteManager;
		}
		
		public function RemoteManager() {
			super(this);
		}
	}
}