/***
DefineButton2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 10:41:52（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineButton2
//DefineButton2 extends the capabilities of DefineButton by allowing any state transition to
//trigger actions.
//The minimum file format version is SWF 3:
//Starting with SWF 9, if the ActionScript3 field of the FileAttributes tag is 1, there must be no
//BUTTONCONDACTION fields in the DefineButton2 tag. ActionOffset must be 0. This
//structure is not supported because it is not permitted to mix ActionScript 1/2 and
//ActionScript 3.0 code within the same SWF file.


//Field 							Type 							Comment
//Header 							RECORDHEADER 					Tag type = 34
//ButtonId 							UI16 							ID for this character
//ReservedFlags 					UB[7] 							Always 0
//TrackAsMenu 						UB[1] 							0 = track as normal button
//																	1 = track as menu button
//ActionOffset 						UI16 							Offset in bytes from start of this
//Characters 						BUTTONRECORD[one or more]		Characters that make up the button
//CharacterEndFlag 					UI8 							Must be 0
//Actions 							BUTTONCONDACTION[zero or more]	Actions to execute at particular button events field to the first BUTTONCONDACTION, or 0 if no actions occur

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.buttons.BUTTONRECORD;
	import zero.swf.BytesData;
	
	public class DefineButton2{
		
		public var id:int;//UI16
		private var Reserved:int;//11111110
		public var TrackAsMenu:Boolean;//00000001
		public var CharacterV:Vector.<BUTTONRECORD>;
		public var ButtonCondActions:*;
		
		public function DefineButton2(){
			//id=0;
			//Reserved=0;
			//TrackAsMenu=false;
			//CharacterV=null;
			//ButtonCondActions=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			var flags:int=data[offset++];
			Reserved=flags&0xfe;//11111110
			TrackAsMenu=((flags&0x01)?true:false);//00000001
			
			var ActionOffset:int=data[offset++]|(data[offset++]<<8);
			
			var i:int=-1;
			CharacterV=new Vector.<BUTTONRECORD>();
			while(data[offset]){
				i++;
				
				CharacterV[i]=new BUTTONRECORD();
				offset=CharacterV[i].initByData(data,offset,endOffset,_initByDataOptions);
				
			}
			
			offset++;
			
			if(ActionOffset&&(offset<endOffset)){
				if(_initByDataOptions){
					if(_initByDataOptions.classes){
						var ButtonCondActionsClass:Class=_initByDataOptions.classes["zero.swf.records.buttons.BUTTONCONDACTIONs"];
					}
					if(ButtonCondActionsClass){
					}else{
						ButtonCondActionsClass=_initByDataOptions.ButtonCondActionsClass;
					}
				}
				ButtonCondActions=new (ButtonCondActionsClass||BytesData)();
				offset=ButtonCondActions.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ButtonCondActions=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			var flags:int=0;
			flags|=Reserved;//11111110
			if(TrackAsMenu){
				flags|=0x01;//00000001
			}
			data[2]=flags;
			
			data[3]=0x00;
			data[4]=0x00;
			
			data.position=5;
			for each(var Character:BUTTONRECORD in CharacterV){
				
				data.writeBytes(Character.toData(_toDataOptions));
				
			}
			
			data[data.length]=0x00;//EndFlag
			
			if(ButtonCondActions){
				var ButtonCondActionsData:ByteArray=ButtonCondActions.toData(_toDataOptions);
				if(ButtonCondActionsData.length){
					var ActionOffset:int=data.length-3;
					data[3]=ActionOffset;
					data[4]=ActionOffset>>8;
					data.position=data.length;
					data.writeBytes(ButtonCondActionsData);
				}
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineButton2"
					id={id}
					Reserved={Reserved}
					TrackAsMenu={TrackAsMenu}
				/>;
				
				if(CharacterV.length){
					var CharacterListXML:XML=<CharacterList count={CharacterV.length}/>;
					for each(var Character:BUTTONRECORD in CharacterV){
						
						CharacterListXML.appendChild(Character.toXML("Character",_toXMLOptions));
						
					}
					xml.appendChild(CharacterListXML);
				}
				
				if(ButtonCondActions){
					xml.appendChild(ButtonCondActions.toXML("ButtonCondActions",_toXMLOptions));
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				Reserved=int(xml.@Reserved.toString());
				
				TrackAsMenu=(xml.@TrackAsMenu.toString()=="true");
				
				var i:int=-1;
				CharacterV=new Vector.<BUTTONRECORD>();
				for each(var CharacterXML:XML in xml.CharacterList.Character){
					i++;
					
					CharacterV[i]=new BUTTONRECORD();
					CharacterV[i].initByXML(CharacterXML,_initByXMLOptions);
					
				}
				
				var ButtonCondActionsXML:XML=xml.ButtonCondActions[0];
				if(ButtonCondActionsXML){
					var classStr:String=ButtonCondActionsXML["@class"].toString();
					var ButtonCondActionsClass:Class=null;
					if(_initByXMLOptions&&_initByXMLOptions.customClasses){
						ButtonCondActionsClass=_initByXMLOptions.customClasses[classStr];
					}
					if(ButtonCondActionsClass){
					}else{
						try{
							import flash.utils.getDefinitionByName;
							ButtonCondActionsClass=getDefinitionByName(classStr) as Class;
						}catch(e:Error){
							ButtonCondActionsClass=null;
						}
					}
					ButtonCondActions=new (ButtonCondActionsClass||BytesData)();
					ButtonCondActions.initByXML(ButtonCondActionsXML,_initByXMLOptions);
				}else{
					ButtonCondActions=null;
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}