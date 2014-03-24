/***
RemoveObject2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月25日 15:06:52（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//RemoveObject2
//The RemoveObject2 tag removes the character at the specified depth from the display list.
//The minimum file format version is SWF 3.

//RemoveObject2
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 28
//Depth 			UI16 			Depth of character

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	public class RemoveObject2{
		
		public var Depth:int;//UI16
		
		public function RemoveObject2(){
			//Depth=0;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			Depth=data[offset++]|(data[offset++]<<8);
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=Depth;
			data[1]=Depth>>8;
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.tagBodys.RemoveObject2"
					Depth={Depth}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				Depth=int(xml.@Depth.toString());
				
			}
		//}//end of CONFIG::USE_XML
	}
}