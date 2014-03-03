package com.makeit.robotgaia {
	import flash.utils.getQualifiedClassName;
	import flash.events.Event;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.utilities.modular.core.IModuleContext;
	import flash.display.MovieClip;

	import com.makeit.core.Ipop;

	/**
	 * @author Happy
	 */
	public class popWindow extends MovieClip implements Ipop {
		public static const SET_POPMEDIATOR:String="set_popmediator";
		
		public var mediatorClass:Class;
		public var viewClass:Class;
		public function popWindow() {
			getViewClass();
		}
		public function dispose():void{
        	
        }
        public function getViewClass():void{
        	viewClass=getQualifiedClassName(this) as Class;
        }
        public function set popMediator(value:Class):void{
        	mediatorClass=value;
        	dispatchEvent(new Event(SET_POPMEDIATOR));
        }
		
	}
}
