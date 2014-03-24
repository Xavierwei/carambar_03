/***
BUTTONRECORD_within_DefineButton
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年10月05日 10:16:39（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//A button record defines a character to be displayed in one or more button states. The
//ButtonState flags indicate which state (or states) the character belongs to.
//A one-to-one relationship does not exist between button records and button states. A single
//button record can apply to more than one button state (by setting multiple ButtonState flags),
//and multiple button records can be present for any button state.
//Each button record also includes a transformation matrix and depth (stacking-order)
//information. These apply just as in a PlaceObject tag, except that both pieces of information
//are relative to the button character itself.
//SWF 8 and later supports the new ButtonHasBlendMode and ButtonHasFilterList fields to
//support blend modes and bitmap filters on buttons. Flash Player 7 and earlier ignores these
//two fields.

//BUTTONRECORD
//Field 				Type 															Comment
//ButtonReserved 		UB[2] 															Reserved bits; always 0
//ButtonHasBlendMode 	UB[1] 															0 = No blend mode
//																						1 = Has blend mode (SWF 8 and later only)
//ButtonHasFilterList 	UB[1] 															0 = No filter list

//																						1 = Has filter list (SWF 8 and later only)
//ButtonStateHitTest 	UB[1] 															Present in hit test state
//ButtonStateDown 		UB[1] 															Present in down state
//ButtonStateOver 		UB[1] 															Present in over state
//ButtonStateUp 		UB[1] 															Present in up state
//CharacterID 			UI16 															ID of character to place
//PlaceDepth 			UI16 															Depth at which to place character
//PlaceMatrix 			MATRIX 															Transformation matrix for character placement
//ColorTransform 		If within DefineButton2,CXFORMWITHALPHA							Character color transform
//FilterList 			If within DefineButton2 and	ButtonHasFilterList = 1,FILTERLIST	List of filters on this button
//BlendMode 			If within DefineButton2 and ButtonHasBlendMode = 1,UI8			0 or 1 = normal
//																						2 = layer
//																						3 = multiply
//																						4 = screen
//																						5 = lighten
//																						6 = darken
//																						7 = difference
//																						8 = add
//																						9 = subtract
//																						10 = invert
//																						11 = alpha
//																						12 = erase
//																						13 = overlay
//																						14 = hardlight
//																						Values 15 to 255 are reserved.

package zero.swf.records.buttons{
	
	import flash.utils.ByteArray;
	import zero.swf.records.MATRIX;
	
	public class BUTTONRECORD_within_DefineButton{
		
		//public var Reserved:int;//11000000
		public var ButtonStateHitTest:Boolean;//00001000
		public var ButtonStateDown:Boolean;//00000100
		public var ButtonStateOver:Boolean;//00000010
		public var ButtonStateUp:Boolean;//00000001
		public var CharacterId:int;//UI16
		public var PlaceDepth:int;//UI16
		public var PlaceMatrix:MATRIX;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var flags:int=data[offset++];
			//Reserved=flags&0xc0;//11000000
			var ButtonHasBlendMode:Boolean=((flags&0x20)?true:false);//00100000
			var ButtonHasFilterList:Boolean=((flags&0x10)?true:false);//00010000
			ButtonStateHitTest=((flags&0x08)?true:false);//00001000
			ButtonStateDown=((flags&0x04)?true:false);//00000100
			ButtonStateOver=((flags&0x02)?true:false);//00000010
			ButtonStateUp=((flags&0x01)?true:false);//00000001
			
			CharacterId=data[offset++]|(data[offset++]<<8);
			
			PlaceDepth=data[offset++]|(data[offset++]<<8);
			
			PlaceMatrix=new MATRIX();
			return PlaceMatrix.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			var flags:int=0;
			//flags|=Reserved;//11110000
			if(ButtonStateHitTest){
				flags|=0x08;//00001000
			}
			if(ButtonStateDown){
				flags|=0x04;//00000100
			}
			if(ButtonStateOver){
				flags|=0x02;//00000010
			}
			if(ButtonStateUp){
				flags|=0x01;//00000001
			}
			data[0]=flags;
			
			data[1]=CharacterId;
			data[2]=CharacterId>>8;
			
			data[3]=PlaceDepth;
			data[4]=PlaceDepth>>8;
			
			data.position=5;
			data.writeBytes(PlaceMatrix.toData(_toDataOptions));
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.records.buttons.BUTTONRECORD_within_DefineButton"
					ButtonStateHitTest={ButtonStateHitTest}
					ButtonStateDown={ButtonStateDown}
					ButtonStateOver={ButtonStateOver}
					ButtonStateUp={ButtonStateUp}
					CharacterId={CharacterId}
					PlaceDepth={PlaceDepth}
				/>;
				
				xml.appendChild(PlaceMatrix.toXML("PlaceMatrix",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				ButtonStateHitTest=(xml.@ButtonStateHitTest.toString()=="true");
				ButtonStateDown=(xml.@ButtonStateDown.toString()=="true");
				ButtonStateOver=(xml.@ButtonStateOver.toString()=="true");
				ButtonStateUp=(xml.@ButtonStateUp.toString()=="true");
				
				CharacterId=int(xml.@CharacterId.toString());
				
				PlaceDepth=int(xml.@PlaceDepth.toString());
				
				PlaceMatrix=new MATRIX();
				PlaceMatrix.initByXML(xml.PlaceMatrix[0],_initByXMLOptions);
				
			}
		//}//end of CONFIG::USE_XML
	}
}