package com.uploadPic 
{
	import com.makeit.managers.Singleton;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author happy
	 */
	public class AppModel extends Singleton 
	{
		public var picData:ByteArray=new ByteArray();
		public var resultData:ByteArray = new ByteArray();
		public var bmp:BitmapData;
		public function AppModel() 
		{
			
		}
		
	}

}