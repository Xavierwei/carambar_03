/***
Random
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年7月26日 21:43:45
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero{
	import com.adobe.crypto.MD5;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	/**
	 * 
	 * 获取确定的随机数
	 * 
	 */	
	public class Random{
		
		private static var random:Random;
		
		/**
		 * 
		 * init(0~0xffffffff的任意一个整数)
		 * 如使用前不 init，则默认种子为 Math.random()*0x100000000
		 * 
		 */		
		public static function init(seed:uint):void{
			if(random){
				random.init(seed);
			}else{
				random=new Random(seed);
			}
		}
		
		private static function getNextRan(ran:uint):uint{
			return random.getNextRan(ran);
		}
		
		/**
		 * 
		 * 返回 0~1 的一个随机浮点数，类似于 Math.random()
		 * 不同机器可能对浮点数的处理不一样，有可能返回带误差的不太确定的随机数
		 * 如需要返回比较确定的随机数，请使用 ranInt()
		 * 
		 */		
		public static function ranNum():Number{
			return random.ranNum();
		}
		
		/**
		 * 
		 * 返回 0~num 的一个随机整数，类似于 AS2 的 random(num)
		 * 不同机器不同系统应该都能获得相同的随机数
		 * 
		 */		
		public static function ranInt(num:uint):uint{
			return random.ranInt(num);
		}
		
		private var ran:uint;
		
		public function Random(...seed){
			if(seed.length){
				init(seed[0]);
			}else{
				init(Math.random()*0x100000000);//0~0xffffffff
			}
		}
		
		/**
		 * 
		 * init(0~0xffffffff的任意一个整数)（0和1等价）
		 * 如使用前不 init，则默认种子为 Math.random()*0x100000000
		 * 
		 */		
		public function init(seed:uint):void{
			trace("zero.Random seed="+seed);
			if(seed==0){//0的话必然会再获取到0，所以直接改成别的数
				seed=1;
			}
			ran=seed;
		}
		
		private function getNextRan(ran:uint):uint{//如果 ran 为 0，会一直得到0
			//1
			//ran=uint("0x"+MD5.hash(ran.toString()).substr(0,8));//很慢
			
			//2
			//http://bbs.9ria.com/thread-139603-1-1.html
			ran^=(ran<<21);
			ran^=(ran>>>3);
			ran^=(ran<<4);
			return ran;
		}
		
		/**
		 * 
		 * 返回 0~1 的一个随机浮点数，类似于 Math.random()
		 * 不同机器可能对浮点数的处理不一样，有可能返回带误差的不太确定的随机数
		 * 如需要返回比较确定的随机数，请使用 ranInt()
		 * 
		 */		
		public function ranNum():Number{
			ran=getNextRan(ran);
			return ran/0x100000000;
		}	
		
		/**
		 * 
		 * 返回 0~num 的一个随机整数，类似于 AS2 的 random(num)
		 * 不同机器不同系统应该都能获得相同的随机数
		 * 
		 */		
		public function ranInt(num:uint):uint{
			ran=getNextRan(ran);
			return ran%num;
		}
		
	}
}