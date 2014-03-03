package com.makeit.core.image
{
    import flash.display.*;
    import flash.geom.*;

    public class Reform extends Object
    {

        public function Reform()
        {
            return;
        }// end function

        public static function Newsize(param1:BitmapData, param2:int, param3:int, param4:Point, param5:uint) : BitmapData
        {
            var _loc_6:* = new BitmapData(param2, param3, true, param5);
            new BitmapData(param2, param3, true, param5).copyPixels(param1, param1.rect, param4);
            return _loc_6;
        }// end function

        public static function MaxSize(param1:BitmapData, param2:int, param3:int) : BitmapData
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            if (param1.width > param2 || param1.height > param3)
            {
                if (param1.height / param3 > param1.width / param2)
                {
                    _loc_4 = Math.round(param1.width * (param3 / param1.height));
                    _loc_5 = param3;
                }
                else
                {
                    _loc_5 = Math.round(param1.height * (param2 / param1.width));
                    _loc_4 = param2;
                }
                return Resize(param1, _loc_4 / param1.width, _loc_5 / param1.height);
            }
            else
            {
                return param1;
            }
        }// end function

        public static function Resize(param1:BitmapData, param2:Number, param3:Number) : BitmapData
        {
            var _loc_4:Matrix = null;
            var _loc_5:BitmapData = null;
            var _loc_6:* = Math.round(param1.width * param2);
            var _loc_7:* = Math.round(param1.height * param3);
            while (param1.width > _loc_6 * 2 && param1.height > _loc_7 * 2)
            {
                
                _loc_5 = param1.clone();
                param1 = new BitmapData(Math.round(param1.width * 0.5), Math.round(param1.height * 0.5), true, 16777215);
                _loc_4 = new Matrix();
                _loc_4.scale(param1.width / _loc_5.width, param1.height / _loc_5.height);
                param1.draw(_loc_5, _loc_4, null, null, null, true);
            }
            _loc_4 = new Matrix();
            _loc_4.scale(_loc_6 / param1.width, _loc_7 / param1.height);
            var _loc_8:* = new Bitmap(param1, "auto", true);
            _loc_5 = new BitmapData(_loc_6, _loc_7, true, 16777215);
            _loc_5.draw(_loc_8, _loc_4, null, null, null, true);
            return _loc_5;
        }// end function

        public static function Rotate(param1:BitmapData) : BitmapData
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:* = param1.width;
            var _loc_5:* = param1.height;
            var _loc_6:* = new BitmapData(_loc_5, _loc_4, true, 16777215);
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                _loc_3 = 0;
                while (_loc_3 < _loc_5)
                {
                    
                    _loc_6.setPixel32(_loc_3, (_loc_4 - 1) - _loc_2, param1.getPixel32(_loc_2, _loc_3));
                    _loc_3++;
                }
                _loc_2++;
            }
            return _loc_6;
        }// end function

    }
}
