/***
TEXTLAYOUT
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月28日 21:41:50（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//Align 			If HasLayout, UI8 			0 = Left
//												1 = Right
//												2 = Center
//												3 = Justify
//LeftMargin 		If HasLayout, UI16 			Left margin in twips.
//RightMargin 		If HasLayout, UI16 			Right margin in twips.
//Indent 			If HasLayout, UI16 			Indent in twips.
//Leading 			If HasLayout, SI16 			Leading in twips (vertical distance between bottom of descender of one line and top of ascender of the next).

package zero.swf.records.texts{
	
	import flash.utils.ByteArray;
	
	public class TEXTLAYOUT{
		
		public var Align:int;//UI8
		public var LeftMargin:int;//UI16
		public var RightMargin:int;//UI16
		public var Indent:int;//UI16
		public var Leading:int;//SI16
		
		public function TEXTLAYOUT(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			Align=data[offset++];
			
			LeftMargin=data[offset++]|(data[offset++]<<8);
			
			RightMargin=data[offset++]|(data[offset++]<<8);
			
			Indent=data[offset++]|(data[offset++]<<8);
			
			Leading=data[offset++]|(data[offset++]<<8);
			if(Leading&0x00008000){Leading|=0xffff0000}//最高位为1,表示负数
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=Align;
			
			data[1]=LeftMargin;
			data[2]=LeftMargin>>8;
			
			data[3]=RightMargin;
			data[4]=RightMargin>>8;
			
			data[5]=Indent;
			data[6]=Indent>>8;
			
			data[7]=Leading;
			data[8]=Leading>>8;
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.records.texts.TEXTLAYOUT"
					Align={Align}
					LeftMargin={LeftMargin}
					RightMargin={RightMargin}
					Indent={Indent}
					Leading={Leading}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				Align=int(xml.@Align.toString());
				
				LeftMargin=int(xml.@LeftMargin.toString());
				
				RightMargin=int(xml.@RightMargin.toString());
				
				Indent=int(xml.@Indent.toString());
				
				Leading=int(xml.@Leading.toString());
				
			}
		//}//end of CONFIG::USE_XML
	}
}