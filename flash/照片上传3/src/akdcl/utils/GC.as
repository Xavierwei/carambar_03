package akdcl.utils {
	import flash.net.LocalConnection;
	/**
	 * ...
	 * @author Akdcl
	 */
	public function GC():void {
		try {
			new LocalConnection().connect("GC");
			new LocalConnection().connect("GC");
		} catch (error:Error){
		}
	}
}