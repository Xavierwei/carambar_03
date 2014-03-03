package com.makeit.MVC.core
{
	import com.makeit.MVC.events.makeEvent;
	import flash.events.EventDispatcher;
	public class eventDispatcher
	{
		private static var instance:eventDispatcher
		private var disptcher:EventDispatcher
		private var listenerArr:Array
		public function eventDispatcher(single:singleClass) {
			disptcher = new EventDispatcher()
			listenerArr=new Array()
			if (single == null) {
				trace("单例类，不能实例化")
			}
			
		}
		public static function getInstance():eventDispatcher {
			if (instance == null) {
				instance=new eventDispatcher(new singleClass())	
			}
			return instance	
		}
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			listenerArr.push([type,listener,useCapture])
			disptcher.addEventListener(type,listener,useCapture,priority,useWeakReference)
		}
		public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ) : void {
			disptcher.removeEventListener(type, listener, useCapture);
		}
		public function removeAllListener():void {
			for (var i:uint = 0; i < listenerArr.length; i++ ) {
				disptcher.removeEventListener(listenerArr[i][0],listenerArr[i][1],listenerArr[i][2])
			}
			
		}
		public function dispatch(e:makeEvent):Boolean {
			return disptcher.dispatchEvent(e)
		}
		public function hasEventListener(type:String):Boolean {
			return disptcher.hasEventListener(type);
		}
		public function willTrigger(type:String) : Boolean {
			return disptcher.willTrigger( type );
		}
		
	}

}
class singleClass{}