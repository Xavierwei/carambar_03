package com.makeit.utils 
{

	public class arrayTool
	{
		
		public function arrayTool() 
		{
			
		}
		/**
		 * 随机顺序
		 */
		public static function sortArr(tempArr:Array):Array {
			var _len = tempArr.length;
			var _newArr:Array = new Array();
			for (var i:uint=0; i<_len; i++) {
				var _n = Math.floor(Math.random()*tempArr.length);
				_newArr.push(tempArr.splice(_n,1));
			}
			return _newArr;
		}
		
	}

}