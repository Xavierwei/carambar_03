package zero.managers{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public final class KeyManager{
		public static var stage:Stage;
		public static var keyArr:Array;
		
		public static var onKeyDown:Function;
		public static var onKeyUp:Function;
		
		public static function init(_stage:Stage):void{
			stage=_stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			stage.addEventListener(Event.DEACTIVATE,resetKeyArr);
			resetKeyArr(null);
		}
		private static function resetKeyArr(event:Event):void{
			keyArr=new Array(256);
			for(var keyCode:int=0;keyCode<256;keyCode++){
				keyArr[keyCode]=false;
			}
		}
		public static function clear():void{
			if(stage){
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP,keyUp);
				stage.removeEventListener(Event.DEACTIVATE,resetKeyArr);
			}
			stage=null;
			keyArr=null;
			onKeyDown=null;
			onKeyUp=null;
		}
		private static function keyDown(event:KeyboardEvent):void{
			if(!keyArr[event.keyCode]){
				keyArr[event.keyCode]=true;
				if(onKeyDown!=null){
					onKeyDown(event.keyCode);
				}
			}
		}
		private static function keyUp(event:KeyboardEvent):void{
			keyArr[event.keyCode]=false;
			if(onKeyUp!=null){
				onKeyUp(event.keyCode);
			}
		}
		public static function isDown(keyCode:int):Boolean{
			return keyArr[keyCode];
		}
	}
}
