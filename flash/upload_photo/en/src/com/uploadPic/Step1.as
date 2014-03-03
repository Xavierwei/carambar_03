package com.uploadPic 
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.makeit.net.uploadImg;
	import com.makeit.managers.Singleton;
	/**
	 * ...
	 * @author happy
	 */
	public class Step1 extends MovieClip 
	{
		public var tipMC:MovieClip;
		public var uploadBtn1:SimpleButton;
		public var uploadBtn2:SimpleButton;
		private var _fileUpload:uploadImg;
		private var _loader:Loader;
		private var _appModel:AppModel = Singleton.getInstance(AppModel);
		public function Step1() 
		{
			_fileUpload = new uploadImg();
			_fileUpload.addEventListener(uploadImg.UPLOAD_IMG_COMPLEGE, uploadCompleteHandler);
			uploadBtn1.addEventListener(MouseEvent.CLICK, clickHandler);
			uploadBtn2.addEventListener(MouseEvent.CLICK, clickHandler);
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
		}
		private function clickHandler(e:MouseEvent):void {
			_fileUpload.upload();
		}
		private function uploadCompleteHandler(e:Event):void {
			_loader.loadBytes(_fileUpload.data);
			
		}
		private function loadCompleteHandler(e:Event):void {
			if (_loader.content.width < 450 || _loader.content.height < 450) {
				tipMC.gotoAndStop(2);
			}else {
				_appModel.picData.writeBytes(_fileUpload.data);
				MovieClip(parent).gotoAndStop(2);
			}
		}
		
	}

}