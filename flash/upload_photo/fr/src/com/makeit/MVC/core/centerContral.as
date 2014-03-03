package com.makeit.MVC.core
{
	import flash.events.IEventDispatcher;
	import com.makeit.MVC.core.*
	public class centerContral
	{
		
		public function centerContral() 
		{
			
		}
		public static function addCommand(type:String, command:Function):void {
			eventDispatcher.getInstance().addEventListener(type,command)
		}
		public static function removeCommand(type:String, command:Function):void {
			eventDispatcher.getInstance().removeEventListener(type,command)
		}
	}

}