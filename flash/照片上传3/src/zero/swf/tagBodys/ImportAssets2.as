/***
ImportAssets2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 20:49:14（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The ImportAssets2 tag replaces the ImportAssets tag for SWF 8 and later. ImportAssets2
//currently mirrors the ImportAssets tag's functionality.
//The ImportAssets2 tag imports characters from another SWF file. The importing SWF file
//references the exporting SWF file by the URL where it can be found. Imported assets are
//added to the dictionary just like characters defined within a SWF file.
//The URL of the exporting SWF file can be absolute or relative. If it is relative, it is resolved
//relative to the location of the importing SWF file.
//The ImportAssets2 tag must be earlier in the frame than any later tags that rely on the
//imported assets.
//The minimum file format version is SWF 8.

//ImportAssets2
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 71
//URL 				STRING 			URL where the source SWF file can be found
//Reserved 			UI8 			Must be 1
//Reserved 			UI8 			Must be 0
//Count 			UI16 			Number of assets to import
//Tag1 				UI16 			Character ID to use for first imported character in importing SWF file (need not match character ID in exporting SWF file)
//Name1 			STRING 			Identifier for first imported character (must match an identifier in exporting SWF file)
//...
//TagN 				UI16 			Character ID to use for last imported character in importing SWF file
//NameN 			STRING 			Identifier for last imported character

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class ImportAssets2{
		
		public var URL:String;//STRING
		private var Reserved:int;//UI8
		private var Reserved2:int;//UI8
		public var TagV:Vector.<int>;//UI16
		public var NameV:Vector.<String>;//STRING
		
		public function ImportAssets2(){
			Reserved=1;
			//Reserved2=0;
			//URL=null;
			//TagV=null;
			//NameV=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			URL=ignoreBOMReadUTFBytes(data,get_str_size);
			offset+=get_str_size;
			
			Reserved=data[offset++];
			
			Reserved2=data[offset++];
			
			var Count:int=data[offset++]|(data[offset++]<<8);
			
			TagV=new Vector.<int>();
			NameV=new Vector.<String>();
			for(var i:int=0;i<Count;i++){
				
				TagV[i]=data[offset++]|(data[offset++]<<8);
				
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=ignoreBOMReadUTFBytes(data,get_str_size);
				offset+=get_str_size;
				
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data.writeUTFBytes(URL+"\x00");
//			//20111208
//			if(URL){
//				for each(var c:String in URL.split("")){
//					if(c.charCodeAt(0)>0xff){
//						data.writeUTFBytes(c);
//					}else{
//						data.writeByte(c.charCodeAt(0));
//					}
//				}
//			}
//			data.writeByte(0x00);
			
			data[data.length]=Reserved;
			
			data[data.length]=Reserved2;
			
			var Count:int=TagV.length;
			data[data.length]=Count;
			data[data.length]=Count>>8;
			
			var i:int=-1;
			for each(var Tag:int in TagV){
				i++;
				
				data[data.length]=Tag;
				data[data.length]=Tag>>8;
				
				data.position=data.length;
				data.writeUTFBytes(NameV[i]+"\x00");
//				//20110912
//				if(NameV[i]){
//					for each(c in NameV[i].split("")){
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
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.ImportAssets2"
					URL={URL}
					Reserved={Reserved}
					Reserved2={Reserved2}
				/>;
				
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
				
				URL=xml.@URL.toString();
				
				Reserved=int(xml.@Reserved.toString());
				
				Reserved2=int(xml.@Reserved2.toString());
				
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