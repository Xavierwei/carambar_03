package com.makeit.events 
{
	import com.makeit.control.makeEvent;
	public class newsEvent extends makeEvent
	{
		public static const NEWS_SELECT:String = "NEWS_SELECT"
		public var id:uint
		public function newsEvent(type:String) 
		{
			super(type)
		}
		
	}

}