package com.makeit.net {
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * @author quhuan
	 */
	public class UploadFileData extends Dictionary {
		public var fileBytes:ByteArray;
		public var fileName:String;
		public var uploadDataFieldName:String;
		public function UploadFileData(weakKeys : Boolean = false) {
			super(weakKeys);
		}
		public function bb():void{
		
		}
	}
}
