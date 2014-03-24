/***
DefineText2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月25日 15:10:36（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineText2
//The DefineText2 tag is almost identical to the DefineText tag. The only difference is that
//Type 1 text records contained within a DefineText2 tag use an RGBA value (rather than an
//RGB value) to define TextColor. This allows partially or completely transparent characters.
//Text defined with DefineText2 is always rendered with glyphs. Device text can never
//include transparency.
//
//The minimum file format version is SWF 3.
//
//DefineText2
//Field 				Type 						Comment
//Header 				RECORDHEADER 				Tag type = 33.
//CharacterID 			UI16 						ID for this text character.
//TextBounds 			RECT 						Bounds of the text.
//TextMatrix 			MATRIX 						Transformation matrix.
//GlyphBits 			UI8 						Bits in each glyph index.
//AdvanceBits 			UI8 						Bits in each advance value.
//TextRecords 			TEXTRECORD[zero or more] 	Text records.
//EndOfRecordsFlag 		UI8 						Must be 0.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.RECT;
	import zero.swf.records.MATRIX;
	import zero.swf.records.texts.TEXTRECORD;
	
	public class DefineText2{
		
		public var id:int;//UI16
		public var TextBounds:RECT;
		public var TextMatrix:MATRIX;
		public var TextRecordV:Vector.<TEXTRECORD>;
		
		public function DefineText2(){
			//id=0;
			//TextBounds=null;
			//TextMatrix=null;
			//TextRecordV=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(_initByDataOptions){
			}else{
				_initByDataOptions=new Object();
			}
			_initByDataOptions.TextColorUseRGBA=true;//20110817
			
			id=data[offset++]|(data[offset++]<<8);
			
			TextBounds=new RECT();
			offset=TextBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			TextMatrix=new MATRIX();
			offset=TextMatrix.initByData(data,offset,endOffset,_initByDataOptions);
			
			_initByDataOptions.GlyphBits=data[offset++];
			
			_initByDataOptions.AdvanceBits=data[offset++];
			
			var i:int=-1;
			TextRecordV=new Vector.<TEXTRECORD>();
			while(data[offset]){
				i++;
				
				TextRecordV[i]=new TEXTRECORD();
				offset=TextRecordV[i].initByData(data,offset,endOffset,_initByDataOptions);
				
			}
			
			return offset+1;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			if(_toDataOptions){
			}else{
				_toDataOptions=new Object();
			}
			_toDataOptions.TextColorUseRGBA=true;//20110817
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data.position=2;
			data.writeBytes(TextBounds.toData(_toDataOptions));
			
			data.writeBytes(TextMatrix.toData(_toDataOptions));
			
			//计算所需最小位数:
			var bGroupMixNum1:int=0;
			var bGroupMixNum2:int=0;
			for each(TextRecord in TextRecordV){
				var i:int=-1;
				for each(var GlyphIndex:int in TextRecord.GlyphIndexV){
					i++;
					bGroupMixNum1|=GlyphIndex;
					var GlyphAdvance:int=TextRecord.GlyphAdvanceV[i];
					bGroupMixNum2|=(GlyphAdvance<0?-GlyphAdvance:GlyphAdvance)<<1;
				}
				
			}
			if(bGroupMixNum1>>>16){if(bGroupMixNum1>>>24){if(bGroupMixNum1>>>28){if(bGroupMixNum1>>>30){if(bGroupMixNum1>>>31){_toDataOptions.GlyphBits=32;}else{_toDataOptions.GlyphBits=31;}}else{if(bGroupMixNum1>>>29){_toDataOptions.GlyphBits=30;}else{_toDataOptions.GlyphBits=29;}}}else{if(bGroupMixNum1>>>26){if(bGroupMixNum1>>>27){_toDataOptions.GlyphBits=28;}else{_toDataOptions.GlyphBits=27;}}else{if(bGroupMixNum1>>>25){_toDataOptions.GlyphBits=26;}else{_toDataOptions.GlyphBits=25;}}}}else{if(bGroupMixNum1>>>20){if(bGroupMixNum1>>>22){if(bGroupMixNum1>>>23){_toDataOptions.GlyphBits=24;}else{_toDataOptions.GlyphBits=23;}}else{if(bGroupMixNum1>>>21){_toDataOptions.GlyphBits=22;}else{_toDataOptions.GlyphBits=21;}}}else{if(bGroupMixNum1>>>18){if(bGroupMixNum1>>>19){_toDataOptions.GlyphBits=20;}else{_toDataOptions.GlyphBits=19;}}else{if(bGroupMixNum1>>>17){_toDataOptions.GlyphBits=18;}else{_toDataOptions.GlyphBits=17;}}}}}else{if(bGroupMixNum1>>>8){if(bGroupMixNum1>>>12){if(bGroupMixNum1>>>14){if(bGroupMixNum1>>>15){_toDataOptions.GlyphBits=16;}else{_toDataOptions.GlyphBits=15;}}else{if(bGroupMixNum1>>>13){_toDataOptions.GlyphBits=14;}else{_toDataOptions.GlyphBits=13;}}}else{if(bGroupMixNum1>>>10){if(bGroupMixNum1>>>11){_toDataOptions.GlyphBits=12;}else{_toDataOptions.GlyphBits=11;}}else{if(bGroupMixNum1>>>9){_toDataOptions.GlyphBits=10;}else{_toDataOptions.GlyphBits=9;}}}}else{if(bGroupMixNum1>>>4){if(bGroupMixNum1>>>6){if(bGroupMixNum1>>>7){_toDataOptions.GlyphBits=8;}else{_toDataOptions.GlyphBits=7;}}else{if(bGroupMixNum1>>>5){_toDataOptions.GlyphBits=6;}else{_toDataOptions.GlyphBits=5;}}}else{if(bGroupMixNum1>>>2){if(bGroupMixNum1>>>3){_toDataOptions.GlyphBits=4;}else{_toDataOptions.GlyphBits=3;}}else{if(bGroupMixNum1>>>1){_toDataOptions.GlyphBits=2;}else{_toDataOptions.GlyphBits=bGroupMixNum1;}}}}}
			if(bGroupMixNum2>>>16){if(bGroupMixNum2>>>24){if(bGroupMixNum2>>>28){if(bGroupMixNum2>>>30){if(bGroupMixNum2>>>31){_toDataOptions.AdvanceBits=32;}else{_toDataOptions.AdvanceBits=31;}}else{if(bGroupMixNum2>>>29){_toDataOptions.AdvanceBits=30;}else{_toDataOptions.AdvanceBits=29;}}}else{if(bGroupMixNum2>>>26){if(bGroupMixNum2>>>27){_toDataOptions.AdvanceBits=28;}else{_toDataOptions.AdvanceBits=27;}}else{if(bGroupMixNum2>>>25){_toDataOptions.AdvanceBits=26;}else{_toDataOptions.AdvanceBits=25;}}}}else{if(bGroupMixNum2>>>20){if(bGroupMixNum2>>>22){if(bGroupMixNum2>>>23){_toDataOptions.AdvanceBits=24;}else{_toDataOptions.AdvanceBits=23;}}else{if(bGroupMixNum2>>>21){_toDataOptions.AdvanceBits=22;}else{_toDataOptions.AdvanceBits=21;}}}else{if(bGroupMixNum2>>>18){if(bGroupMixNum2>>>19){_toDataOptions.AdvanceBits=20;}else{_toDataOptions.AdvanceBits=19;}}else{if(bGroupMixNum2>>>17){_toDataOptions.AdvanceBits=18;}else{_toDataOptions.AdvanceBits=17;}}}}}else{if(bGroupMixNum2>>>8){if(bGroupMixNum2>>>12){if(bGroupMixNum2>>>14){if(bGroupMixNum2>>>15){_toDataOptions.AdvanceBits=16;}else{_toDataOptions.AdvanceBits=15;}}else{if(bGroupMixNum2>>>13){_toDataOptions.AdvanceBits=14;}else{_toDataOptions.AdvanceBits=13;}}}else{if(bGroupMixNum2>>>10){if(bGroupMixNum2>>>11){_toDataOptions.AdvanceBits=12;}else{_toDataOptions.AdvanceBits=11;}}else{if(bGroupMixNum2>>>9){_toDataOptions.AdvanceBits=10;}else{_toDataOptions.AdvanceBits=9;}}}}else{if(bGroupMixNum2>>>4){if(bGroupMixNum2>>>6){if(bGroupMixNum2>>>7){_toDataOptions.AdvanceBits=8;}else{_toDataOptions.AdvanceBits=7;}}else{if(bGroupMixNum2>>>5){_toDataOptions.AdvanceBits=6;}else{_toDataOptions.AdvanceBits=5;}}}else{if(bGroupMixNum2>>>2){if(bGroupMixNum2>>>3){_toDataOptions.AdvanceBits=4;}else{_toDataOptions.AdvanceBits=3;}}else{if(bGroupMixNum2>>>1){_toDataOptions.AdvanceBits=2;}else{_toDataOptions.AdvanceBits=bGroupMixNum2;}}}}}
			
			data[data.length]=_toDataOptions.GlyphBits;
			
			data[data.length]=_toDataOptions.AdvanceBits;
			
			data.position=data.length;
			for each(var TextRecord:TEXTRECORD in TextRecordV){
				
				data.writeBytes(TextRecord.toData(_toDataOptions));
				
			}
			
			data[data.length]=0x00;//EndFlag
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				if(_toXMLOptions){
				}else{
					_toXMLOptions=new Object();
				}
				_toXMLOptions.TextColorUseRGBA=true;//20110817
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineText2"
					id={id}
				/>;
				
				xml.appendChild(TextBounds.toXML("TextBounds",_toXMLOptions));
				
				xml.appendChild(TextMatrix.toXML("TextMatrix",_toXMLOptions));
				
				if(TextRecordV.length){
					var TextRecordListXML:XML=<TextRecordList count={TextRecordV.length}/>;
					for each(var TextRecord:TEXTRECORD in TextRecordV){
						
						TextRecordListXML.appendChild(TextRecord.toXML("TextRecord",_toXMLOptions));
						
					}
					xml.appendChild(TextRecordListXML);
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				TextBounds=new RECT();
				TextBounds.initByXML(xml.TextBounds[0],_initByXMLOptions);
				
				TextMatrix=new MATRIX();
				TextMatrix.initByXML(xml.TextMatrix[0],_initByXMLOptions);
				
				var i:int=-1;
				TextRecordV=new Vector.<TEXTRECORD>();
				for each(var TextRecordXML:XML in xml.TextRecordList.TextRecord){
					i++;
					
					TextRecordV[i]=new TEXTRECORD();
					TextRecordV[i].initByXML(TextRecordXML,_initByXMLOptions);
					
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}