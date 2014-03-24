/***
BUTTONCONDACTION
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:17（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//BUTTONCONDACTION
//Field 					Type 						Comment
//CondActionSize 			UI16 						Offset in bytes from start of this field to next BUTTONCONDACTION, or 0 if last action
//CondIdleToOverDown 		UB[1] 						Idle to OverDown
//CondOutDownToIdle 		UB[1] 						OutDown to Idle
//CondOutDownToOverDown 	UB[1] 						OutDown to OverDown
//CondOverDownToOutDown 	UB[1] 						OverDown to OutDown
//CondOverDownToOverUp 		UB[1] 						OverDown to OverUp
//CondOverUpToOverDown 		UB[1] 						OverUp to OverDown
//CondOverUpToIdle 			UB[1] 						OverUp to Idle
//CondIdleToOverUp 			UB[1] 						Idle to OverUp

//CondKeyPress 				UB[7] 						SWF 4 or later: key code Otherwise: always 0
//														Valid key codes:
//														1 = left arrow
//														2 = right arrow
//														3 = home
//														4 = end
//														5 = insert
//														6 = delete
//														8 = backspace
//														13 = enter
//														14 = up arrow
//														15 = down arrow
//														16 = page up
//														17 = page down
//														18 = tab
//														19 = escape
//														32 to 126: follows ASCII
//CondOverDownToIdle 		UB[1] 						OverDown to Idle
//Actions 					ACTIONRECORD[zero or more]	Actions to perform. See DoAction.
//ActionEndFlag 			UI8 						Must be 0
package zero.swf.records.buttons{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import zero.swf.BytesData;
	import zero.swf.records.KeyPressKeyCodes;
	
	public class BUTTONCONDACTION{
		
		public var CondIdleToOverDown:Boolean;
		public var CondOutDownToIdle:Boolean;
		public var CondOutDownToOverDown:Boolean;
		public var CondOverDownToOutDown:Boolean;
		public var CondOverDownToOverUp:Boolean;
		public var CondOverUpToOverDown:Boolean;
		public var CondOverUpToIdle:Boolean;
		public var CondIdleToOverUp:Boolean;
		public var CondKeyPress:int;
		public var CondOverDownToIdle:Boolean;
		public var Actions:*;
		//public var ActionEndFlag:int;//经测试这是会被播放器执行的（把 ActionEndFlag 设置为 8（toggleQuality）然后执行按钮动作，将发现播放质量发生变化，所以 ActionEndFlag 应是 Actions 的一部分）
		
		public function BUTTONCONDACTION(){
			//CondIdleToOverDown=false;
			//CondOutDownToIdle=false;
			//CondOutDownToOverDown=false;
			//CondOverDownToOutDown=false;
			//CondOverDownToOverUp=false;
			//CondOverUpToOverDown=false;
			//CondOverUpToIdle=false;
			//CondIdleToOverUp=false;
			//CondKeyPress=0;
			//CondOverDownToIdle=false;
			//Actions=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var CondActionSize:int=data[offset++]|(data[offset++]<<8);
			if(CondActionSize){
				endOffset=offset-2+CondActionSize;
			}
			
			var flags:int=data[offset++];
			CondIdleToOverDown=((flags&0x80)?true:false);			//10000000
			CondOutDownToIdle=((flags&0x40)?true:false);			//01000000
			CondOutDownToOverDown=((flags&0x20)?true:false);		//00100000
			CondOverDownToOutDown=((flags&0x10)?true:false);		//00010000
			CondOverDownToOverUp=((flags&0x08)?true:false);		//00001000
			CondOverUpToOverDown=((flags&0x04)?true:false);		//00000100
			CondOverUpToIdle=((flags&0x02)?true:false);			//00000010
			CondIdleToOverUp=((flags&0x01)?true:false);			//00000001
			
			flags=data[offset++];
			CondKeyPress=(flags<<24)>>>25;					//11111110
			CondOverDownToIdle=((flags&0x01)?true:false);			//00000001
			
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					var ActionsClass:Class=_initByDataOptions.classes["zero.swf.avm1.ACTIONRECORDs"];
				}
				if(ActionsClass){
				}else{
					ActionsClass=_initByDataOptions.ActionsClass;
				}
			}
			Actions=new (ActionsClass||BytesData)();
			Actions.initByData(data,offset,endOffset<offset?offset:endOffset,_initByDataOptions);
			return endOffset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=0x00;//CondActionSize
			data[1]=0x00;//CondActionSize
			
			var flags:int=0;
			if(CondIdleToOverDown){
				flags|=0x80;								//10000000
			}
			if(CondOutDownToIdle){
				flags|=0x40;								//01000000
			}
			if(CondOutDownToOverDown){
				flags|=0x20;								//00100000
			}
			if(CondOverDownToOutDown){
				flags|=0x10;								//00010000
			}
			if(CondOverDownToOverUp){
				flags|=0x08;								//00001000
			}
			if(CondOverUpToOverDown){
				flags|=0x04;								//00000100
			}
			if(CondOverUpToIdle){
				flags|=0x02;								//00000010
			}
			if(CondIdleToOverUp){
				flags|=0x01;								//00000001
			}
			data[2]=flags;
			
			flags=0;
			flags|=CondKeyPress<<1;							//11111110
			if(CondOverDownToIdle){
				flags|=0x01;								//00000001
			}
			data[3]=flags;
			
			data.position=4;
			data.writeBytes(Actions.toData(_toDataOptions));
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName} class="zero.swf.records.buttons.BUTTONCONDACTION"
				CondIdleToOverDown={CondIdleToOverDown}
				CondOutDownToIdle={CondOutDownToIdle}
				CondOutDownToOverDown={CondOutDownToOverDown}
				CondOverDownToOutDown={CondOverDownToOutDown}
				CondOverDownToOverUp={CondOverDownToOverUp}
				CondOverUpToOverDown={CondOverUpToOverDown}
				CondOverUpToIdle={CondOverUpToIdle}
				CondIdleToOverUp={CondIdleToOverUp}
			
				CondKeyPress={KeyPressKeyCodes.keyCodeV[CondKeyPress]}
				CondOverDownToIdle={CondOverDownToIdle}
			/>;
			
			xml.appendChild(Actions.toXML("Actions",_toXMLOptions));
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			CondIdleToOverDown=(xml.@CondIdleToOverDown.toString()=="true");
			CondOutDownToIdle=(xml.@CondOutDownToIdle.toString()=="true");
			CondOutDownToOverDown=(xml.@CondOutDownToOverDown.toString()=="true");
			CondOverDownToOutDown=(xml.@CondOverDownToOutDown.toString()=="true");
			CondOverDownToOverUp=(xml.@CondOverDownToOverUp.toString()=="true");
			CondOverUpToOverDown=(xml.@CondOverUpToOverDown.toString()=="true");
			CondOverUpToIdle=(xml.@CondOverUpToIdle.toString()=="true");
			CondIdleToOverUp=(xml.@CondIdleToOverUp.toString()=="true");
			
			CondKeyPress=KeyPressKeyCodes[xml.@CondKeyPress.toString()];
			CondOverDownToIdle=(xml.@CondOverDownToIdle.toString()=="true");
			
			var ActionsXML:XML=xml.Actions[0];
			var classStr:String=ActionsXML["@class"].toString();
			var ActionsClass:Class=null;
			if(_initByXMLOptions&&_initByXMLOptions.customClasses){
				ActionsClass=_initByXMLOptions.customClasses[classStr];
			}
			if(ActionsClass){
			}else{
				try{
					ActionsClass=getDefinitionByName(classStr) as Class;
				}catch(e:Error){
					ActionsClass=null;
				}
			}
			Actions=new (ActionsClass||BytesData)();
			Actions.initByXML(ActionsXML,_initByXMLOptions);
			
		}
		//}//end of CONFIG::USE_XML
	}
}
