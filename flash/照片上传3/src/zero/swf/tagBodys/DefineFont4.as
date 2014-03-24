/***
DefineFont4
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 10:02:16（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineFont4
//DefineFont4 supports only the new Flash Text Engine. The storage of font data for embedded
//fonts is in CFF format.
//The minimum file format version is SWF 10.

//Header 				RECORDHEADER 			Tag type = 91
//FontID 				UI16 					ID for this font character.
//FontFlagsReserved 	UB[5] 					Reserved bit fields.
//FontFlagsHasFontData 	UB[1] 					Font is embedded. Font tag includes SFNT font data block.
//FontFlagsItalic 		UB[1] 					Italic font
//FontFlagsBold 		UB[1] 					Bold font
//FontName 				STRING 					Name of the font.
//FontData 				FONTDATA[0 or 1] 		When present, this is an OpenType CFF font, as defined in the OpenType specification at www.microsoft.com/ typography/otspec. The following tables must be present: 'CFF ', 'cmap', 'head', 'maxp', 'OS/2', 'post', and either (a) 'hhea' and 'hmtx', or (b) 'vhea', 'vmtx', and 'VORG'. The 'cmap' table must include one of the following kinds of Unicode 'cmap' subtables: (0, 4), (0, 3), (3, 10), (3, 1), or (3, 0) [notation: (platform ID, platformspecific encoding ID)]. Tables such as 'GSUB', 'GPOS', 'GDEF', and 'BASE' may also be present. Only present for embedded fonts.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	import zero.swf.BytesData;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class DefineFont4{
		
		public var id:int;//UI16
		private var Reserved:int;//11111000
		public var FontFlagsItalic:Boolean;//00000010
		public var FontFlagsBold:Boolean;//00000001
		public var FontName:String;//STRING
		public var FontData:BytesData;
		
		public function DefineFont4(){
			//id=0;
			//Reserved=0;
			//FontFlagsItalic=false;
			//FontFlagsBold=false;
			//FontName=null;
			//FontData=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			id=data[offset++]|(data[offset++]<<8);
			
			var flags:int=data[offset++];
			Reserved=flags&0xf8;//11111000
			var FontFlagsHasFontData:Boolean=((flags&0x04)?true:false);//00000100
			FontFlagsItalic=((flags&0x02)?true:false);//00000010
			FontFlagsBold=((flags&0x01)?true:false);//00000001
			
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			FontName=ignoreBOMReadUTFBytes(data,get_str_size);
			offset+=get_str_size;
			
			if(FontFlagsHasFontData){
				FontData=new BytesData();
				offset=FontData.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				FontData=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			var flags:int=0;
			flags|=Reserved;//11111000
			if(FontData){
				flags|=0x04;//FontFlagsHasFontData//00000100
			}
			if(FontFlagsItalic){
				flags|=0x02;//00000010
			}
			if(FontFlagsBold){
				flags|=0x01;//00000001
			}
			data[2]=flags;
			
			data.position=3;
			data.writeUTFBytes(FontName+"\x00");
//			//20111208
//			if(FontName){
//				for each(var c:String in FontName.split("")){
//					if(c.charCodeAt(0)>0xff){
//						data.writeUTFBytes(c);
//					}else{
//						data.writeByte(c.charCodeAt(0));
//					}
//				}
//			}
//			data.writeByte(0x00);
			if(FontData){
				data.writeBytes(FontData.toData(_toDataOptions));
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineFont4"
					id={id}
					Reserved={Reserved}
					FontFlagsItalic={FontFlagsItalic}
					FontFlagsBold={FontFlagsBold}
					FontName={FontName}
				/>;
				
				if(FontData){
					xml.appendChild(FontData.toXML("FontData",_toXMLOptions));
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				Reserved=int(xml.@Reserved.toString());
				
				FontFlagsItalic=(xml.@FontFlagsItalic.toString()=="true");
				FontFlagsBold=(xml.@FontFlagsBold.toString()=="true");
				
				FontName=xml.@FontName.toString();
				
				var FontDataXML:XML=xml.FontData[0];
				if(FontDataXML){
					FontData=new BytesData();
					FontData.initByXML(FontDataXML,_initByXMLOptions);
				}else{
					FontData=null;
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}