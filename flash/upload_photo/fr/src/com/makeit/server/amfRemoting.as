package com.makeit.server{
	import com.makeit.robotgaia.ModulePage;
	import flash.net.Responder;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.ObjectEncoding;
	import flash.net.NetConnection;
	import org.robotlegs.utilities.modular.mvcs.ModuleActor;
	/**
	 * @author Happy
	 */
	public class amfRemoting extends ModulePage {
		
		
		protected var connection:NetConnection;
		protected var responder:Responder;
		public function amfRemoting():void{
			
		}
		protected function connect(serverpath:String):void{
		//	this.addHeader("Credentials", false, {userid: userid, password: password});
			connection = new NetConnection();
			connection.objectEncoding = ObjectEncoding.AMF3;
			//"http://122.70.185.177/amf/?username=test&password=123456"
			connection.connect(serverpath);
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            responder=new Responder(onResult, onFault);
		}
		private function netStatusHandler(event:NetStatusEvent):void {
			trace(event.info.code);
            switch (event.info.code) {
                case "NetConnection.Connect.Success":
                    break;
            }
        }
		private function ioErrorHandler(e:IOErrorEvent):void {
			trace(e);
		}

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
        /**
         * 调用成功
         */
         protected function onResult(success:*):void{
         	trace("success");
         	closeCon();
         
         }
        /**
         * 调用远程服务失败
         */
        protected function onFault(fault:Object):void { 
			trace("失败");
			closeCon();
		}
        /**
         * 关闭连接
         */
		protected function closeCon():void {
			if(connection){
				connection.close();
				connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				connection.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				connection = null;
			}
			if(responder){
				responder=null;
			}
		}
	}
}
