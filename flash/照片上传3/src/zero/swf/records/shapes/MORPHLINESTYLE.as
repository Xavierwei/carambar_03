/***
MORPHLINESTYLE
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 20:24:16（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//MORPHLINESTYLE
//The format of a line style value within the file is described in the following table.
//
//MORPHLINESTYLE
//Field 			Type 			Comment
//StartWidth 		UI16 			Width of line in start shape in twips.
//EndWidth 			UI16 			Width of line in end shape in twips.
//StartColor 		RGBA 			Color value including alpha channel information for start shape.
//EndColor 			RGBA 			Color value including alpha channel information for end shape.

package zero.swf.records.shapes{
	
	import flash.utils.ByteArray;
	import zero.BytesAndStr16;
	
	public class MORPHLINESTYLE{
		
		public var StartWidth:int;//UI16
		public var EndWidth:int;//UI16
		public var StartColor:uint;//RGBA
		public var EndColor:uint;//RGBA
		
		public function MORPHLINESTYLE(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			StartWidth=data[offset++]|(data[offset++]<<8);
			
			EndWidth=data[offset++]|(data[offset++]<<8);
			
			StartColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			
			EndColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=StartWidth;
			data[1]=StartWidth>>8;
			
			data[2]=EndWidth;
			data[3]=EndWidth>>8;
			
			data[4]=StartColor>>16;
			data[5]=StartColor>>8;
			data[6]=StartColor;
			data[7]=StartColor>>24;
			
			data[8]=EndColor>>16;
			data[9]=EndColor>>8;
			data[10]=EndColor;
			data[11]=EndColor>>24;
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.records.shapes.MORPHLINESTYLE"
					StartWidth={StartWidth}
					EndWidth={EndWidth}
					StartColor={"0x"+BytesAndStr16._16V[(StartColor>>24)&0xff]+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff]}
					EndColor={"0x"+BytesAndStr16._16V[(EndColor>>24)&0xff]+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff]}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				StartWidth=int(xml.@StartWidth.toString());
				
				EndWidth=int(xml.@EndWidth.toString());
				
				StartColor=uint(xml.@StartColor.toString());
				
				EndColor=uint(xml.@EndColor.toString());
				
			}
		//}//end of CONFIG::USE_XML
	}
}