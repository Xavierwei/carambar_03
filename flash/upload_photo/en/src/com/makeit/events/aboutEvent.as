package com.makeit.events 
{
	import com.makeit.control.makeEvent;
	public class aboutEvent extends makeEvent
	{
		public static const ABOUT_NAV:String = "about_nav"
		public var menuID:uint
		public function aboutEvent(type:String) 
		{
			super(type)
		}
		
	}

}