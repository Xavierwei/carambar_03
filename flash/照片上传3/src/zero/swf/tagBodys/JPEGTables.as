/***
JPEGTables
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月24日 13:33:50（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//This tag defines the JPEG encoding table (the Tables/Misc segment) for all JPEG images
//defined using the DefineBits tag. There may only be one JPEGTables tag in a SWF file.
//The data in this tag begins with the JPEG SOI marker 0xFF, 0xD8 and ends with the EOI
//marker 0xFF, 0xD9. Before version 8 of the SWF file format, SWF files could contain an
//erroneous header of 0xFF, 0xD9, 0xFF, 0xD8 before the JPEG SOI marker.
//The minimum file format version for this tag is SWF 1.

//JPEGTables
//Field 			Type 						Comment
//Header 			RECORDHEADER 				Tag type = 8
//JPEGData 			UI8[encoding data size] 	JPEG encoding table

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.BytesData;
	
	public class JPEGTables{
		
		public var JPEGData:BytesData;
		
		public function JPEGTables(){
			//JPEGData=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			JPEGData=new BytesData();
			return JPEGData.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			return JPEGData.toData(_toDataOptions);
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.JPEGTables"/>;
				
				xml.appendChild(JPEGData.toXML("JPEGData",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				JPEGData=new BytesData();
				JPEGData.initByXML(xml.JPEGData[0],_initByXMLOptions);
				
			}
		//}//end of CONFIG::USE_XML
	}
}