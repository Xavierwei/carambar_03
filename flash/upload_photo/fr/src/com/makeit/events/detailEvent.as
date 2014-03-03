package com.makeit.events 
{
	import com.makeit.control.makeEvent;
	public class detailEvent extends makeEvent
	{
		public static const SELECT_DETAIL:String = "select_detail"
		public static const SELECT_NUM:String = "select_num"
		public static const TYPE_NUM:String = "type_num"
		public static const DOWNLOAD:String="download"
		public var picID:uint
		public var showFrame:uint
		public function detailEvent(type:String) 
		{
			super(type)
		}
		
	}

}