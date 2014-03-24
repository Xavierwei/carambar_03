/***
SampleTest
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月14日 14:59:17
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds.test{
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	import zero.shaders.Float2;
	import zero.shaders.Pixel4;
	import zero.stage3Ds.*;
	
	/**
	 * 
	 * 取样测试
	 * 
	 */	
	public class SampleTest extends BaseEffect{
		
		public static const nameV:Vector.<String>=new <String>["sampleX","sampleY"];
		//SampleTestCode//为了编译进来
		public static const byteV:Vector.<int>=new <int>[
			0xa0,0x01,0x00,0x00,0x00,0xa1,0x01,
			
			//tex oc.xyzw,fc0.xyyy,fs0<2d>
			0x28,0x00,0x00,0x00, 0x00,0x00,0x0f,0x03, 0x00,0x00,0x00,0x54,0x01,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,0x05,0x00,0x00,0x00
		];
		
		public static const data:Vector.<Number>=new <Number>[
			
			//fc0
			0,//u_sampleX
			0,//v_sampleY
			0,//占位
			0//占位
			
		];
		data.fixed=true;
		
		/**
		 * 
		 * 取样点X （-1~160） 默认 12
		 * 
		 */
		public var sampleX:int;
		
		/**
		 * 
		 * 取样点Y （-1~120） 默认 34
		 * 
		 */
		public var sampleY:int;
		

		/**
		 * 
		 * 取样点X （-1~160） 默认 12<br/>
		 * 取样点Y （-1~120） 默认 34<br/>
		 * 
		 */
		public function SampleTest(_sampleX:int=12,_sampleY:int=34){
			sampleX=_sampleX;
			sampleY=_sampleY;
		}
		
		override public function updateParams():void{
			
			//fc0
			data[0]=(Xiuzhengs.d+sampleX+0.5)/uploadBmd.width;//0 u_sampleX
			data[1]=(Xiuzhengs.d+sampleY+0.5)/uploadBmd.height;//0 v_sampleY
			//0 占位
			//0 占位
		}
		

	}
}