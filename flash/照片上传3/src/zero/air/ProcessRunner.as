/***
ProcessRunner 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月25日 12:05:06
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.air{
	import flash.desktop.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.system.*;
	import flash.utils.*;
	public class ProcessRunner{
		
		protected var process:NativeProcess;
		private var nativeProcessStartupInfo:NativeProcessStartupInfo;
		
		public var onOutputData:Function;
		private var hasOutputData:Boolean;
		public var onOutputClose:Function;
		public var onExit:Function;
		
		public function ProcessRunner(
			fileURI:String,
			workingDirectory:File,
			arguments:Vector.<String>,
			_onOutputData:Function,
			_onOutputClose:Function,
			_onExit:Function
		):void{
			//trace(fileURI,arguments);
			//输入 exe,bat,或vbs等的路径
			onOutputData=_onOutputData;
			hasOutputData=false;
			onOutputClose=_onOutputClose;
			onExit=_onExit;
			if(NativeProcess.isSupported){
				if(Capabilities.os.toLowerCase().indexOf("win")>=0){
					var file:File=new File(fileURI);
					if(file.exists){
					}else{
						throw file.nativePath+"不存在";
					}
					nativeProcessStartupInfo=new NativeProcessStartupInfo();
					nativeProcessStartupInfo.executable=file;
					if(arguments){
						nativeProcessStartupInfo.arguments=arguments;
					}
					if(workingDirectory){
						nativeProcessStartupInfo.workingDirectory=workingDirectory;
					}
					
					process=new NativeProcess();
					process.addEventListener(ProgressEvent.STANDARD_INPUT_PROGRESS,inputData);
					process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,outputData);
					process.addEventListener(Event.STANDARD_OUTPUT_CLOSE,outputClose);
					process.addEventListener(NativeProcessExitEvent.EXIT,exit);
					
					//process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
					//process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
					//process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
					
					process.start(nativeProcessStartupInfo);
					process.closeInput();
				}else{
					throw new Error("貌似你的系统不是 windows");
				}
			}else{
				throw new Error("NativeProcess not supported.");
			}
		}
		public function clear():void{
			process.removeEventListener(ProgressEvent.STANDARD_INPUT_PROGRESS,inputData);
			process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,outputData);
			process.removeEventListener(Event.STANDARD_OUTPUT_CLOSE,outputClose);
			process.removeEventListener(NativeProcessExitEvent.EXIT,exit);
			process.closeInput();
			//process.exit();//trace("建议进程关闭");
			process.exit(true);//trace("强制进程关闭");
			
			onOutputData=null;
			onOutputClose=null;
			onExit=null;
		}
		private function inputData(event:ProgressEvent):void{
			//标准输入
			//trace("inputData: event="+event);
		}
		private function outputData(event:ProgressEvent):void{
			//标准输出
			//trace("outputData");
			hasOutputData=true;
			if(onOutputData==null){
			}else{
				onOutputData(
					process.standardOutput.readMultiByte(
						process.standardOutput.bytesAvailable,
						"gb2312"
					)
				);
			}
		}
		private function outputClose(event:Event):void{
			//trace("outputClose");
			if(onOutputClose==null){
			}else{
				onOutputClose(
					hasOutputData?process.standardOutput.readMultiByte(
						process.standardOutput.bytesAvailable,
						"gb2312"
					):null
				);
			}
		}
		
		/*
		public function onErrorData(event:ProgressEvent):void{
			trace("ERROR -",process.standardError.readMultiByte(process.standardError.bytesAvailable,"gb2312"));
		}
		public function onIOError(event:IOErrorEvent):void{
			trace(event.toString());
		}
		*/
		
		private function exit(event:NativeProcessExitEvent):void{
			//trace("exit");
			//1 进程运行main函数完毕 event.exitCode==main函数返回值
			//2 用户从任务管理器中删除进程 event.exitCode==1
			//3 调用了process.exit() event.exitCode==NaN
			//trace("Process exited with ",event.exitCode);
			if(onExit==null){
			}else{
				onExit(event.exitCode);
			}
		}
		
		

		public function sendMsg(msg:String):void{
			//nativeProcessStartupInfo.arguments=new <String>["传给exe的参数"];
			process.standardInput.writeMultiByte(msg+"\n","gb2312");
			//process.closeInput();//会引起 IOError
		}
	}
}