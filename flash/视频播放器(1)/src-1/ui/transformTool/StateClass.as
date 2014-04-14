package ui.transformTool
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	internal class StateClass 
	{
		private const STATE_NORMAL:String="on_normal";
		private const STATE_SELECT:String="on_select";
		private const STATE_AREA:String="on_area";
		private const STATE_DRAG:String="on_drag";
		private const STATE_CHANGE:String = "on_change";
		public function get normal():String
		{
			return STATE_NORMAL;
		}
		public function get select():String
		{
			return STATE_SELECT;
		}
		public function get area():String
		{
			return	STATE_AREA;
		}
		public function get drag():String
		{
			return	STATE_DRAG;
		}
		public function get change():String
		{
			return	STATE_CHANGE;
		}
	}
}