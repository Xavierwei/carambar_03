package com.makeit.utils {
	import flash.net.LocalConnection;
	/**
	 * @author Happy
	 */
	public class gcHack {
		public static function GC():void{

         try {
            new LocalConnection().connect('foo');
            new LocalConnection().connect('foo');
         } catch (e:Error) {}
   
		
		}
	}
}
