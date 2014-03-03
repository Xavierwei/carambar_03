package com.makeit.events 
{
	import com.makeit.control.makeEvent;
	public class soundEvent extends makeEvent
	{
		public static var MUTED:String = "muted"
		public static var UNMUTED:String = "unmuted"
		
		public function soundEvent(type:String) 
		{
			super(type)
		}
		
	}

}