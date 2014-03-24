/***
Metadata
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 09:52:12（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The Metadata tag is an optional tag to describe the SWF file to an external process. The tag
//embeds XML metadata in the SWF file so that, for example, a search engine can locate this
//tag, access a title for the SWF file, and display that title in search results. Flash Player always
//ignores the Metadata tag.
//If the Metadata tag is included in a SWF file, the FileAttributes tag must also be in the SWF
//file with its HasMetadata flag set. Conversely, if the FileAttributes tag has the HasMetadata
//flag set, the Metadata tag must be in the SWF file. The Metadata tag can only be in the SWF
//file one time.
//The format of the metadata is RDF that is compliant with Adobe's Extensible Metadata
//Platform (XMP™) specification. For more information about RDF and XMP, see the
//following sources:
//■ The RDF Primer at www.w3.org/TR/rdf-primer
//■ The RDF Specification at www.w3.org/TR/1999/REC-rdf-syntax-19990222
//■ The XMP home page at www.adobe.com/products/xmp
//SymbolClass
//Field Type Comment
//Header RECORDHEADER Tag type = 76
//NumSymbols UI16 Number of symbols that
//will be associated by this
//tag.
//Tag1 U16 The 16-bit character tag ID
//for the symbol to associate
//Name1 STRING The fully-qualified name of
//the ActionScript 3.0 class
//with which to associate this
//symbol. The class must
//have already been
//declared by a DoABC tag.
//... ... ...
//TagN U16 Tag ID for symbol N
//NameN STRING Fully-qualified class name
//for symbol N
//64 Control Tags
//The following examples show two of many acceptable ways to represent the Metadata string
//in the SWF file. The first example provides basic information about the SWF file, the title
//and description:
//<rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
//<rdf:Description rdf:about='' xmlns:dc='http://purl.org/dc/1.1'>
//<dc:title>Simple Title</dc:title>
//<dc:description>Simple Description</dc:description>
//</rdf:Description>
//</rdf:RDF>
//In the second example, the title is described for multiple languages:
//<rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
//<rdf:Description rdf:about='' xmlns:dc='http://purl.org/dc/1.1'>
//<dc:title>
//<rdf:Alt>
//<rdf:li xml:lang='x-default'>Default Title</rdf:li>
//<rdf:li xml:lang='en-us'>US English Title</rdf:li>
//<rdf:li xml:lang='fr-fr'>Titre Français</rdf:li>
//<rdf:li xml:lang='it-it'>Titolo Italiano</rdf:li>
//</rdf:Alt>
//</dc:title>
//<dc:description>Simple Description</dc:description>
//</rdf:Description>
//</rdf:RDF>
//The Metadata string is stored in the SWF file with all unnecessary white space removed.
//The minimum file format version is SWF 1.

//Metadata
//Field 	Type 			Comment
//Header 	RECORDHEADER 	Tag type = 77
//Metadata 	STRING 			XML Metadata

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class Metadata{
		
		public var metadata:String;//STRING
		
		public function Metadata(){
			//metadata=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			metadata=ignoreBOMReadUTFBytes(data,get_str_size);
			return offset+get_str_size;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data.writeUTFBytes(metadata+"\x00");
//			//20111208
//			if(metadata){
//				for each(var c:String in metadata.split("")){
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
				
				return <{xmlName} class="zero.swf.tagBodys.Metadata"
					metadata={metadata}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				metadata=xml.@metadata.toString();
				
			}
		//}//end of CONFIG::USE_XML
	}
}