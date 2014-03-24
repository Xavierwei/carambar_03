/***
BaseEffect
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月11日 21:00:56
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds{
	import flash.display.*;
	import flash.display3D.Context3DProgramType;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.shaders.Float2;
	import zero.shaders.Pixel4;
	import zero.stage3Ds.AGAL2Program;
	import zero.stage3Ds.getProgramByByteV;
	
	public class BaseEffect{
		
		public function BaseEffect(){
			
			var fragmentProgram:ByteArray=this["constructor"].fragmentProgram;
			if(fragmentProgram){
			}else{
				try{
					var byteV:Vector.<int>=this["constructor"].byteV;
					if(byteV.length){
					}else{
						byteV=null;
					}
				}catch(e:Error){
					byteV=null;
				}
				if(byteV){
					fragmentProgram=getProgramByByteV(byteV);
				}else{
					fragmentProgram=AGAL2Program(
						Context3DProgramType.FRAGMENT,//片段着色器（好像也叫像素着色器）
						new (getDefinitionByName(getQualifiedClassName(this)+"Code"))().toString()
					);
				}
			}
			
			//fragmentProgram:ByteArray=getProgramByByteV();
			if(this["constructor"].fragmentProgram){
			}else{
				this["constructor"].fragmentProgram=fragmentProgram;
				//trace("初始化 fragmentProgram，fragmentProgram.length="+fragmentProgram.length);
				
				var nameV:Vector.<String>=this["constructor"].nameV;
				nameV.fixed=true;
				
				var typeMark:Object=new Object();
				
				for each(var node:XML in describeType(this).children()){
					switch(node.name().toString()){
						case "variable":
						case "accessor":
							typeMark[node.@name.toString()]=getDefinitionByName(node.@type.toString());
						break;
					}
				}
				var typeV:Vector.<Class>=new Vector.<Class>();
				for each(var name:String in nameV){
					typeV.push(typeMark[name]);
				}
				typeV.fixed=true;
				this["constructor"].typeV=typeV;
				
				//trace("nameV="+nameV);
				//trace("typeV="+typeV);
			}
		}
		
		public function clear():void{
			__bmd=null;
			if(__uploadBmd){
				__uploadBmd.dispose();
				__uploadBmd=null;
			}
		}
		
		private var __bmd:BitmapData;
		public function get bmd():BitmapData{
			return __bmd;
		}
		public function set bmd(_bmd:BitmapData):void{
			__bmd=_bmd;
			if(__uploadBmd){
				__uploadBmd.dispose();
			}
			
			var uploadBmdWid:int=1;
			while(uploadBmdWid<__bmd.width+Xiuzhengs.d*2){
				uploadBmdWid<<=1;
			}
			var uploadBmdHei:int=1;
			while(uploadBmdHei<__bmd.height+Xiuzhengs.d*2){
				uploadBmdHei<<=1;
			}
			
			__uploadBmd=new BitmapData(uploadBmdWid,uploadBmdHei,__bmd.transparent,0x00000000);
			__uploadBmd.copyPixels(__bmd,__bmd.rect,new Point(Xiuzhengs.d,Xiuzhengs.d));
			//if(__bmd.width<uploadBmdWid){
			//	//向右复制最右边一列，以便对付当 u=1 时的一些情况
			//	__uploadBmd.copyPixels(__bmd,new Rectangle(__bmd.width-1,0,1,__bmd.height),new Point(__bmd.width,0));
			//}
			//if(__bmd.height<uploadBmdHei){
			//	//向下复制最下边一行，以便对付当 v=1 时的一些情况
			//	__uploadBmd.copyPixels(__bmd,new Rectangle(0,__bmd.height-1,__bmd.width,1),new Point(0,__bmd.height));
			//}
			//if(__bmd.width<uploadBmdWid&&__bmd.height<uploadBmdHei){
			//	__uploadBmd.setPixel32(__bmd.width,__bmd.height,__bmd.getPixel32(__bmd.width-1,__bmd.height-1));
			//}
		}
		
		private var __uploadBmd:BitmapData;
		public function get uploadBmd():BitmapData{
			return __uploadBmd;
		}
		
		public function initNullParams():void{//对可能为null的某些值赋一个初始值
			var i:int=-1;
			for each(var type:Class in this["constructor"].typeV){
				i++;
				var name:String=this["constructor"].nameV[i];
				switch(type){
					case Float2:
						if(this[name]){
						}else{
							//对任何未赋值的 Float2 ，设置默认值为图片中心
							this[name]=new Float2(bmd.width*0.5,bmd.height*0.5);
						}
					break;
					case Pixel4:
						if(this[name]){
						}else{
							//对任何未赋值的 Pixel4 ，设置默认值为不透明黑色
							this[name]=new Pixel4(0,0,0,1);
						}
					break;
				}
			}
		}
		public function updateParams():void{}
	}
}