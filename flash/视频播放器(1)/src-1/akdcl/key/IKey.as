package akdcl.key {
	import flash.events.IEventDispatcher;

	interface IKey extends IEventDispatcher {
		//
		function isDown(_state:Boolean = false):Boolean;
		function isUp(_state:Boolean = false):Boolean;
		//
		function get keyCode():uint;
		function set keyCode(_code:uint):void;
		function get keyName():String;
		function set keyName(_name:String):void;
		function get type():String;
		function set type(_type:String):void;
		//
		function get groupName():String;
		function set groupName(_name:String):void;
		function get groupID():int;
		function set groupID(_id:int):void;
		//
		function get combined():Boolean;
		function set combined(_type:Boolean):void;
		//
		function get disable():Boolean;
		function set disable(_b:Boolean):void;
		//
		function get holdTime():uint;
		function set holdTime(_time:uint):void;
		//
		function get voidTime():uint;
		function set voidTime(_time:uint):void;
	}
}