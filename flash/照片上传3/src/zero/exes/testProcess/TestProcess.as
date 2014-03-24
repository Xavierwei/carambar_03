/***
TestProcess
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年11月21日 11:24:13
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.exes.testProcess{
	
	import flash.desktop.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class TestProcess{
		
		private static var _executable:File;
		private static function get executable():File{
			if(_executable){
			}else{
				_executable=new File(File.applicationDirectory.nativePath+"/exes/wscript.exe");
				var stream:FileStream=new FileStream();
				stream.open(_executable,FileMode.WRITE);
				stream.writeBytes(new TestProcessEXEData());
				stream.close();
			}
			return _executable;
		}
		
		private static var nativeProcess:NativeProcess;
		public static function start():void{
			if(nativeProcess){
				throw new Error("不支持同时进行两个 TestProcess.start()");
			}
			var nativeProcessStartupInfo:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable=executable;
			
			nativeProcess=new NativeProcess();
			nativeProcess.addEventListener(NativeProcessExitEvent.EXIT,exit);
			nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,output);
			nativeProcess.start(nativeProcessStartupInfo);
			nativeProcess.closeInput();
		}
		public static function end():void{
			if(nativeProcess){
				nativeProcess.exit();
			}
		}
		public static function input(str:String):void{
			nativeProcess.standardInput.writeMultiByte(str+"\n","gb2312");
		}
		public static function output(event:ProgressEvent):void{
			var str:String=nativeProcess.standardOutput.readMultiByte(nativeProcess.standardOutput.bytesAvailable,"gb2312");
			trace("output："+str);
		}
		private static function exit(event:NativeProcessExitEvent):void{
			trace("event.exitCode="+event.exitCode);
			nativeProcess.removeEventListener(NativeProcessExitEvent.EXIT,exit);
			nativeProcess=null;
		}
	}
}