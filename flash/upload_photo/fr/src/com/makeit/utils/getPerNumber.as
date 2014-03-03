package com.makeit.utils{
	
	public class getPerNumber{
		
		public function checkIDCard() 
		{
			
		}
		public static function getGeWei(value:Number):uint{
			
			var geNum:Number = value-Math.floor(value / 10)*10
			return geNum
			
		}
		public static function getShiWei(value:Number):uint{
			var shiNum:Number=Math.floor((value/100-Math.floor(value/100))*10)
			return shiNum
		}
		public static function getBaiWei(value:Number):uint{
			var baiNum:Number = Math.floor((value / 1000 - Math.floor(value / 1000)) * 100 / 10)
			return baiNum
		}
		
	}
}