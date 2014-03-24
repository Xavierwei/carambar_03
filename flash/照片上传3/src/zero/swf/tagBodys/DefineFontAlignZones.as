/***
DefineFontAlignZones
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 10:33:48（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The DefineFont3 tag can be modified by a DefineFontAlignZones tag. The advanced text
//rendering engine uses alignment zones to establish the borders of a glyph for pixel snapping.
//Alignment zones are critical for high-quality display of fonts.
//The alignment zone defines a bounding box for strong vertical and horizontal components of
//a glyph. The box is described by a left coordinate, thickness, baseline coordinate, and height.
//Small thicknesses or heights are often set to 0.
//For example, consider the letter I. The letter I has a strong horizontal at its baseline and the
//top of the letter. The letter I also has strong verticals that occur at the edges of the stem—not
//the short top bar or serif. These strong verticals and horizontals of the center block of the
//letter define the alignment zones.
//
//The minimum file format version is SWF 8.
//
//DefineFontAlignZones
//Field 					Type 					Comment
//Header 					RECORDHEADER 			Tag type = 73.
//FontID 					UI16 					ID of font to use, specified by DefineFont3.
//CSMTableHint 				UB[2] 					Font thickness hint. Refers to the thickness of the typical stroke used in the font.
//													0 = thin
//													1 = medium
//													2 = thick
//													Flash Player maintains a selection of CSM tables for many fonts. However, if the font is not found in Flash Player's internal table, this hint is used to choose an appropriate table.
//Reserved 					UB[6] 					Must be 0.
//ZoneTable 				ZONERECORD[GlyphCount] 	Alignment zone information for each glyph.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.texts.ZONERECORD;
	
	public class DefineFontAlignZones{
		
		public var FontID:int;//UI16
		public var CSMTableHint:int;//11000000
		private var Reserved:int;//00111111
		public var ZoneRecordV:Vector.<ZONERECORD>;
		
		public function DefineFontAlignZones(){
			//FontID=0;
			//CSMTableHint=0;
			//Reserved=0;
			//ZoneRecordV=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			FontID=data[offset++]|(data[offset++]<<8);
			
			var flags:int=data[offset++];
			CSMTableHint=(flags&0xc0)>>>6;//11000000
			Reserved=flags&0x3f;//00111111
			
			var i:int=-1;
			ZoneRecordV=new Vector.<ZONERECORD>();
			while(offset<endOffset){
				i++;
				
				ZoneRecordV[i]=new ZONERECORD();
				offset=ZoneRecordV[i].initByData(data,offset,endOffset,_initByDataOptions);
				
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=FontID;
			data[1]=FontID>>8;
			
			var flags:int=0;
			flags|=CSMTableHint<<6;//11000000
			flags|=Reserved;//00111111
			data[2]=flags;
			
			data.position=3;
			for each(var ZoneRecord:ZONERECORD in ZoneRecordV){
				
				data.writeBytes(ZoneRecord.toData(_toDataOptions));
				
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineFontAlignZones"
					FontID={FontID}
					CSMTableHint={CSMTableHint}
					Reserved={Reserved}
				/>;
				
				if(ZoneRecordV.length){
					var ZoneRecordListXML:XML=<ZoneRecordList count={ZoneRecordV.length}/>;
					for each(var ZoneRecord:ZONERECORD in ZoneRecordV){
						
						ZoneRecordListXML.appendChild(ZoneRecord.toXML("ZoneRecord",_toXMLOptions));
						
					}
					xml.appendChild(ZoneRecordListXML);
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				FontID=int(xml.@FontID.toString());
				
				CSMTableHint=int(xml.@CSMTableHint.toString());
				
				Reserved=int(xml.@Reserved.toString());
				
				var i:int=-1;
				ZoneRecordV=new Vector.<ZONERECORD>();
				for each(var ZoneRecordXML:XML in xml.ZoneRecordList.ZoneRecord){
					i++;
					
					ZoneRecordV[i]=new ZONERECORD();
					ZoneRecordV[i].initByXML(ZoneRecordXML,_initByXMLOptions);
					
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}