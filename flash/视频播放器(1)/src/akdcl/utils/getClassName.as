package akdcl.utils {
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function getClassName(_object:Object):String {
		return getQualifiedClassName(_object).split("::").pop();
	}
}