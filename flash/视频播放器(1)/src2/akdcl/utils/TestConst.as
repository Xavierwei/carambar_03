package akdcl.utils{
	
	/**
	 * ...
	 * @author akdcl
	 */
	final public class TestConst {
		
		public static const TEST_IMAGES:Array = [
			"http://w2i.wanmei.com/pic/8d.jpg",
			"http://w2i.wanmei.com/pic/16d.jpg",
			"http://w2i.wanmei.com/pic/22d.jpg",
			"http://w2i.wanmei.com/pic/27d.jpg",
			"http://w2i.wanmei.com/pic/29d.jpg"
		];
		
		public static const TEST_FLV:Array = [
			"http://media101.wanmei.com/media/xiaoao/110107/xacg110106p.flv",
			"http://media101.wanmei.com/media/xiaoao/xa110422.flv",
			"http://xa.wanmei.com/flv/MV-0611.flv",
			"http://xa.wanmei.com/flv/stzs.flv",
			"http://xa.wanmei.com/flv/xiaoao_HD_1080p.flv",
			"http://xa.wanmei.com/flv/wvxxx.flv",
			"http://vhot2.qqvideo.tc.qq.com/59261446/7O9m8Qn4Ron.flv",
			"http://vkpws.video.qq.com/flv/191/83/7YWEqxkxadV.flv"
		];
		
		public static const TEST_SOUND:Array = [
			"http://xa.wanmei.com/mp3/0.mp3",
			"http://xa.wanmei.com/mp3/1.mp3",
			"http://xa.wanmei.com/mp3/2.mp3",
			"http://xa.wanmei.com/mp3/3.mp3",
			"http://xa.wanmei.com/mp3/4.mp3"
		];
		
		public static function getImage(_id:int = -1):String {
			if (_id<0) {
				_id = int(Math.random() * TEST_IMAGES.length);
			}
			return TEST_IMAGES[_id];
		}
		
		public static function getFLV(_id:int = -1):String {
			if (_id<0) {
				_id = int(Math.random() * TEST_FLV.length);
			}
			return TEST_FLV[_id];
		}
		
		public static function getSound(_id:int = -1):String {
			if (_id<0) {
				_id = int(Math.random() * TEST_SOUND.length);
			}
			return TEST_SOUND[_id];
		}
		
		public static function getRandomSource():String {
			var _random:Number = Math.random();
			if (_random<0.3) {
				return getImage();
			}else if (_random<0.6) {
				return getFLV();
			}else {
				return getSound();
			}
		}
	}
}