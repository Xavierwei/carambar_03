package akdcl.net {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.DataEvent;

	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;

	import zero.FileTypes;
	import zero.codec.BMPEncoder;

	public class FileREF extends FileReference {

		private static const ERROR_BROWSE:String = "浏览失败！";
		private static const ERROR_SIZE_LIMIT:String = "超过尺寸限制！";
		private static const ERROR_IO:String = "IO错误！";

		public var fileSizeLimit:int = 10240;
		public var fileInfo:String = "图片";
		public var fileTypes:String = "jpg,jpeg,gif,png,bmp";

		public var errorMessage:String;
		public var dataDecoded:Object;

		private var url:Object;
		private var fileID:String;

		public function FileREF(){
			addEventListener(Event.SELECT, onSelectedHandler);
			addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			addEventListener(Event.COMPLETE, onLoadComplete);
			addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadComplete);
		}

		public function remove():void {
			removeEventListener(Event.SELECT, onSelectedHandler);
			removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			removeEventListener(Event.COMPLETE, onLoadComplete);
			removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadComplete);
			if (dataDecoded is BitmapData) {
				dataDecoded.dispose();
			}
			dataDecoded = null;
		}

		public function launch(_url:Object = null, _fileID:String = null):void {
			try {
				url = _url;
				fileID = _fileID;
				browse([new FileFilter(fileInfo, "*." + fileTypes.replace(/\,/g, ";*."))]);
			} catch (_e:Error){
				onErrorHandler(fileInfo + ERROR_BROWSE);
			}
		}

		private function onSelectedHandler(_e:Event):void {
			if (size > fileSizeLimit * 1024){
				_e.stopImmediatePropagation();
				//fileSizeLimit + "K!"
				onErrorHandler(fileInfo + ERROR_SIZE_LIMIT);
			} else {
				if (dataDecoded is BitmapData) {
					dataDecoded.dispose();
				}
				dataDecoded = null;
				if (url){
					upload(new URLRequest(url as String), fileID);
				} else {
					load();
				}
			}
		}

		private function onErrorHandler(_eOrMessage:Object):void {
			if (_eOrMessage is String){
				errorMessage = _eOrMessage as String;
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			} else if (_eOrMessage is Event){
				switch (_eOrMessage.type){
					case IOErrorEvent.IO_ERROR:
						errorMessage = fileInfo + ERROR_IO;
						break;
				}
			}
		}

		private function onUploadComplete(_e:DataEvent):void {
			var _result:String = _e.data.replace(/(^\s*)|(\s*$)/g, "");
			dataDecoded = _result;
		}

		private function onLoadComplete(_e:Event):void {
			switch (FileTypes.getType(data, name)){
				case FileTypes.BMP:
					dataDecoded = BMPEncoder.decode(data);
					break;
				case FileTypes.JPG:
				case FileTypes.PNG:
				case FileTypes.GIF:
					if (dataDecoded){
					} else {
						var _loader:Loader = new Loader();
						_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageDecodeHandler);
						_loader.loadBytes(data);
						_e.stopImmediatePropagation();
					}
					break;
				default:
					dataDecoded = data;
					break;
			}
		}

		private function onImageDecodeHandler(_e:Event):void {
			_e.target.removeEventListener(Event.COMPLETE, onImageDecodeHandler);
			var _loader:Loader = _e.currentTarget.loader;
			dataDecoded = (_loader.content as Bitmap).bitmapData;
			dispatchEvent(_e);
			try {
				_loader.unload();
				_loader.close();
			} catch (_e:Error){

			}
		}
	}
}