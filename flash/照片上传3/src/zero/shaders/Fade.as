/***
Fade
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月02日 17:45:45
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders{
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.ShaderFilter;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	public class Fade{
		
		/**
		 * 为避免有时获取 dspObj.filters 时flash创作工具崩溃，只对渐变对象使用单一滤镜
		 */		
		public static var useSingleFilter:Boolean=true;
		
		private static const enterFrameFadeV:Vector.<Fade>=new Vector.<Fade>();
		private static const intervalFadeV:Vector.<Fade>=new Vector.<Fade>();
		
		private static var enterFrameObj:Shape;
		private static var intervalId:int;
		
		public static function from(_dspObjOrBmd:*,_duration:Number,_shaderClass:Class,_vars:Object):Fade{
			return new Fade(_dspObjOrBmd,_duration,_shaderClass,_vars,null);
		}
		public static function to(_dspObjOrBmd:*,_duration:Number,_shaderClass:Class,_vars:Object):Fade{
			return new Fade(_dspObjOrBmd,_duration,_shaderClass,null,_vars);
		}
		public static function fromTo(_dspObjOrBmd:*,_duration:Number,_shaderClass:Class,_fromVars:Object,_toVars:Object):Fade{
			return new Fade(_dspObjOrBmd,_duration,_shaderClass,_fromVars,_toVars);
		}
		public static function stop(_dspObjOrBmd:*):void{
			for each(var fade:Fade in enterFrameFadeV.concat(intervalFadeV)){
				if(fade){
					if(
						fade.dspObj==_dspObjOrBmd
						||
						fade.bmd==_dspObjOrBmd
					){
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
		
		private var dspObj:DisplayObject;
		
		private var bmd:BitmapData;
		
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
		
		private var filterArr:Array;
		
		private var bmd0:BitmapData;
		
		private var shaderFilter:ShaderFilter;
		private var shaderClass:Class;
		
		public function Fade(_dspObjOrBmd:*,_duration:Number,_shaderClass:Class,_fromVars:Object,_toVars:Object){
			
			if(_dspObjOrBmd){
			}else{
				throw new Error("不能渐变空对象："+_dspObjOrBmd);
			}
			if(_dspObjOrBmd is BitmapData){
				bmd=_dspObjOrBmd;
			}else if(_dspObjOrBmd is DisplayObject){
				dspObj=_dspObjOrBmd;
			}else{
				throw new Error("不支持的渐变对象："+_dspObjOrBmd);
			}
			
			if(_duration>=0){
			}else{
				throw new Error("不合法的 _duration："+_duration);
			}
			
			if(_shaderClass){
				shaderClass=_shaderClass;
			}else{
				throw new Error("_shaderClass 不能为空："+_shaderClass);
			}
			
			if(_fromVars||_toVars){
			}else{
				throw new Error("_fromVars 和 _toVars 不能同时为空："+_fromVars+"，"+_toVars);
			}
			
			for each(var fade:Fade in enterFrameFadeV.concat(intervalFadeV)){
				if(fade){
					if(
						fade.dspObj==_dspObjOrBmd
						||
						fade.bmd==_dspObjOrBmd
					){
						fade.clear();
						break;
					}
				}
			}
			
			//trace("filterArr="+filterArr);
			
			if(bmd){
				bmd0=bmd.clone();
				shaderFilter=new ShaderFilter(new _shaderClass());
			}else if(dspObj){
				shaderFilter=removeFilter()||new ShaderFilter(new _shaderClass());
				filterArr.push(shaderFilter);
			}
			
			vars=new Object();
			for each(var name:String in _shaderClass.nameV){
				vars[name]=[shaderFilter.shader[name],shaderFilter.shader[name]];
			}
			ease=0;
			delay=0;
			getVars(_fromVars,_shaderClass.nameV,0);
			getVars(_toVars,_shaderClass.nameV,1);
			//for each(name in _shaderClass.nameV){
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
			if(shaderFilter){
				for each(var name:String in shaderClass.nameV){
					//trace(name+"="+shaderFilter.shader[name]);
					delete vars[name];
				}
				shaderFilter=null;
			}
			//trace("===-----------------------------===");
			if(dspObj){
				if(autoRemoveFilter){
					removeFilter();
				}
				//trace("dspObj.filters="+dspObj.filters);
				dspObj=null;
			}
			if(bmd){
				bmd=null;
			}
			if(filterArr){
				filterArr.length=0;
				filterArr=null;
			}
			if(bmd0){
				bmd0.dispose();
				bmd0=null;
			}
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
			shaderClass=null;
			shaderFilter=null;
		}
		private function removeFilter():ShaderFilter{
			if(useSingleFilter){
				filterArr=new Array();
			}else{
				try{
					filterArr=dspObj.filters;
					//try 都无法避免
					//flash cs6：FlashPro encountered a fatal exception...
					//flash cs5.5："0x3038f963" 指令引用的 "0x3a3a73c1" 内存。该内存不能为 "read"。...
				}catch(e:Error){
					trace("e="+e);
					//ArgumentError: Error #2171: Shader 对象不包含任何要执行的字节代码。
					//仅调试时发生
					filterArr=new Array();
				}
			}
			var i:int=filterArr.length;
			while(--i>=0){
				var _shaderFilter:ShaderFilter=filterArr[i] as ShaderFilter;
				if(_shaderFilter){
					if(_shaderFilter.shader){
						if(_shaderFilter.shader["toString"]()=="[object Object]"){
							trace("_shaderFilter.shader="+_shaderFilter.shader);
							//仅调试时发生
							filterArr.splice(i,1);
						}else if(_shaderFilter.shader["constructor"]==shaderClass){
							trace("删除滤镜："+_shaderFilter);
							filterArr.splice(i,1);
							dspObj.filters=filterArr;
							return _shaderFilter;
						}else{
							trace("_shaderFilter.shader="+_shaderFilter.shader);
						}
					}else{
						trace("_shaderFilter.shader="+_shaderFilter.shader);
						//仅调试时发生
						filterArr.splice(i,1);
					}
				}
			}
			dspObj.filters=filterArr;
			return null;
		}
		private function updateParamValues(k:Number):void{
			//trace("k="+k);
			if(k==0||k==1){
			}else{
				if(ease){
					k+=k*(1-k)*ease*0.01;
				}
			}
			
			(shaderFilter.shader as BaseShader).initNullParams();
			
			var i:int=-1;
			for each(var name:String in shaderClass.nameV){
				i++;
				var arr:Array=vars[name];
				switch(shaderClass.typeV[i]){
					case Boolean:
						shaderFilter.shader[name]=k==1?arr[1]:arr[0]
					break;
					case Float2:
						var srcSize:Float2=(shaderFilter.shader as BaseShader).srcSize;
						if(arr[0]){
							var x0:Number=arr[0].x;
							var y0:Number=arr[0].y;
						}else{
							x0=srcSize.x*0.5;
							y0=srcSize.y*0.5;
						}
						if(arr[1]){
							var x1:Number=arr[1].x;
							var y1:Number=arr[1].y;
						}else{
							x1=srcSize.x*0.5;
							y1=srcSize.y*0.5;
						}
						shaderFilter.shader[name].x=x0+(x1-x0)*k;
						shaderFilter.shader[name].y=y0+(y1-y0)*k;
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
						shaderFilter.shader[name].r=r0+(r1-r0)*k;
						shaderFilter.shader[name].g=g0+(g1-g0)*k;
						shaderFilter.shader[name].b=b0+(b1-b0)*k;
						shaderFilter.shader[name].a=a0+(a1-a0)*k;
					break;
					default:
						shaderFilter.shader[name]=arr[0]+(arr[1]-arr[0])*k;
					break;
				}
			}
			
			(shaderFilter.shader as BaseShader).updateParams();
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
			
			(shaderFilter.shader as BaseShader).updateSrcSize(dspObj||bmd);
			
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
			
			//for each(var name:String in shaderClass.nameV){
			//	trace(name+"="+shaderFilter.shader[name]);
			//}
			//trace("-----------------------------------");
			
			if(dspObj){
				dspObj.filters=filterArr;
			}else if(bmd){
				bmd.applyFilter(bmd0,bmd0.rect,new Point(),shaderFilter);
			}
			
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
						onUpdate(dspObj||bmd);
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
						onComplete(dspObj||bmd);
					break;
				}
			}
			clear();
		}
	}
}