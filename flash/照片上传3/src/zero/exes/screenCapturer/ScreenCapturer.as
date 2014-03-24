/***
ScreenCapturer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年11月20日 21:10:00
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.exes.screenCapturer{
	
	import flash.desktop.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class ScreenCapturer{
		
		private static var onCapComplete:Function;
		
		private static var _executable:File;
		private static function get executable():File{
			if(_executable){
			}else{
				_executable=new File(File.applicationDirectory.nativePath+"/exes/ScreenCapturer.exe");
				var stream:FileStream=new FileStream();
				stream.open(_executable,FileMode.WRITE);
				stream.writeBytes(new ScreenCapturerEXEData());
				stream.close();
			}
			return _executable;
		}
		
		private static var nativeProcess:NativeProcess;
		public static function cap(_bmpPath:String=null,_onCapComplete:Function=null):void{
			if(nativeProcess){
				throw new Error("不支持同时进行两个 ScreenCapturer.cap()");
			}
			onCapComplete=_onCapComplete;
			if(_bmpPath){
			}else{
				_bmpPath=File.applicationDirectory.nativePath+"/截屏.bmp";
			}
			var nativeProcessStartupInfo:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable=executable;
			nativeProcessStartupInfo.arguments=new <String>[new File(_bmpPath).nativePath];
			nativeProcess=new NativeProcess();
			nativeProcess.addEventListener(NativeProcessExitEvent.EXIT,exit);
			nativeProcess.start(nativeProcessStartupInfo);
			nativeProcess.closeInput();
		}
		private static function exit(event:NativeProcessExitEvent):void{
			switch(event.exitCode){
				case 0:
					nativeProcess.removeEventListener(NativeProcessExitEvent.EXIT,exit);
					nativeProcess=null;
					var _onCapComplete:Function=onCapComplete;
					onCapComplete=null;
					if(_onCapComplete==null){
					}else{
						_onCapComplete();
					}
				break;
				case 1:
					throw new Error("内存错误，无法为屏幕截图分配内存");
				break;
				case 2:
					throw new Error("路径错误，可能是所指定的图片路径不合法");
				break;
				case 3:
					throw new Error("参数错误，在调用ScreenCapturer.exe时必须指定保存的图片的路径");
				break;
				default:
					throw new Error("未知错误");
				break;
			}
		}
	}
}