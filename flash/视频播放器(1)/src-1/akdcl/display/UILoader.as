package akdcl.display {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	import akdcl.manager.RequestManager;
	import akdcl.utils.setProgressClip;

	/**
	 * ...
	 * @author ...
	 */

	/// @eventType	flash.events.Event.COMPLETE
	[Event(name="complete",type="flash.events.Event")]

	public class UILoader extends UIDisplay {
		protected static const rM:RequestManager = RequestManager.getInstance();

		public var progressClip:DisplayObject;
		public var sameChange:Boolean;
		
		protected var loadProgress:Number;
		
		private var eventComplete:Event;
		private var source:String;

		public function UILoader(_rectWidth:uint = 0, _rectHeight:uint = 0, _bgColor:int = -1){
			super(_rectWidth, _rectHeight, _bgColor);
		}
		
		override protected function init():void 
		{
			super.init();
			loadProgress = 0;
			eventComplete = new Event(Event.COMPLETE);
			setProgressClip(progressClip, 1, true);
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			if (source) {
				rM.unloadDisplay(source, onCompleteHandler, onErrorHandler, onProgressHandler);
				source = null;
			}
			progressClip = null;
			eventComplete = null;
		}

		public function load(_url:String, _tweenMode:int = 2, _alignX:Number = 0.5, _alignY:Number = 0.5, _scaleMode:Number = 1):void {
			if (!sameChange && _url && label == _url){
				return;
			}
			if (source) {
				rM.unloadDisplay(source, onCompleteHandler, onErrorHandler, onProgressHandler);
			}
			setContent(null, tweenMode);
			loadProgress = 0;
			source = _url;
			label = source;
			if (source) {
				alignXReady = _alignX;
				alignYReady = _alignY;
				scaleModeReady = _scaleMode;
				tweenMode = _tweenMode;
				rM.loadDisplay(source, onCompleteHandler, onErrorHandler, onProgressHandler);
			}
		}

		protected function onErrorHandler(_e:IOErrorEvent):void {
			setProgressClip(progressClip, 1, true);
		}

		protected function onProgressHandler(_e:Object):void {
			if (_e is ProgressEvent){
				loadProgress = _e.bytesLoaded / _e.bytesTotal;
			} else if(_e is Number){
				loadProgress = _e as Number;
			}else {
				loadProgress = 0;
			}
			if (isNaN(loadProgress)){
				loadProgress = 0;
			}
			setProgressClip(progressClip, loadProgress, true);
		}

		protected function onCompleteHandler(_data:*, _url:String = null):void {
			setProgressClip(progressClip, 1, true);
			setContent(_data, tweenMode, alignXReady, alignYReady, scaleModeReady);
			if (hasEventListener(Event.COMPLETE)){
				dispatchEvent(eventComplete);
			}
		}

		override protected function showContent():void {
			if (isHidding && loadProgress < 1){

			} else {
				super.showContent();
			}
		}
	}
}