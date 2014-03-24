/***
Fade
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月11日 20:19:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds{
	import flash.display.*;
	import flash.display3D.*;
	import flash.display3D.textures.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import zero.shaders.Float2;
	import zero.shaders.Pixel4;
	
	public class Fade{
		
		private static const vertexProgram:ByteArray=getProgramByByteV(0xa0,0x01,0x00,0x00,0x00,0xa1,0x00,0x18,0x00,0x00,0x00,0x00,0x00,0x0f,0x03,0x00,0x00,0x00,0xe4,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xe4,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0f,0x04,0x01,0x00,0x00,0xe4,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00);
		//private static const vertexProgram:ByteArray=AGAL2Program(
		//	Context3DProgramType.VERTEX,//顶点着色器
		//	
		//	"m44 op, va0, vc0\n" + 
		//	//可理解为：op=vc0.transformVector(va0)
		//	//vc<n>，用于顶点着色器的常量寄存器，vc0 在这里就是 stage3D.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,new Matrix3D(),true); 中的 new Matrix()
		//	//va<n>，用于顶点着色器的属性寄存器，va0 在这里就是 stage3D.context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3); 中的 vertexBuffer 的 xyz 们
		//	//op，用于顶点着色器的输出寄存器
		//	
		//	"mov v0, va1"
		//	//可理解为：v0=va1
		//	//va1 在这里就是 stage3D.context3D.setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2); 中的 vertexBuffer 的 uv 们
		//	//v<n>，变寄存器，用来从顶点着色器传递数据到像素着色器，以这种方式获取传递的典型数据是顶点颜色，或 纹理UV 坐标。
		//);
		
		private static var stage3D:Stage3D;
		private static var onInitComplete:Function;
		private static var onInitError:Function;
		
		private static var oldWid:int;
		private static var oldHei:int;
		
		private static var vertexBuffer:VertexBuffer3D;
		private static var indexBuffer:IndexBuffer3D;
		private static var texture:Texture;
		private static var program:Program3D;
		
		private static var fade:Fade;
		public static var ready:Boolean;
		
		private static const vertices:Vector.<Number>=new <Number>[
			//x,y,u,v
			-1,1,0,0,//左上角
			1,1,0,0,//右上角
			1,-1,0,0,//右下角
			-1,-1,0,0//左下角
		];
		private static const indices:Vector.<uint>=new <uint>[0,1,2,2,3,0];
		
		public static function init(_stage3D:Stage3D,_onInitComplete:Function,_onInitError:Function):void{
			
			clear();
			
			if(_stage3D){
			}else{
				throw new Error("_stage3D="+_stage3D);
				return;
			}
			
			stage3D=_stage3D;
			onInitComplete=_onInitComplete;
			onInitError=_onInitError;
			//trace("stage3D="+stage3D);
			stage3D.addEventListener(Event.CONTEXT3D_CREATE,createContext3D);
			stage3D.addEventListener(ErrorEvent.ERROR,initError);
			stage3D.requestContext3D();
		}
		private static function initError(...args):void{
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE,createContext3D);
			stage3D.removeEventListener(ErrorEvent.ERROR,initError);
			trace("initError");
			var _onInitError:Function=onInitError;
			clear();
			if(_onInitError==null){
			}else{
				_onInitError();
			}
		}
		public static function clear():void{
			ready=false;
			oldWid=-1;
			oldHei=-1;
			if(stage3D){
				stage3D.removeEventListener(Event.CONTEXT3D_CREATE,createContext3D);
				stage3D.removeEventListener(ErrorEvent.ERROR,initError);
				if(stage3D.context3D){
					stage3D.context3D.dispose();
				}
				stage3D=null;
			}
			if(vertexBuffer){
				vertexBuffer.dispose();
				vertexBuffer=null;
			}
			if(indexBuffer){
				indexBuffer.dispose();
				indexBuffer=null;
			}
			if(texture){
				texture.dispose();
				texture=null;
			}
			if(program){
				program.dispose();
				program=null;
			}
			fade=null;
			onInitComplete=null;
			onInitError=null;
		}
		private static function createContext3D(...args):void{
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE,createContext3D);
			stage3D.removeEventListener(ErrorEvent.ERROR,initError);
			stage3D.context3D.enableErrorChecking=true;
			trace("stage3D.context3D.driverInfo="+stage3D.context3D.driverInfo);
			ready=true;
			
			indexBuffer=stage3D.context3D.createIndexBuffer(6);
			indexBuffer.uploadFromVector(indices,0,6);
			
			stage3D.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,new Matrix3D(),true);
			
			if(onInitComplete==null){
			}else{
				onInitComplete();
				onInitComplete=null;
			}
			onInitError=null;
		}
		private static function update(_fade:Fade):void{
			if(fade==_fade){
			}else{
				fade=_fade;
				//trace("initFade fade="+fade);
				
				if(vertexBuffer){
					vertexBuffer.dispose();
				}
				if(texture){
					texture.dispose();
				}
				if(program){
					program.dispose();
				}
				
				if(oldWid==fade.effect.bmd.width&&oldHei==fade.effect.bmd.height){
					
				}else{
					stage3D.context3D.configureBackBuffer(fade.effect.bmd.width,fade.effect.bmd.height,0,false);trace("配置缓冲区是一个缓慢的操作。在正常渲染操作期间，请避免更改缓冲区大小或属性。");
					
					vertices[2]=vertices[14]=Xiuzhengs.d/fade.effect.uploadBmd.width;
					vertices[3]=vertices[7]=Xiuzhengs.d/fade.effect.uploadBmd.height;
					vertices[6]=vertices[10]=(Xiuzhengs.d+fade.effect.bmd.width)/fade.effect.uploadBmd.width;
					vertices[11]=vertices[15]=(Xiuzhengs.d+fade.effect.bmd.height)/fade.effect.uploadBmd.height;
					
					//trace("vertices="+vertices.toString().replace(/(([^,]+,){4})/g,"$1\n"));
					//trace("indices="+indices.toString().replace(/(([^,]+,){6})/g,"$1\n"));
					
					vertexBuffer=stage3D.context3D.createVertexBuffer(4,4);
					vertexBuffer.uploadFromVector(vertices,0,4);
					
					stage3D.context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_2);
					stage3D.context3D.setVertexBufferAt(1,vertexBuffer,2,Context3DVertexBufferFormat.FLOAT_2);
					
					oldWid=fade.effect.bmd.width;
					oldHei=fade.effect.bmd.height;
				}
				
				texture=stage3D.context3D.createTexture(fade.effect.uploadBmd.width,fade.effect.uploadBmd.height,Context3DTextureFormat.BGRA,false);
				texture.uploadFromBitmapData(fade.effect.uploadBmd);
				stage3D.context3D.setTextureAt(0,texture);
				
				program=stage3D.context3D.createProgram();
				program.upload(vertexProgram,fade.effect["constructor"].fragmentProgram);
				stage3D.context3D.setProgram(program);
			}
			
			stage3D.context3D.clear();
			fade.effect.updateParams();
			var data:Vector.<Number>=fade.effect["constructor"].data;
			if(data&&data.length){
				if(data.length%4==0){
					stage3D.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,data);
				}else{
					throw new Error("data.length="+data.length+" 不是 4 的倍数");
				}
			}
			stage3D.context3D.drawTriangles(indexBuffer);
			if(fade.outputBmd){
				stage3D.context3D.drawToBitmapData(fade.outputBmd);
			}else{
				stage3D.context3D.present();
			}
		
		}
		
		private static const enterFrameFadeV:Vector.<Fade>=new Vector.<Fade>();
		private static const intervalFadeV:Vector.<Fade>=new Vector.<Fade>();
		
		private static var enterFrameObj:Shape;
		private static var intervalId:int;
		
		/**
		 * 
		 * _outputBmd 设置为 null 可避免调用 drawToBitmapData()（直接渲染至 stage3D，可能可提高性能？） 
		 * 
		 */		
		public static function from(_bmd:BitmapData,_outputBmd:BitmapData,_duration:Number,_effectClass:Class,_vars:Object):Fade{
			if(ready){
			}else{
				throw new Error("请先执行 init() 并等待 initComplete");
			}
			return new Fade(_bmd,_outputBmd,_duration,_effectClass,_vars,null);
		}
		
		/**
		 * 
		 * _outputBmd 设置为 null 可避免调用 drawToBitmapData()（直接渲染至 stage3D，可能可提高性能？） 
		 * 
		 */		
		public static function to(_bmd:BitmapData,_outputBmd:BitmapData,_duration:Number,_effectClass:Class,_vars:Object):Fade{
			if(ready){
			}else{
				throw new Error("请先执行 init() 并等待 initComplete");
			}
			return new Fade(_bmd,_outputBmd,_duration,_effectClass,null,_vars);
		}
		
		/**
		 * 
		 * _outputBmd 设置为 null 可避免调用 drawToBitmapData()（直接渲染至 stage3D，可能可提高性能？） 
		 * 
		 */		
		public static function fromTo(_bmd:BitmapData,_outputBmd:BitmapData,_duration:Number,_effectClass:Class,_fromVars:Object,_toVars:Object):Fade{
			if(ready){
			}else{
				throw new Error("请先执行 init() 并等待 initComplete");
			}
			return new Fade(_bmd,_outputBmd,_duration,_effectClass,_fromVars,_toVars);
		}
		
		public static function stop(_bmd:BitmapData):void{
			for each(var fade:Fade in enterFrameFadeV.concat(intervalFadeV)){
				if(fade){
					if(fade.effect.bmd==_bmd){
						fade.clear();
					}
				}
			}
		}
		private static function enterFrame(...args):void{
			for each(var fade:Fade in enterFrameFadeV){
				if(fade){
					fade.step(false);
				}
			}
			var i:int=enterFrameFadeV.length;
			while(--i>=0){
				if(enterFrameFadeV[i]){
				}else{
					enterFrameFadeV.splice(i,1);
				}
			}
			//trace("enterFrameFadeV.length="+enterFrameFadeV.length);
			if(enterFrameFadeV.length){
			}else{
				enterFrameObj.removeEventListener(Event.ENTER_FRAME,enterFrame);
			}
		}
		private static function interval():void{
			for each(var fade:Fade in intervalFadeV){
				if(fade){
					fade.step(false);
				}
			}
			var i:int=intervalFadeV.length;
			while(--i>=0){
				if(intervalFadeV[i]){
				}else{
					intervalFadeV.splice(i,1);
				}
			}
			//trace("intervalFadeV.length="+intervalFadeV.length);
			if(intervalFadeV.length){
			}else{
				clearInterval(intervalId);
				intervalId=-1;
			}
		}
		
		private var outputBmd:BitmapData;
		
		private var stepId:int;
		
		private var useFrames:Boolean;
		private var ease:Number;//-100~100
		private var delay:int;
		private var autoRemoveFilter:Boolean;
		private var onUpdate:Function;
		private var onComplete:Function;
		
		private var time:int;
		private var startTime:int;
		
		private var vars:Object;
		
		private var effect:BaseEffect;
		
		public function Fade(_bmd:BitmapData,_outputBmd:BitmapData,_duration:Number,_effectClass:Class,_fromVars:Object,_toVars:Object){
			if(ready){
			}else{
				throw new Error("请先执行 init() 并等待 initComplete");
			}
			
			if(_bmd){
			}else{
				throw new Error("不能渐变空对象："+_bmd);
			}
			
			if(_outputBmd){
			}else{
				throw new Error("_outputBmd="+_outputBmd);
			}
			outputBmd=_outputBmd;
			outputBmd.fillRect(outputBmd.rect,0x00000000);
			
			if(_duration>=0){
			}else{
				throw new Error("不合法的 _duration："+_duration);
			}
			
			if(_effectClass){
			}else{
				throw new Error("_effectClass 不能为空："+_effectClass);
			}
			
			if(_fromVars||_toVars){
			}else{
				throw new Error("_fromVars 和 _toVars 不能同时为空："+_fromVars+"，"+_toVars);
			}
			
			for each(var fade:Fade in enterFrameFadeV.concat(intervalFadeV)){
				if(fade){
					if(fade.effect.bmd==_bmd){
						fade.clear();
						break;
					}
				}
			}
			
			effect=new _effectClass();
			effect.bmd=_bmd;
			
			vars=new Object();
			for each(var name:String in _effectClass.nameV){
				vars[name]=[effect[name],effect[name]];
			}
			ease=0;
			delay=0;
			getVars(_fromVars,_effectClass.nameV,0);
			getVars(_toVars,_effectClass.nameV,1);
			//for each(name in _effectClass.nameV){
			//	trace(name+"="+vars[name][0]+"~"+vars[name][1]);
			//}
			//trace("+++-----------------------------+++");
			
			if(useFrames){
				if(delay>0){
					delay/=1000;
				}
				time=_duration;
				enterFrameFadeV.push(this);
				if(enterFrameObj){
				}else{
					enterFrameObj=new Shape();
				}
				if(enterFrameObj.hasEventListener(Event.ENTER_FRAME)){
				}else{
					enterFrameObj.addEventListener(Event.ENTER_FRAME,enterFrame);
				}
			}else{
				time=int(_duration*1000);
				intervalFadeV.push(this);
				if(intervalId>0){
				}else{
					intervalId=setInterval(interval,30);
				}
			}
			
			stepId=-1;
			startTime=getTimer();
			
			step(true);
		}
		private function getVars(_vars:Object,nameV:Vector.<String>,id:int):void{
			if(_vars){
				if(_vars.useFrames){
					useFrames=true;
				}
				if(_vars.ease){
					ease=_vars.ease;
				}
				if(_vars.delay>0){
					delay=Math.round(_vars.delay*1000);
				}
				if(_vars.autoRemoveFilter){
					autoRemoveFilter=true;
				}
				if(_vars.onUpdate){
					onUpdate=_vars.onUpdate;
				}
				if(_vars.onComplete){
					onComplete=_vars.onComplete;
				}
				for each(var name:String in nameV){
					if(_vars.hasOwnProperty(name)){
						vars[name][id]=_vars[name];
					}
				}
			}
		}
		public function clear():void{
			if(effect){
				for each(var name:String in effect["constructor"].nameV){
					//trace(name+"="+effect[name]);
					delete vars[name];
				}
				effect.clear();
				effect=null;
			}
			//trace("===-----------------------------===");
			if(useFrames){
				var id:int=enterFrameFadeV.indexOf(this);
				if(id>-1){
					enterFrameFadeV[id]=null;
				}
			}else{
				id=intervalFadeV.indexOf(this);
				if(id>-1){
					intervalFadeV[id]=null;
				}
			}
			onUpdate=null;
			onComplete=null;
		}
		private function updateParamValues(k:Number):void{
			//trace("k="+k);
			if(k==0||k==1){
			}else{
				if(ease){
					k+=k*(1-k)*ease*0.01;
				}
			}
			
			effect.initNullParams();
			
			var i:int=-1;
			for each(var name:String in effect["constructor"].nameV){
				i++;
				var arr:Array=vars[name];
				switch(effect["constructor"].typeV[i]){
					case Boolean:
						effect[name]=k==1?arr[1]:arr[0]
					break;
					case Float2:
						if(arr[0]){
							var x0:Number=arr[0].x;
							var y0:Number=arr[0].y;
						}else{
							x0=effect.bmd.width*0.5;
							y0=effect.bmd.height*0.5;
						}
						if(arr[1]){
							var x1:Number=arr[1].x;
							var y1:Number=arr[1].y;
						}else{
							x1=effect.bmd.width*0.5;
							y1=effect.bmd.height*0.5;
						}
						effect[name].x=x0+(x1-x0)*k;
						effect[name].y=y0+(y1-y0)*k;
					break;
					case Pixel4:
						if(arr[0]){
							var r0:Number=arr[0].r;
							var g0:Number=arr[0].g;
							var b0:Number=arr[0].b;
							var a0:Number=arr[0].a;
						}else{
							r0=0;
							g0=0;
							b0=0;
							a0=1;
						}
						if(arr[1]){
							var r1:Number=arr[1].r;
							var g1:Number=arr[1].g;
							var b1:Number=arr[1].b;
							var a1:Number=arr[1].a;
						}else{
							r1=0;
							g1=0;
							b1=0;
							a1=1;
						}
						effect[name].r=r0+(r1-r0)*k;
						effect[name].g=g0+(g1-g0)*k;
						effect[name].b=b0+(b1-b0)*k;
						effect[name].a=a0+(a1-a0)*k;
					break;
					default:
						effect[name]=arr[0]+(arr[1]-arr[0])*k;
					break;
				}
			}
			
			effect.updateParams();
		}
		private function step(ifDelayRunOne:Boolean):void{
			
			//trace("delay="+delay);
			
			if(delay>0){
				if(useFrames){
					if(--delay>0){//如果 delay 初始为1 那么应该在第一个 enterFrame 时就执行 step()
						if(ifDelayRunOne){
						}else{
							return;
						}
					}
				}else{
					if(delay>getTimer()-startTime){
						if(ifDelayRunOne){
						}else{
							return;
						}
					}
				}
				if(ifDelayRunOne){
				}else{
					delay=-1;
				}
				startTime=getTimer();
			}
			
			stepId++;
			//trace("stepId="+stepId);
			
			if(stepId==0){
				updateParamValues(time>0?0:1);
			}else{
				if(useFrames){
					if(stepId>time){
						stepId=time;
					}
					updateParamValues(time>0?stepId/time:1);
				}else{
					var dTime:int=getTimer()-startTime;
					if(dTime>time){
						dTime=time;
					}
					updateParamValues(time>0?dTime/time:1);
				}
			}
			
			//for each(var name:String in effectClass.nameV){
			//	trace(name+"="+effect[name]);
			//}
			//trace("-----------------------------------");
			
			update(this);
			
			if(ifDelayRunOne){
				if(time>0){//20121214
					return;
				}
			}
			
			if(onUpdate==null){
			}else{
				switch(onUpdate.length){
					case 0:
						onUpdate();
					break;
					case 1:
						onUpdate(effect.bmd);
					break;
				}
			}
			if(useFrames){
				if(stepId<time){
					return;
				}
			}else{
				if(dTime<time){
					return;
				}
			}
			if(onComplete==null){
			}else{
				switch(onComplete.length){
					case 0:
						onComplete();
					break;
					case 1:
						onComplete(effect.bmd);
					break;
				}
			}
			clear();
		}
	}
}