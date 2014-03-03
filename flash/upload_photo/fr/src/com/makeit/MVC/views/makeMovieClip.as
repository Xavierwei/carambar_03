package com.makeit.MVC.views 
{
	import com.makeit.MVC.events.makeEvent;
	import flash.display.MovieClip;
	import com.makeit.MVC.core.*
	import flash.events.Event;
	public class makeMovieClip extends MovieClip
	{
		protected var listenerArr:Array=new Array()
		public function makeMovieClip() 
		{
			listenerArr=addListenerHandler()
			for (var i:uint = 0; i < listenerArr.length; i++ ) {
				centerContral.addCommand(listenerArr[i],listenerHandler)
			}
			this.addEventListener(Event.REMOVED_FROM_STAGE,removeStageHandler)
		}
		public function addListenerHandler():Array {
			
			return []
		}
		public function listenerHandler(e:makeEvent):void {
			
		}
		public function removeListener(type:String):Boolean {
			var index:int=listenerArr.indexOf(type)
			if (index== -1) {
				return false
			}
			listenerArr.splice(index, 1)
			return true
		}
		private function removeStageHandler(e:Event):void {
			for (var i:uint = 0; i < listenerArr.length; i++ ) {
				centerContral.removeCommand(listenerArr[i],listenerHandler)
			}
		}
	}

}