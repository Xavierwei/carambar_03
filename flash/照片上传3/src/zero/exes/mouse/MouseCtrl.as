/***
MouseCtrl
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年11月20日 13:57:15
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.exes.mouse{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import flash.desktop.*;
	import flash.filesystem.*;
	
	public class MouseCtrl{
		
		public static var currX:int;
		public static var currY:int;
		
		private static var _executable:File;
		private static function get executable():File{
			if(_executable){
			}else{
				_executable=new File(File.applicationDirectory.nativePath+"/exes/mouse.exe");
				var stream:FileStream=new FileStream();
				stream.open(_executable,FileMode.WRITE);
				stream.writeBytes(new MouseEXEData());
				stream.close();
			}
			return _executable;
		}
		
		public static function moveTo(x:int,y:int,onExit:Function=null):void{
			currX=x;
			currY=y;
			new MoveTo(executable,currX,currY,onExit);
		}
		public static function click(onExit:Function=null):void{
			new Click(executable,onExit);
		}
		public static function rightClick(onExit:Function=null):void{
			new RightClick(executable,onExit);
		}
		
		private static const stepTime:int=10;
		private static var intervalId:int;
		private static var tweenXYArr:Array;
		private static var onTweenComplete:Function;
		public static function tween(x0:int,y0:int,xt:int,yt:int,time:int,_onTweenComplete:Function):void{
			clearTween();
			onTweenComplete=_onTweenComplete;
			var dx:int=xt-x0;
			var dy:int=yt-y0;
			tweenXYArr=new Array();
			var stepNum:int=time/stepTime;
			if(stepNum>0){
			}else{
				stepNum=1;
			}
			for(var i:int=0;i<=stepNum;i++){
				tweenXYArr[i]=[Math.round(x0+dx*i/stepNum),Math.round(y0+dy*i/stepNum)];
			}
			intervalId=setInterval(tween_step,stepTime);
		}
		public static function clearTween():void{
			clearInterval(intervalId);
		}
		private static function tween_step():void{
			if(tweenXYArr.length){
				var tweenXY:Array=tweenXYArr.shift();
				moveTo(tweenXY[0],tweenXY[1]);
			}else{
				clearTween();
				var _onTweenComplete:Function=onTweenComplete;
				onTweenComplete=null;
				if(_onTweenComplete==null){
				}else{
					_onTweenComplete();
				}
			}
		}
	}
}

import flash.desktop.*;
import flash.events.*;
import flash.filesystem.*;

class MoveTo extends NativeProcess{
	private var onExit:Function;
	public function MoveTo(_executable:File,x:int,y:int,_onExit:Function):void{
		onExit=_onExit;
		var nativeProcessStartupInfo:NativeProcessStartupInfo=new NativeProcessStartupInfo();
		nativeProcessStartupInfo.executable=_executable;
		nativeProcessStartupInfo.arguments=new <String>["m,"+x+","+y];
		this.addEventListener(NativeProcessExitEvent.EXIT,_exit);
		this.start(nativeProcessStartupInfo);
	}
	private function _exit(event:NativeProcessExitEvent):void{
		//trace("event.exitCode="+event.exitCode);
		this.removeEventListener(NativeProcessExitEvent.EXIT,_exit);
		if(onExit==null){
		}else{
			onExit();
			onExit=null;
		}
	}
}

class Click extends NativeProcess{
	private var onExit:Function;
	public function Click(_executable:File,_onExit:Function):void{
		onExit=_onExit;
		var nativeProcessStartupInfo:NativeProcessStartupInfo=new NativeProcessStartupInfo();
		nativeProcessStartupInfo.executable=_executable;
		nativeProcessStartupInfo.arguments=new <String>["l"];
		this.addEventListener(NativeProcessExitEvent.EXIT,_exit);
		this.start(nativeProcessStartupInfo);
	}
	private function _exit(event:NativeProcessExitEvent):void{
		//trace("event.exitCode="+event.exitCode);
		this.removeEventListener(NativeProcessExitEvent.EXIT,_exit);
		if(onExit==null){
		}else{
			onExit();
			onExit=null;
		}
	}
}

class RightClick extends NativeProcess{
	private var onExit:Function;
	public function RightClick(_executable:File,_onExit:Function):void{
		onExit=_onExit;
		var nativeProcessStartupInfo:NativeProcessStartupInfo=new NativeProcessStartupInfo();
		nativeProcessStartupInfo.executable=_executable;
		nativeProcessStartupInfo.arguments=new <String>["r"];
		this.addEventListener(NativeProcessExitEvent.EXIT,_exit);
		this.start(nativeProcessStartupInfo);
	}
	private function _exit(event:NativeProcessExitEvent):void{
		//trace("event.exitCode="+event.exitCode);
		this.removeEventListener(NativeProcessExitEvent.EXIT,_exit);
		if(onExit==null){
		}else{
			onExit();
			onExit=null;
		}
	}
}