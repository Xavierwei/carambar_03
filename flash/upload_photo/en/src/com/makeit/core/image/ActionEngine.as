package com.makeit.core.image
{
   
    import flash.display.*;
	import flash.display.shaders.*;

    import flash.filters.*;
    import flash.geom.*;

    public class ActionEngine extends Object
    {
        private static const power:String = "v6";
        private static const version:int = 2;

        public function ActionEngine()
        {
            return;
        }// end function

        public static function Run(param1:BitmapData, param2:Object) : void
        {
			
            var _loc_3:Array = null;
            if (param2 != null)
            {
//                if (param2.engine.power.toLowerCase() != power)
//                {
//                    return;
//                }
//                if (param2.engine.version > version)
//                {
//                    return;
//                }
                _loc_3 = new Array();
                _loc_3.push(param1);
                RunAction(_loc_3, param2.actions);
            }
            return;
        }// end function

        private static function RunAction(param1:Array, param2:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_3:int = 0;
            while (_loc_4 < param2.length)
            {
                
                _loc_5 = param2[_loc_4];
                if (_loc_5.target != null)
                {
                    _loc_3 = _loc_5.target;
                }
                switch(_loc_5.type)
                {
                    case "blur":
                    {
                        Blur(param1[_loc_3], _loc_5.param.amount, _loc_5.param.quality);
                        break;
                    }
                    case "boxblur":
                    {
                        BoxBlur(param1[_loc_3], _loc_5.param.amount);
                        break;
                    }
                    case "sharpen":
                    {
                        Sharpen(param1[_loc_3]);
                        break;
                    }
                    case "noise":
                    {
                        Noise(param1[_loc_3], _loc_5.param.amount);
                        break;
                    }
                    case "pixelate":
                    {
                        Pixelate(param1[_loc_3], _loc_5.param.size);
                        break;
                    }
                    case "waterdown":
                    {
                        Waterdown(param1[_loc_3]);
                        break;
                    }
                    case "autofix":
                    {
                        AutoFix(param1[_loc_3]);
                        break;
                    }
                    case "lookup":
                    {
                        Lookup(param1[_loc_3], _loc_5.param.data);
                        break;
                    }
                    case "colorize":
                    {
                        Colorize(param1[_loc_3], _loc_5.param.hue);
                        break;
                    }
                    case "saturation":
                    {
                        Saturation(param1[_loc_3], _loc_5.param.amount);
                        break;
                    }
                    case "brightness":
                    {
                        Brightness(param1[_loc_3], _loc_5.param.amount);
                        break;
                    }
                    case "contrast":
                    {
                        Contrast(param1[_loc_3], _loc_5.param.amount);
                        break;
                    }
                    case "threshold":
                    {
                        Threshold(param1[_loc_3], _loc_5.param.value);
                        break;
                    }
                    case "desaturate":
                    {
                        Desaturate(param1[_loc_3]);
                        break;
                    }
                    case "invert":
                    {
                        Invert(param1[_loc_3]);
                        break;
                    }
                    case "vignette":
                    {
                        Vignette(param1[_loc_3], _loc_5.param.color, _loc_5.param.size);
                        break;
                    }
                    case "mapping":
                    {
                        Mapping(param1[_loc_3], _loc_5.param.red, _loc_5.param.green, _loc_5.param.blue);
                        break;
                    }
                    case "levels":
                    {
                        Levels(param1[_loc_3], _loc_5.param.min, _loc_5.param.max);
                        break;
                    }
                    case "fill":
                    {
                        Fill(param1, ++_loc_3, _loc_5.param.x, _loc_5.param.y, _loc_5.param.width, _loc_5.param.height, _loc_5.param.color);
                        break;
                    }
                    case "gradient":
                    {
                        _loc_3++;
					//	trace(param1, ++_loc_3 + 1, _loc_5.param.type, _loc_5.param.rotation, _loc_5.param.colors, _loc_5.param.alphas, _loc_5.param.ratios)
                        Gradient(param1, _loc_3, _loc_5.param.type, _loc_5.param.rotation, _loc_5.param.colors, _loc_5.param.alphas, _loc_5.param.ratios);
                        break;
                    }
                    case "duplicate":
                    {
                        Duplicate(param1, ++_loc_3);
                        break;
                    }
                    case "copy":
                    {
                       // _loc_3 = ++_loc_3 + 1;
                       _loc_3++;
                        Copy(param1, _loc_3, _loc_5.param.x, _loc_5.param.y, _loc_5.param.width, _loc_5.param.height, _loc_5.param.tx, _loc_5.param.ty, _loc_5.param.scale);
                        break;
                    }
                    case "merge":
                    {
                        Merge(param1, --_loc_3, _loc_5.param.opacity, _loc_5.param.blend, _loc_5.param.mask);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        private static function Duplicate(param1:Array, param2:int) : void
        {
            param1.splice(param2, 0, (param1[(param2 - 1)] as BitmapData).clone());
            return;
        }// end function

        private static function Copy(param1:Array, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number = 100) : void
        {
            var _loc_13:BitmapData = null;
            var _loc_10:* = param1[(param2 - 1)].width;
            var _loc_11:* = param1[(param2 - 1)].height;
            var _loc_12:* = new BitmapData(_loc_10, _loc_11, true, 16777215);
            if (isNaN(param9) || param9 == 0 || param9 == 100)
            {
                _loc_12.copyPixels(param1[(param2 - 1)] as BitmapData, new Rectangle(Math.round(_loc_10 * (param3 / 100)), Math.round(_loc_11 * (param4 / 100)), Math.round(_loc_10 * (param5 / 100)), Math.round(_loc_11 * (param6 / 100))), new Point(Math.round(_loc_10 * (param7 / 100)), Math.round(_loc_11 * (param8 / 100))));
            }
            else
            {
                _loc_13 = new BitmapData(Math.round(_loc_10 * (param5 / 100)), Math.round(_loc_11 * (param6 / 100)), true, 16777215);
                _loc_13.copyPixels(param1[(param2 - 1)] as BitmapData, new Rectangle(Math.round(_loc_10 * (param3 / 100)), Math.round(_loc_11 * (param4 / 100)), Math.round(_loc_10 * (param5 / 100)), Math.round(_loc_11 * (param6 / 100))), new Point(0, 0));
                _loc_13 = Reform.Resize(_loc_13, param9 / 100, param9 / 100);
                _loc_12.copyPixels(_loc_13, _loc_13.rect, new Point(Math.round(_loc_10 * (param7 / 100)), Math.round(_loc_11 * (param8 / 100))));
            }
            param1.splice(param2, 0, _loc_12);
            return;
        }// end function

        private static function Merge(param1:Array, param2:int, param3:int, param4:String, param5:int) : void
        {
            var _loc_8:Bitmap = null;
            var _loc_6:* = new Bitmap(param1[(param2 + 1)] as BitmapData);
            if (param3 != 0)
            {
                _loc_6.alpha = param3 / 100;
            }
            if (param4 != null && param4 != "")
            {
                if (param4 == "softlight")
                {
                    _loc_6.blendShader = new BlendModeSoftlight();
                    _loc_6.blendMode = BlendMode.SHADER;
                }
                else
                {
                    _loc_6.blendMode = param4;
                }
            }
            var _loc_7:* = new Sprite();
            if (param5 != 0)
            {
                _loc_8 = new Bitmap(param1[param5] as BitmapData);
                _loc_8.cacheAsBitmap = true;
                _loc_7.cacheAsBitmap = true;
                _loc_7.addChild(_loc_8);
                _loc_7.mask = _loc_8;
            }
            _loc_7.addChild(_loc_6);
            (param1[param2] as BitmapData).draw(_loc_7);
            if (param5 != 0)
            {
                param1.splice(param5, 1);
            }
            param1.splice((param2 + 1), 1);
            return;
        }// end function

        private static function Fill(param1:Array, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint) : void
        {
            var _loc_8:* = param1[0].width;
            var _loc_9:* = param1[0].height;
            var _loc_10:* = new BitmapData(_loc_8, _loc_9, true, 16777215);
            var _loc_11:* = new BitmapData(_loc_8, _loc_9, false, param7);
            _loc_10.copyPixels(_loc_11, new Rectangle(0, 0, Math.round(_loc_8 * (param5 / 100)), Math.round(_loc_9 * (param6 / 100))), new Point(Math.round(_loc_8 * (param3 / 100)), Math.round(_loc_9 * (param4 / 100))));
            param1.splice(param2, 0, _loc_10);
            return;
        }// end function

        private static function Gradient(param1:Array, param2:int, param3:String, param4:int, param5:Array, param6:Array, param7:Array) : void
        {
            var _loc_8:Matrix = new Matrix();
		
            _loc_8.createGradientBox(param1[(param2 - 1)].width, param1[(param2 - 1)].height, param4 / (180 / Math.PI), 0, 0);
            var _loc_9:Sprite = new Sprite();
            _loc_9.graphics.beginGradientFill(param3, param5, param6, param7, _loc_8);
            _loc_9.graphics.drawRect(0, 0, param1[(param2 - 1)].width, param1[(param2 - 1)].height);
            _loc_9.graphics.endFill();
            var _loc_10:* = new BitmapData(param1[(param2 - 1)].width, param1[(param2 - 1)].height, true, 16777215);
            new BitmapData(param1[(param2 - 1)].width, param1[(param2 - 1)].height, true, 16777215).draw(_loc_9);
            param1.splice(param2, 0, _loc_10);
            return;
        }// end function

        private static function AutoFix(param1:BitmapData) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:uint = 0;
            var _loc_14:int = 0;
            var _loc_6:* = new Vector.<int>(256, true);
            var _loc_7:* = new Vector.<int>(256, true);
            var _loc_8:* = new Vector.<int>(256, true);
            var _loc_9:int = 0;
            while (_loc_9 < param1.width)
            {
                
                _loc_14 = 0;
                while (_loc_14 < param1.height)
                {
                    
                    _loc_5 = param1.getPixel(_loc_9, _loc_14);
                    _loc_2 = _loc_5 >>> 16 & 255;
                    _loc_3 = _loc_5 >>> 8 & 255;
                    _loc_4 = _loc_5 & 255;
                    (_loc_6[_loc_2] + 1);
                    (_loc_7[_loc_3] + 1);
                    (_loc_8[_loc_4] + 1);
                    _loc_14++;
                }
                _loc_9++;
            }
            var _loc_10:* = Math.round(param1.width * param1.height / 1000);
            var _loc_11:* = new ChannelMap();
            var _loc_12:* = new ChannelMap();
            var _loc_13:* = new ChannelMap();
            PrepareMap(_loc_6, _loc_11, _loc_10);
            PrepareMap(_loc_7, _loc_12, _loc_10);
            PrepareMap(_loc_8, _loc_13, _loc_10);
            param1.paletteMap(param1, param1.rect, param1.rect.topLeft, _loc_11.ComputeArray(16), _loc_12.ComputeArray(8), _loc_13.ComputeArray(0));
            return;
        }// end function

        private static function PrepareMap(param1:Vector.<int>, param2:ChannelMap, param3:int) : void
        {
            var _loc_4:int = 0;
            _loc_4 = 0;
            while (_loc_4 < 256)
            {
                
                if (param1[_loc_4] > param3)
                {
                    param2.minin = _loc_4;
                    break;
                }
                _loc_4++;
            }
            _loc_4 = 255;
            while (_loc_4 >= 0)
            {
                
                if (param1[_loc_4] > param3)
                {
                    param2.maxin = _loc_4;
                    break;
                }
                _loc_4 = _loc_4 - 1;
            }
            return;
        }// end function

        private static function Lookup(param1:BitmapData, param2:Array) : void
        {
            var _loc_3:uint = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            _loc_8 = 0;
            while (_loc_8 < param1.height)
            {
                
                _loc_7 = 0;
                while (_loc_7 < param1.width)
                {
                    
                    _loc_3 = param1.getPixel(_loc_7, _loc_8);
                    _loc_4 = _loc_3 >>> 16 & 255;
                    _loc_5 = _loc_3 >>> 8 & 255;
                    _loc_6 = _loc_3 & 255;
                    param1.setPixel(_loc_7, _loc_8, param2[int((_loc_4 + _loc_5 + _loc_6) / 3)]);
                    _loc_7++;
                }
                _loc_8++;
            }
            return;
        }// end function

        private static function Colorize(param1:BitmapData, param2:int) : void
        {
            var _loc_3:* = new ColorMatrix();
            _loc_3.Colorize(param2);
            param1.applyFilter(param1, param1.rect, param1.rect.topLeft, _loc_3.filter);
            return;
        }// end function

        private static function Saturation(param1:BitmapData, param2:int) : void
        {
            var _loc_3:* = new ColorMatrix();
            _loc_3.AdjustSaturation(1 + param2 / 100);
            param1.applyFilter(param1, param1.rect, param1.rect.topLeft, _loc_3.filter);
            return;
        }// end function

        private static function Brightness(param1:BitmapData, param2:int) : void
        {
            var _loc_3:* = new ColorMatrix();
            _loc_3.AdjustBrightness(param2 / 100 * 255);
            param1.applyFilter(param1, param1.rect, param1.rect.topLeft, _loc_3.filter);
            return;
        }// end function

        private static function Contrast(param1:BitmapData, param2:int) : void
        {
            var _loc_3:* = new ColorMatrix();
            _loc_3.AdjustContrast(param2 / 100);
            param1.applyFilter(param1, param1.rect, param1.rect.topLeft, _loc_3.filter);
            return;
        }// end function

        private static function Threshold(param1:BitmapData, param2:int) : void
        {
            var _loc_3:* = new ColorMatrix();
            _loc_3.Threshold(param2);
            param1.applyFilter(param1, param1.rect, param1.rect.topLeft, _loc_3.filter);
            return;
        }// end function

        private static function Invert(param1:BitmapData) : void
        {
            var _loc_2:* = new ColorMatrix();
            _loc_2.Invert();
            param1.applyFilter(param1, param1.rect, param1.rect.topLeft, _loc_2.filter);
            return;
        }// end function

        private static function Desaturate(param1:BitmapData) : void
        {
            var _loc_2:* = new ColorMatrix();
            _loc_2.Desaturate();
            param1.applyFilter(param1, param1.rect, param1.rect.topLeft, _loc_2.filter);
            return;
        }// end function

        private static function Waterdown(param1:BitmapData) : void
        {
            var _loc_2:uint = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_8:int = 0;
            param1.lock();
            var _loc_7:int = 0;
            while (_loc_7 < param1.height)
            {
                
                _loc_8 = 0;
                while (_loc_8 < param1.width)
                {
                    
                    _loc_2 = param1.getPixel(_loc_8, _loc_7);
                    _loc_4 = _loc_2 >>> 16 & 255;
                    _loc_5 = _loc_2 >>> 8 & 255;
                    _loc_6 = _loc_2 & 255;
                    _loc_4 = _loc_4 * 0.393 + _loc_5 * 0.769 + _loc_6 * 0.189;
                    _loc_5 = _loc_4 * 0.349 + _loc_5 * 0.686 + _loc_6 * 0.168;
                    _loc_6 = _loc_4 * 0.272 + _loc_5 * 0.534 + _loc_6 * 0.131;
                    if (_loc_4 > 255)
                    {
                        _loc_4 = 255;
                    }
                    else if (_loc_4 < 0)
                    {
                        _loc_4 = 0;
                    }
                    if (_loc_5 > 255)
                    {
                        _loc_5 = 255;
                    }
                    else if (_loc_5 < 0)
                    {
                        _loc_5 = 0;
                    }
                    if (_loc_6 > 255)
                    {
                        _loc_6 = 255;
                    }
                    else if (_loc_6 < 0)
                    {
                        _loc_6 = 0;
                    }
                    param1.setPixel(_loc_8, _loc_7, _loc_4 << 16 | _loc_5 << 8 | _loc_6);
                    _loc_8++;
                }
                _loc_7++;
            }
            param1.unlock();
            return;
        }// end function

        private static function Pixelate(param1:BitmapData, param2:int) : void
        {
            var _loc_4:int = 0;
            var _loc_5:uint = 0;
            var _loc_6:Number = NaN;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_3:* = Math.round((param1.width + param1.height) / 2 * (param2 / 100));
            var _loc_7:* = int(_loc_3 / 2);
            param1.lock();
            var _loc_8:int = 0;
            while (_loc_8 < param1.height)
            {
                
                _loc_9 = 0;
                while (_loc_9 < param1.width)
                {
                    
                    _loc_5 = param1.getPixel(_loc_9, _loc_8);
                    _loc_10 = 0;
                    while (_loc_10 < _loc_3)
                    {
                        
                        _loc_11 = 0;
                        while (_loc_11 < _loc_3)
                        {
                            
                            param1.setPixel(_loc_9 + _loc_11, _loc_8 + _loc_10, _loc_5);
                            _loc_11++;
                        }
                        _loc_10++;
                    }
                    _loc_9 = _loc_9 + _loc_3;
                }
                _loc_8 = _loc_8 + _loc_3;
            }
            param1.unlock();
            return;
        }// end function

        private static function Noise(param1:BitmapData, param2:int) : void
        {
            var _loc_3:int = 0;
            var _loc_4:uint = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_11:int = 0;
            var _loc_9:* = param2 / 2;
            param1.lock();
            var _loc_10:int = 0;
            while (_loc_10 < param1.height)
            {
                
                _loc_11 = 0;
                while (_loc_11 < param1.width)
                {
                    
                    _loc_4 = param1.getPixel(_loc_11, _loc_10);
                    _loc_6 = _loc_4 >>> 16 & 255;
                    _loc_7 = _loc_4 >>> 8 & 255;
                    _loc_8 = _loc_4 & 255;
                    _loc_3 = int(Math.random() * param2 - _loc_9);
                    _loc_6 = _loc_6 + _loc_3;
                    _loc_7 = _loc_7 + _loc_3;
                    _loc_8 = _loc_8 + _loc_3;
                    if (_loc_6 > 255)
                    {
                        _loc_6 = 255;
                    }
                    else if (_loc_6 < 0)
                    {
                        _loc_6 = 0;
                    }
                    if (_loc_7 > 255)
                    {
                        _loc_7 = 255;
                    }
                    else if (_loc_7 < 0)
                    {
                        _loc_7 = 0;
                    }
                    if (_loc_8 > 255)
                    {
                        _loc_8 = 255;
                    }
                    else if (_loc_8 < 0)
                    {
                        _loc_8 = 0;
                    }
                    param1.setPixel(_loc_11, _loc_10, _loc_6 << 16 | _loc_7 << 8 | _loc_8);
                    _loc_11++;
                }
                _loc_10++;
            }
            param1.unlock();
            return;
        }// end function

        private static function Vignette(param1:BitmapData, param2:uint = 0, param3:int = 50) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:uint = 0;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_15:Number = NaN;
            var _loc_21:int = 0;
            var _loc_16:* = param1.width / 2;
            var _loc_17:* = param1.height / 2;
            var _loc_18:* = _loc_16 - param3 * (_loc_16 / 3) / 100;
            var _loc_19:* = _loc_17 - param3 * (_loc_17 / 3) / 100;
            _loc_7 = param2 >>> 16 & 255;
            _loc_8 = param2 >>> 8 & 255;
            _loc_9 = param2 & 255;
            param1.lock();
            var _loc_20:int = 0;
            while (_loc_20 < param1.width)
            {
                
                _loc_21 = 0;
                while (_loc_21 < param1.height)
                {
                    
                    _loc_12 = param1.getPixel(_loc_20, _loc_21);
                    _loc_4 = _loc_12 >>> 16 & 255;
                    _loc_5 = _loc_12 >>> 8 & 255;
                    _loc_6 = _loc_12 & 255;
                    _loc_10 = _loc_16 - _loc_20;
                    _loc_11 = _loc_17 - _loc_21;
                    _loc_15 = _loc_10 * _loc_10 / (_loc_18 * _loc_18) + _loc_11 * _loc_11 / (_loc_19 * _loc_19);
                    if (_loc_15 > 1)
                    {
                        _loc_13 = (_loc_15 - 1) / 1.5;
                        _loc_14 = 1 - _loc_13;
                        _loc_4 = _loc_14 * _loc_4 + _loc_13 * _loc_7;
                        _loc_5 = _loc_14 * _loc_5 + _loc_13 * _loc_8;
                        _loc_6 = _loc_14 * _loc_6 + _loc_13 * _loc_9;
                        if (_loc_4 > 255)
                        {
                            _loc_4 = 255;
                        }
                        else if (_loc_4 < 0)
                        {
                            _loc_4 = 0;
                        }
                        if (_loc_5 > 255)
                        {
                            _loc_5 = 255;
                        }
                        else if (_loc_5 < 0)
                        {
                            _loc_5 = 0;
                        }
                        if (_loc_6 > 255)
                        {
                            _loc_6 = 255;
                        }
                        else if (_loc_6 < 0)
                        {
                            _loc_6 = 0;
                        }
                        param1.setPixel(_loc_20, _loc_21, _loc_4 << 16 | _loc_5 << 8 | _loc_6);
                    }
                    _loc_21++;
                }
                _loc_20++;
            }
            param1.unlock();
            return;
        }// end function

        private static function Blur(param1:BitmapData, param2:int, param3:int) : void
        {
            if (param3 == 0)
            {
                param3 = 3;
            }
            param1.applyFilter(param1, param1.rect, param1.rect.topLeft, new BlurFilter(param2, param2, param3));
            return;
        }// end function

        private static function BoxBlur(param1:BitmapData, param2:int) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            if (param2 > param1.width || param2 > param1.height)
            {
                param2 = Math.min(param1.width - 2, param1.height - 2);
            }
            var _loc_15:* = param1.width;
            var _loc_16:* = param1.height;
            var _loc_17:* = _loc_15 - 1;
            var _loc_18:* = _loc_16 - 1;
            var _loc_19:* = param2 * 2 + 1;
            var _loc_20:* = new Vector.<int>(_loc_15 * _loc_16, true);
            var _loc_21:* = new Vector.<int>(_loc_15 * _loc_16, true);
            var _loc_22:* = new Vector.<int>(_loc_15 * _loc_16, true);
            var _loc_23:* = new Vector.<int>(_loc_15 > _loc_16 ? (_loc_15) : (_loc_16), true);
            var _loc_24:* = new Vector.<int>(_loc_15 > _loc_16 ? (_loc_15) : (_loc_16), true);
            var _loc_25:* = new Vector.<int>(256 * _loc_19, true);
            var _loc_26:* = param1.getVector(param1.rect);
            _loc_9 = 0;
            while (_loc_9 < 256 * _loc_19)
            {
                
                _loc_25[_loc_9] = _loc_9 / _loc_19;
                _loc_9++;
            }
            var _loc_27:int = 0;
            _loc_13 = 0;
            _loc_14 = _loc_27;
            _loc_7 = 0;
            while (_loc_7 < _loc_16)
            {
                
                var _loc_27:int = 0;
                _loc_5 = 0;
                var _loc_27:* = _loc_27;
                _loc_4 = _loc_27;
                _loc_3 = _loc_27;
                _loc_9 = -param2;
                while (_loc_9 <= param2)
                {
                    
                    _loc_8 = _loc_26[_loc_13 + Math.min(_loc_17, Math.max(_loc_9, 0))];
                    _loc_3 = _loc_3 + ((_loc_8 & 16711680) >> 16);
                    _loc_4 = _loc_4 + ((_loc_8 & 65280) >> 8);
                    _loc_5 = _loc_5 + (_loc_8 & 255);
                    _loc_9++;
                }
                _loc_6 = 0;
                while (_loc_6 < _loc_15)
                {
                    
                    _loc_20[_loc_13] = _loc_25[_loc_3];
                    _loc_21[_loc_13] = _loc_25[_loc_4];
                    _loc_22[_loc_13] = _loc_25[_loc_5];
                    if (_loc_7 == 0)
                    {
                        _loc_24[_loc_6] = Math.min(_loc_6 + param2 + 1, _loc_17);
                        _loc_23[_loc_6] = Math.max(_loc_6 - param2, 0);
                    }
                    _loc_10 = _loc_26[_loc_14 + _loc_24[_loc_6]];
                    _loc_11 = _loc_26[_loc_14 + _loc_23[_loc_6]];
                    _loc_3 = _loc_3 + ((_loc_10 & 16711680) - (_loc_11 & 16711680) >> 16);
                    _loc_4 = _loc_4 + ((_loc_10 & 65280) - (_loc_11 & 65280) >> 8);
                    _loc_5 = _loc_5 + ((_loc_10 & 255) - (_loc_11 & 255));
                    _loc_13++;
                    _loc_6++;
                }
                _loc_14 = _loc_14 + _loc_15;
                _loc_7++;
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_15)
            {
                
                var _loc_27:int = 0;
                _loc_5 = 0;
                var _loc_27:* = _loc_27;
                _loc_4 = _loc_27;
                _loc_3 = _loc_27;
                _loc_12 = (-param2) * _loc_15;
                _loc_9 = -param2;
                while (_loc_9 <= param2)
                {
                    
                    _loc_13 = (_loc_12 < 0 ? (0) : (_loc_12)) + _loc_6;
                    _loc_3 = _loc_3 + _loc_20[_loc_13];
                    _loc_4 = _loc_4 + _loc_21[_loc_13];
                    _loc_5 = _loc_5 + _loc_22[_loc_13];
                    _loc_12 = _loc_12 + _loc_15;
                    _loc_9++;
                }
                _loc_13 = _loc_6;
                _loc_7 = 0;
                while (_loc_7 < _loc_16)
                {
                    
                    _loc_26[_loc_13] = 4278190080 | _loc_25[_loc_3] << 16 | _loc_25[_loc_4] << 8 | _loc_25[_loc_5];
                    if (_loc_6 == 0)
                    {
                        _loc_24[_loc_7] = Math.min(_loc_7 + param2 + 1, _loc_18) * _loc_15;
                        _loc_23[_loc_7] = Math.max(_loc_7 - param2, 0) * _loc_15;
                    }
                    _loc_10 = _loc_6 + _loc_24[_loc_7];
                    _loc_11 = _loc_6 + _loc_23[_loc_7];
                    _loc_3 = _loc_3 + (_loc_20[_loc_10] - _loc_20[_loc_11]);
                    _loc_4 = _loc_4 + (_loc_21[_loc_10] - _loc_21[_loc_11]);
                    _loc_5 = _loc_5 + (_loc_22[_loc_10] - _loc_22[_loc_11]);
                    _loc_13 = _loc_13 + _loc_15;
                    _loc_7++;
                }
                _loc_6++;
            }
            param1.setVector(param1.rect, _loc_26);
            return;
        }// end function

        public static function Sharpen(param1:BitmapData) : void
        {
            var _loc_2:uint = 0;
            var _loc_3:uint = 0;
            var _loc_4:uint = 0;
            var _loc_5:uint = 0;
            var _loc_6:uint = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_17:int = 0;
            var _loc_15:* = param1.clone();
            param1.lock();
            var _loc_16:int = 1;
            while (_loc_16 < (param1.height - 1))
            {
                
                _loc_4 = _loc_15.getPixel(1, _loc_16);
                _loc_3 = _loc_15.getPixel(0, _loc_16);
                _loc_17 = 1;
                while (_loc_17 < (param1.width - 1))
                {
                    
                    _loc_2 = _loc_3;
                    _loc_3 = _loc_4;
                    _loc_5 = _loc_15.getPixel(_loc_17, (_loc_16 + 1));
                    _loc_6 = _loc_15.getPixel(_loc_17, (_loc_16 - 1));
                    _loc_4 = _loc_15.getPixel((_loc_17 + 1), _loc_16);
                    _loc_8 = Math.round(((_loc_2 >>> 16 & 255) + (_loc_4 >>> 16 & 255) + (_loc_3 >>> 16 & 255) + (_loc_5 >>> 16 & 255) + (_loc_6 >>> 16 & 255)) / 5);
                    _loc_9 = Math.round(((_loc_2 >>> 8 & 255) + (_loc_4 >>> 8 & 255) + (_loc_3 >>> 8 & 255) + (_loc_5 >>> 8 & 255) + (_loc_6 >>> 8 & 255)) / 5);
                    _loc_10 = Math.round(((_loc_2 & 255) + (_loc_4 & 255) + (_loc_3 & 255) + (_loc_5 & 255) + (_loc_6 & 255)) / 5);
                    _loc_12 = _loc_3 >>> 16 & 255;
                    _loc_13 = _loc_3 >>> 8 & 255;
                    _loc_14 = _loc_3 & 255;
                    _loc_8 = _loc_12 + (_loc_12 - _loc_8);
                    _loc_9 = _loc_13 + (_loc_13 - _loc_9);
                    _loc_10 = _loc_14 + (_loc_14 - _loc_10);
                    if (_loc_8 > 255)
                    {
                        _loc_8 = 255;
                    }
                    else if (_loc_8 < 0)
                    {
                        _loc_8 = 0;
                    }
                    if (_loc_9 > 255)
                    {
                        _loc_9 = 255;
                    }
                    else if (_loc_9 < 0)
                    {
                        _loc_9 = 0;
                    }
                    if (_loc_10 > 255)
                    {
                        _loc_10 = 255;
                    }
                    else if (_loc_10 < 0)
                    {
                        _loc_10 = 0;
                    }
                    param1.setPixel(_loc_17, _loc_16, _loc_8 << 16 | _loc_9 << 8 | _loc_10);
                    _loc_17++;
                }
                _loc_16++;
            }
            param1.unlock();
            return;
        }// end function

        private static function Levels(param1:BitmapData, param2:int, param3:int) : void
        {
            var _loc_4:* = new ChannelMap();
            new ChannelMap().minin = param2;
            _loc_4.maxin = param3;
            param1.paletteMap(param1, param1.rect, param1.rect.topLeft, _loc_4.ComputeArray(16), _loc_4.ComputeArray(8), _loc_4.ComputeArray(0));
            return;
        }// end function

        private static function Mapping(param1:BitmapData, param2:Array, param3:Array, param4:Array) : void
        {
            param1.paletteMap(param1, param1.rect, param1.rect.topLeft, ComputeMap(param2, 16), ComputeMap(param3, 8), ComputeMap(param4, 0));
            return;
        }// end function

        private static function ComputeMap(param1:Array, param2:int) : Array
        {
            var _loc_3:int = -1;
            var _loc_4:* = new Array();
            while (++_loc_3 < 256)
            {
                
                _loc_4[_loc_3] = param1[_loc_3] << param2;
            }
            return _loc_4;
        }// end function

    }
}
