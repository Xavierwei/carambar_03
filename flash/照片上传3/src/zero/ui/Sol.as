/***
Sol
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月28日 20:29:07
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.utils.Proxy;
	import flash.utils.clearTimeout;
	import flash.utils.flash_proxy;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	public class Sol extends EventDispatcher{
		private var timeoutId:int;
		
		private var so:SharedObject;
		private var soXMLFile:*;
		private var fileXML:XML;//当前磁盘上的 xml 文件
		public var xml:XML;
		
		public var enabledCopyToCurr:Boolean;//- -
		
		private var onChangeSetting:Function;
		private var onChangeValue:Function;
		
		private var version:String;
		
		public function Sol(nameOrSoXMLFile:*,_version:String,_onChangeSetting:Function=null,_onChangeValue:Function=null){
			if(nameOrSoXMLFile){
				enabledCopyToCurr=true;//当任意值改变时自动复制当前配置为“当前”
				
				version=_version;
				onChangeSetting=_onChangeSetting;
				onChangeValue=_onChangeValue;
				
				if(nameOrSoXMLFile is String){
					so=SharedObject.getLocal(nameOrSoXMLFile,"/");
					if(so.data.xml){
						try{
							xml=new XML(so.data.xml);
						}catch(e:Error){
							xml=null;
						}
						if(xml){
							fileXML=xml.copy();
						}
					}
				}else{
					soXMLFile=nameOrSoXMLFile;
					if(soXMLFile.exists){
						var fs:*=new (getDefinitionByName("flash.filesystem.FileStream"))();
						fs.open(soXMLFile,getDefinitionByName("flash.filesystem.FileMode").READ);
						try{
							xml=new XML(fs.readUTFBytes(fs.bytesAvailable));
						}catch(e:Error){
							xml=null;
						}
						if(xml){
							fileXML=xml.copy();
						}
						fs.close();
					}
				}
				if(xml){
					if(xml.@version.toString()==version){
						if(xml.@currSettingName.toString()&&getSettingXML(xml.@currSettingName.toString())){
							var _settingXMLMark:Object=new Object();
							var _settingXMLArr:Array=new Array();
							var _settingXML:XML;
							for each(_settingXML in xml.setting){
								if(_settingXMLMark["~"+_settingXML.@name.toString()]){
								}else{
									_settingXMLMark["~"+_settingXML.@name.toString()]=true;
									_settingXMLArr.push(_settingXML);
								}
							}
							_settingXMLArr.sortOn("@name",Array.CASEINSENSITIVE);
							xml=<sol version={version} currSettingName={xml.@currSettingName.toString()}/>
							for each(_settingXML in _settingXMLArr){
								xml.appendChild(_settingXML);
							}
						}else{
							reset();
						}
					}else{
						reset();
					}
				}else{
					reset();
				}
				
				updateDelay();
				
			}else{
				throw new Error("nameOrSoXMLFile="+nameOrSoXMLFile);
			}
		}
		public function clear():void{
			clearTimeout(timeoutId);
			
			so=null;
			soXMLFile=null;
			fileXML=null;
			xml=null;
			
			onChangeSetting=null;
			onChangeValue=null;
		}
		
		private function reset():void{
			
			fileXML=null;
			
			if(soXMLFile){
			}else{
				//
				//so.data={};//属性是只读的
				
				//
				for(var valueName:String in so.data){
					delete so.data[valueName];
				}
			}
			
			xml=<sol version={version} currSettingName="默认"/>
		}
		
		public function getValue(name:String):*{
			if(name){
			}else{
				throw new Error("name="+name);
			}
			
			var subNameArr:Array=name.split(".");
			var lastName:String=subNameArr.pop();
			var subXML:XML=getSettingXML(xml.@currSettingName.toString());
			for each(var subName:String in subNameArr){
				subXML=subXML[subName][0];
				if(subXML){
				}else{
					return undefined;
				}
			}
			subXML=subXML[lastName][0];
			if(subXML){
				return xml2value(subXML);
			}
			return undefined;
		}
		
		public function setValue(name:String,value:*):void{
			if(name){
			}else{
				throw new Error("name="+name);
			}
			
			var oldValue:*=this.getValue(name);
			if(oldValue===value){
				return;
			}
			
			var subNameArr:Array=name.split(".");
			var lastName:String=subNameArr.pop();
			var subXML:XML;
			if(xml.@currSettingName.toString()=="当前"){
			}else{
				if(enabledCopyToCurr){
					
					//throw new Error("复制当前配置为“当前”");
					
					subXML=getSettingXML(xml.@currSettingName.toString()).copy();
					subXML.@name="当前";
					xml.@currSettingName="当前";
					setSettingXML(xml.@currSettingName.toString(),subXML);
					
					if(onChangeSetting==null){
					}else{
						onChangeSetting(xml.@currSettingName.toString());
					}
				}
			}
			subXML=getSettingXML(xml.@currSettingName.toString());
			for each(var subName:String in subNameArr){
				if(subXML[subName][0]){
				}else{
					subXML[subName]=<{subName}/>;
				}
				subXML=subXML[subName][0];
			}
			
			subXML[lastName]=value2xml(lastName,value);
			
			updateDelay();
			
			if(onChangeValue==null){
			}else{
				onChangeValue(
					xml.@currSettingName.toString(),
					name.toString(),
					value
				);
			}
		}
		
		private function xml2value(valueXML:XML):*{
			
			var itemXML:XML;
			
			switch(valueXML.@type.toString()){
				case "true":
					return true;
				break;
				case "false":
					return false;
				break;
				case "null":
					return null;
				break;
				case "undefined":
					return undefined;
				break;
				case "int":
					return int(valueXML.@value.toString());
				break;
				case "uint":
					return uint(valueXML.@value.toString());
				break;
				case "Number":
					return Number(valueXML.@value.toString());
				break;
				case "String":
					return valueXML.@value.toString();
				break;
				case "XML":
					return valueXML.children()[0];
				break;
				case "Array":
					var arr:Array=new Array();
					var i:int=-1;
					for each(itemXML in valueXML.children()){
						i++;
						arr[i]=xml2value(itemXML);
					}
					return arr;
				break;
				case "Object":
					var obj:Object=new Object();
					for each(itemXML in valueXML.children()){
						obj[itemXML.@valueName.toString()]=xml2value(itemXML);
					}
					return obj;
				break;
			}
			
			throw new Error("valueXML="+valueXML);
		}
		
		private function value2xml(name:String,value:*):XML{
			switch(value){
				case true:
					return <{name} type="true"/>;
				break;
				case false:
					return <{name} type="false"/>;
				break;
				case null:
					return <{name} type="null"/>;
				break;
				case undefined:
					return <{name} type="undefined"/>;
				break;
			}
			if(value is int){
				return <{name} type="int" value={value}/>;
			}
			if(value is uint){
				return <{name} type="uint" value={value}/>;
			}
			if(value is Number){
				return <{name} type="Number" value={value}/>;
			}
			if(value is String){
				return <{name} type="String" value={value}/>;
			}
			
			var valueXML:XML;
			
			//trace("value is XML="+(value is XML));
			//trace("value is XMLList="+(value is XMLList));
			if(value){
				if(value is XML){
					valueXML=<{name} type="XML"/>;
					valueXML.appendChild(value);
					return valueXML;
				}
				switch(value.constructor){
					case Array:
						valueXML=<{name} type="Array"/>;
						var L:int=value.length;
						for(var i:int=0;i<L;i++){
							valueXML.appendChild(value2xml("item",value[i]));
						}
						return valueXML;
					break;
					case Object:
						valueXML=<{name} type="Object"/>;
						for(var valueName:String in value){
							var itemXML:XML=value2xml("item",value[valueName]);
							itemXML.@valueName=valueName;
							valueXML.appendChild(itemXML);
						}
						return valueXML;
					break;
				}
			}
			
			throw new Error("value="+value);
		}
		
		public function getSettingXML(settingName:String):XML{
			switch(settingName){
				case "默认":
					return <setting name="默认"/>;
				break;
				//case "当前":
				//break;
				default:
					for each(var _settingXML:XML in xml.setting){
						if(_settingXML.@name.toString()==settingName){
							return _settingXML;
						}
					}
				break;
			}
			return null;
		}
		public function setSettingXML(settingName:String,settingXML:XML):void{
			settingXML=settingXML.copy();
			switch(settingName){
				case "默认":
				break;
				//case "当前":
				//break;
				default:
					var i:int=-1;
					for each(var _settingXML:XML in xml.setting){
						i++;
						if(_settingXML.@name.toString()==settingName){
							_settingXML.setChildren(settingXML.children());
							return;
						}
						if(_settingXML.@name.toString().toLowerCase()>settingName.toLowerCase()){
							settingXML.@name=settingName;
							xml.insertChildBefore(_settingXML,settingXML);
							return;
						}
					}
					settingXML.@name=settingName;
					xml.appendChild(settingXML);
				break;
			}
		}
		public function addSetting(settingName:String):void{
			if(xml.@currSettingName.toString()==settingName){
				return;
			}
			setSettingXML(settingName,getSettingXML(xml.@currSettingName.toString()));
			changeSetting(settingName);
		}
		public function changeSetting(settingName:String):void{
			if(xml.@currSettingName.toString()==settingName){
				return;
			}
			if(getSettingXML(settingName)){
				xml.@currSettingName=settingName;
			}else{
				xml.@currSettingName="默认";
			}
			
			updateDelay();
			
			if(onChangeSetting==null){
			}else{
				onChangeSetting(xml.@currSettingName.toString());
			}
		}
		
		
		private function updateDelay():void{
			clearTimeout(timeoutId);
			timeoutId=setTimeout(update,500);
		}
		public function update():void{
			clearTimeout(timeoutId);
			
			if(fileXML&&(xml.toXMLString()==fileXML.toXMLString())){
			}else{
				
				//trace("update");
				
				fileXML=xml.copy();
				if(soXMLFile){
					var fs:*=new (getDefinitionByName("flash.filesystem.FileStream"))();
					fs.open(soXMLFile,getDefinitionByName("flash.filesystem.FileMode").WRITE);
					fs.writeUTFBytes(('<?xml version="1.0" encoding="utf-8"?>\n'+xml.toXMLString()).replace(/\r\n/g,"\n").replace(/\n/g,"\r\n"));
					fs.close();
				}else{
					so.data.xml=xml.toXMLString();
					so.flush();
				}
				
				//if(onUpdate==null){
				//}else{
				//	onUpdate();
				//}
			}
		}
	}
}