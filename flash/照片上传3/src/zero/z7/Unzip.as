/***
Unzip
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年08月30日 10:40:45
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.z7{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	public class Unzip extends EventDispatcher{
		
		private var executable:File;
		
		private var zipFile:File;
		private var outputFolder:File;
		
		private var listContentsOutputData:ByteArray;
		private var listContentsProcess:NativeProcess;
		private var total:int;
		
		private var extractOutputData:ByteArray;
		private var extractProcess:NativeProcess;
		
		public function Unzip(_executable:File){
			executable=_executable;
		}
		
		public function clear():void{
			
			zipFile=null;
			outputFolder=null;
			
			listContentsOutputData=null;
			if(listContentsProcess){
				listContentsProcess.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,listContentsOutput);
				listContentsProcess.removeEventListener(NativeProcessExitEvent.EXIT,listContentsExit);
				listContentsProcess.exit(true);
				listContentsProcess=null;
			}
			
			extractOutputData=null;
			if(extractProcess){
				extractProcess.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,extractOutput);
				extractProcess.removeEventListener(NativeProcessExitEvent.EXIT,extractExit);
				extractProcess.exit(true);
				extractProcess=null;
			}
			
		}
		
		public function start(_zipFile:File,_outputFolder:File):void{
			
			clear();
			
			zipFile=_zipFile;
			outputFolder=_outputFolder;
			
			if(zipFile.exists){
			}else{
				throw "找不到文件："+decodeURI(zipFile.url);
			}
			
			if(zipFile.isDirectory){
				throw "不能是文件夹："+decodeURI(zipFile.url);
			}
			
			if(outputFolder.exists){
				if(outputFolder.isDirectory){
				}else{
					throw "必须是文件夹："+decodeURI(outputFolder.url);
				}
			}
			
			listContents();
			
		}
		private function listContents():void{
			
			var info:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			info.executable=executable;
			info.workingDirectory=executable.parent;
			info.arguments=new <String>["l",zipFile.nativePath];
			
			listContentsOutputData=new ByteArray();
			listContentsProcess=new NativeProcess();
			listContentsProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,listContentsOutput);
			listContentsProcess.addEventListener(NativeProcessExitEvent.EXIT,listContentsExit);
			listContentsProcess.start(info);
			listContentsProcess.closeInput();
			
		}
		
		private function listContentsOutput(...args):void{
			//trace("listContentsOutput");
			listContentsProcess.standardOutput.readBytes(listContentsOutputData,listContentsOutputData.length,listContentsProcess.standardOutput.bytesAvailable);
		}
		
		private function listContentsExit(event:NativeProcessExitEvent):void{
			if(event.exitCode==0){
				listContentsOutputData.position=0;
				var listContentsOutput:String=listContentsOutputData.readMultiByte(listContentsOutputData.length,"gb2312");
				//trace("listContentsOutput="+listContentsOutput);
				
				//读取俩 "------------------- ----- ------------ ------------  ------------------------" 之间的内容获取行数，便得知文件数量：
				//trace(listContentsOutput);
				total=listContentsOutput.replace(/^[\s\S]*?[\-\s]{30,}([\s\S]*?)[\-\s]{30,}[\s\S]*$/,"$1").replace(/^\s*|\s*$/g,"").split(/\s*\n\s*/).length;
				
				extract();
				
			}else{
				this.dispatchEvent(new UnzipErrorEvent(listContentsOutput,event.exitCode));
			}
		}
		
		private function extract():void{
			
			var info:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			info.workingDirectory=executable.parent;
			info.executable=executable;
			info.arguments=new <String>[
				"x",
				"-y",
				zipFile.nativePath,
				'-o'+outputFolder.nativePath,
			];
			
			extractOutputData=new ByteArray();
			extractProcess=new NativeProcess();
			extractProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,extractOutput);
			extractProcess.addEventListener(NativeProcessExitEvent.EXIT,extractExit);
			extractProcess.start(info);
			extractProcess.closeInput();
			
		}
		
		private function extractOutput(...args):void{
			extractProcess.standardOutput.readBytes(extractOutputData,extractOutputData.length,extractProcess.standardOutput.bytesAvailable);
			extractOutputData.position=0;
			var extractOutput:String=extractOutputData.readMultiByte(extractOutputData.length,"gb2312");
			//trace("extractOutput="+extractOutput);
			var matchArr:Array=extractOutput.match(/\n\s*Extracting\s+.*/g);
			if(matchArr){
				var curr:int=matchArr.length;
				//trace(curr,total);
				if(curr>total){
					curr=total;
				}
			}else{
				curr=0;
			}
			this.dispatchEvent(new UnzipProgressEvent(curr,total));
		}
		
		private function extractExit(event:NativeProcessExitEvent):void{
			if(event.exitCode==0){
				extractOutputData.position=0;
				var extractOutput:String=extractOutputData.readMultiByte(extractOutputData.length,"gb2312");
				//trace("extractOutput="+extractOutput);
				this.dispatchEvent(new UnzipCompleteEvent(extractOutput));
			}else{
				this.dispatchEvent(new UnzipErrorEvent(extractOutput,event.exitCode));
			}
		}
		
	}
	
}

/*
7-Zip 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18



Usage: 7z <command> [<switches>...] <archive_name> [<file_names>...]

[<@listfiles...>]



<Commands>

a: Add files to archive

b: Benchmark

d: Delete files from archive

e: Extract files from archive (without using directory names)

l: List contents of archive

t: Test integrity of archive

u: Update files to archive

x: eXtract files with full paths

<Switches>

-ai[r[-|0]]{@listfile|!wildcard}: Include archives

-ax[r[-|0]]{@listfile|!wildcard}: eXclude archives

-bd: Disable percentage indicator

-i[r[-|0]]{@listfile|!wildcard}: Include filenames

-m{Parameters}: set compression Method

-o{Directory}: set Output directory

-p{Password}: set Password

-r[-|0]: Recurse subdirectories

-scs{UTF-8 | WIN | DOS}: set charset for list files

-sfx[{name}]: Create SFX archive

-si[{name}]: read data from stdin

-slt: show technical information for l (List) command

-so: write data to stdout

-ssc[-]: set sensitive case mode

-ssw: compress shared files

-t{Type}: Set type of archive

-u[-][p#][q#][r#][x#][y#][z#][!newArchiveName]: Update options

-v{Size}[b|k|m|g]: Create volumes

-w[{path}]: assign Work directory. Empty path means a temporary directory

-x[r[-|0]]]{@listfile|!wildcard}: eXclude filenames

-y: assume Yes on all queries


exitCode=0
*/