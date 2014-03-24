package akdcl.net.remoting {	

	import flash.net.NetConnection;
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;	
	
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import flash.utils.Dictionary;

	[Event(name="fault", type="com.klstudio.events.FaultEvent")]
	[Event(name="result", type="com.klstudio.events.ResultEvent")]
	
	[Event(name="netStatus", type="flash.events.NetStatusEvent")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
			
	dynamic public class Service extends Proxy implements IEventDispatcher {
		private var _gateway : String;
		private var _nc : NetConnection;
		private var _destination : String;
		private var _dispatcher : EventDispatcher;	
		private var _operations : Dictionary;	
		
		/**
		 * 构建
		 * @param gateway remoting网关地址
		 * @param destination remoting目标地址
		 * @param objectEncoding remoting编码(amf0/amf3)
		 */
		public function Service(gateway : String,destination : String,objectEncoding : uint = 3) {
			_operations = new Dictionary(true);
			
			_gateway = gateway;
			_destination = destination;
			
			_dispatcher = new EventDispatcher(this);

			_nc = new NetConnection();
			_nc.client = this;
			_nc.objectEncoding = objectEncoding;
			_nc.addEventListener(NetStatusEvent.NET_STATUS, ncHandler);
			_nc.addEventListener(IOErrorEvent.IO_ERROR, ncHandler);
			_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ncHandler);
			_nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, ncHandler);
			_nc.connect(_gateway);			
		}

		/**
		 * public
		 */
		/**
		 * 设置安全证书的用户名和密码
		 * @param userName 用户名
		 * @param password 密码
		 */
		public function setRemoteCredentials(userName : String,password : String) : void {
			_nc.addHeader("Credentials", false, { userid : userName, password : password });
		}
		
		/**
		 * remoting网关地址
		 */
		public function get gateway():String{
			return _gateway;
		}
		/**
		 * remoting目标地址
		 */
		public function get destination():String{
			return _destination;
		}
		
		public function set destination(value:String):void {
			_destination = value;
		}
		
		/**
		 * remoting编码
		 */
		public function get objectEncoding():uint{
			return _nc.objectEncoding;
		}
		
		public function set objectEncoding(value:uint):void{
			_nc.objectEncoding = value;
		}
		
		/**
		 * remoting连接
		 */
		public function get connenction():NetConnection{
			return _nc;
		}
		
		public function toString() : String {
			return "[Service gateway="+gateway+", destination="+destination+", objectEncoding="+objectEncoding+"]";
		}

		/**
		 * private
		 */
		private function ncHandler(event : Event) : void {
			switch(event.type){
				case AsyncErrorEvent.ASYNC_ERROR:
					break;
				default:
					dispatchEvent(event);
			}			
		}
		
		private function getOperation(name:String):Operation{
			var operation:Operation = _operations[name];
			if(operation == null) {
				operation = new Operation(this,name);
				_operations[name] = operation;				
			}
			return operation;
		}
		
		private function getLocalName(name:*):String{
			if(name is QName){
				return QName(name).localName;
			}
			return String(name);
		}

		/**
		 * proxy
		 */
		override flash_proxy function getProperty(name : *) : * {
			return getOperation(getLocalName(name));
		}

		override flash_proxy function callProperty( methodName : *, ...parametres : * ) : * {
			return getOperation(getLocalName(methodName)).send.apply(null,parametres);
		}		

		/**
		 * IEventDispatcher
		 */

		public function dispatchEvent(event : Event) : Boolean {
			// TODO: Auto-generated method stub
			return _dispatcher.dispatchEvent(event);
		}

		public function hasEventListener(type : String) : Boolean {
			// TODO: Auto-generated method stub
			return _dispatcher.hasEventListener(type);
		}

		public function willTrigger(type : String) : Boolean {
			// TODO: Auto-generated method stub
			return _dispatcher.willTrigger(type);
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			_dispatcher.removeEventListener(type, listener, useCapture);
		}

		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
	}
}
/*package test {
	import com.klstudio.events.FaultEvent;
	import com.klstudio.events.ResultEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.klstudio.net.remoting.Service;

	import flash.display.Sprite;
	public class TestRemoting extends Sprite {
		private var _service:Service;
		public function TestRemoting() {
			_service = new Service("http://localhost:8080/test/messagebroker/amf","Remoting");
			_service.addEventListener(FaultEvent.FAULT, faultHandler);
			stage.addEventListener(MouseEvent.CLICK, stageHandler);	
		}
		
		private function stageHandler(event:Event):void{
			_service.getTitle.addEventListener(ResultEvent.RESULT,getTitleHandler);
			_service.getTitle();
		}

		private function getTitleHandler(event:ResultEvent):void{
			trace("result>" + event.result);
		}
		
		private function faultHandler(event:FaultEvent):void{
			trace(event.fault.toString());
		}
	}
}
*/
