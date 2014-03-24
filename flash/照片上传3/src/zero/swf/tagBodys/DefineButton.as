/***
DefineButton
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年10月05日 11:47:30（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The DefineButton tag defines a button character for later use by control tags such as
//PlaceObject.
//DefineButton includes an array of Button records that represent the four button shapes: an up
//character, a mouse-over character, a down character, and a hit-area character. It is not
//necessary to define all four states, but at least one button record must be present. For example,
//if the same button record defines both the up and over states, only three button records are
//required to describe the button.
//More than one button record per state is allowed. If two button records refer to the same state,
//both are displayed for that state.
//DefineButton also includes an array of ACTIONRECORDs, which are performed when the
//button is clicked and released (see "SWF 3 actions" on page 68).

//The minimum file format version is SWF 1.

//DefineButton
//Field 			Type 						Comment
//Header 			RECORDHEADER 				Tag type = 7
//ButtonId 			UI16 						ID for this character
//Characters 		BUTTONRECORD[one or more]	Characters that make up the button
//CharacterEndFlag 	UI8 						Must be 0
//Actions 			ACTIONRECORD[zero or more]	Actions to perform
//ActionEndFlag 	UI8 						Must be 0

package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import zero.swf.BytesData;
	import zero.swf.records.buttons.BUTTONRECORD_within_DefineButton;
	
	public class DefineButton{
		
		public var id:int;//UI16
		public var CharacterV:Vector.<BUTTONRECORD_within_DefineButton>;
		public var Actions:*;
		
		public function DefineButton(){
			//id=0;
			//CharacterV=null;
			//Actions=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			var i:int=-1;
			CharacterV=new Vector.<BUTTONRECORD_within_DefineButton>();
			while(data[offset]){
				i++;
				
				CharacterV[i]=new BUTTONRECORD_within_DefineButton();
				offset=CharacterV[i].initByData(data,offset,endOffset,_initByDataOptions);
				
			}
			
			offset++;
			
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
			return Actions.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data.position=2;
			for each(var Character:BUTTONRECORD_within_DefineButton in CharacterV){
				
				data.writeBytes(Character.toData(_toDataOptions));
				
			}
			
			data[data.length]=0x00;//EndFlag
			
			data.position=data.length;
			data.writeBytes(Actions.toData(_toDataOptions));
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineButton"
				id={id}
			/>;
			
			if(CharacterV.length){
				var CharacterListXML:XML=<CharacterList count={CharacterV.length}/>;
				for each(var Character:BUTTONRECORD_within_DefineButton in CharacterV){
					
					CharacterListXML.appendChild(Character.toXML("Character",_toXMLOptions));
					
				}
				xml.appendChild(CharacterListXML);
			}
			
			xml.appendChild(Actions.toXML("Actions",_toXMLOptions));
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			id=int(xml.@id.toString());
			
			var i:int=-1;
			CharacterV=new Vector.<BUTTONRECORD_within_DefineButton>();
			for each(var CharacterXML:XML in xml.CharacterList.Character){
				i++;
				
				CharacterV[i]=new BUTTONRECORD_within_DefineButton();
				CharacterV[i].initByXML(CharacterXML,_initByXMLOptions);
				
			}
			
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