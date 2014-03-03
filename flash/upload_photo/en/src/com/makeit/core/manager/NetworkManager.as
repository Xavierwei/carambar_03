package com.makeit.core.manager
{
    import flash.net.*;
    import flash.utils.*;

    public class NetworkManager extends Object
    {
        private var file:FileReference;
        private var uploadURL:URLRequest;

        public function NetworkManager()
        {
            return;
        }// end function

        public function GenerateRequest(param1:String, param2:ByteArray, param3:String, param4:Dictionary, param5:String = "image") : URLRequest
        {
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_11:String = null;
            var _loc_8:String = "--";
            var _loc_9:* = new URLRequest();
            var _loc_10:* = new ByteArray();
            _loc_6 = 0;
            while (_loc_6 < 16)
            {
                
                _loc_8 = _loc_8 + String.fromCharCode(int(97 + Math.random() * 25));
                _loc_6++;
            }
            _loc_9.url = param1;
            _loc_9.contentType = "multipart/form-data; boundary=" + _loc_8;
            _loc_9.method = URLRequestMethod.POST;
            _loc_10.endian = Endian.BIG_ENDIAN;
            for (_loc_11 in param4)
            {
                
                _loc_10.writeShort(11565);
                _loc_6 = 0;
                while (_loc_6 < _loc_8.length)
                {
                    
                    _loc_10.writeByte(_loc_8.charCodeAt(_loc_6));
                    _loc_6++;
                }
                _loc_10.writeShort(3338);
                _loc_7 = "Content-Disposition: form-data; name=\"" + _loc_11 + "\"";
                _loc_6 = 0;
                while (_loc_6 < _loc_7.length)
                {
                    
                    _loc_10.writeByte(_loc_7.charCodeAt(_loc_6));
                    _loc_6++;
                }
                _loc_10.writeInt(218762506);
                _loc_10.writeUTFBytes(param4[_loc_11]);
                _loc_10.writeShort(3338);
            }
            _loc_10.writeShort(11565);
            _loc_6 = 0;
            while (_loc_6 < _loc_8.length)
            {
                
                _loc_10.writeByte(_loc_8.charCodeAt(_loc_6));
                _loc_6++;
            }
            _loc_10.writeShort(3338);
            _loc_7 = "Content-Disposition: form-data; name=\"" + param5 + "\"; filename=\"";
            _loc_6 = 0;
            while (_loc_6 < _loc_7.length)
            {
                
                _loc_10.writeByte(_loc_7.charCodeAt(_loc_6));
                _loc_6++;
            }
            _loc_10.writeUTFBytes(param3);
            _loc_10.writeByte(34);
            _loc_10.writeShort(3338);
            _loc_7 = "Content-Type: application/octet-stream";
            _loc_6 = 0;
            while (_loc_6 < _loc_7.length)
            {
                
                _loc_10.writeByte(_loc_7.charCodeAt(_loc_6));
                _loc_6++;
            }
            _loc_10.writeInt(218762506);
            _loc_10.writeBytes(param2, 0, param2.length);
            _loc_10.writeShort(3338);
            _loc_10.writeShort(11565);
            _loc_6 = 0;
            while (_loc_6 < _loc_8.length)
            {
                
                _loc_10.writeByte(_loc_8.charCodeAt(_loc_6));
                _loc_6++;
            }
            _loc_10.writeShort(11565);
            _loc_10.writeShort(3338);
            _loc_9.data = _loc_10;
            _loc_9.requestHeaders.push(new URLRequestHeader("Cache-Control", "no-cache"));
            return _loc_9;
        }// end function

    }
}
