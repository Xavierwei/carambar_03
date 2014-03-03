package com.makeit.events 
{
	import com.makeit.control.makeEvent;
	public class indexEvent extends makeEvent
	{
		public static var MENU_OVER:String = "menuOver"
		public static var MENU_OUT:String="menuOut"
		public function indexEvent(type:String) 
		{
			super(type)
		}
		
	}

}