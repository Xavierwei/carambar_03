package com.makeit.core
{
    import flash.display.*;
    import flash.geom.*;

    public class Util extends Object
    {

        public function Util()
        {
            return;
        }// end function

        public static function BestFit(param1:Rectangle, param2:Rectangle) : Rectangle
        {
            var _loc_3:* = new Rectangle();
            var _loc_4:* = param2.width / param2.height;
            var _loc_5:* = param1.width / param1.height;
            var _loc_6:Number = 1;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            if (_loc_5 > _loc_4)
            {
                _loc_6 = param2.width / param1.width;
                _loc_3.y = (param2.height - param1.height * _loc_6) / 2;
            }
            else
            {
                _loc_6 = param2.height / param1.height;
                _loc_3.x = (param2.width - param1.width * _loc_6) / 2;
            }
            _loc_3.width = param1.width * _loc_6;
            _loc_3.height = param1.height * _loc_6;
            return _loc_3;
        }// end function

        public static function CalculateBorder(param1:BitmapData, param2:int, param3:int) : BitmapData
        {
            var _loc_5:Bitmap = null;
            var _loc_6:Bitmap = null;
            var _loc_7:Bitmap = null;
            var _loc_8:Bitmap = null;
            var _loc_4:* = new BitmapData(param2, param3, true, 16777215);
            new BitmapData(param2, param3, true, 16777215).copyPixels(param1, new Rectangle(0, 0, 100, 100), new Point(0, 0));
            _loc_4.copyPixels(param1, new Rectangle(param1.width - 100, 0, 100, 100), new Point(_loc_4.width - 100, 0));
            _loc_4.copyPixels(param1, new Rectangle(0, param1.height - 100, 100, 100), new Point(0, _loc_4.height - 100));
            _loc_4.copyPixels(param1, new Rectangle(param1.width - 100, param1.height - 100, 100, 100), new Point(_loc_4.width - 100, _loc_4.height - 100));
            if (_loc_4.width - 200 <= param1.width - 200)
            {
                _loc_4.copyPixels(param1, new Rectangle(100, 0, _loc_4.width - 200, 100), new Point(100, 0));
                _loc_4.copyPixels(param1, new Rectangle(100, param1.height - 100, _loc_4.width - 200, 100), new Point(100, _loc_4.height - 100));
            }
            else
            {
                _loc_5 = new Bitmap(Util.GetPart(param1, 100, 0, param1.width - 200, 100));
                _loc_6 = new Bitmap(Util.GetPart(param1, 100, param1.height - 100, param1.width - 200, 100));
                var _loc_9:* = _loc_4.width - 200;
                _loc_6.width = _loc_4.width - 200;
                _loc_5.width = _loc_9;
                _loc_6.y = _loc_4.height - 100;
                var _loc_9:int = 100;
                _loc_6.x = 100;
                _loc_5.x = _loc_9;
                _loc_4.draw(_loc_5, _loc_5.transform.matrix);
                _loc_4.draw(_loc_6, _loc_6.transform.matrix);
            }
            if (_loc_4.height - 200 <= param1.height - 200)
            {
                _loc_4.copyPixels(param1, new Rectangle(0, 100, 100, _loc_4.height - 200), new Point(0, 100));
                _loc_4.copyPixels(param1, new Rectangle(param1.width - 100, 100, 100, _loc_4.height - 200), new Point(_loc_4.width - 100, 100));
            }
            else
            {
                _loc_7 = new Bitmap(Util.GetPart(param1, 0, 100, 100, param1.height - 200));
                _loc_8 = new Bitmap(Util.GetPart(param1, param1.width - 100, 100, 100, param1.height - 200));
                var _loc_9:* = _loc_4.height - 200;
                _loc_8.height = _loc_4.height - 200;
                _loc_7.height = _loc_9;
                _loc_8.x = _loc_4.width - 100;
                var _loc_9:int = 100;
                _loc_8.y = 100;
                _loc_7.y = _loc_9;
                _loc_4.draw(_loc_7, _loc_7.transform.matrix);
                _loc_4.draw(_loc_8, _loc_8.transform.matrix);
            }
            return _loc_4;
        }// end function

        public static function GetPart(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : BitmapData
        {
            var _loc_6:* = new BitmapData(param4, param5);
            new BitmapData(param4, param5).copyPixels(param1, new Rectangle(param2, param3, param4, param5), param1.rect.topLeft);
            return _loc_6;
        }// end function

    }
}
