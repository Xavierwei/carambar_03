/***
ARGB
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月05日 00:24:30
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
	 * 透明红绿蓝
	 * 
	 */	
	public class ARGB extends BaseEffect{
		
		public static const nameV:Vector.<String>=new <String>["alpha","red","green","blue"];
		//ARGBCode//为了编译进来
		public static const byteV:Vector.<int>=new <int>[
			0xa0,0x01,0x00,0x00,0x00,0xa1,0x01,
			
			//tex ft0.xyzw,v0.xyzw,fs0<2d>
			0x28,0x00,0x00,0x00, 0x00,0x00,0x0f,0x02, 0x00,0x00,0x00,0xe4,0x04,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,0x05,0x00,0x00,0x00,
			
			//mul ft0.xyzw,ft0.xyzw,fc0.xyzw
			0x03,0x00,0x00,0x00, 0x00,0x00,0x0f,0x02, 0x00,0x00,0x00,0xe4,0x02,0x00,0x00,0x00, 0x00,0x00,0x00,0xe4,0x01,0x00,0x00,0x00,
			
			//mul ft0.xyz,ft0.xyz,fc0.www
			0x03,0x00,0x00,0x00, 0x00,0x00,0x07,0x02, 0x00,0x00,0x00,0x24,0x02,0x00,0x00,0x00, 0x00,0x00,0x00,0x3f,0x01,0x00,0x00,0x00,
			
			//mov oc.xyzw,ft0.xyzw
			0x00,0x00,0x00,0x00, 0x00,0x00,0x0f,0x03, 0x00,0x00,0x00,0xe4,0x02,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
		];
		
		public static const data:Vector.<Number>=new <Number>[
			
			//fc0
			0,//red
			0,//green
			0,//blue
			0//alpha
			
		];
		data.fixed=true;
		
		/**
		 * 
		 * 透明度 （0~1） 默认 1
		 * 
		 */
		public var alpha:Number;
		
		/**
		 * 
		 * 红 （0~1） 默认 1
		 * 
		 */
		public var red:Number;
		
		/**
		 * 
		 * 绿 （0~1） 默认 1
		 * 
		 */
		public var green:Number;
		
		/**
		 * 
		 * 蓝 （0~1） 默认 1
		 * 
		 */
		public var blue:Number;
		

		/**
		 * 
		 * 透明度 （0~1） 默认 1<br/>
		 * 红 （0~1） 默认 1<br/>
		 * 绿 （0~1） 默认 1<br/>
		 * 蓝 （0~1） 默认 1<br/>
		 * 
		 */
		public function ARGB(_alpha:Number=1,_red:Number=1,_green:Number=1,_blue:Number=1){
			alpha=_alpha;
			red=_red;
			green=_green;
			blue=_blue;
		}
		
		override public function updateParams():void{
			
			//fc0
			data[0]=red
			data[1]=green
			data[2]=blue
			data[3]=alpha
		}
		

	}
}