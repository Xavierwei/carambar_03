/***
WScript
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年11月20日 23:19:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.exes.wscript{
	
	import flash.desktop.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class WScript{
		
		private static var onRunComplete:Function;
		
		private static var _executable:File;
		private static function get executable():File{
			if(_executable){
			}else{
				_executable=new File(File.applicationDirectory.nativePath+"/exes/wscript.exe");
				var stream:FileStream=new FileStream();
				stream.open(_executable,FileMode.WRITE);
				stream.writeBytes(new WScriptEXEData());
				stream.close();
			}
			return _executable;
		}
		
		private static var nativeProcess:NativeProcess;
		private static const vbsFile:File=new File(File.applicationDirectory.nativePath+"/exes/temp.vbs");
		public static function run(script:String,_onRunComplete:Function=null):void{
			if(nativeProcess){
				throw new Error("不支持同时进行两个 WScript.run()");
			}
			onRunComplete=_onRunComplete;
			var nativeProcessStartupInfo:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable=executable;
			
			var stream:FileStream=new FileStream();
			stream.open(vbsFile,FileMode.WRITE);
			stream.writeMultiByte(script,"gb2312");
			stream.close();
			
			nativeProcessStartupInfo.arguments=new <String>[vbsFile.nativePath];
			nativeProcess=new NativeProcess();
			nativeProcess.addEventListener(NativeProcessExitEvent.EXIT,exit);
			nativeProcess.start(nativeProcessStartupInfo);
			nativeProcess.closeInput();
		}
		private static function exit(event:NativeProcessExitEvent):void{
			trace("event.exitCode="+event.exitCode);
			nativeProcess.removeEventListener(NativeProcessExitEvent.EXIT,exit);
			nativeProcess=null;
			var _onRunComplete:Function=onRunComplete;
			onRunComplete=null;
			if(_onRunComplete==null){
			}else{
				_onRunComplete();
			}
		}
	}
}