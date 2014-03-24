package akdcl.utils {

	/**
	 * ...
	 * @author ...
	 */
	//addAttributeToXML(xml,id,value,id,value,id,value,id,value,id,value,...);
	public function addAttributeToXML(_xml:XML, ...args):void {
		if (_xml) {
			for (var _i:uint = 0; _i < args.length; _i += 2 ) {
				_xml["@" + args[_i]] = args[_i + 1];
			}
		}
	}

}