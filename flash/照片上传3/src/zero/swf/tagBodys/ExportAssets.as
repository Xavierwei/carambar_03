/***
ExportAssets
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 18:59:18（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The ExportAssets tag makes portions of a SWF file available for import by other SWF files
//(see "ImportAssets" on page 56). For example, ten SWF files that are all part of the same
//website can share an embedded custom font if one file embeds the font and exports the font
//character. Each exported character is identified by a string. Any type of character can be
//exported.
//If the value of the character in ExportAssets was previously exported with a different identifier,
//Flash Player associates the tag with the latter identifier. That is, if Flash Player has already read
//a given value for Tag1 and the same Tag1 value is read later in the SWF file, the second Name1
//value is used.
//The minimum file format version is SWF 5.

//Field 		Type 			Comment
//Header 		RECORDHEADER 	Tag type = 56
//Count 		UI16 			Number of assets to export
//Tag1 			UI16 			First character ID to export
//Name1 		STRING 			Identifier for first exported character
//...
//TagN 			UI16 			Last character ID to export
//NameN 		STRING 			Identifier for last exported character

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class ExportAssets{
		
		public var TagV:Vector.<int>;//UI16
		public var NameV:Vector.<String>;//STRING
		
		public function ExportAssets(){
			//TagV=null;
			//NameV=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var Count:int=data[offset++]|(data[offset++]<<8);
			
			TagV=new Vector.<int>();
			NameV=new Vector.<String>();
			for(var i:int=0;i<Count;i++){
				
				TagV[i]=data[offset++]|(data[offset++]<<8);
				
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=ignoreBOMReadUTFBytes(data,get_str_size);
				offset+=get_str_size;
				
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			var Count:int=TagV.length;
			data[0]=Count;
			data[1]=Count>>8;
			
			var i:int=-1;
			for each(var Tag:int in TagV){
				i++;
				
				data[data.length]=Tag;
				data[data.length]=Tag>>8;
				
				data.position=data.length;
				data.writeUTFBytes(NameV[i]+"\x00");
//				//20110912
//				if(NameV[i]){
//					for each(var c:String in NameV[i].split("")){
//						if(c.charCodeAt(0)>0xff){
//							data.writeUTFBytes(c);
//						}else{
//							data.writeByte(c.charCodeAt(0));
//						}
//					}
//				}
//				data.writeByte(0x00);
				
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.ExportAssets"/>;
				
				if(TagV.length){
					var i:int=-1;
					var TagAndNameListXML:XML=<TagAndNameList count={TagV.length}/>;
					for each(var Tag:int in TagV){
						i++;
						
						TagAndNameListXML.appendChild(<Tag value={Tag}/>);
						
						TagAndNameListXML.appendChild(<Name value={NameV[i]}/>);
						
					}
					xml.appendChild(TagAndNameListXML);
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				var i:int=-1;
				var NameXMLList:XMLList=xml.TagAndNameList.Name;
				TagV=new Vector.<int>();
				NameV=new Vector.<String>();
				for each(var TagXML:XML in xml.TagAndNameList.Tag){
					i++;
					
					TagV[i]=int(TagXML.@value.toString());
					
					NameV[i]=NameXMLList[i].@value.toString();
					
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}