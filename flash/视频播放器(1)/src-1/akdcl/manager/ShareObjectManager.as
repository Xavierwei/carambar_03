package akdcl.manager {
	import akdcl.utils.copyObject;
	import flash.net.SharedObject;

	/**
	 * ...
	 * @author ...
	 */
	final public class ShareObjectManager extends BaseManager {
		baseManager static var instance:ShareObjectManager;
		public static function getInstance():ShareObjectManager {
			return createConstructor(ShareObjectManager) as ShareObjectManager;
		}
		
		public function ShareObjectManager() {
			super(this);
			
			setLocal(LOCAL_DOMAIN);
		}

		private static const LOCAL_DOMAIN:String = "akdcl/shareLocal";

		private var shareObject:SharedObject;
		private var shareObjectGroup:Object;

		public function setLocal(_domain:String):void {
			shareObject = SharedObject.getLocal(_domain);
		}

		public function setGroup(_group:String):void {
			if (_group){
				shareObjectGroup = shareObject.data[_group];
				if (!shareObjectGroup){
					shareObjectGroup = shareObject.data[_group] = {};
				}
			} else {
				shareObjectGroup = null;
			}
		}

		public function getValue(_key:String):Object {
			if (shareObjectGroup){
				return shareObjectGroup[_key];
			} else {
				return shareObject.data[_key];
			}
		}

		public function setValue(_key:String, _value:Object):void {
			if (shareObjectGroup){
				shareObjectGroup[_key] = _value;
			} else {
				shareObject.data[_key] = _value;
			}
		}
		
		public function autoValue(_key:String, _value:Object):void {
			if (_value && !getValue(_key)) {
				setValue(_key, _value);
			}
		}

		public function getValueCopy(_key:String):Object {
			var _object:Object = getValue(_key);
			return _object ? copyObject(_object) : null;
		}

		public function setValueCopy(_key:String, _value:Object):void {
			setValue(_key, _value ? copyObject(_value) : null);
		}

		public function flush():void {
			if (shareObject){
				shareObject.flush();
			}
		}
	}

}