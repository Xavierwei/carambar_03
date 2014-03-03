package com.makeit.core.image
{

    public class ChannelMap extends Object
    {
        private var knLog127Over255:Number;
        public var minin:Number = 0;
        public var midin:Number = 1;
        public var maxin:Number = 255;
        public var minout:Number = 0;
        public var maxout:Number = 255;
        public var mid:Number = 0.5;

        public function ChannelMap()
        {
            this.knLog127Over255 = Math.log(127 / 255);
            return;
        }// end function

        public function Reset() : void
        {
            this.minout = 0;
            this.maxout = 255;
            this.midin = 1;
            this.minin = 0;
            this.maxin = 255;
            this.mid = 0.5;
            return;
        }// end function

        public function get flat() : Boolean
        {
            return Boolean(this.minout == 0 && this.maxout == 255 && this.mid == 0.5 && this.minin == 0 && this.maxin == 255);
        }// end function

        public function SetMid(param1:int) : void
        {
            this.mid = (param1 - this.minin) / (this.maxin - this.minin);
            this.midin = this.MidToIn(this.mid);
            return;
        }// end function

        public function MidToIn(param1:Number) : Number
        {
            return Math.min(Math.max(Math.pow(9.99, 2 * param1 - 1), 0.1), 9.99);
        }// end function

        public function map(param1:Number) : int
        {
            param1 = (param1 - this.minin) / (this.maxin - this.minin);
            param1 = Math.pow(param1, this.midin);
            param1 = this.minout + param1 * (this.maxout - this.minout);
            if (param1 > this.maxout)
            {
                param1 = this.maxout;
            }
            else if (param1 < this.minout)
            {
                param1 = this.minout;
            }
            return Math.round(param1);
        }// end function

        public function ComputeArray(param1:int = 16) : Array
        {
            var _loc_2:int = 0;
            var _loc_3:* = new Array();
            var _loc_4:int = 0;
            while (_loc_4++ < 256)
            {
                
                _loc_2 = this.map(_loc_4);
                if (_loc_2 < 0)
                {
                    _loc_2 = 0;
                }
                else if (_loc_2 > 255)
                {
                    _loc_2 = 255;
                }
                _loc_3.push(_loc_2 << param1);
            }
            return _loc_3;
        }// end function

    }
}
