package akdcl.media{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class PlayState {
		public static const SEEK:String = "seek";
		public static const PLAY:String = "play";
		public static const PAUSE:String = "pause";
		public static const STOP:String = "stop";
		public static const COMPLETE:String = "complete";
		public static const READY:String = "ready";
		public static const CONNECT:String = "connect";
		public static const WAIT:String = "wait";
		public static const BUFFER:String = "buffer";
		public static const RECONNECT:String = "reconnect";
		
		private static const NAME_LIST:Object = { };
		NAME_LIST[SEEK] = "搜索";
		NAME_LIST[PLAY] = "播放";
		NAME_LIST[PAUSE] = "暂停";
		NAME_LIST[STOP] = "停止";
		NAME_LIST[COMPLETE] = "结束";
		NAME_LIST[READY] = "就绪";
		NAME_LIST[CONNECT] = "连接";
		NAME_LIST[WAIT] = "等待";
		NAME_LIST[BUFFER] = "缓冲";
		NAME_LIST[RECONNECT] = "重新连接";
		
		public static function getStateName(_state:String):String {
			return NAME_LIST[_state] || _state;
		}
	}
	
}