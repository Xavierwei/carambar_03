package com.makeit.utils {
	import com.makeit.crypto.Base64
	/**
	 * @author quhuan
	 */
	public class BitmapBytes {
		import flash.display.BitmapData;    
	    import flash.geom.Rectangle;    
	    import flash.utils.ByteArray;      
            
        public static function encodeByteArray(data:BitmapData):ByteArray{    
            if(data == null){    
                throw new Error("data参数不能为空!");    
            }    
            var bytes:ByteArray = data.getPixels(data.rect);    
            bytes.writeShort(data.width);    
            bytes.writeShort(data.height);    
            bytes.writeBoolean(data.transparent);    
            bytes.compress();    
            return bytes;    
        }    
        public static function encodeBase64(data:BitmapData):String{    
            return Base64.encodeByteArray(encodeByteArray(data));    
        }    
            
        public static function decodeByteArray(bytes:ByteArray):BitmapData{    
            if(bytes == null){    
                throw new Error("bytes参数不能为空!");    
            }    
            bytes.uncompress();    
            if(bytes.length < 6){    
                throw new Error("bytes参数为无效值!");    
            }               
            bytes.position = bytes.length - 1;    
            var transparent:Boolean = bytes.readBoolean();    
            bytes.position = bytes.length - 3;    
            var height:int = bytes.readShort();    
            bytes.position = bytes.length - 5;    
            var width:int = bytes.readShort();    
            bytes.position = 0;    
            var datas:ByteArray = new ByteArray();              
            bytes.readBytes(datas,0,bytes.length - 5);    
            var bmp:BitmapData = new BitmapData(width,height,transparent,0);    
            bmp.setPixels(new Rectangle(0,0,width,height),datas);    
            return bmp;    
        }    
            
        public static function decodeBase64(data:String):BitmapData{                
            return decodeByteArray(Base64.decodeToByteArray(data));    
        }           
            
        public function BitmapBytes() {    
            throw new Error("BitmapBytes类只是一个静态类!");    
        }    
            
 	}
}  

          
