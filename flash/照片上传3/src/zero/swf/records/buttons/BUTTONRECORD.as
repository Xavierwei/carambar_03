/***
BUTTONRECORD
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月30日 10:30:25（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
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
	
	import zero.swf.records.CXFORMWITHALPHA;
	import zero.swf.records.Filter;
	import zero.swf.records.MATRIX;
	
	public class BUTTONRECORD{
		
		//public var Reserved:int;//11000000
		public var ButtonStateHitTest:Boolean;//00001000
		public var ButtonStateDown:Boolean;//00000100
		public var ButtonStateOver:Boolean;//00000010
		public var ButtonStateUp:Boolean;//00000001
		public var CharacterId:int;//UI16
		public var PlaceDepth:int;//UI16
		public var PlaceMatrix:MATRIX;
		public var ColorTransform:CXFORMWITHALPHA;
		public var filterV:Vector.<Filter>;
		public var BlendMode:int;//UI8
		
		public function BUTTONRECORD(){
		}
		
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
			offset=PlaceMatrix.initByData(data,offset,endOffset,_initByDataOptions);
			
			ColorTransform=new CXFORMWITHALPHA();
			offset=ColorTransform.initByData(data,offset,endOffset,_initByDataOptions);
			
			if(ButtonHasFilterList){
				var NumberOfFilters:int=data[offset++];
				if(NumberOfFilters){
					filterV=new Vector.<Filter>();
					for(var i:int=0;i<NumberOfFilters;i++){
						
						filterV[i]=new Filter();
						offset=filterV[i].initByData(data,offset,endOffset,_initByDataOptions);
						
					}
				}else{
					filterV=null;
				}
			}else{
				filterV=null;
			}
			
			if(ButtonHasBlendMode){
				BlendMode=data[offset++];
			}else{
				BlendMode=-1;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			var flags:int=0;
			//flags|=Reserved;//11000000
			if(BlendMode>-1){
				flags|=0x20;//ButtonHasBlendMode//00100000
			}
			if(filterV&&filterV.length){
				flags|=0x10;//ButtonHasFilterList//00010000
			}
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
			
			data.writeBytes(ColorTransform.toData(_toDataOptions));
			
			if(filterV){
				var NumberOfFilters:int=filterV.length;
				if(NumberOfFilters){
					
					data[data.length]=NumberOfFilters;
					
					data.position=data.length;
					
					for each(var filter:Filter in filterV){
						
						data.writeBytes(filter.toData(_toDataOptions));
						
					}
				}
			}
			
			if(BlendMode>-1){
				data[data.length]=BlendMode;
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			import zero.swf.records.BlendModes;
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.records.buttons.BUTTONRECORD"
					ButtonStateHitTest={ButtonStateHitTest}
					ButtonStateDown={ButtonStateDown}
					ButtonStateOver={ButtonStateOver}
					ButtonStateUp={ButtonStateUp}
					CharacterId={CharacterId}
					PlaceDepth={PlaceDepth}
				/>;
				
				xml.appendChild(PlaceMatrix.toXML("PlaceMatrix",_toXMLOptions));
				
				xml.appendChild(ColorTransform.toXML("ColorTransform",_toXMLOptions));
				
				if(filterV){
					if(filterV.length){
						var filterListXML:XML=<filterList count={filterV.length}/>;
						for each(var filter:Filter in filterV){
							
							filterListXML.appendChild(filter.toXML("filter",_toXMLOptions));
							
						}
						xml.appendChild(filterListXML);
					}
				}
				
				if(BlendMode>-1){
					xml.@BlendMode=BlendModes.blendModeV[BlendMode];
				}
				
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
				
				ColorTransform=new CXFORMWITHALPHA();
				ColorTransform.initByXML(xml.ColorTransform[0],_initByXMLOptions);
				
				var filterXMLList:XMLList=xml.filterList.filter;
				if(filterXMLList.length()){
					var i:int=-1;
					filterV=new Vector.<Filter>();
					for each(var filterXML:XML in filterXMLList){
						i++;
						
						filterV[i]=new Filter();
						filterV[i].initByXML(filterXML,_initByXMLOptions);
						
					}
				}else{
					filterV=null;
				}
				
				var BlendModeXML:XML=xml.@BlendMode[0];
				if(BlendModeXML){
					BlendMode=BlendModes[BlendModeXML.toString()];
				}else{
					BlendMode=-1;
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}