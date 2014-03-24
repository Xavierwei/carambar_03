/*@
***summary***
Copyright (c) 2007 Frank@2solo.cn
URL:www.2solo.cn
Create date:2008.01.12
Last modified by:frank
Last modified at:2008.01.12
File version:v1.00
Framework ID:Novattack Ver3.0.1
Path:nt.utils
Info:byteArray转换器(Byte encoder)
Location:shanghai,china
*/
package nt.utils{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	public class ByteEncoder extends Sprite{
		/*
		*将乱码的编码转换为中文
		*/
		public static function EncodeUtf8(str : String):String {
			if (str!=null) {
				var oriByteArr : ByteArray = new ByteArray();
				oriByteArr.writeUTFBytes(str);
				var tempByteArr : ByteArray = new ByteArray();
				for (var i = 0; i<oriByteArr.length; i++) {
					if (oriByteArr[i] == 194) {
						tempByteArr.writeByte(oriByteArr[i+1]);
						i++;
					} else if (oriByteArr[i] == 195) {
						tempByteArr.writeByte(oriByteArr[i+1] + 64);
						i++;
					} else {
						tempByteArr.writeByte(oriByteArr[i]);
					}
				}
				tempByteArr.position = 0;
				return tempByteArr.readMultiByte(tempByteArr.bytesAvailable,"chinese");
			} else {
				return "";
			}
		}
	}
}