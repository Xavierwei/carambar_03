/***
DefineBinaryData
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 08:42:39（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineBinaryData
//The DefineBinaryData tag permits arbitrary binary data to be embedded in a SWF file.
//DefineBinaryData is a definition tag, like DefineShape and DefineSprite. It associates a blob
//of binary data with a standard SWF 16-bit character ID. The character ID is entered into the
//SWF file's character dictionary.
//DefineBinaryData is intended to be used in conjunction with the SymbolClass tag. The
//SymbolClass tag can be used to associate a DefineBinaryData tag with an AS3 class definition.
//The AS3 class must be a subclass of ByteArray. When the class is instantiated, it will be
//populated automatically with the contents of the binary data resource.
//
//DefineBinaryData
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 87
//Tag 				UI16 			16-bit character ID
//Reserved 			U32 			Reserved space; must be 0
//Data 				BINARY 			A blob of binary data, up to the end of the tag

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	import zero.swf.BytesData;
	
	public class DefineBinaryData{
		
		public var id:int;//UI16
		private var Reserved:uint;//UI32
		public var Data:BytesData;
		
		public function DefineBinaryData(){
			//id=0;
			//Reserved=0;
			//Data=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			Reserved=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			
			Data=new BytesData();
			return Data.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data[2]=Reserved;
			data[3]=Reserved>>8;
			data[4]=Reserved>>16;
			data[5]=Reserved>>24;
			
			data.position=6;
			data.writeBytes(Data.toData(_toDataOptions));
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineBinaryData"
				id={id}
				Reserved={"0x"+BytesAndStr16._16V[(Reserved>>24)&0xff]+BytesAndStr16._16V[(Reserved>>16)&0xff]+BytesAndStr16._16V[(Reserved>>8)&0xff]+BytesAndStr16._16V[Reserved&0xff]}
			/>;
			
			xml.appendChild(Data.toXML("Data",_toXMLOptions));
			
			if(_toXMLOptions&&_toXMLOptions.addToXMLInfos){//20130407
				_toXMLOptions.addToXMLInfos(this,xml);
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			id=int(xml.@id.toString());
			Reserved=uint(xml.@Reserved.toString());
			
			Data=new BytesData();
			Data.initByXML(xml.Data[0],_initByXMLOptions);
			
		}
		
	}
}