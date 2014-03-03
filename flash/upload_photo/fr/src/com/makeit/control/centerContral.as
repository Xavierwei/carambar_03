package com.makeit.control
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary
	import com.makeit.control.eventDispatcher
	
	public class centerContral
	{
		private static var dic:Dictionary=new Dictionary()
		public function centerContral() 
		{
			
		}
		public static function addCommand(obj:DisplayObject, type:String, command:Function):void {
			eventDispatcher.getInstance().addEventListener(type, command)
			/*
			if (dic[obj] == null) {
				dic[obj]= obj
				dic[obj]["arr"] = new Array()
				obj.addEventListener(Event.REMOVED_FROM_STAGE,removeFrameStage)
			}
			dic[obj]["arr"].push({type:type,command:command})
			*/
		}
		public static function removeCommand(type:String, command:Function):void {
			eventDispatcher.getInstance().removeEventListener(type,command)
		}
		/*
		private static function removeFrameStage(e:Event):void {
			var target:DisplayObject=e.target as DisplayObject
			for (var i:uint = 0; i < dic[target]["arr"].length; i++ ) {
				eventDispatcher.getInstance().removeEventListener(dic[target]["arr"]["type"],dic[target]["arr"]["command"])
			}
			target.removeEventListener(Event.REMOVED_FROM_STAGE,removeFrameStage)
		}
		*/
	}

}