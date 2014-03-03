package com.makeit.MVC.events
{
	import flash.events.Event;
	import com.makeit.MVC.core.*
	public class makeEvent extends Event
	{
		public var data:*
		public function makeEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type,bubbles,cancelable)
		}
		public function dispatch():Boolean {
			return eventDispatcher.getInstance().dispatch(this)
		}
		public override function clone():Event 
		{ 
			return new makeEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("makeEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}

}