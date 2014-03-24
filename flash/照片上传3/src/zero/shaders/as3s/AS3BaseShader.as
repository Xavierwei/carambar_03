/***
AS3BaseShader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月14日 20:20:18
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders.as3s{
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import zero.shaders.*;
	import zero.stage3Ds.as3s.AS3BaseEffect;
	
	public class AS3BaseShader{
		
		protected static const xml:XML=<xml>
			<params/>
			<constParams/>
			<constFuns/>
		</xml>;
		
		public var shader:BaseShader;
		public var as3Effect:AS3BaseEffect;
		
		protected var src:Image4;
		protected var dst:Pixel4;
		private var oc:Float2;
		protected var srcSize:Float2;
		
		public var alpha:Number=1;
		xml.params[0].appendChild(<alpha description="透明度" minValue="0" maxValue="1"/>);
		
		public var focalLength:Number=200;
		xml.params[0].appendChild(<focalLength description="视点到投影屏幕的距离" minValue="0" maxValue="2048"/>);
		
		public var center:Float2=null;
		xml.params[0].appendChild(<center description="坐标"/>);
		
		public var center_z:Number=0;
		xml.params[0].appendChild(<center_z description="坐标z" minValue="-1024" maxValue="1024"/>);
		
		public var scaleX:Number=1;
		xml.params[0].appendChild(<scaleX description="scaleX" minValue="-4" maxValue="4"/>);
		
		public var scaleY:Number=1;
		xml.params[0].appendChild(<scaleY description="scaleX" minValue="-4" maxValue="4"/>);
		
		public var skewX:Number=0;
		xml.params[0].appendChild(<skewX description="skewX" minValue="-360" maxValue="360"/>);
		
		public var skewY:Number=0;
		xml.params[0].appendChild(<skewY description="skewY" minValue="-360" maxValue="360"/>);
		
		public var rotationX:Number=0;
		xml.params[0].appendChild(<rotationX description="rotationX" minValue="-360" maxValue="360"/>);
		
		public var rotationY:Number=0;
		xml.params[0].appendChild(<rotationY description="rotationY" minValue="-360" maxValue="360"/>);
		
		public var rotationZ:Number=0;
		xml.params[0].appendChild(<rotationZ description="rotationZ" minValue="-360" maxValue="360"/>);
		
		protected function updateTransform():void{
			
			o.x=srcSize.x*0.5;
			o.y=srcSize.y*0.5;
			
			//一左上角为（0,0）的图片 bmp，放到 mc1 里，bmp.x=-o.x，bmp.y=-o.y
			var m:Matrix3D=new Matrix3D(new <Number>[
				1,0,0,0,
				0,1,0,0,
				0,0,1,0,
				-o.x,-o.y,0,1
			]);
			
			//mc1 用于斜切和缩放
			m.append(new Matrix3D(new <Number>[
				scaleX*Math.cos(skewY*(Math.PI/180)),scaleX*Math.sin(skewY*(Math.PI/180)),0,0,
				-scaleY*Math.sin(skewX*(Math.PI/180)),scaleY*Math.cos(skewX*(Math.PI/180)),0,0,
				0,0,1,0,
				0,0,0,1
			]));
			
			//mc1 放 mc2 里，mc2 用于 rotationX
			var _c:Number=Math.cos(rotationX*(Math.PI/180));
			var _s:Number=Math.sin(rotationX*(Math.PI/180));
			m.append(new Matrix3D(new <Number>[
				1,0,0,0,
				0,_c,_s,0,
				0,-_s,_c,0,
				0,0,0,1
			]));
			
			//mc2 放 mc3 里，mc3 用于 rotationY
			_c=Math.cos(rotationY*(Math.PI/180));
			_s=Math.sin(rotationY*(Math.PI/180));
			m.append(new Matrix3D(new <Number>[
				_c,0,-_s,0,
				0,1,0,0,
				_s,0,_c,0,
				0,0,0,1
			]));
			
			//mc3 放 mc4 里，mc4 用于 rotationZ
			_c=Math.cos(rotationZ*(Math.PI/180));
			_s=Math.sin(rotationZ*(Math.PI/180));
			m.append(new Matrix3D(new <Number>[
				_c,_s,0,0,
				-_s,_c,0,0,
				0,0,1,0,
				0,0,0,1
			]));
			
			//mc4 放 mc5 里，mc5 用于位移
			m.append(new Matrix3D(new <Number>[
				1,0,0,0,
				0,1,0,0,
				0,0,1,0,
				center.x-o.x,center.y-o.y,center_z,1
			]));
			
			//=============================================================================================
			var a:Number=m.rawData[0];var b:Number=m.rawData[1];var c:Number=m.rawData[2];
			var d:Number=m.rawData[4];var e:Number=m.rawData[5];var f:Number=m.rawData[6];
			var g:Number=m.rawData[8];var h:Number=m.rawData[9];var i:Number=m.rawData[10];
			var tx:Number=m.rawData[12];var ty:Number=m.rawData[13];var tz:Number=m.rawData[14];
			
			//通过 x1,y1,z1(其实=0)，m 求 x3,y3：
			//p1*m=p2;
			//p2*fL=p3*(fl+z2);
			//var x1:Number=0;
			//var y1:Number=0;
			//var z1:Number=0;
			//var x2:Number=x1*a+y1*d+z1*g+tx;
			//var y2:Number=x1*b+y1*e+z1*h+ty;
			//var z2:Number=x1*c+y1*f+z1*i+tz;
			//var x3:Number=x2*focalLength/(focalLength+z2);
			//var y3:Number=y2*focalLength/(focalLength+z2);
			//x3+=o.x;
			//y3+=o.y;
			
			//通过 x3,y3 求 x1,y1：
			//x2=x1*a+y1*d+tx;
			//y2=x1*b+y1*e+ty;
			//z2=x1*c+y1*f+tz;
			//x3=x2*focalLength/(focalLength+z2)+xo;
			//y3=y2*focalLength/(focalLength+z2)+yo;
			//==>
			//x3=(x1*a+y1*d+tx)*focalLength/(focalLength+(x1*c+y1*f+tz))+xo;
			//y3=(x1*b+y1*e+ty)*focalLength/(focalLength+(x1*c+y1*f+tz))+yo;
			//==>
			//(x3-xo)*(focalLength+(x1*c+y1*f+tz))-(x1*a+y1*d+tx)*focalLength=0
			//(y3-yo)*(focalLength+(x1*c+y1*f+tz))-(x1*b+y1*e+ty)*focalLength=0
			//=>
			//+focalLength*x3+c*x1*x3+f*x3*y1+tz*x3-focalLength*xo-c*x1*xo-f*xo*y1-tz*xo-a*focalLength*x1-d*focalLength*y1-focalLength*tx=0
			//+focalLength*y3+c*x1*y3+f*y1*y3+tz*y3-focalLength*yo-c*x1*yo-f*y1*yo-tz*yo-b*focalLength*x1-e*focalLength*y1-focalLength*ty=0
			//=>
			//(c*x3-c*xo-a*focalLength)*x1 + (f*x3-f*xo-d*focalLength)*y1 + (focalLength*x3+tz*x3-focalLength*xo-tz*xo-focalLength*tx) = 0
			//(c*y3-c*yo-b*focalLength)*x1 + (f*y3-f*yo-e*focalLength)*y1 + (focalLength*y3+tz*y3-focalLength*yo-tz*yo-focalLength*ty) = 0
			//=>
			//(c*x3-c*xo-a*focalLength)*(f*y3-f*yo-e*focalLength)*x1 + (f*x3-f*xo-d*focalLength)*(f*y3-f*yo-e*focalLength)*y1 + (f*y3-f*yo-e*focalLength)*(focalLength*x3+tz*x3-focalLength*xo-tz*xo-focalLength*tx) = 0
			//(c*y3-c*yo-b*focalLength)*(f*x3-f*xo-d*focalLength)*x1 + (f*y3-f*yo-e*focalLength)*(f*x3-f*xo-d*focalLength)*y1 + (f*x3-f*xo-d*focalLength)*(focalLength*y3+tz*y3-focalLength*yo-tz*yo-focalLength*ty) = 0
			//=>
			//x1=((f*x3-f*xo-d*focalLength)*(focalLength*y3+tz*y3-focalLength*yo-tz*yo-focalLength*ty)-(f*y3-f*yo-e*focalLength)*(focalLength*x3+tz*x3-focalLength*xo-tz*xo-focalLength*tx))/((c*x3-c*xo-a*focalLength)*(f*y3-f*yo-e*focalLength)-(c*y3-c*yo-b*focalLength)*(f*x3-f*xo-d*focalLength))
			//y1=((c*x3-c*xo-a*focalLength)*(focalLength*y3+tz*y3-focalLength*yo-tz*yo-focalLength*ty)-(c*y3-c*yo-b*focalLength)*(focalLength*x3+tz*x3-focalLength*xo-tz*xo-focalLength*tx))/((f*x3-f*xo-d*focalLength)*(c*y3-c*yo-b*focalLength)-(c*x3-c*xo-a*focalLength)*(f*y3-f*yo-e*focalLength))
			//==>
			//x1=(-f*focalLength*ty*x3+f*focalLength*ty*xo-d*focalLength*focalLength*y3-d*focalLength*tz*y3+d*focalLength*focalLength*yo+d*focalLength*tz*yo+d*focalLength*focalLength*ty+f*focalLength*tx*y3-f*focalLength*tx*yo+e*focalLength*focalLength*x3+e*focalLength*tz*x3-e*focalLength*focalLength*xo-e*focalLength*tz*xo-e*focalLength*focalLength*tx)/(-c*e*focalLength*x3+c*e*focalLength*xo-a*f*focalLength*y3+a*f*focalLength*yo+a*e*focalLength*focalLength+c*d*focalLength*y3-c*d*focalLength*yo+b*f*focalLength*x3-b*f*focalLength*xo-b*d*focalLength*focalLength)
			//y1=(-c*focalLength*ty*x3+c*focalLength*ty*xo-a*focalLength*focalLength*y3-a*focalLength*tz*y3+a*focalLength*focalLength*yo+a*focalLength*tz*yo+a*focalLength*focalLength*ty+c*focalLength*tx*y3-c*focalLength*tx*yo+b*focalLength*focalLength*x3+b*focalLength*tz*x3-b*focalLength*focalLength*xo-b*focalLength*tz*xo-b*focalLength*focalLength*tx)/(-b*f*focalLength*x3+b*f*focalLength*xo-c*d*focalLength*y3+c*d*focalLength*yo+b*d*focalLength*focalLength+c*e*focalLength*x3-c*e*focalLength*xo+a*f*focalLength*y3-a*f*focalLength*yo-a*e*focalLength*focalLength)
			
			//var fL:Number=focalLength;
			//var x3:Number=123;
			//var y3:Number=456;
			//var xo:Number=o.x;
			//var yo:Number=o.y;
			//var x1:Number,y1:Number;
			//x1=((f*x3-f*xo-d*fL)*(fL*y3+tz*y3-fL*yo-tz*yo-fL*ty)-(f*y3-f*yo-e*fL)*(fL*x3+tz*x3-fL*xo-tz*xo-fL*tx))/((c*x3-c*xo-a*fL)*(f*y3-f*yo-e*fL)-(c*y3-c*yo-b*fL)*(f*x3-f*xo-d*fL))
			//y1=((c*x3-c*xo-a*fL)*(fL*y3+tz*y3-fL*yo-tz*yo-fL*ty)-(c*y3-c*yo-b*fL)*(fL*x3+tz*x3-fL*xo-tz*xo-fL*tx))/((f*x3-f*xo-d*fL)*(c*y3-c*yo-b*fL)-(c*x3-c*xo-a*fL)*(f*y3-f*yo-e*fL))
			//trace(x1,y1);
			//x1=(-f*fL*ty*x3+f*fL*ty*xo-d*fL*fL*y3-d*fL*tz*y3+d*fL*fL*yo+d*fL*tz*yo+d*fL*fL*ty+f*fL*tx*y3-f*fL*tx*yo+e*fL*fL*x3+e*fL*tz*x3-e*fL*fL*xo-e*fL*tz*xo-e*fL*fL*tx)/(-c*e*fL*x3+c*e*fL*xo-a*f*fL*y3+a*f*fL*yo+a*e*fL*fL+c*d*fL*y3-c*d*fL*yo+b*f*fL*x3-b*f*fL*xo-b*d*fL*fL)
			//y1=(-c*fL*ty*x3+c*fL*ty*xo-a*fL*fL*y3-a*fL*tz*y3+a*fL*fL*yo+a*fL*tz*yo+a*fL*fL*ty+c*fL*tx*y3-c*fL*tx*yo+b*fL*fL*x3+b*fL*tz*x3-b*fL*fL*xo-b*fL*tz*xo-b*fL*fL*tx)/(-b*f*fL*x3+b*f*fL*xo-c*d*fL*y3+c*d*fL*yo+b*d*fL*fL+c*e*fL*x3-c*e*fL*xo+a*f*fL*y3-a*f*fL*yo-a*e*fL*fL)
			//trace(x1,y1);
			//var xxx:Number=(c*e*xo+a*f*yo+a*e*fL-c*d*yo-b*f*xo-b*d*fL)+(b*f-c*e)*x3+(c*d-a*f)*y3;
			//x1=((f*ty*xo+d*fL*yo+d*tz*yo+d*fL*ty-f*tx*yo-e*fL*xo-e*tz*xo-e*fL*tx)+(e*fL+e*tz-f*ty)*x3+(f*tx-d*fL-d*tz)*y3)/xxx
			//y1=((c*ty*xo+a*fL*yo+a*tz*yo+a*fL*ty-c*tx*yo-b*fL*xo-b*tz*xo-b*fL*tx)+(b*fL+b*tz-c*ty)*x3+(c*tx-a*fL-a*tz)*y3)/-xxx
			//trace(x1,y1);
			
			ma=a;mb=b;mc=c;
			md=d;me=e;mf=f;
			mg=g;mh=h;mi=i;
			mtx=tx;mty=ty;mtz=tz;
			//trace("----------");
			//trace(ma,mb,mc,0);
			//trace(md,me,mf,0);
			//trace(mg,mh,mi,0);
			//trace(mtx,mty,mtz,1);
			//trace("----------");
			
			tranParam1=c*e*o.x+a*f*o.y+a*e*focalLength-c*d*o.y-b*f*o.x-b*d*focalLength;
			tranParam2=b*f-c*e;
			tranParam3=c*d-a*f;
			tranParam4=f*ty*o.x+d*focalLength*o.y+d*tz*o.y+d*focalLength*ty-f*tx*o.y-e*focalLength*o.x-e*tz*o.x-e*focalLength*tx;
			tranParam5=e*focalLength+e*tz-f*ty;
			tranParam6=f*tx-d*focalLength-d*tz;
			tranParam7=c*ty*o.x+a*focalLength*o.y+a*tz*o.y+a*focalLength*ty-c*tx*o.y-b*focalLength*o.x-b*tz*o.x-b*focalLength*tx;
			tranParam8=b*focalLength+b*tz-c*ty;
			tranParam9=c*tx-a*focalLength-a*tz;
			
			var tranParamKK:Number=tranParam1+tranParam2*center.x+tranParam3*center.y;
			cc.x=(tranParam4+tranParam5*center.x+tranParam6*center.y)/tranParamKK;
			cc.y=(tranParam7+tranParam8*center.x+tranParam9*center.y)/-tranParamKK;
			
			//var tranParamKK:Number=tranParam1+tranParam2*x3+tranParam3*y3;
			//x1=(tranParam4+tranParam5*x3+tranParam6*y3)/tranParamKK
			//y1=(tranParam7+tranParam8*x3+tranParam9*y3)/-tranParamKK
			//trace(x1,y1);
			//trace("===================");
			
			//=============================================================================================
			//m.invert();
			//a=m.rawData[0];b=m.rawData[1];c=m.rawData[2];
			//d=m.rawData[4];e=m.rawData[5];f=m.rawData[6];
			//g=m.rawData[8];h=m.rawData[9];i=m.rawData[10];
			//tx=m.rawData[12];ty=m.rawData[13];tz=m.rawData[14];
			
			//通过 x1,y1,z1(其实=0)，mT 求 x3,y3：
			//p1=p2*mT;
			//p2*fL=p3*(fl+z2);
			//x1=x2*a+y2*d+z2*g+tx;
			//y1=x2*b+y2*e+z2*h+ty;
			//z1=x2*c+y2*f+z2*i+tz;
			//x3=x2*focalLength/(focalLength+z2);
			//y3=y2*focalLength/(focalLength+z2);
			//x3+=o.x;
			//y3+=o.y;
			
			//通过 x3,y3 求 x1,y1：
			//x1=x2*a+y2*d+z2*g+tx;
			//y1=x2*b+y2*e+z2*h+ty;
			//0=x2*c+y2*f+z2*i+tz;
			//x3=x2*focalLength/(focalLength+z2)+xo;
			//y3=y2*focalLength/(focalLength+z2)+yo;
			
		}
		xml.constFuns[0].appendChild(<updateTransform description="获取变换参数"/>);
		
		protected var o:Float2=new Float2(0,0);
		xml.constParams[0].appendChild(<o description="图片中心"/>);
		protected var ma:Number;
		xml.constParams[0].appendChild(<ma description="变换参数 ma"/>);
		protected var mb:Number;
		xml.constParams[0].appendChild(<mb description="变换参数 mb"/>);
		protected var mc:Number;
		xml.constParams[0].appendChild(<mc description="变换参数 mc"/>);
		protected var md:Number;
		xml.constParams[0].appendChild(<md description="变换参数 md"/>);
		protected var me:Number;
		xml.constParams[0].appendChild(<me description="变换参数 me"/>);
		protected var mf:Number;
		xml.constParams[0].appendChild(<mf description="变换参数 mf"/>);
		protected var mg:Number;
		xml.constParams[0].appendChild(<mg description="变换参数 mg"/>);
		protected var mh:Number;
		xml.constParams[0].appendChild(<mh description="变换参数 mh"/>);
		protected var mi:Number;
		xml.constParams[0].appendChild(<mi description="变换参数 mi"/>);
		protected var mtx:Number;
		xml.constParams[0].appendChild(<mtx description="变换参数 mtx"/>);
		protected var mty:Number;
		xml.constParams[0].appendChild(<mty description="变换参数 mty"/>);
		protected var mtz:Number;
		xml.constParams[0].appendChild(<mtz description="变换参数 mtz"/>);
		
		protected var tranParam1:Number;
		xml.constParams[0].appendChild(<tranParam1 description="变换参数 tranParam1"/>);
		protected var tranParam2:Number;
		xml.constParams[0].appendChild(<tranParam2 description="变换参数 tranParam2"/>);
		protected var tranParam3:Number;
		xml.constParams[0].appendChild(<tranParam3 description="变换参数 tranParam3"/>);
		protected var tranParam4:Number;
		xml.constParams[0].appendChild(<tranParam4 description="变换参数 tranParam4"/>);
		protected var tranParam5:Number;
		xml.constParams[0].appendChild(<tranParam5 description="变换参数 tranParam5"/>);
		protected var tranParam6:Number;
		xml.constParams[0].appendChild(<tranParam6 description="变换参数 tranParam6"/>);
		protected var tranParam7:Number;
		xml.constParams[0].appendChild(<tranParam7 description="变换参数 tranParam7"/>);
		protected var tranParam8:Number;
		xml.constParams[0].appendChild(<tranParam8 description="变换参数 tranParam8"/>);
		protected var tranParam9:Number;
		xml.constParams[0].appendChild(<tranParam9 description="变换参数 tranParam9"/>);
		
		protected var cc:Float2=new Float2(0,0);
		xml.constParams[0].appendChild(<cc description="center 经过变换后对应到的取样点"/>);
		
		public var ran_size:int=16;
		xml.params[0].appendChild(<ran_size description="随机数组 ran 的长度的平方根" minValue="1" maxValue="256" inputName="ran"/>);
		
		protected function get ran():Vector.<Number>{
			return getRanInput(ran_size*ran_size);
		}
		
		public function AS3BaseShader(_description:String){
			xml.@description=_description;
			src=new Image4(null);
			oc=new Float2(0,0);
			srcSize=new Float2(0,0);
		}
		protected function initNullParams():void{//对可能为null的某些值赋一个初始值
			var i:int=-1;
			for each(var type:Class in shader["constructor"].typeV){
				i++;
				var name:String=shader["constructor"].nameV[i];
				switch(type){
					case Float2:
						if(this[name]){
						}else{
							//对任何未赋值的 Float2 ，设置默认值为图片中心
							this[name]=new Float2(srcSize.x*0.5,srcSize.y*0.5);
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
		
		private var intervalId:int;
		private var outputBmd:BitmapData;
		private var stepId:int;
		public function stopRenderBmp():void{
			clearInterval(intervalId);
		}
		public function renderBmp(bmp:Bitmap,bmd:BitmapData,paramArr:Array):void{
			
			stopRenderBmp();
			
			src.bmd=bmd;
			
			for each(var subArr:Array in paramArr){
				this[subArr[0]]=subArr[1];
			}
			
			srcSize.x=bmd.width;
			srcSize.y=bmd.height;
			
			initNullParams();
			
			updateParams();
			
			bmp.bitmapData=outputBmd=bmd.clone();
			outputBmd.fillRect(outputBmd.rect,0x00000000);
			
			stepId=-1;
			
			//center.x=int(center.x);
			//center.y=int(center.y);
			//trace("renderBmp，center="+center);
			
			intervalId=setInterval(renderStep,30);
			renderStep();
		}
		private function renderStep():void{
			var t:int=getTimer();
			while(getTimer()-t<30){
				stepId++;
				var y:int=int(stepId/src.bmd.width);
				if(y<src.bmd.height){
					var x:int=stepId%src.bmd.width;
					oc.x=x;
					oc.y=y;
					dst=null;
					evaluatePixel();
					outputBmd.setPixel32(x,y,(int(dst.a*0xff)<<24)|(int(dst.r*0xff)<<16)|(int(dst.g*0xff)<<8)|int(dst.b*0xff));
				}else{
					stopRenderBmp();
					break;
				}
			}
			//trace("y="+y);
			//trace("耗时："+(getTimer()-t)+" 毫秒");
		}
		
		protected function updateParams():void{}
		protected function evaluatePixel():void{}
		
		protected function outCoord():Float2{
			return oc;
		}
		
		protected static function sampleNearest(img:*,p:Float2):*{
			switch(img.constructor){
				case Image4:
					var color:uint=(img as Image4).bmd.getPixel32(p.x,p.y);
					return new Pixel4(
						((color>>16)&0xff)/0xff,
						((color>>8)&0xff)/0xff,
						(color&0xff)/0xff,
						((color>>24)&0xff)/0xff
					);
				break;
			}
			throw new Error("暂不支持的 img："+img);
		}
		protected static function sample(img:*,p:Float2):*{
			switch(img.constructor){
				case Vector.<Number>:
					return img[Math.sqrt(img.length)*p.y+p.x];
				break;
			}
			throw new Error("暂不支持的 img："+img);
		}
		
		protected static function dot(x:*,y:*):Number{
			switch(x.constructor){
				case Number:
					switch(y.constructor){
						case Number:
							return x.x*y.x+x.y*y.y;
						break;
					}
				break;
				case Float2:
					switch(y.constructor){
						case Float2:
							return x.x*y.x+x.y*y.y;
						break;
					}
				break;
				case Float3:
					switch(y.constructor){
						case Float3:
							return x.x*y.x+x.y*y.y+x.z*y.z;
						break;
					}
				break;
				//case Pixel4:
				//	switch(y.constructor){
				//		case Pixel4:
				//			return x.r*y.r+x.g*y.g+x.b*y.b+x.a+y.a;
				//		break;
				//	}
				//break;
			}
			throw new Error("暂不支持的 x 或 y："+x+"，"+y);
		}
		
		protected static function float4(a:Number,r:Number,g:Number,b:Number):Pixel4{
			return new Pixel4(a,r,g,b);
		}
		
		protected static function distance(p1:Float2,p2:Float2):Number{
			var dx:Number=p2.x-p1.x;
			var dy:Number=p2.y-p1.y;
			return Math.sqrt(dx*dx+dy*dy);
		}
		protected static function length(p:Float2):Number{
			return Math.sqrt(p.x*p.x+p.y*p.y);
		}
		protected static function normalize(p:*):*{
			switch(p.constructor){
				case Float2:
					var len:Number=Math.sqrt(p.x*p.x+p.y*p.y);
					return new Float2(p.x/len,p.y/len);
				break;
				case Float3:
					len=Math.sqrt(p.x*p.x+p.y*p.y+p.z*p.z);
					return new Float3(p.x/len,p.y/len,p.z/len);
				break;
			}
		}
		
		protected static function mod(value1:*,value2:*):*{
			//return x%y;和 pixel bender 里的不一致
			switch(value1.constructor){
				case Float2:
					switch(value2.constructor){
						case Number:
							return new Float2(value1.x-value2*Math.floor(value1.x/value2),value1.y-value2*Math.floor(value1.y/value2));
						break;
					}
				break;
				case Number:
					switch(value2.constructor){
						case Number:
							return value1-value2*Math.floor(value1/value2);
						break;
					}
				break;
			}
			throw new Error("暂不支持的 value1 或 value2："+value1+"，"+value2);
		}
		
		protected static function step(x:Number,y:Number):Number{
			//If y < x, returns 0.0, otherwise returns 1.0
			return y<x?0:1;
		}
		
		protected static function clamp(x:*,minval:Number,maxval:Number):*{
			//If x<minval, returns minval If x>maxval, returns maxval otherwise returns x.
			
			switch(x.constructor){
				case Number:
					if(x<minval){
						return minval;
					}
					if(x>maxval){
						return maxval;
					}
					return x;
				break;
				case Pixel4:
					var r:Number=x.r;
					if(r<minval){
						r=minval;
					}
					if(r>maxval){
						r=maxval;
					}
					var g:Number=x.g;
					if(g<minval){
						g=minval;
					}
					if(g>maxval){
						g=maxval;
					}
					var b:Number=x.b;
					if(b<minval){
						b=minval;
					}
					if(b>maxval){
						b=maxval;
					}
					var a:Number=x.a;
					if(a<minval){
						a=minval;
					}
					if(a>maxval){
						a=maxval;
					}
					return new Pixel4(r,g,b,a);
				break;
			}
			throw new Error("暂不支持的 x："+x);
		}
		
		protected static function mix(x:*,y:*,a:Number):*{
			//Returns x * (1.0 - a) +y * a (that is, a linear interpolation between x and y).
			switch(x.constructor){
				case Number:
					switch(y.constructor){
						case Number:
							return x * (1.0 - a) +y * a;
						break;
					}
				break;
				case Pixel4:
					switch(y.constructor){
						case Pixel4:
							return new Pixel4(x.r * (1.0 - a) +y.r * a,x.g * (1.0 - a) +y.g * a,x.b * (1.0 - a) +y.b * a,x.a * (1.0 - a) +y.a * a);
						break;
					}
				break;
			}
			throw new Error("暂不支持的 x 或 y："+x+"，"+y);
		}
		
		protected static function smoothStep(edge0:Number,edge1:Number,x:*):*{
			//If x <= edge0, returns 0 If x >= edge1, returns 1, otherwise performs smooth hermite interpolation.
			switch(x.constructor){
				case Number:
					if(x<=edge0){
						return 0;
					}
					if(x>=edge1){
						return 1;
					}
					return (x-edge0)/(edge1-edge0);
				break;
				case Pixel4:
					var r:Number=x.r;
					if(r<=edge0){
						r=0;
					}
					if(r>=edge1){
						r=1;
					}
					var g:Number=x.g;
					if(g<=edge0){
						g=0;
					}
					if(g>=edge1){
						g=1;
					}
					var b:Number=x.b;
					if(b<=edge0){
						b=0;
					}
					if(b>=edge1){
						b=1;
					}
					var a:Number=x.a;
					if(a<=edge0){
						a=0;
					}
					if(a>=edge1){
						a=1;
					}
					return new Pixel4(r,g,b,a);
				break;
			}
			throw new Error("暂不支持的 x："+x);
			
		}
		
		protected static function xOr(b1:Boolean,b2:Boolean):Boolean{
			if(b1){
				if(b2){
				}else{
					return true;
				}
			}else{
				if(b2){
					return true;
				}
			}
			return false;
		}
		
		protected static function add(value1:*,value2:*):*{
			switch(value1.constructor){
				case Number:
					switch(value2.constructor){
						case Float2:
							return new Float2(value1+value2.x,value1+value2.y);
						break;
					}
				break;
				case Float2:
					switch(value2.constructor){
						case Float2:
							return new Float2(value1.x+value2.x,value1.y+value2.y);
						break;
						case Number:
							return new Float2(value1.x+value2,value1.y+value2);
						break;
					}
				break;
				case Float3:
					switch(value2.constructor){
						case Float3:
							return new Float3(value1.x+value2.x,value1.y+value2.y,value1.z+value2.z);
						break;
					}
				break;
				case Pixel4:
					switch(value2.constructor){
						case Pixel4:
							return new Pixel4(value1.r+value2.r,value1.g+value2.g,value1.b+value2.b,value1.a+value2.a);
						break;
					}
				break;
			}
			throw new Error("暂不支持的 value1 或 value2："+value1+"，"+value2);
		}
		protected static function subtract(value1:*,value2:*):*{
			switch(value1.constructor){
				case Float2:
					switch(value2.constructor){
						case Number:
							return new Float2(value1.x-value2,value1.y-value2);
						break;
						case Float2:
							return new Float2(value1.x-value2.x,value1.y-value2.y);
						break;
					}
				break;
				case Pixel4:
					switch(value2.constructor){
						case Pixel4:
							return new Pixel4(value1.r-value2.r,value1.g-value2.g,value1.b-value2.b,value1.a-value2.a);
						break;
					}
				break;
			}
			throw new Error("暂不支持的 value1 或 value2："+value1+"，"+value2);
		}
		protected static function multiply(value1:*,value2:*):*{
			switch(value1.constructor){
				case Number:
					switch(value2.constructor){
						case Float2:
							return new Float2(value1*value2.x,value1*value2.y);
						break;
						case Float3:
							return new Float3(value1*value2.x,value1*value2.y,value1*value2.z);
						break;
						case Pixel4:
							return new Pixel4(value1*value2.r,value1*value2.g,value1*value2.b,value1*value2.a);
						break;
					}
				break;
				case Float2:
					switch(value2.constructor){
						case Number:
							return new Float2(value1.x*value2,value1.y*value2);
						break;
						case Float2:
							return new Float2(value1.x*value2.x,value1.y*value2.y);
						break;
					}
				break;
				case Pixel4:
					switch(value2.constructor){
						case Number:
							return new Pixel4(value1.r*value2,value1.g*value2,value1.b*value2,value1.a*value2);
						break;
						case Pixel4:
							return new Pixel4(value1.r*value2.r,value1.g*value2.g,value1.b*value2.b,value1.a*value2.a);
						break;
					}
				break;
			}
			throw new Error("暂不支持的 value1 或 value2："+value1+"，"+value2);
		}
		protected static function divide(value1:*,value2:*):*{
			switch(value1.constructor){
				case Float2:
					switch(value2.constructor){
						case Number:
							return new Float2(value1.x/value2,value1.y/value2);
						break;
						case Float2:
							return new Float2(value1.x/value2.x,value1.y/value2.y);
						break;
					}
				break;
				case Pixel4:
					switch(value2.constructor){
						case Number:
							return new Pixel4(value1.r/value2,value1.g/value2,value1.b/value2,value1.a/value2);
						break;
					}
				break;
			}
			throw new Error("暂不支持的 value1 或 value2："+value1+"，"+value2);
		}
	}
}