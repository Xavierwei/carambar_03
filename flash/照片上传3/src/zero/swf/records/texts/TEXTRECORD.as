/***
TEXTRECORD
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月17日 00:25:11
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//Text records
//A TEXTRECORD sets text styles for subsequent characters. It can be used to select a font,
//change the text color, change the point size, insert a line break, or set the x and y position of
//the next character in the text. The new text styles apply until another TEXTRECORD
//changes the styles.
//
//The TEXTRECORD also defines the actual characters in a text object. Characters are
//referred to by an index into the current font's glyph table, not by a character code. Each
//TEXTRECORD contains a group of characters that all share the same text style, and are on
//the same line of text.
//
//TEXTRECORD
//Field 							Type 												Comment
//TextRecordType 					UB[1] 												Always 1.
//StyleFlagsReserved 				UB[3] 												Always 0.
//StyleFlagsHasFont 				UB[1] 												1 if text font specified.
//StyleFlagsHasColor 				UB[1] 												1 if text color specified.
//StyleFlagsHasYOffset 				UB[1] 												1 if y offset specified.
//StyleFlagsHasXOffset 				UB[1] 												1 if x offset specified.
//FontID 							If StyleFlagsHasFont, UI16 							Font ID for following text.
//TextColor 						If StyleFlagsHasColor, RGB							Font color for following text.	
//									If this record is part of a DefineText2 tag, RGBA
//XOffset 							If StyleFlagsHasXOffset, SI16 						x offset for following text.
//YOffset 							If StyleFlagsHasYOffset, SI16 						y offset for following text.
//TextHeight 						If hasFont, UI16 									Font height for following text.
//GlyphCount 						UI8 Number of glyphs in record.
//GlyphEntries 						GLYPHENTRY[GlyphCount] 								Glyph entry (see following).

//Glyph entry
//The GLYPHENTRY structure describes a single character in a line of text. It is composed of
//an index into the current font’s glyph table, and an advance value. The advance value is the
//horizontal distance between the reference point of this character and the reference point of the
//following character.
	
//GLYPHENTRY
//Field 			Type 				Comment
//GlyphIndex 		UB[GlyphBits] 		Glyph index into current font.
//GlyphAdvance 		SB[AdvanceBits] 	x advance value for glyph.
package zero.swf.records.texts{
	import flash.utils.ByteArray;
	import zero.BytesAndStr16;
	import zero.swf.BytesData;
	import zero.swf.records.MATRIX;
	import zero.swf.records.RECT;
	import zero.swf.records.texts.TEXTRECORD;
	public class TEXTRECORD{
		public var FontID:int;
		public var StyleFlagsHasColor:Boolean;
		public var TextColor:uint;
		public var StyleFlagsHasXOffset:Boolean;
		public var XOffset:int;
		public var StyleFlagsHasYOffset:Boolean;
		public var YOffset:int;
		public var TextHeight:int;
		public var GlyphIndexV:Vector.<int>;
		public var GlyphAdvanceV:Vector.<int>;
		//
		
		public function TEXTRECORD(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			//import zero.BytesAndStr16;
			//trace("--"+BytesAndStr16.bytes2str16(data,offset,endOffset-offset));
			
			if(_initByDataOptions){
			}else{
				throw new Error("需要提供 _initByDataOptions");
			}
			
			var flags:int=data[offset++];
			//TextRecordType&0x80								//10000000
			//Reserved=flags&0x70;								//01110000
			StyleFlagsHasColor=((flags&0x04)?true:false);		//00000100
			StyleFlagsHasYOffset=((flags&0x02)?true:false);	//00000010
			StyleFlagsHasXOffset=((flags&0x01)?true:false);	//00000001
			if(flags&0x08){//StyleFlagsHasFont					//00001000
				FontID=data[offset++]|(data[offset++]<<8);
			}else{
				FontID=-1;
			}
			if(StyleFlagsHasColor){
				if(_initByDataOptions.TextColorUseRGBA){//20110817
					TextColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				}else{
					TextColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
				}
			}
			if(StyleFlagsHasXOffset){
				XOffset=data[offset++]|(data[offset++]<<8);
				if(XOffset&0x00008000){XOffset|=0xffff0000}//最高位为1,表示负数
			}
			if(StyleFlagsHasYOffset){
				YOffset=data[offset++]|(data[offset++]<<8);
				if(YOffset&0x00008000){YOffset|=0xffff0000}//最高位为1,表示负数
			}
			if(flags&0x08){//StyleFlagsHasFont				//00001000
				TextHeight=data[offset++]|(data[offset++]<<8);
			}else{
				TextHeight=-1;
			}
			
			var GlyphCount:int=data[offset++];
			
			var bGroupValue:int=(data[offset++]<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
			var bGroupBitsOffset:int=0;
			
			var bGroupRshiftBitsOffset1:int=32-_initByDataOptions.GlyphBits;
			var bGroupRshiftBitsOffset2:int=32-_initByDataOptions.AdvanceBits;
			var bGroupNegMask2:int=1<<(_initByDataOptions.AdvanceBits-1);
			var bGroupNeg2:int=0xffffffff<<_initByDataOptions.AdvanceBits;
			
			GlyphIndexV=new Vector.<int>();
			GlyphAdvanceV=new Vector.<int>();
			for(var i:int=0;i<GlyphCount;i++){
				if(_initByDataOptions.GlyphBits){
					GlyphIndexV[i]=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset1;
					bGroupBitsOffset+=_initByDataOptions.GlyphBits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
				
				}else{
					GlyphIndexV[i]=0;
				}
				if(_initByDataOptions.AdvanceBits){
					GlyphAdvanceV[i]=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset2;
					if(GlyphAdvanceV[i]&bGroupNegMask2){GlyphAdvanceV[i]|=bGroupNeg2;}//最高位为1,表示负数
					bGroupBitsOffset+=_initByDataOptions.AdvanceBits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
				}else{
					GlyphAdvanceV[i]=0;
				}
			}
			
			return offset-int(4-bGroupBitsOffset/8);
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			if(_toDataOptions){
			}else{
				throw new Error("需要提供 _toDataOptions");
			}
			
			var data:ByteArray=new ByteArray();
			var flags:int=0x80;//TextRecordType
			if(FontID>-1){
				flags|=0x08;
				data[1]=FontID;
				data[2]=FontID>>8;
				var offset:int=3;
			}else{
				offset=1;
			}
			if(StyleFlagsHasColor){
				flags|=0x04;
				if(_toDataOptions.TextColorUseRGBA){//20110817
					data[offset++]=TextColor>>16;
					data[offset++]=TextColor>>8;
					data[offset++]=TextColor;
					data[offset++]=TextColor>>24;
				}else{
					data[offset++]=TextColor>>16;
					data[offset++]=TextColor>>8;
					data[offset++]=TextColor;
				}
			}
			if(StyleFlagsHasXOffset){
				flags|=0x01;
				data[offset++]=XOffset;
				data[offset++]=XOffset>>8;
			}
			if(StyleFlagsHasYOffset){
				flags|=0x02;
				data[offset++]=YOffset;
				data[offset++]=YOffset>>8;
			}
			if(TextHeight>-1){
				data[offset++]=TextHeight;
				data[offset++]=TextHeight>>8;
			}
			
			data[0]=flags;
			
			data[offset++]=GlyphIndexV.length;
			
			var bGroupValue:int=0;
			var bGroupBitsOffset:int=0;
			var bGroupRshiftBitsOffset1:int=32-_toDataOptions.GlyphBits;
			var bGroupRshiftBitsOffset2:int=32-_toDataOptions.AdvanceBits;
			
			//trace("GlyphBits="+_toDataOptions.GlyphBits);
			//trace("AdvanceBits="+_toDataOptions.AdvanceBits);
			
			//trace("GlyphIndexV="+GlyphIndexV);
			//trace("GlyphAdvanceV="+GlyphAdvanceV);
			
			var i:int=-1;
			for each(var GlyphIndex:int in GlyphIndexV){
				i++;
				
				bGroupValue|=(GlyphIndex<<bGroupRshiftBitsOffset1)>>>bGroupBitsOffset;
				bGroupBitsOffset+=_toDataOptions.GlyphBits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
				bGroupValue|=(GlyphAdvanceV[i]<<bGroupRshiftBitsOffset2)>>>bGroupBitsOffset;
				bGroupBitsOffset+=_toDataOptions.AdvanceBits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
			}
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;data[offset++]=bGroupValue;}else{data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;}else{data[offset++]=bGroupValue>>24;}
			
			
			//import zero.BytesAndStr16;
			//trace("--"+BytesAndStr16.bytes2str16(data,0,data.length));
			
			return data;
		}
		
		////
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.texts.TEXTRECORD"/>;
				if(FontID>-1){
					xml.@FontID=FontID;
				}
				if(StyleFlagsHasColor){
					if(_toXMLOptions&&_toXMLOptions.TextColorUseRGBA){//20110817
						xml.@TextColor="0x"+BytesAndStr16._16V[(TextColor>>24)&0xff]+BytesAndStr16._16V[(TextColor>>16)&0xff]+BytesAndStr16._16V[(TextColor>>8)&0xff]+BytesAndStr16._16V[TextColor&0xff];
					}else{
						xml.@TextColor="0x"+BytesAndStr16._16V[(TextColor>>16)&0xff]+BytesAndStr16._16V[(TextColor>>8)&0xff]+BytesAndStr16._16V[TextColor&0xff];
					}
				}
				if(StyleFlagsHasXOffset){
					xml.@XOffset=XOffset;
				}
				if(StyleFlagsHasYOffset){
					xml.@YOffset=YOffset;
				}
				if(TextHeight>-1){
					xml.@TextHeight=TextHeight;
				}
				if(GlyphIndexV.length){
					var GlyphIndexAndGlyphAdvanceListXML:XML=<GlyphIndexAndGlyphAdvanceList count={GlyphIndexV.length}/>
					var i:int=-1;
					for each(var GlyphIndex:int in GlyphIndexV){
						i++;
						GlyphIndexAndGlyphAdvanceListXML.appendChild(<GlyphIndex value={GlyphIndex}/>);
						GlyphIndexAndGlyphAdvanceListXML.appendChild(<GlyphAdvance value={GlyphAdvanceV[i]}/>);
					}
					xml.appendChild(GlyphIndexAndGlyphAdvanceListXML);
				}
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				var FontIDXML:XML=xml.@FontID[0];
				if(FontIDXML){
					FontID=int(FontIDXML.toString());
				}else{
					FontID=-1;
				}
				var TextColorXML:XML=xml.@TextColor[0];
				if(TextColorXML){
					StyleFlagsHasColor=true;
					TextColor=uint(TextColorXML.toString());
				}else{
					StyleFlagsHasColor=false;
				}
				var XOffsetXML:XML=xml.@XOffset[0];
				if(XOffsetXML){
					StyleFlagsHasXOffset=true;
					XOffset=int(XOffsetXML.toString());
				}else{
					StyleFlagsHasXOffset=false;
				}
				var YOffsetXML:XML=xml.@YOffset[0];
				if(YOffsetXML){
					StyleFlagsHasYOffset=true;
					YOffset=int(YOffsetXML.toString());
				}else{
					StyleFlagsHasYOffset=false;
				}
				var TextHeightXML:XML=xml.@TextHeight[0];
				if(TextHeightXML){
					TextHeight=int(TextHeightXML.toString());
				}else{
					TextHeight=-1;
				}
				var GlyphAdvanceXMLList:XMLList=xml.GlyphIndexAndGlyphAdvanceList.GlyphAdvance;
				var i:int=-1;
				GlyphIndexV=new Vector.<int>();
				GlyphAdvanceV=new Vector.<int>();
				for each(var GlyphIndexXML:XML in xml.GlyphIndexAndGlyphAdvanceList.GlyphIndex){
					i++;
					GlyphIndexV[i]=int(GlyphIndexXML.@value.toString());
					GlyphAdvanceV[i]=int(GlyphAdvanceXMLList[i].@value.toString());
				}
			}
		//}//end of CONFIG::USE_XML
	}
}