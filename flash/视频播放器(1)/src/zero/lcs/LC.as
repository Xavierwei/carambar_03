/***
LC
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月14日 10:58:02
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.lcs{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.net.SharedObject;
	
	public class LC{
		
		private static function checkIsConnected(name:String):Boolean{
			var lc:LocalConnection=new LocalConnection();
			lc.allowDomain("*");
			lc.allowInsecureDomain("*");
			try{
				lc.connect(name);
			}catch(e:Error){
				return true;
			}
			lc.close();
			return false;
		}
		
		private var groupName:String;
		
		public var name:String;
		private var lc:LocalConnection;
		
		private var sendingArrArr:Array;
		
		public var onReceive:Function;
		
		public function LC(_groupName:String){
			
			groupName=_groupName;
			
			lc=new LocalConnection();
			lc.allowDomain("*");
			lc.allowInsecureDomain("*");
			lc.client=this;
			
			clearUnconnectedConns();
			
			var nameArr:Array=getNameArr();
			//找出一个未使用的连接名作为连接名
			//var time:Number=new Date().time;
			var time:int=0;
			while(
				nameArr.indexOf("_zero.lcs.LC"+time)>-1
				||
				checkIsConnected("_zero.lcs.LC"+time)
			){
				time++;
			}
			name="_zero.lcs.LC"+time;
			
			//trace("name="+name);
			nameArr.push(name);
			//trace("nameArr.length="+nameArr.length);
			
			saveNameArr(nameArr);
			
			sendingArrArr=new Array();
			
			lc.addEventListener(StatusEvent.STATUS,status);
			lc.connect(name);
			
		}
		
		public function clear():void{
			if(lc){
				lc.removeEventListener(StatusEvent.STATUS,status);
				lc.close();
				lc=null;
			}
			clearUnconnectedConns();
			sendingArrArr=null;
			onReceive=null;
		}
		
		public function getNameArr():Array{
			var so:SharedObject=SharedObject.getLocal("zero.lcs.LC."+groupName,"/");
			if(so.data.nameArr){
			}else{
				so.data.nameArr=new Array();
				so.flush();
			}
			return so.data.nameArr;
		}
		public function saveNameArr(nameArr:Array):void{
			var so:SharedObject=SharedObject.getLocal("zero.lcs.LC."+groupName,"/");
			so.data.nameArr=nameArr;
			so.flush();
		}
		
		private function clearUnconnectedConns():void{
			//清除不活动的连接名
			var nameArr:Array=getNameArr();
			var i:int=nameArr.length;
			while(i--){
				if(checkIsConnected(nameArr[i])){
				}else{
					nameArr.splice(i,1);
				}
			}
			saveNameArr(nameArr);
		}
		
		public function call(targetName:String,onCallComplete:Function,...args):void{
			trace("call，targetName="+targetName+"，args="+args);
			sendingArrArr.push([targetName,onCallComplete,args]);
			if(sendingArrArr.length==1){
				sendNext();
			}
		}
		private function sendNext():void{
			if(sendingArrArr&&sendingArrArr.length){
				var sendingArr:Array=sendingArrArr[0];
				lc.send(sendingArr[0],"receive",sendingArr[2]);
			}
		}
		
		/**
		 * 
		 * 不得已弄成 public 的，请不要直接调用
		 * 
		 */		
		public function receive(args:Array):void{
			trace("receive，args="+args);
			if(onReceive==null){
			}else{
				onReceive(args);
			}
		}
		private function status(event:StatusEvent):void{
			if(sendingArrArr&&sendingArrArr.length){
				trace("event.code="+event.code+"，event.level="+event.level);
				var sendingArr:Array=sendingArrArr.shift();
				if(sendingArr[1]){
					sendingArr[1](event.level=="status");
				}
				if(sendingArrArr.length){
					sendNext();
				}
			}
		}
		
		/**
		 * 
		 * 除this.name以外的最后一个name
		 * 
		 */		
		public function getLastLCName():String{
			var nameArr:Array=getNameArr();
			var lastName:String=nameArr[nameArr.length-1];
			if(lastName){
				if(name==lastName){
					return nameArr[nameArr.length-2];
				}
				return lastName;
			}
			return null;
		}
		
		public function addThisToTail():Boolean{
			var nameArr:Array=getNameArr();
			var id:int=nameArr.indexOf(name);
			if(id>-1){
				nameArr.splice(id,1);
				nameArr.push(name);
				saveNameArr(nameArr);
				return true;
			}
			return false;
		}
		
	}
}