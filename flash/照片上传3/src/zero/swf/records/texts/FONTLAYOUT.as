/***
FONTLAYOUT
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月28日 21:39:26（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//FontAscent 				If FontFlagsHasLayout, SI16 						Font ascender height.
//FontDescent 				If FontFlagsHasLayout, SI16 						Font descender height.
//FontLeading 				If FontFlagsHasLayout, SI16 						Font leading height (see following).
//FontAdvanceTable 			If FontFlagsHasLayout, SI16[NumGlyphs]				Advance value to be used for each glyph in dynamic glyph text.
//FontBoundsTable 			If FontFlagsHasLayout, RECT[NumGlyphs]				Not used in Flash Player through version 7 (but must be present).
//KerningCount 				If FontFlagsHasLayout, UI16 						Not used in Flash Player through version 7 (always set to 0 to save space).
//FontKerningTable 			If FontFlagsHasLayout, KERNINGRECORD[KerningCount]	Not used in Flash Player through version 7 (omit with KerningCount of 0).

//Kerning record
//A Kerning Record defines the distance between two glyphs in EM square coordinates. Certain
//pairs of glyphs appear more aesthetically pleasing if they are moved closer together, or farther
//apart. The FontKerningCode1 and FontKerningCode2 fields are the character codes for the
//left and right characters. The FontKerningAdjustment field is a signed integer that defines a
//value to be added to the advance value of the left character.
//KERNINGRECORD
//Field 					Type 							Comment
//FontKerningCode1 			If FontFlagsWideCodes, UI16		Character code of the left character.
//							Otherwise UI8
//FontKerningCode2 			If FontFlagsWideCodes, UI16		Character code of the right character.
//							Otherwise UI8
//FontKerningAdjustment 	SI16 							Adjustment relative to left character's advance value.

package zero.swf.records.texts{
	
	import flash.utils.ByteArray;
	import zero.swf.records.RECT;
	
	public class FONTLAYOUT{
		
		public var FontAscent:int;//SI16
		public var FontDescent:int;//SI16
		public var FontLeading:int;//SI16
		public var FontAdvanceV:Vector.<int>;//SI16
		public var FontBoundsV:Vector.<RECT>;
		public var FontKerningCode1V:Vector.<int>;//UI16
		public var FontKerningCode2V:Vector.<int>;//UI16
		public var FontKerningAdjustmentV:Vector.<int>;//SI16
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(_initByDataOptions){//20110830
			}else{
				throw new Error("需要提供 _initByDataOptions");
			}
			
			FontAscent=data[offset++]|(data[offset++]<<8);
			if(FontAscent&0x00008000){FontAscent|=0xffff0000}//最高位为1,表示负数
			
			FontDescent=data[offset++]|(data[offset++]<<8);
			if(FontDescent&0x00008000){FontDescent|=0xffff0000}//最高位为1,表示负数
			
			FontLeading=data[offset++]|(data[offset++]<<8);
			if(FontLeading&0x00008000){FontLeading|=0xffff0000}//最高位为1,表示负数
			
			FontAdvanceV=new Vector.<int>();
			for(var i:int=0;i<_initByDataOptions.NumGlyphs;i++){
				
				FontAdvanceV[i]=data[offset++]|(data[offset++]<<8);
				if(FontAdvanceV[i]&0x00008000){FontAdvanceV[i]|=0xffff0000}//最高位为1,表示负数
				
			}
			
			FontBoundsV=new Vector.<RECT>();
			for(i=0;i<_initByDataOptions.NumGlyphs;i++){
				
				FontBoundsV[i]=new RECT();
				offset=FontBoundsV[i].initByData(data,offset,endOffset,_initByDataOptions);
				
			}
			
			var KerningCount:int=data[offset++]|(data[offset++]<<8);
			
			FontKerningCode1V=new Vector.<int>();
			FontKerningCode2V=new Vector.<int>();
			FontKerningAdjustmentV=new Vector.<int>();
			
			if(_initByDataOptions.FontFlagsWideCodes){
				for(i=0;i<KerningCount;i++){
					
					FontKerningCode1V[i]=data[offset++]|(data[offset++]<<8);
					
					FontKerningCode2V[i]=data[offset++]|(data[offset++]<<8);
					
					FontKerningAdjustmentV[i]=data[offset++]|(data[offset++]<<8);
					if(FontKerningAdjustmentV[i]&0x00008000){FontKerningAdjustmentV[i]|=0xffff0000}//最高位为1,表示负数
					
				}
			}else{
				for(i=0;i<KerningCount;i++){
					
					FontKerningCode1V[i]=data[offset++];
					
					FontKerningCode2V[i]=data[offset++];
					
					FontKerningAdjustmentV[i]=data[offset++]|(data[offset++]<<8);
					if(FontKerningAdjustmentV[i]&0x00008000){FontKerningAdjustmentV[i]|=0xffff0000}//最高位为1,表示负数
					
				}
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			if(_toDataOptions){//20110830
			}else{
				throw new Error("需要提供 _toDataOptions");
			}
			
			var data:ByteArray=new ByteArray();
			
			data[0]=FontAscent;
			data[1]=FontAscent>>8;
			
			data[2]=FontDescent;
			data[3]=FontDescent>>8;
			
			data[4]=FontLeading;
			data[5]=FontLeading>>8;
			
			for each(var FontAdvance:int in FontAdvanceV){
				
				data[data.length]=FontAdvance;
				data[data.length]=FontAdvance>>8;
				
			}
			
			data.position=data.length;
			for each(var FontBounds:RECT in FontBoundsV){
				
				data.writeBytes(FontBounds.toData(_toDataOptions));
				
			}
			
			var KerningCount:int=FontKerningCode1V.length;
			data[data.length]=KerningCount;
			data[data.length]=KerningCount>>8;
			
			var i:int=-1;
			if(_toDataOptions.FontFlagsWideCodes){
				for each(var FontKerningAdjustment:int in FontKerningAdjustmentV){
					i++;
					
					data[data.length]=FontKerningCode1V[i];
					data[data.length]=FontKerningCode1V[i]>>8;
					
					data[data.length]=FontKerningCode2V[i];
					data[data.length]=FontKerningCode2V[i]>>8;
					
					data[data.length]=FontKerningAdjustment;
					data[data.length]=FontKerningAdjustment>>8;
					
				}
			}else{
				for each(FontKerningAdjustment in FontKerningAdjustmentV){
					i++;
					
					data[data.length]=FontKerningCode1V[i];
					
					data[data.length]=FontKerningCode2V[i];
					
					data[data.length]=FontKerningAdjustment;
					data[data.length]=FontKerningAdjustment>>8;
					
				}
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.records.texts.FONTLAYOUT"
					FontAscent={FontAscent}
					FontDescent={FontDescent}
					FontLeading={FontLeading}
				/>;
				
				if(FontAdvanceV.length){
					var FontAdvanceListXML:XML=<FontAdvanceList count={FontAdvanceV.length}/>;
					for each(var FontAdvance:int in FontAdvanceV){
						
						FontAdvanceListXML.appendChild(<FontAdvance value={FontAdvance}/>);
						
					}
					xml.appendChild(FontAdvanceListXML);
				}
				
				if(FontBoundsV.length){
					var FontBoundsListXML:XML=<FontBoundsList count={FontBoundsV.length}/>;
					for each(var FontBounds:RECT in FontBoundsV){
						
						FontBoundsListXML.appendChild(FontBounds.toXML("FontBounds",_toXMLOptions));
						
					}
					xml.appendChild(FontBoundsListXML);
				}
				
				if(FontKerningCode1V.length){
					var i:int=-1;
					var FontKerningCode1AndFontKerningCode2AndFontKerningAdjustmentListXML:XML=<FontKerningCode1AndFontKerningCode2AndFontKerningAdjustmentList count={FontKerningCode1V.length}/>;
					for each(var FontKerningCode1:int in FontKerningCode1V){
						i++;
						
						FontKerningCode1AndFontKerningCode2AndFontKerningAdjustmentListXML.appendChild(<FontKerningCode1 value={FontKerningCode1}/>);
						
						FontKerningCode1AndFontKerningCode2AndFontKerningAdjustmentListXML.appendChild(<FontKerningCode2 value={FontKerningCode2V[i]}/>);
						
						FontKerningCode1AndFontKerningCode2AndFontKerningAdjustmentListXML.appendChild(<FontKerningAdjustment value={FontKerningAdjustmentV[i]}/>);
						
					}
					xml.appendChild(FontKerningCode1AndFontKerningCode2AndFontKerningAdjustmentListXML);
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				FontAscent=int(xml.@FontAscent.toString());
				
				FontDescent=int(xml.@FontDescent.toString());
				
				FontLeading=int(xml.@FontLeading.toString());
				
				var i:int=-1;
				FontAdvanceV=new Vector.<int>();
				for each(var FontAdvanceXML:XML in xml.FontAdvanceList.FontAdvance){
					i++;
					
					FontAdvanceV[i]=int(FontAdvanceXML.@value.toString());
					
				}
				
				i=-1;
				FontBoundsV=new Vector.<RECT>();
				for each(var FontBoundsXML:XML in xml.FontBoundsList.FontBounds){
					i++;
					
					FontBoundsV[i]=new RECT();
					FontBoundsV[i].initByXML(FontBoundsXML,_initByXMLOptions);
					
				}
				
				i=-1;
				var FontKerningCode2XMLList:XMLList=xml.FontKerningCode1AndFontKerningCode2AndFontKerningAdjustmentList.FontKerningCode2;
				var FontKerningAdjustmentXMLList:XMLList=xml.FontKerningCode1AndFontKerningCode2AndFontKerningAdjustmentList.FontKerningAdjustment;
				FontKerningCode1V=new Vector.<int>();
				FontKerningCode2V=new Vector.<int>();
				FontKerningAdjustmentV=new Vector.<int>();
				for each(var FontKerningCode1XML:XML in xml.FontKerningCode1AndFontKerningCode2AndFontKerningAdjustmentList.FontKerningCode1){
					i++;
					
					FontKerningCode1V[i]=int(FontKerningCode1XML.@value.toString());
					
					FontKerningCode2V[i]=int(FontKerningCode2XMLList[i].@value.toString());
					
					FontKerningAdjustmentV[i]=int(FontKerningAdjustmentXMLList[i].@value.toString());
					
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}