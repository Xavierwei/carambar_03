//http://code.google.com/p/as3-jpeg-decoder/downloads/detail?name=jpeg-decoder.zip&can=2&q=

/**
 * __    ___  __ ___   ___                   _           
   \ \  / _ \/__\ _ \ /   \___  ___ ___   __| | ___ _ __ 
    \ \/ /_)/_\/ /_\// /\ / _ \/ __/ _ \ / _` |/ _ \ '__|
 /\_/ / ___//__ /_\\/ /_//  __/ (__ (_) | (_| |  __/ |   
 \___/\/   \__\____/___,' \___|\___\___/ \__,_|\___|_|
 
 * This class lets you decode a JPEG stream in ActionScript 3 in Flash Player 10
 * @author Thibault Imbert (bytearray.org)
 * @version 0.2 - Removed unuseful setters.
 * @version 0.3 - If needed, stream can now be passed when JPEGDecoder is instanciated.
 * @version 0.4 - Check file header before processing it.
 */

package zero.codec{
	import cmodule.jpegdecoder.CLibInit;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	public final class JPEGDecoder{
		
		//20120920
		
		private static const loader:CLibInit=new CLibInit();
		private static const ns:Namespace = new Namespace("cmodule.jpegdecoder");
		
		public static function decode(imgData:ByteArray):BitmapData{
			imgData.position = 0;
			if (imgData.readUnsignedShort() == 0xFFD8){
				loader.supplyFile("stream", imgData);
				var lib:Object = loader.init();
				
				var memory:ByteArray = (ns::gstate).ds;
				var infos:Array = lib.parseJPG ("stream");
				
				var _width:int = infos[0];
				var _height:int = infos[1];
				//var _numComponents:uint = infos[2];
				//var _colorComponents:uint = infos[3];
				var position:int = infos[4];
				var i:int = _width*_height*3;
				
				var bmdBytesId:int=0;
				var bmdBytes:ByteArray=new ByteArray();
				while(i--){
					bmdBytes[bmdBytesId++]=0xff;
					bmdBytes[bmdBytesId++]=memory[position++];
					bmdBytes[bmdBytesId++]=memory[position++];
					bmdBytes[bmdBytesId++]=memory[position++];
				}
				var bmd:BitmapData=new BitmapData(_width,_height,false);
				bmd.setPixels(bmd.rect,bmdBytes);
				return bmd;
			}
			throw new Error ("Not a valid JPEG file.");
		}
	}
}