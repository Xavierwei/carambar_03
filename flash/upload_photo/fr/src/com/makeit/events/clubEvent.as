package com.makeit.events 
{
	import com.makeit.control.makeEvent;
	import flash.display.BitmapData;
	public class clubEvent extends makeEvent
	{
		public static const START:String = "start"
		public static const NEXT:String = "next"
		public static const PREV:String="prev"
		public static const ADJUST:String = "adjust"
		public static const ADJUST_FACE:String = "adjust_face"
		public static const CLOTH_SELECT:String = "cloth_select"
		public static const PANT_SELECT:String = "pant_select"
		public static const COLOR_SELECT:String = "color_select"
		public static const TYPE_SELECT:String = "type_select"
		public static const BG_SELECT:String = "bg_select"
		public static const SEND:String = "send"
		public static const SEND_COMPLETE:String="send_complete"
		public var value:Number
		public var typeData:String
		public var bmp:BitmapData
		public var id:uint
		public function clubEvent(type:String) 
		{
			super(type)
		}
		
	}

}