/***
SOUNDENVELOPE
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 10:51:12（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The SOUNDENVELOPE structure is defined as follows:
//SOUNDENVELOPE
//Field 		Type 		Comment
//Pos44 		UI32 		Position of envelope point as a number of 44 kHz samples. Multiply accordingly if using a sampling rate less than 44 kHz.
//LeftLevel 	UI16 		Volume level for left channel. Minimum is 0, maximum is 32768.
//RightLevel 	UI16 		Volume level for right channel. Minimum is 0, maximum is 32768.
//
//For mono sounds, set the LeftLevel and RightLevel fields to the same value. If the values differ, they will be averaged.

package zero.swf.records.sounds{
	
	import flash.utils.ByteArray;
	
	public class SOUNDENVELOPE{
		
		public var Pos44:uint;//UI32
		public var LeftLevel:int;//UI16
		public var RightLevel:int;//UI16
		
		public function SOUNDENVELOPE(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			Pos44=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			
			LeftLevel=data[offset++]|(data[offset++]<<8);
			
			RightLevel=data[offset++]|(data[offset++]<<8);
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=Pos44;
			data[1]=Pos44>>8;
			data[2]=Pos44>>16;
			data[3]=Pos44>>24;
			
			data[4]=LeftLevel;
			data[5]=LeftLevel>>8;
			
			data[6]=RightLevel;
			data[7]=RightLevel>>8;
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.records.sounds.SOUNDENVELOPE"
					Pos44={Pos44}
					LeftLevel={LeftLevel}
					RightLevel={RightLevel}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				Pos44=uint(xml.@Pos44.toString());
				
				LeftLevel=int(xml.@LeftLevel.toString());
				
				RightLevel=int(xml.@RightLevel.toString());
				
			}
		//}//end of CONFIG::USE_XML
	}
}