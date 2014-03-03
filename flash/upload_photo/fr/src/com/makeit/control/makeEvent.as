package com.makeit.control 
{
	import flash.events.Event;
	import com.makeit.control.eventDispatcher
	public class makeEvent extends Event
	{
		public var data:*
		public function makeEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type,bubbles,cancelable)
		}
		public function dispatch():Boolean {
			return eventDispatcher.getInstance().dispatch(this)
		}
		
	}

}