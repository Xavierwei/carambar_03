package com.makeit.events 
{
	import com.makeit.control.makeEvent;
	public class loadSwfEvent extends makeEvent
	{
		public static const LOAD_SWF:String = "load_swf"
		public static const REMOVE_SWF:String="remove_swf"
		public var swfURL:String
		public function loadSwfEvent(type:String) 
		{
			super(type)
		}
		
	}

}