package com.util.http
{
	
	public class Clear extends Object {

		public function Clear()
		{
		}
		
		/**
		 *	@public
		 *	@param	object		删除事件的对象
		 *	@param	evt	 			事件
		 *	@param	fun				事件的函数
		 *	
		 *	清除对象的事件
		 */
		public static function removeEvent(object:*, evt:String, fun:Function):void
		{
			if (object && object.hasEventListener(evt))
			{
				object.removeEventListener(evt, fun);
			}
		}
		
	}

}

