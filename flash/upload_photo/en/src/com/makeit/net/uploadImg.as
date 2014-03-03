package com.makeit.net 
{
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.*
	import flash.net.*
	public class uploadImg extends EventDispatcher
	{
		public static const UPLOAD_IMG_COMPLEGE:String="upload_img_complege";
		public var file:FileReference;
		public function uploadImg() 
		{
			file = new FileReference();
			file.addEventListener(Event.SELECT, selectHandler);
            file.addEventListener(Event.COMPLETE, completeHandler);
		}
		public function upload():void {
			
            file.browse(getTypes());
		}
		private function selectHandler(event:Event):void {
            var file:FileReference = FileReference(event.target);
			file.load();
			
        }
        private function completeHandler(event:Event):void {
			this.dispatchEvent(new Event(UPLOAD_IMG_COMPLEGE));
        }
		private function getTypes():Array {
            var allTypes:Array = new Array(getImageTypeFilter());
            return allTypes;
        }
			
        private function getImageTypeFilter():FileFilter {
            return new FileFilter("Images (*.jpg, *.jpeg, *.png)", "*.jpg;*.jpeg;*.png");
        }
        
        public function dispose():void{
        	file.removeEventListener(Event.SELECT, selectHandler);
            file.removeEventListener(Event.COMPLETE, completeHandler);
        	file=null;
        }
		public function get data():ByteArray{
			return file.data;
		}
	}

}