package ui {
	import flash.display.DisplayObject;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * ...
	 * @author akdcl
	 */
	public class DocClassLoading extends UIMovieClip {
		public var progressClip:DisplayObject;
		public var progressTxt:TextField;


		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
		}

		protected function onProgressHandler(_progress:Number):void {
			
		}
		
		protected function setStyle():void {
			switch (stage.align){
				case StageAlign.TOP_LEFT:
				case StageAlign.LEFT:
				case StageAlign.BOTTOM_LEFT:
					x = int(stage.stageWidth * 0.5);
					break;
				case StageAlign.TOP_RIGHT:
				case StageAlign.RIGHT:
				case StageAlign.BOTTOM_RIGHT:
					__left = originalWidth - stageWidth;
					break;
				default:
					x = int(loaderInfo.width * 0.5);
					break;
			}

			switch (stage.align){
				case StageAlign.TOP_LEFT:
				case StageAlign.TOP:
				case StageAlign.TOP_RIGHT:
					__top = 0;
					break;
				case StageAlign.BOTTOM_LEFT:
				case StageAlign.BOTTOM:
				case StageAlign.BOTTOM_RIGHT:
					__top = originalHeight - stageHeight;
					break;
				default:
					__top = (originalHeight - stageHeight) * 0.5;
					break;
			}
			__bottom = __top + __stageHeight;
			y = loaderInfo.height * 0.5;
		}
	}

}