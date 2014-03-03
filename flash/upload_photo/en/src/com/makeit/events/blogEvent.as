package com.makeit.events 
{
	import com.makeit.control.makeEvent;
	public class blogEvent extends makeEvent
	{
		public static var  BLOG_SELECT:String = "blog_select"
		public var id:int
		public function blogEvent(type:String) 
		{
			super(type)
		}
		
	}

}