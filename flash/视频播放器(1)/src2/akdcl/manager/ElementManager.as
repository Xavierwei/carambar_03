package akdcl.manager {
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	final public class ElementManager extends BaseManager {
		baseManager static var instance:ElementManager;
		public static function getInstance():ElementManager {
			return createConstructor(ElementManager) as ElementManager;
		}
		
		public function ElementManager() {
			super(this);
			elementsDic = { };
		}
		
		private var elementsDic:Object;

		public function register(_elementID:String, _ElementClass:Class = null, _factory:Function = null):void {
			if (elementsDic[_elementID]) {
				lM.warn(ElementManager, "register(id:{0}, class:{1}, factory:{2}) id is already registed!", null, _elementID, _ElementClass, _factory);
				return;
			}
			if (_ElementClass || _factory != null) {
				lM.info(ElementManager, "register(id:{0}, class:{1}, factory:{2})", null, _elementID, _ElementClass, _factory);
				var _elements:Elements = elementsDic[_elementID] = new Elements(_ElementClass, _factory);
			} else {
				lM.warn(ElementManager, "register(id:{0}, classOrFactory:{1}) class or factory mast be setted!", null, _elementID, _ElementClass, _factory);
			}
		}
		
		public function unregister(_elementID:String):void {
			var _elements:Elements = elementsDic[_elementID];
			if (_elements) {
				delete elementsDic[_elementID];
				_elements.remove();
			}
		}
		
		public function registerByClass(_ElementClass:Class, _factory:Function = null):void {
			var _id:String = getQualifiedClassName(_ElementClass);
			register(_id, _ElementClass, _factory);
		}
		
		public function unregisterByClass(_ElementClass:Class):void {
			var _id:String = getQualifiedClassName(_ElementClass);
			unregister(_id);
		}

		public function getElement(_elementID:String, ..._args):Object {
			var _elements:Elements = elementsDic[_elementID];
			if (_elements) {
				var _length:uint = _elements.getLength();
				lM.info(ElementManager, "getElement(id:{0}) length:{1}", null, _elementID, Math.max(_length - 1, 0));
				return (_args.length > 0?_elements.getElement.apply(null, _args):_elements.getElement());
			}
			lM.warn(ElementManager, "getElement(id:{0}) class is unregistered!", null, _elementID);
			return null;
		}
		
		public function getElementByClass(_ElementClass:Class, ..._args):Object {
			var _id:String = getQualifiedClassName(_ElementClass);
			if (_args.length > 0) {
				_args.unshift(_id);
				return getElement.apply(null, _args);
			}
			return getElement(_id);
		}
		
		public function recycle(_element:Object, _id:String = null):void {
			var _success:Boolean;
			var _elements:Elements;
			if (_id) {
				_elements = elementsDic[_id];
				_elements.recycle(_element);
				_success = true;
			}else {
				for each (_elements in elementsDic){
					if (_elements.recycleClass(_element)) {
						_success = true;
						break;
					}
				}
			}
			if (_success) {
				lM.info(ElementManager, "recycle(element:{0}) length:{1}", null, _element, _elements.getLength());
			}else {
				lM.warn(ElementManager, "recycle(element:{0}) unregister element!", null, _element);
			}
		}
	}
}

class Elements extends Object {
	private var factory:Function;
	private var ElementClass:Class;
	private var elementPrepared:Array;
	private var length:uint;

	public function getLength():uint {
		return length;
	}
	
	public function Elements(_ElementClass:Class, _factory:Function):void {
		ElementClass = _ElementClass;
		factory = _factory;
		elementPrepared = [];
		length = 0;
	}

	public function getElement(..._args):Object {
		var _element:Object;
		if (length > 0) {
			_element = elementPrepared.pop();
			length--;
		}else if(factory != null) {
			_element = (_args.length > 0?factory.apply(null, _args):factory());
		}else if (ElementClass) {
			_element = new ElementClass();
		}
		return _element;
	}
	
	public function recycle(_element:Object):void {
		elementPrepared.push(_element);
		length++;
	}

	public function recycleClass(_element:Object):Boolean {
		if (ElementClass && _element is ElementClass) {
			recycle(_element);
			return true;
		}
		return false;
	}
	
	public function remove():void {
		ElementClass = null;
		factory = null;
		elementPrepared = null;
		length = 0;
	}
}