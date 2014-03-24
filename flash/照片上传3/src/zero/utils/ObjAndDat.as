/***
ObjAndDat
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月28日 09:26:12
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.xml.XMLDocument;
	
	import zero.BytesAndStr16;
	import zero.ComplexString;
	
	public class ObjAndDat{
		
		/**
		 * 对于具有相同结构的obj，返回一致的dat
		 */		
		public static function obj2dat(obj:Object):ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeObject(obj2arr(obj));
			data.compress();
			return data;
		}
		
		/**
		 * obj2dat的相反过程
		 */		
		public static function dat2obj(data:ByteArray):Object{
			data.uncompress();
			return arr2obj(data.readObject());
		}
		
		/**
		 * 给 obj 的属性按名称排序，以便返回一致的 arr<br>
		 * 例如：{b:1,a:{d:2,c:3},e:[4,5,6]} 将会转换为：[[["a",["c","d"]],"b",["e",[0,1,2]]],[[3,2],1,[4,5,6]]]<br>
		 */
		public static function obj2arr(obj:Object):Array{
			
			//trace("obj2arr obj="+obj2str(obj));
			
			var nameArr:Array=[];
			var valueArr:Array=[];
			_obj2arr(obj,nameArr,valueArr);
			var arr:Array=[nameArr,valueArr];
			
			//trace("obj2arr arr="+obj2str(arr));
			
			return arr;
		}
		private static function _obj2arr(obj:Object,nameArr:Array,valueArr:Array):void{
			
			for(var name:* in obj){
				nameArr.push(name);
			}
			if(nameArr.length){
				nameArr.sort();
				
				//trace("nameArr1="+obj2str(nameArr));
				
				var i:int=nameArr.length;
				while(--i>=0){
					name=nameArr[i];
					if(obj[name]){
						if(obj[name] is XML){
							valueArr[i]=["XML",obj[name].toXMLString()];
						}else if(obj[name] is XMLList){
							valueArr[i]=["XMLList",obj[name].toXMLString()];
						}else{
							switch(obj[name].constructor){
								case Boolean:
								case Number:
								case String:
									//简单类型
									valueArr[i]=obj[name];
								break;
								case Object:
								case Array:
									nameArr[i]=[name,[]];
									valueArr[i]=[];
									_obj2arr(obj[name],nameArr[i][1],valueArr[i]);
								break;
								case XMLDocument:
									valueArr[i]=["XMLDocument",obj[name].toString()];
								break;
								case Date:
									valueArr[i]=["Date",obj[name].time];
								break;
								case ByteArray:
									valueArr[i]=["ByteArray",BytesAndStr16.bytes2str16(obj[name],0,obj[name].length)];
								break;
								default://others
									//throw new Error("_obj2arr 不支持的类型："+obj[name].constructor);
									var bytes:ByteArray=new ByteArray();
									bytes.writeObject(obj[name]);
									valueArr[i]=["others("+getQualifiedClassName(obj[name])+")",BytesAndStr16.bytes2str16(bytes,0,bytes.length)];
								break;
							}
						}
					}else{
						//false,0,NaN,"",null,undefined 等逻辑值为false的简单类型
						valueArr[i]=obj[name];
					}
				}
			}else{
				//[] 或 {}
				valueArr[0]=obj;
			}
			
			//trace("nameArr2="+obj2str(nameArr));
			//trace("valueArr="+obj2str(valueArr));
			
		}
		
		/**
		 * arr2obj的相反过程
		 */		
		public static function arr2obj(arr:Array):Object{
			
			//trace("arr2obj arr="+obj2str(arr));
			
			var obj:Object=_arr2obj(arr[0],arr[1]);
			
			//trace("arr2obj obj="+obj2str(obj));
			
			return obj;
		}
		private static function _arr2obj(nameArr:Array,valueArr:Array):Object{
			if(nameArr.length){
				var name:*=nameArr[0];
				if(name.constructor==Array){
					name=name[0];
				}
				if(name.constructor==String){
					var obj:Object={};
				}else{
					obj=[];
				}
				var i:int=-1;
				for each(name in nameArr){
					i++;
					if(name.constructor==Array){
						obj[name[0]]=_arr2obj(name[1],valueArr[i]);
					}else{
						if(valueArr[i]){
							switch(valueArr[i].constructor){
								case Boolean:
								case Number:
								case String:
									//简单类型
									obj[name]=valueArr[i];
								break;
								case Array:
									if(valueArr[i].length==2){
										switch(valueArr[i][0]){
											case "XML":
												obj[name]=new XML(valueArr[i][1]);
											break;
											case "XMLList":
												obj[name]=new XMLList(valueArr[i][1]);
											break;
											case "XMLDocument":
												obj[name]=new XMLDocument(valueArr[i][1]);
											break;
											case "Date":
												obj[name]=new Date(valueArr[i][1]);
											break;
											case "ByteArray":
												obj[name]=BytesAndStr16.str162bytes(valueArr[i][1]);
											break;
											default://others
												//throw new Error("_arr2obj 不支持的valueArr[i]："+valueArr[i]);
												var bytes:ByteArray=BytesAndStr16.str162bytes(valueArr[i][1]);
												obj[name]=bytes.readObject();
											break;
										}
									}else{
										throw new Error("_arr2obj 不支持的valueArr[i]："+valueArr[i]);
									}
								break;
								default:
									throw new Error("_arr2obj 不支持的类型："+valueArr[i].constructor);
								break;
							}
						}else{
							//false,0,NaN,"",null,undefined 等逻辑值为false的简单类型
							obj[name]=valueArr[i];
						}
					}
				}
				return obj;
			}
			return valueArr[0];//[] 或 {}
		}
		
		public static function obj2str(obj:*):String{
			if(obj){
				if(obj is XML){
					return obj.toXMLString();
				}
				if(obj is XMLList){
					return "<>\n"+obj.toXMLString()+"\n</>";
				}
				switch(obj.constructor){
					case Boolean:
					case Number:
						return String(obj);
					break;
					case String:
						//简单类型
						return '"'+ComplexString.normal.escape(obj)+'"';
					break;
					case Object:
						var str:String="";
						for(var name:String in obj){
							str+=","+name+":"+obj2str(obj[name]);
						}
						return "{"+str.substr(1)+"}";
					break;
					case Array:
						str="";
						var L:int=obj.length;
						for(var i:int=0;i<L;i++){
							str+=","+obj2str(obj[i]);
						}
						return "["+str.substr(1)+"]";
					break;
					case XMLDocument:
						var xmlDom:XMLDocument=obj;
						return "new XMLDocument('"+xmlDom.toString()+"')";
					break;
					case Date:
						var date:Date=obj;
						return "new Date("+date.fullYear+","+date.month+","+date.date+","+date.hours+","+date.minutes+","+date.seconds+","+date.milliseconds+")";
					break;
					case ByteArray:
						var bytes:ByteArray=obj;
						return "BytesAndStr16.str162bytes(\""+BytesAndStr16.bytes2str16(bytes,0,bytes.length)+"\")";
					break;
					default://others
						bytes=new ByteArray();
						bytes.writeObject(obj);
						bytes.position=0;
						obj=bytes.readObject();
						if(obj.constructor==Object){
							return obj2str(obj);
						}
						return String(obj);
					break;
				}
			}
			
			//false,0,NaN,"",null,undefined 等逻辑值为false的简单类型
			if(obj===""){
				return '""';
			}
			return String(obj);
		}
	}
}