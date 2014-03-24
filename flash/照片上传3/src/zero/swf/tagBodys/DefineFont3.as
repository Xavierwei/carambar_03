/***
DefineFont3
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月30日 06:40:58（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineFont3
//The DefineFont3 tag is introduced along with the DefineFontAlignZones tag in SWF 8. The
//DefineFontAlignZones tag is optional but recommended for SWF files using advanced antialiasing,
//and it modifies the DefineFont3 tag.
//The DefineFont3 tag extends the functionality of DefineFont2 by expressing the SHAPE
//coordinates in the GlyphShapeTable at 20 times the resolution. All the EMSquare coordinates
//are multiplied by 20 at export, allowing fractional resolution to 1/20 of a unit. This allows for
//more precisely defined glyphs and results in better visual quality.
//The minimum file format version is SWF 8.

//DefineFont3
//Field 					Type 												Comment
//Header 					RECORDHEADER 										Tag type = 75.
//FontID 					UI16 												ID for this font character.
//FontFlagsHasLayout 		UB[1] 												Has font metrics/layout information.
//FontFlagsShiftJIS 		UB[1] 												ShiftJIS encoding.
//FontFlagsSmallText 		UB[1] 												SWF 7 or later: Font is small. Character glyphs are aligned on pixel boundaries for dynamic and input text.
//FontFlagsANSI 			UB[1] 												ANSI encoding.
//FontFlagsWideOffsets 		UB[1] 												If 1, uses 32 bit offsets.
//FontFlagsWideCodes 		UB[1] 												Must be 1.
//FontFlagsItalic 			UB[1] 												Italic Font.
//FontFlagsBold 			UB[1] 												Bold Font.
//LanguageCode 				LANGCODE 											SWF 5 or earlier: always 0
//																				SWF 6 or later: language code
//FontNameLen 				UI8 												Length of name.
//FontName 					UI8[FontNameLen]									Name of font (see DefineFontInfo).
//NumGlyphs 				UI16 												Count of glyphs in font. May be zero for device fonts.
//OffsetTable 				If FontFlagsWideOffsets, UI32[NumGlyphs]			Same as in DefineFont.
//							Otherwise UI16[NumGlyphs]
//CodeTableOffset 			If FontFlagsWideOffsets, UI32						Byte count from start of OffsetTable to start of CodeTable.
//							Otherwise UI16
//GlyphShapeTable 			SHAPE[NumGlyphs] 									Same as in DefineFont.
//CodeTable 				UI16[NumGlyphs] 									Sorted in ascending order. Always UCS-2 in SWF 6 or later.
//FontAscent 				If FontFlagsHasLayout, SI16 						Font ascender height.
//FontDescent 				If FontFlagsHasLayout, SI16 						Font descender height.
//FontLeading 				If FontFlagsHasLayout, SI16 						Font leading height (see following).
//FontAdvanceTable 			If FontFlagsHasLayout, SI16[NumGlyphs]				Advance value to be used for each glyph in dynamic glyph text.
//FontBoundsTable 			If FontFlagsHasLayout, RECT[NumGlyphs]				Not used in Flash Player through version 7 (but must be present).
//KerningCount 				If FontFlagsHasLayout, UI16 						Not used in Flash Player through version 7 (always set to 0 to save space).
//FontKerningTable 			If FontFlagsHasLayout, KERNINGRECORD[KerningCount]	Not used in Flash Player through version 7 (omit with KerningCount of 0).

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	import zero.swf.records.shapes.SHAPE;
	import zero.swf.records.texts.FONTLAYOUT;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class DefineFont3{
		
		public var id:int;//UI16
		public var FontFlagsShiftJIS:Boolean;//01000000
		public var FontFlagsSmallText:Boolean;//00100000
		public var FontFlagsANSI:Boolean;//00010000
		private var FontFlagsWideCodes:Boolean;//00000100
		public var FontFlagsItalic:Boolean;//00000010
		public var FontFlagsBold:Boolean;//00000001
		public var LanguageCode:int;//LANGCODE
		public var FontName:String;//STRING
		public var GlyphShapeV:Vector.<SHAPE>;
		public var CodeV:Vector.<int>;//UI16
		public var fontLayout:FONTLAYOUT;
		
		public function DefineFont3(){
			//id=0;
			//FontFlagsShiftJIS=false;
			//FontFlagsSmallText=false;
			//FontFlagsANSI=false;
			FontFlagsWideCodes=true;
			//FontFlagsItalic=false;
			//FontFlagsBold=false;
			//LanguageCode=0;
			//FontName=null;
			//GlyphShapeV=null;
			//CodeV=null;
			//fontLayout=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			var flags:int=data[offset++];
			var FontFlagsHasLayout:Boolean=((flags&0x80)?true:false);//10000000
			FontFlagsShiftJIS=((flags&0x40)?true:false);//01000000
			FontFlagsSmallText=((flags&0x20)?true:false);//00100000
			FontFlagsANSI=((flags&0x10)?true:false);//00010000
			var FontFlagsWideOffsets:Boolean=((flags&0x08)?true:false);//00001000
			FontFlagsWideCodes=((flags&0x04)?true:false);//00000100
			FontFlagsItalic=((flags&0x02)?true:false);//00000010
			FontFlagsBold=((flags&0x01)?true:false);//00000001
			
			LanguageCode=data[offset++];
			
			var FontNameLen:int=data[offset++];
			data.position=offset;
			FontName=ignoreBOMReadUTFBytes(data,FontNameLen);
			offset+=FontNameLen;
			
			var NumGlyphs:int=data[offset++]|(data[offset++]<<8);
			if(FontFlagsWideOffsets){
				
				offset+=4*(NumGlyphs+1);//OffsetV，CodeTableOffset
				
			}else{
				
				offset+=2*(NumGlyphs+1);//OffsetV，CodeTableOffset
				
			}
			
			if(NumGlyphs==0){//20110914
				if(offset==endOffset+2){
					offset=endOffset;
				}
			}
			
			GlyphShapeV=new Vector.<SHAPE>();
			for(var i:int=0;i<NumGlyphs;i++){
				
				GlyphShapeV[i]=new SHAPE();
				offset=GlyphShapeV[i].initByData(data,offset,endOffset,_initByDataOptions);
				
			}
			
			CodeV=new Vector.<int>();
			for(i=0;i<NumGlyphs;i++){
				
				CodeV[i]=data[offset++]|(data[offset++]<<8);
				
			}
			
			if(FontFlagsHasLayout||(offset<endOffset)){
				if(_initByDataOptions){
				}else{
					_initByDataOptions=new Object();
				}
				_initByDataOptions.NumGlyphs=NumGlyphs;//20110830
				_initByDataOptions.FontFlagsWideCodes=true;//20110830
				fontLayout=new FONTLAYOUT();
				offset=fontLayout.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				fontLayout=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			var NumGlyphs:int=GlyphShapeV.length;
			var GlyphShapesData:ByteArray=new ByteArray();
			var GlyphShapeDOffsetV:Vector.<int>=new Vector.<int>();
			for each(var GlyphShape:SHAPE in GlyphShapeV){
				GlyphShapeDOffsetV.push(GlyphShapesData.length);//DOffset
				GlyphShapesData.writeBytes(GlyphShape.toData(_toDataOptions));
			}
			GlyphShapeDOffsetV.push(GlyphShapesData.length);//DCodeTableOffset
			
			if((NumGlyphs+1)*2+GlyphShapesData.length>0xffff){
				var FontFlagsWideOffsets:Boolean=true;
			}else{
				FontFlagsWideOffsets=false;
			}
			
			var flags:int=0;
			if(fontLayout){
				flags|=0x80;//FontFlagsHasLayout//10000000
			}
			if(FontFlagsShiftJIS){
				flags|=0x40;//01000000
			}
			if(FontFlagsSmallText){
				flags|=0x20;//00100000
			}
			if(FontFlagsANSI){
				flags|=0x10;//00010000
			}
			if(FontFlagsWideOffsets){
				flags|=0x08;//00001000
			}
			if(FontFlagsWideCodes){
				flags|=0x04;//00000100
			}
			if(FontFlagsItalic){
				flags|=0x02;//00000010
			}
			if(FontFlagsBold){
				flags|=0x01;//00000001
			}
			data[2]=flags;
			
			data[3]=LanguageCode;
			
			var set_str_data:ByteArray=new ByteArray();
			set_str_data.writeUTFBytes(FontName+"\x00");
//			//20111208
//			if(FontName){
//				for each(var c:String in FontName.split("")){
//					if(c.charCodeAt(0)>0xff){
//						set_str_data.writeUTFBytes(c);
//					}else{
//						set_str_data.writeByte(c.charCodeAt(0));
//					}
//				}
//			}
//			set_str_data.writeByte(0x00);
			if(set_str_data.length>0xff){
				throw new Error("set_str_data.length="+set_str_data.length);
			}
			data[4]=set_str_data.length;
			data.position=5;
			data.writeBytes(set_str_data);
			
			data[data.length]=NumGlyphs;
			data[data.length]=NumGlyphs>>8;
			
			if(FontFlagsWideOffsets){
				var OffsetsLen:int=(NumGlyphs+1)*4;
				for each(var DOffset:int in GlyphShapeDOffsetV){//GlyphShapeDOffsetV 的最后一个是 CodeTableOffset
					
					var Offset:int=DOffset+OffsetsLen;
					
					data[data.length]=Offset;
					data[data.length]=Offset>>8;
					data[data.length]=Offset>>16;
					data[data.length]=Offset>>24;
					
				}
			}else{
				OffsetsLen=(NumGlyphs+1)*2;
				for each(DOffset in GlyphShapeDOffsetV){//GlyphShapeDOffsetV 的最后一个是 CodeTableOffset
					
					Offset=DOffset+OffsetsLen;
					data[data.length]=Offset;
					data[data.length]=Offset>>8;
					
				}
			}
			
			data.position=data.length;
			data.writeBytes(GlyphShapesData);
			
			for each(var Code:int in CodeV){
				
				data[data.length]=Code;
				data[data.length]=Code>>8;
				
			}
			
			if(fontLayout){
				if(_toDataOptions){
				}else{
					_toDataOptions=new Object();
				}
				_toDataOptions.FontFlagsWideCodes=FontFlagsWideCodes;//20120918
				data.position=data.length;
				data.writeBytes(fontLayout.toData(_toDataOptions));
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineFont3"
					id={id}
					FontFlagsShiftJIS={FontFlagsShiftJIS}
					FontFlagsSmallText={FontFlagsSmallText}
					FontFlagsANSI={FontFlagsANSI}
					FontFlagsWideCodes={FontFlagsWideCodes}
					FontFlagsItalic={FontFlagsItalic}
					FontFlagsBold={FontFlagsBold}
					LanguageCode={LANGCODEs.codeV[LanguageCode]}
					FontName={FontName}
				/>;
				
				if(GlyphShapeV.length){
					var GlyphShapeListXML:XML=<GlyphShapeList count={GlyphShapeV.length}/>;
					for each(var GlyphShape:SHAPE in GlyphShapeV){
						
						GlyphShapeListXML.appendChild(GlyphShape.toXML("GlyphShape",_toXMLOptions));
						
					}
					xml.appendChild(GlyphShapeListXML);
				}
				
				if(CodeV.length){
					var CodeListXML:XML=<CodeList count={CodeV.length}/>;
					for each(var Code:int in CodeV){
						
						CodeListXML.appendChild(<Code value={Code} info={String.fromCharCode(Code)}/>);
						
					}
					xml.appendChild(CodeListXML);
				}
				
				if(fontLayout){
					xml.appendChild(fontLayout.toXML("fontLayout",_toXMLOptions));
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				FontFlagsShiftJIS=(xml.@FontFlagsShiftJIS.toString()=="true");
				FontFlagsSmallText=(xml.@FontFlagsSmallText.toString()=="true");
				FontFlagsANSI=(xml.@FontFlagsANSI.toString()=="true");
				FontFlagsWideCodes=(xml.@FontFlagsWideCodes.toString()=="true");
				FontFlagsItalic=(xml.@FontFlagsItalic.toString()=="true");
				FontFlagsBold=(xml.@FontFlagsBold.toString()=="true");
				
				LanguageCode=LANGCODEs[xml.@LanguageCode.toString()];
				
				FontName=xml.@FontName.toString();
				
				var i:int=-1;
				GlyphShapeV=new Vector.<SHAPE>();
				for each(var GlyphShapeXML:XML in xml.GlyphShapeList.GlyphShape){
					i++;
					
					GlyphShapeV[i]=new SHAPE();
					GlyphShapeV[i].initByXML(GlyphShapeXML,_initByXMLOptions);
					
				}
				
				i=-1;
				CodeV=new Vector.<int>();
				for each(var CodeXML:XML in xml.CodeList.Code){
					i++;
					
					CodeV[i]=int(CodeXML.@value.toString());
					
				}
				
				var fontLayoutXML:XML=xml.fontLayout[0];
				if(fontLayoutXML){
					fontLayout=new FONTLAYOUT();
					fontLayout.initByXML(fontLayoutXML,_initByXMLOptions);
				}else{
					fontLayout=null;
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}