/***
DefineFontName
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 09:49:34（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The DefineFontName tag contains the name and copyright information for a font embedded in the SWF file.
//
//The minimum file format version is SWF 9.
//
//DefineFontName
//Field 				Type 				Comment
//Header 				RECORDHEADER 		Tag type = 88
//FontID 				UI16 				ID for this font to which this refers
//FontName 				STRING 				Name of the font. 
//											For fonts starting as Type 1, this is the PostScript FullName.
//											For fonts starting in sfnt formats such as TrueType and OpenType, this is name ID 4, platform ID 1, language ID 0 (Full name, Mac OS, English).
//FontCopyright			STRING 				Arbitrary string of copyright information

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class DefineFontName{
		
		public var FontID:int;//UI16
		public var FontName:String;//STRING
		public var FontCopyright:String;//STRING
		
		public function DefineFontName(){
			//FontID=0;
			//FontName=null;
			//FontCopyright=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			FontID=data[offset++]|(data[offset++]<<8);
			
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			FontName=ignoreBOMReadUTFBytes(data,get_str_size);
			offset+=get_str_size;
			
			get_str_size=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			FontCopyright=ignoreBOMReadUTFBytes(data,get_str_size);
			return offset+get_str_size;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=FontID;
			data[1]=FontID>>8;
			
			data.position=2;
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
			
			data.writeUTFBytes(FontCopyright+"\x00");
//			//20111208
//			if(FontCopyright){
//				for each(c in FontCopyright.split("")){
//					if(c.charCodeAt(0)>0xff){
//						data.writeUTFBytes(c);
//					}else{
//						data.writeByte(c.charCodeAt(0));
//					}
//				}
//			}
//			data.writeByte(0x00);
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.tagBodys.DefineFontName"
					FontID={FontID}
					FontName={FontName}
					FontCopyright={FontCopyright}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				FontID=int(xml.@FontID.toString());
				
				FontName=xml.@FontName.toString();
				
				FontCopyright=xml.@FontCopyright.toString();
				
			}
		//}//end of CONFIG::USE_XML
	}
}