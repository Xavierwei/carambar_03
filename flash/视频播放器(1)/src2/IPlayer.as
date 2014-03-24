/***
IPlayer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月21日 11:53:18
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	
	internal interface IPlayer{
		
		function set bufferTime(_bufferTime:Number):void;
		function get source():String;
		
		function clearCurr():void;
		function clear():void;
		
		function get bufferProgress():Number;
		
		function get bytesLoaded():int;
		function get bytesTotal():int;
		
		function load(_source:String):void;
		
		function play():void;
		function stop():void;
		function pause():void;
		
		function getPlayheadTime():Number;
		function setPlayheadTime(_playheadTime:Number,__playheadIsMovingOrIsGoingToMove:Boolean):void;
		
		function get totalTime():Number;
		
		function get volume():Number;
		function set volume(_volume:Number):void;
		
	}
}