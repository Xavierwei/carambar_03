package com.makeit.core.image
{
    import flash.filters.*;

    public class ColorMatrix extends Object
    {
        private var  LUMA_R:Number = 0.212671;
        private var  LUMA_G:Number = 0.71516;
        private var  LUMA_B:Number = 0.072169;
        private var  LUMA_R2:Number = 0.3086;
        private var  LUMA_G2:Number = 0.6094;
        private var  LUMA_B2:Number = 0.082;
        private var  ONETHIRD:Number = 0.333333;
        private var  IDENTITY:Array;
        private const RAD:Number = 0.0174533;
        public var matrix:Array;

        public function ColorMatrix()
        {
            IDENTITY = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
            this.matrix = this.IDENTITY.concat();
            return;
        }// end function

        public function Invert() : void
        {
            this.concat([-1, 0, 0, 0, 255, 0, -1, 0, 0, 255, 0, 0, -1, 0, 255, 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function AdjustSaturation(param1:Number) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            _loc_2 = 1 - param1;
            _loc_3 = _loc_2 * this.LUMA_R;
            _loc_4 = _loc_2 * this.LUMA_G;
            _loc_5 = _loc_2 * this.LUMA_B;
            this.concat([_loc_3 + param1, _loc_4, _loc_5, 0, 0, _loc_3, _loc_4 + param1, _loc_5, 0, 0, _loc_3, _loc_4, _loc_5 + param1, 0, 0, 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function AdjustContrast(param1:Number) : void
        {
            param1 = param1 + 1;
            this.concat([param1, 0, 0, 0, 128 * (1 - param1), 0, param1, 0, 0, 128 * (1 - param1), 0, 0, param1, 0, 128 * (1 - param1), 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function AdjustBrightness(param1:Number) : void
        {
            this.concat([1, 0, 0, 0, param1, 0, 1, 0, 0, param1, 0, 0, 1, 0, param1, 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function AdjustHue(param1:Number) : void
        {
            param1 = param1 * this.RAD;
            var _loc_2:* = Math.cos(param1);
            var _loc_3:* = Math.sin(param1);
            this.concat([this.LUMA_R + _loc_2 * (1 - this.LUMA_R) + _loc_3 * (-this.LUMA_R), this.LUMA_G + _loc_2 * (-this.LUMA_G) + _loc_3 * (-this.LUMA_G), this.LUMA_B + _loc_2 * (-this.LUMA_B) + _loc_3 * (1 - this.LUMA_B), 0, 0, this.LUMA_R + _loc_2 * (-this.LUMA_R) + _loc_3 * 0.143, this.LUMA_G + _loc_2 * (1 - this.LUMA_G) + _loc_3 * 0.14, this.LUMA_B + _loc_2 * (-this.LUMA_B) + _loc_3 * -0.283, 0, 0, this.LUMA_R + _loc_2 * (-this.LUMA_R) + _loc_3 * (-(1 - this.LUMA_R)), this.LUMA_G + _loc_2 * (-this.LUMA_G) + _loc_3 * this.LUMA_G, this.LUMA_B + _loc_2 * (1 - this.LUMA_B) + _loc_3 * this.LUMA_B, 0, 0, 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function Colorize(param1:int) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:int = 1;
            var _loc_6:int = 1;
            var _loc_7:* = param1 / 60;
            var _loc_8:* = int(_loc_7);
            var _loc_9:* = _loc_7 - _loc_8;
            var _loc_10:* = _loc_6 * (1 - _loc_5);
            var _loc_11:* = _loc_6 * (1 - _loc_5 * _loc_9);
            var _loc_12:* = _loc_6 * (1 - _loc_5 * (1 - _loc_9));
            switch(_loc_8)
            {
                case 0:
                {
                    _loc_2 = 1;
                    _loc_3 = _loc_12;
                    _loc_4 = _loc_10;
                    break;
                }
                case 1:
                {
                    _loc_2 = _loc_11;
                    _loc_3 = 1;
                    _loc_4 = _loc_10;
                    break;
                }
                case 2:
                {
                    _loc_2 = _loc_10;
                    _loc_3 = 1;
                    _loc_4 = _loc_12;
                    break;
                }
                case 3:
                {
                    _loc_2 = _loc_10;
                    _loc_3 = _loc_11;
                    _loc_4 = 1;
                    break;
                }
                case 4:
                {
                    _loc_2 = _loc_12;
                    _loc_3 = _loc_10;
                    _loc_4 = 1;
                    break;
                }
                case 5:
                {
                    _loc_2 = 1;
                    _loc_3 = _loc_10;
                    _loc_4 = _loc_11;
                    break;
                }
                case 6:
                {
                    _loc_2 = 1;
                    _loc_3 = _loc_12;
                    _loc_4 = _loc_10;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.concat([_loc_2 * this.LUMA_R2, _loc_2 * this.LUMA_G2, _loc_2 * this.LUMA_B2, 0, 0, _loc_3 * this.LUMA_R2, _loc_3 * this.LUMA_G2, _loc_3 * this.LUMA_B2, 0, 0, _loc_4 * this.LUMA_R2, _loc_4 * this.LUMA_G2, _loc_4 * this.LUMA_B2, 0, 0, 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function Threshold(param1:Number, param2:Number = 256) : void
        {
            this.concat([this.LUMA_R * param2, this.LUMA_G * param2, this.LUMA_B * param2, 0, (-param2) * param1, this.LUMA_R * param2, this.LUMA_G * param2, this.LUMA_B * param2, 0, (-param2) * param1, this.LUMA_R * param2, this.LUMA_G * param2, this.LUMA_B * param2, 0, (-param2) * param1, 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function AlphaThreshold(param1:Number, param2:Number = 256) : void
        {
            this.concat([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, param2, (-param2) * param1]);
            return;
        }// end function

        public function Desaturate() : void
        {
            this.concat([this.LUMA_R, this.LUMA_G, this.LUMA_B, 0, 0, this.LUMA_R, this.LUMA_G, this.LUMA_B, 0, 0, this.LUMA_R, this.LUMA_G, this.LUMA_B, 0, 0, 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function InvertAlpha() : void
        {
            this.concat([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, -1, 255]);
            return;
        }// end function

        public function get filter() : ColorMatrixFilter
        {
            return new ColorMatrixFilter(this.matrix);
        }// end function

        public function concat(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_2:Array = [];
            var _loc_3:int = 0;
            _loc_5 = 0;
            while (_loc_5 < 4)
            {
                
                _loc_4 = 0;
                while (_loc_4 < 5)
                {
                    
                    _loc_2[int(_loc_3 + _loc_4)] = Number(param1[_loc_3]) * Number(this.matrix[_loc_4]) + Number(param1[int((_loc_3 + 1))]) * Number(this.matrix[int(_loc_4 + 5)]) + Number(param1[int(_loc_3 + 2)]) * Number(this.matrix[int(_loc_4 + 10)]) + Number(param1[int(_loc_3 + 3)]) * Number(this.matrix[int(_loc_4 + 15)]) + (_loc_4 == 4 ? (Number(param1[int(_loc_3 + 4)])) : (0));
                    _loc_4++;
                }
                _loc_3 = _loc_3 + 5;
                _loc_5++;
            }
            this.matrix = _loc_2;
            return;
        }// end function

        public function rotateRed(param1:Number) : void
        {
            this.rotateColor(param1, 2, 1);
            return;
        }// end function

        public function rotateGreen(param1:Number) : void
        {
            this.rotateColor(param1, 0, 2);
            return;
        }// end function

        public function rotateBlue(param1:Number) : void
        {
            this.rotateColor(param1, 1, 0);
            return;
        }// end function

        private function rotateColor(param1:Number, param2:int, param3:int) : void
        {
            param1 = param1 * this.RAD;
            var _loc_4:* = this.IDENTITY.concat();
            var _loc_5:* = Math.cos(param1);
            _loc_4[param3 + param3 * 5] = Math.cos(param1);
            this.IDENTITY.concat()[param2 + param2 * 5] = _loc_5;
            _loc_4[param3 + param2 * 5] = Math.sin(param1);
            _loc_4[param2 + param3 * 5] = -Math.sin(param1);
            this.concat(_loc_4);
            return;
        }// end function

        public function shearRed(param1:Number, param2:Number) : void
        {
            this.shearColor(0, 1, param1, 2, param2);
            return;
        }// end function

        public function shearGreen(param1:Number, param2:Number) : void
        {
            this.shearColor(1, 0, param1, 2, param2);
            return;
        }// end function

        public function shearBlue(param1:Number, param2:Number) : void
        {
            this.shearColor(2, 0, param1, 1, param2);
            return;
        }// end function

        private function shearColor(param1:int, param2:int, param3:Number, param4:int, param5:Number) : void
        {
            var _loc_6:* = this.IDENTITY.concat();
            this.IDENTITY.concat()[param2 + param1 * 5] = param3;
            _loc_6[param4 + param1 * 5] = param5;
            this.concat(_loc_6);
            return;
        }// end function

    }
}
