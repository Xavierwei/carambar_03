/***
BaseShader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月26日 10:36:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class BaseShader extends Shader{
		
		/**
		 * 输入图像的宽高 
		 */
		public var srcSize:Float2;
		
		///**
		// * 
		// * 不允许获取 data
		// * 
		// */		
		//override public function get data():ShaderData{
		//	throw new Error("不允许获取 data");
		//}
		
		//public function get description():String{
		//	return super.data.description;
		//}
		
		public function BaseShader(){
			
			var code:ByteArray=this["constructor"].code;
			if(code){
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
					code=new ByteArray();
					var offset:int=0;
					for each(var byte:int in byteV){
						code[offset++]=byte;
					}
				}else{
					code=new (getDefinitionByName(getQualifiedClassName(this)+"Code"))();
				}
			}
			
			super(code);
			
			if(this["constructor"].code){
			}else{
				this["constructor"].code=code;
				//trace("初始化 code，code.length="+code.length);
				
				var nameV:Vector.<String>=this["constructor"].nameV;
				if(nameV){
					nameV.fixed=true;
				}
				
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
				
				var data:ShaderData=super.data;
				
				//前6字节貌似都是 a5 01 00 00 00 a4
				var execResult:Array=/^(.*?)[\.:]+([^\.:]+)$/.exec(getQualifiedClassName(this));
				
				var nameLen:int=code[6]|(code[7]<<8);
				code.position=8;
				name=code.readUTFBytes(nameLen);
				//trace("name="+name);
				if(name==execResult[2]){
				}else{
					throw new Error("name 不一致："+name+"，"+execResult[0]);
				}
				
				if(data.namespace==execResult[1]){
				}else{
					throw new Error("namespace 不一致："+execResult[1]+"，"+execResult[0]);
				}
				
				if(data.version==2){
				}else{
					throw new Error("data.version="+data.version);
				}
				
				offset=8+nameLen;
				var endOffset:int=code.length;
				loop:while(offset<endOffset){
					if(code[offset++]==0xa0){
						
						offset++;
						
						var get_str_size:int=0;
						while(code[offset+(get_str_size++)]){}
						code.position=offset;
						var paramName:String=code.readUTFBytes(get_str_size);
						offset+=get_str_size;
						
						switch(code[offset-get_str_size-1]){
							case 0x0c:
								
								get_str_size=0;
								while(code[offset+(get_str_size++)]){}
								code.position=offset;
								
								switch(paramName){
									case "namespace":
									case "vendor":
									case "description":
										var paramValue:*=code.readMultiByte(get_str_size,"gb2312");
										data[paramName]=paramValue;
									break;
									default:
										//
									break;
								}
								
								offset+=get_str_size;
								
							break;
							case 0x08:
								
								paramValue=code[offset++]|(code[offset++]<<8);
								
								switch(paramName){
									case "version":
										if(data[paramName]==paramValue){
										}else{
											throw new Error(paramName+" 不一致："+paramValue+"，"+data[paramName]);
										}
									break;
									default:
										//
									break;
								}
								
							break;
							default:
								break loop;
							break;
						}
						//trace(paramName+"="+data[paramName]);
					}else{
						break loop;
					}
				}
				//outputParamInfos();
			}
			
			srcSize=new Float2(0,0);
		}
		
		/**
		 *
		 * 输出信息 
		 * 
		 */		
		public function outputParamInfos():void{
			trace("-------------------------------------------");
			for(var paramName:String in data){
				trace(paramName+"="+data[paramName]);
				for(var attName:String in data[paramName]){
					trace(" "+attName+"="+data[paramName][attName]);
				}
			}
			trace("-------------------------------------------");
		}
		
		/**
		 * 
		 * 更新输入图像的宽高，需要显式地从外部传入，例如 shader.updateSrcSize(mc);
		 * 如不传入，将使用 [0,0] 作为默认参数，可能会出现不可预见的问题
		 * 
		 */
		public function updateSrcSize(_dspObjOrBmd:*):void{
			var dspObj:DisplayObject=_dspObjOrBmd  as DisplayObject;
			if(dspObj){
				if(dspObj.stage){
					try{
						var b:Rectangle=dspObj.getBounds(dspObj.stage);
					}catch(e:Error){
						b=null;
					}
				}
				if(b){
				}else{
					if(dspObj.root){
						try{
							b=dspObj.getBounds(dspObj.root);
						}catch(e:Error){
							b=null;
						}
					}
				}
				if(b){
				}else{
					var parent:DisplayObject=dspObj;
					while(parent){
						var lastParent:DisplayObject=parent;
						try{
							parent=parent.parent;
						}catch(e:Error){
							parent=null;
						}
					}
					try{
						b=dspObj.getBounds(parent);
					}catch(e:Error){
						b=null;
					}
				}
				if(b){
					srcSize.x=b.width;
					srcSize.y=b.height;
				}
			}else{
				var bmd:BitmapData=_dspObjOrBmd as BitmapData;
				if(bmd){
					srcSize.x=bmd.width;
					srcSize.y=bmd.height;
				}else{
					throw new Error("不支持的对象："+_dspObjOrBmd);
				}
			}
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
		public function updateParams():void{}
	}
}