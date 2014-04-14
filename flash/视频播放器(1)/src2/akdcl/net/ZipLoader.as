package akdcl.net
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.ProgressEvent;
	import riaidea.utils.zip.ZipArchive;
	import riaidea.utils.zip.ZipEvent;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ... Akdcl
	 */
	public class ZipLoader 
	{
		private static const FILETYPE_JPG:String = ".jpg";
		private static const FILETYPE_PNG:String = ".png";
		public var onContentsLoaded:Function;
		public var onContentsLoading:Function;
		public function ZipLoader() {
			zipArchiveDic = { };
		}
		public function loadZip(_pathOrId:String, _byteArray:ByteArray = null):void {
			var _zipArchive:ZipArchive = new ZipArchive(_pathOrId);
			addZipArchiveToDic(_zipArchive);
			if (_byteArray != null) {
				if (_zipArchive.open(_byteArray)) {
					onZipLoaded( { currentTarget:_zipArchive } );
				}
			}else {
				_zipArchive.addEventListener(ZipEvent.ZIP_INIT, onZipLoaded);
				_zipArchive.addEventListener(ProgressEvent.PROGRESS, onZipLoading);
				_zipArchive.load(_pathOrId);
			}
		}
		private var zipArchiveDic:Object;
		private function addZipArchiveToDic(_zipArchive:ZipArchive):void {
			var _ob:Object = { };
			_ob.zipArchive = _zipArchive;
			_ob.contentCounts = 0;
			_ob.datas = { };
			zipArchiveDic[_zipArchive.name] = _ob;
		}
		private function removeZipArchiveFromDic(_zipArchive:ZipArchive):void {
			_zipArchive.removeEventListener(ZipEvent.ZIP_INIT, onZipLoaded);
			_zipArchive.removeEventListener(ZipEvent.ZIP_CONTENT_LOADED, onZipContentLoaded);
			var _ob:Object = zipArchiveDic[_zipArchive.name];
			for (var _i:String in _ob) {
				delete _ob[_i];
			}
			delete zipArchiveDic[_zipArchive.name];
		}
		private function zipArchiveFileGot(_zipArchive:ZipArchive, _data:*, _fileName:String):void {
			var _ob:Object = zipArchiveDic[_zipArchive.name];
			_ob.contentCounts++;
			_ob.datas[_fileName] = _data;
			if (_zipArchive.length == _ob.contentCounts) {
				_zipArchive.name, _ob.datas
				if (onContentsLoaded!=null) {
					onContentsLoaded(_zipArchive.name, _ob.datas);
				}
				_zipArchive.removeEventListener(ZipEvent.ZIP_CONTENT_LOADED, onZipContentLoaded);
				removeZipArchiveFromDic(_zipArchive);
			}
		}
		private function onZipLoading(_evt:ProgressEvent):void {
			//加载中
			if (onContentsLoading!=null) {
				onContentsLoading(int(_evt.bytesLoaded / _evt.bytesTotal * 100) / 100);
			}
		}
		private function onZipLoaded(_evt:Object):void {
			var _zipArchive:ZipArchive = (_evt.currentTarget as ZipArchive);
			_zipArchive.removeEventListener(ZipEvent.ZIP_INIT, onZipLoaded);
			_zipArchive.addEventListener(ZipEvent.ZIP_CONTENT_LOADED, onZipContentLoaded);
			var _fileCounts:uint = _zipArchive.length;
			var _i:uint;
			var _fileName:String;
			var _fileNameLowerCase:String;
			while (_i < _fileCounts) {
				_fileName = _zipArchive.getFileAt(_i).name;
				_fileNameLowerCase = _fileName.toLowerCase();
				if (_fileNameLowerCase.indexOf(FILETYPE_JPG)>=0||_fileNameLowerCase.indexOf(FILETYPE_PNG)>=0) {
					_zipArchive.getBitmapByName(_fileName);
				}else {
					zipArchiveFileGot(_zipArchive, _zipArchive.getFileByName(_fileName).data, _fileName);
				}
				_i++;
			}
		}
		private function onZipContentLoaded(_evt:ZipEvent):void {
			var _zipArchive:ZipArchive = (_evt.currentTarget as ZipArchive);
			var _bmd:BitmapData = (_evt.content as BitmapData);
			zipArchiveFileGot(_zipArchive, _bmd, _evt.file.name);
		}
	}
	
}