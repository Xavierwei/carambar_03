/***
So
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月05日 09:45:15
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setTimeout;
	
	import zero.utils.complexArr2SimpleArr;
	import zero.utils.isClass;
	
	public class So{
		
		private static const flexClassNameV:Vector.<String>=new <String>[
			"mx.controls.ComboBox",
			"mx.controls.TextInput",
			"mx.controls.TextArea",
			"spark.components.CheckBox",
			"spark.components.RadioButton",
			"spark.components.RadioButtonGroup",
			"mx.controls.ColorPicker"
		];
		
		private static const flClassNameV:Vector.<String>=new <String>[
			"fl.controls.ComboBox",
			"fl.controls.TextInput",
			"fl.controls.TextArea",
			"fl.controls.CheckBox",
			"fl.controls.RadioButton",
			"fl.controls.RadioButtonGroup",
			"fl.controls.ColorPicker"
		];
		
		private static var so:SharedObject;
		private static var dict:Dictionary;
		private static var lastKeyCode:int;
		private static var currTxt:*;
		
		private static var timeoutId:int;
		
		private static var getDefinitionFun:Function;//20130306
		
		public static function init(key:String,_getDefinitionFun:Function=null):void{
			clear();
			dict=new Dictionary();
			so=SharedObject.getLocal(key,"/");
			getDefinitionFun=_getDefinitionFun||getDefinitionByName;
		}
		public static function clear():void{
			for(var obj:* in dict){
				remove(obj);
			}
			dict=null;
			so=null;
			getDefinitionFun=null;
			clearTimeout(timeoutId);
		}
		private static function keyDown(event:KeyboardEvent):void{
			//fl.controls.TextInput 的 stage 接收不到 KeyDown事件
			lastKeyCode=event.keyCode;
			//trace("keyDown lastKeyCode="+lastKeyCode);
			var focus:DisplayObject=event.target as DisplayObject;
			if(currTxt){
				while(focus){
					if(currTxt==focus){
						break;
					}
					focus=focus.parent;
				}
				if(currTxt==focus){
					switch(lastKeyCode){
						case Keyboard.ENTER:
							if(getClassName(currTxt)=="TextInput"){
								currTxt.setSelection(currTxt.text.length,currTxt.text.length);
							}
							var obj:*=currTxt;
							while(obj){
								if(dict[obj]){
									if(dict[obj].vars.enterAction){
										dict[obj].vars.enterAction();
									}
									break;
								}
								obj=obj.parent;
							}
						break;
					}
				}
			}
		}
		public static function has(obj:*):Boolean{
			return dict[obj];
		}
		
		/**
		 * 
		 * depth<=1，不带parent；depth>1，带parent
		 * 
		 */		
		public static function add(obj:*,depthOrKey:*,vars:Object=null):void{
			if(has(obj)){
				throw new Error("不可重复 add(obj)");
			}
			
			if(depthOrKey is int){
				var depth:int=depthOrKey;
				if(isClass(obj,flexClassNameV,getDefinitionFun)){
					var key:String=obj.id;
					var parent:*=obj.parent;
					depth--;
					while(parent&&depth>=1){
						if(parent.id){
							key=parent.id+"."+key;
							depth--;
						}
						parent=parent.parent;
					}
				}else if(isClass(obj,flClassNameV,getDefinitionFun)){
					key=obj.name;
					parent=obj.parent;
					while(parent&&--depth>=1){
						key=parent.name+"."+key;
						parent=parent.parent;
					}
				}else{
					throw new Error("暂不支持的 obj："+getQualifiedClassName(obj));
				}
			}else{
				key=depthOrKey;
			}
			
			trace("key="+key);
			
			dict[obj]={key:key,vars:(vars||new Object())};
			switch(getClassName(obj)){
				case "TextInput":
				case "TextArea":
					if(so.data.hasOwnProperty(dict[obj].key)){
						updateObjBySo(obj);
					}else{
						updateSoByObj(obj);
					}
					obj.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
					obj.addEventListener(Event.CHANGE,change);
				break;
				case "ComboBox":
					if(so.data.hasOwnProperty(dict[obj].key)){
						updateObjBySo(obj);
					}else{
						updateSoByObj(obj);
					}
					obj.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
					obj.addEventListener(Event.CHANGE,change);
					obj.addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
				break;
				case "CheckBox":
					if(so.data.hasOwnProperty(dict[obj].key)){
						updateObjBySo(obj);
					}else{
						updateSoByObj(obj);
					}
					obj.addEventListener(Event.CHANGE,change);
				break;
				case "RadioButton":
					if(so.data.hasOwnProperty(dict[obj].key)){
						updateObjBySo(obj);
					}else{
						updateSoByObj(obj);
					}
					obj.group.addEventListener(Event.CHANGE,change);
				break;
				case "ColorPicker":
					if(so.data.hasOwnProperty(dict[obj].key)){
						updateObjBySo(obj);
					}else{
						updateSoByObj(obj);
					}
					obj.addEventListener(Event.CHANGE,change);
				break;
				default:
					delete dict[obj];
					throw new Error("暂不支持的 obj："+getQualifiedClassName(obj));
				break;
			}
		}
		public static function remove(obj:*):void{
			if(has(obj)){
			}else{
				throw new Error("请先 add(obj)");
			}
			delete dict[obj];
			switch(getClassName(obj)){
				case "TextInput":
				case "TextArea":
					obj.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown);
					obj.removeEventListener(Event.CHANGE,change);
				break;
				case "ComboBox":
					obj.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown);
					obj.removeEventListener(Event.CHANGE,change);
					obj.removeEventListener(MouseEvent.MOUSE_WHEEL,mouseWheel);
				break;
				case "CheckBox":
					obj.removeEventListener(Event.CHANGE,change);
				break;
				case "RadioButton":
					obj.group.removeEventListener(Event.CHANGE,change);
				break;
				case "ColorPicker":
					obj.removeEventListener(Event.CHANGE,change);
				break;
				default:
					throw new Error("暂不支持的 obj："+getQualifiedClassName(obj));
				break;
			}
		}
		public static function updateSoByObj(obj:*):void{
			if(obj){
			}else{
				throw new Error("obj="+obj);
			}
			if(has(obj)){
			}else{
				throw new Error("请先 add("+obj+")");
			}
			switch(getClassName(obj)){
				case "TextInput":
				case "TextArea":
					write(dict[obj].key,obj.text);
				break;
				case "ComboBox":
					//trace("updateSoByObj dict[obj].key="+dict[obj].key,getComboBoxSelectedItem(obj));
					write(dict[obj].key,getComboBoxSelectedItem(obj));
				break;
				case "CheckBox":
					write(dict[obj].key,obj.selected);
				break;
				case "RadioButton":
					write(dict[obj].key,getRadioButtonGroupSelectedValue(obj.group));
				break;
				case "ColorPicker":
					write(dict[obj].key,obj.selectedColor);
				break;
				default:
					throw new Error("暂不支持的 obj："+getQualifiedClassName(obj));
				break;
			}
			updateSomethingByVars(obj);
		}
		public static function updateObjBySo(obj:*):void{
			if(has(obj)){
			}else{
				throw new Error("请先 add(obj)");
			}
			switch(getClassName(obj)){
				case "TextInput":
				case "TextArea":
					obj.text=read(dict[obj].key);
				break;
				case "ComboBox":
					//trace("updateObjBySo dict[obj].key="+dict[obj].key);
					setComboBoxSelectedItem(obj,read(dict[obj].key));
				break;
				case "CheckBox":
					obj.selected=read(dict[obj].key);
				break;
				case "RadioButton":
					setRadioButtonGroupSelectedValue(obj.group,read(dict[obj].key));
				break;
				case "ColorPicker":
					obj.selectedColor=read(dict[obj].key);
				break;
				default:
					throw new Error("暂不支持的 obj："+getQualifiedClassName(obj));
				break;
			}
			updateSomethingByVars(obj);
		}
		private static function updateSomethingByVars(obj:*):void{
			switch(getClassName(obj)){
				case "TextInput":
				case "TextArea":
					//
				break;
				case "ComboBox":
					//
				break;
				case "CheckBox":
					if(dict[obj].vars.enabledObj){
						dict[obj].vars.enabledObj.enabled=obj.selected;
					}
				break;
				case "RadioButton":
					if(dict[obj].vars.enabledObjArr){
						var i:int=-1;
						for each(var something:* in dict[obj].vars.enabledObjArr){
							i++;
							var _radioButton:*=obj.group.getRadioButtonAt(i);
							if(_radioButton.label==getRadioButtonGroupSelectedValue(obj.group)){
							}else{
								for each(var _obj:* in complexArr2SimpleArr(something)){
									if(_obj){
										_obj.enabled=false;
									}
								}
							}
						}
						i=-1;
						for each(something in dict[obj].vars.enabledObjArr){
							i++;
							_radioButton=obj.group.getRadioButtonAt(i);
							if(_radioButton.label==getRadioButtonGroupSelectedValue(obj.group)){
								for each(_obj in complexArr2SimpleArr(something)){
									if(_obj){
										_obj.enabled=true;
									}
								}
							}
						}
					}
				break;
				case "ColorPicker":
					//
				break;
				default:
					throw new Error("暂不支持的 obj："+getQualifiedClassName(obj));
				break;
			}
			if(dict[obj].vars.onChange){
				switch(dict[obj].vars.onChange.length){
					case 0:
						dict[obj].vars.onChange();
					break;
					case 1:
						dict[obj].vars.onChange(obj);
					break;
				}
			}
		}
		private static function change(event:Event):void{
			switch(getClassName(event.target)){
				case "TextInput":
				case "TextArea":
					currTxt=event.target;
					updateSoByObj(currTxt);
				break;
				case "ComboBox":
					var comboBox:*=event.target;
					comboBox.validateNow();//否则 text 会取得上一次的 selectedLabel
					var text:String=comboBox.text;
					if(text){
						var labelArr:Array=getDataProviderArr(comboBox.dataProvider);
						var i:int=labelArr.indexOf(comboBox.text);
						if(i>-1){
							//comboBox.selectedIndex=i;
						}else{
							i=-1;
							for each(var label:String in labelArr){
								i++;
								if(label.toLowerCase().indexOf(text.toLowerCase())==0){
									currTxt=getComboBoxTxt(comboBox);
									comboBox.selectedIndex=i;
									comboBox.validateNow();//否则会 setSelection 选择整个 text
									//trace("change lastKeyCode="+lastKeyCode);
									switch(lastKeyCode){
										case Keyboard.BACKSPACE:
											currTxt.setSelection(text.length-1,label.length);
										break;
										default:
											currTxt.setSelection(text.length,label.length);
										break;
									}
									break;
								}
							}
						}
						updateSoByObj(comboBox);
					}
				break;
				case "CheckBox":
					updateSoByObj(event.target);
				break;
				case "RadioButton":
					updateSoByObj(event.target);
				break;
				case "ColorPicker":
					updateSoByObj(event.target);
				break;
				case "RadioButtonGroup":
					for(var obj:* in dict){
						if(getClassName(obj)=="RadioButton"&&obj.group==event.target){
							updateSoByObj(obj);
							break;
						}
					}
				break;
				default:
					throw new Error("暂不支持的 obj："+getQualifiedClassName(obj));
				break;
			}
		}
		private static function mouseWheel(event:MouseEvent):void{
			var comboBox:*=event.currentTarget;
			if(event.delta<0){
				if(comboBox.selectedIndex>0){
					comboBox.selectedIndex--;
					updateSoByObj(comboBox);
				}
			}else{
				if(comboBox.selectedIndex<comboBox.dataProvider.length-1){
					comboBox.selectedIndex++;
					updateSoByObj(comboBox);
				}
			}
		}
		
		public static function read(key:String):*{
			return so.data[key];
		}
		public static function write(key:String,value:*):void{
			//trace("key="+key,"value="+value);
			so.data[key]=value;
			clearTimeout(timeoutId);
			timeoutId=setTimeout(flush,1000);
		}
		private static function flush():void{
			clearTimeout(timeoutId);
			so.flush();
			//trace("flush");
		}
		
		private static function getClassName(obj:*):String{
			return getQualifiedClassName(obj).replace(/^.*?(\w+)$/,"$1");
		}
		private static function getRadioButtonGroupSelectedValue(group:*):String{
			if(isClass(group,"spark.components.RadioButtonGroup",getDefinitionFun)){
				return group.selectedValue;
			}
			
			if(isClass(group,"fl.controls.RadioButtonGroup",getDefinitionFun)){
				if(group.selection){
					var i:int=group.numRadioButtons;
					while(--i>=0){
						var rb:*=group.getRadioButtonAt(i);
						if(rb==group.selection){
							return rb.label;
						}
					}
				}
				return null;
			}
			
			throw new Error("暂不支持的 group："+group);
		}
		private static function setRadioButtonGroupSelectedValue(group:*,value:String):void{
			if(isClass(group,"spark.components.RadioButtonGroup",getDefinitionFun)){
				group.selectedValue=value;
				return;
			}
			
			if(isClass(group,"fl.controls.RadioButtonGroup",getDefinitionFun)){
				var i:int=group.numRadioButtons;
				while(--i>=0){
					var rb:*=group.getRadioButtonAt(i);
					if(rb.label==value){
						group.selection=rb;
						break;
					}
				}
				return;
			}
			
			throw new Error("暂不支持的 group："+group);
		}
		private static function getComboBoxSelectedItem(comboBox:*):String{
			if(isClass(comboBox,[
				"mx.controls.ComboBox",
				"fl.controls.ComboBox"
			],getDefinitionFun)){
				comboBox.validateNow();//否则可能会不正确
				return comboBox.text;
			}
			
			throw new Error("暂不支持的 comboBox："+getQualifiedClassName(comboBox));
		}
		private static function setComboBoxSelectedItem(comboBox:*,value:String):void{
			var i:int=getDataProviderArr(comboBox.dataProvider).indexOf(value);
			if(i>-1){
				comboBox.selectedIndex=i;
			}
		}
		private static function getComboBoxTxt(comboBox:*):*{
			if(isClass(comboBox,"mx.controls.ComboBox",getDefinitionFun)){
				var i:int=comboBox.numChildren;
				while(--i>=0){
					var child:*=comboBox.getChildAt(i);
					if(getClassName(child)=="TextInput"){
						return child;
					}
				}
				throw new Error("找不到 comboBox.textInput");
			}
			
			if(isClass(comboBox,"fl.controls.ComboBox",getDefinitionFun)){
				return comboBox.textField;
			}
			
			throw new Error("暂不支持的 comboBox："+getQualifiedClassName(comboBox));
		}
		private static function getDataProviderArr(dataProvider:*):Array{
			if(isClass(dataProvider,"mx.collections.ArrayCollection",getDefinitionFun)){
				return dataProvider.source;
			}
			if(isClass(dataProvider,"fl.data.DataProvider",getDefinitionFun)){
				var arr:Array=new Array();
				var i:int=dataProvider.length;
				while(--i>=0){
					arr[i]=dataProvider.getItemAt(i).label;
				}
				return arr;
			}
			
			throw new Error("暂不支持的 dataProvider："+dataProvider);
		}

	}
}