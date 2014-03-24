/***
ZONERECORD
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 21:30:18（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//ZONERECORD
//Field 				Type 					Comment
//NumZoneData 			UI8 					Number of ZoneData entries. Always 2.
//ZoneData 				ZONEDATA[NumZoneData] 	Compressed alignment zone information.
//Reserved 				UB[6] 					Must be 0.
//ZoneMaskY 			UB[1] 					Set if there are Y alignment zones.
//ZoneMaskX 			UB[1] 					Set if there are X alignment zones.

//ZONEDATA
//Field 				Type 					Comment
//AlignmentCoordinate 	FLOAT16 				X (left) or Y (baseline) coordinate of the alignment zone.
//Range 				FLOAT16 				Width or height of the alignment zone.

package zero.swf.records.texts{
	
	import flash.utils.ByteArray;
	
	public class ZONERECORD{
		
		public var AlignmentCoordinateV:Vector.<int>;//FLOAT16
		public var RangeV:Vector.<int>;//FLOAT16
		//public var Reserved:int;//11111100
		public var ZoneMaskY:int;//00000010
		public var ZoneMaskX:int;//00000001
		
		public function ZONERECORD(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var NumZoneData:int=data[offset++];
			
			AlignmentCoordinateV=new Vector.<int>();
			RangeV=new Vector.<int>();
			for(var i:int=0;i<NumZoneData;i++){
				
				AlignmentCoordinateV[i]=data[offset++]|(data[offset++]<<8);
				
				RangeV[i]=data[offset++]|(data[offset++]<<8);
				
			}
			
			var flags:int=data[offset++];
			//Reserved=flags&0xfc;//11111100
			ZoneMaskY=(flags&0x02)>>>1;//00000010
			ZoneMaskX=flags&0x01;//00000001
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			var NumZoneData:int=AlignmentCoordinateV.length;
			data[0]=NumZoneData;
			
			var i:int=-1;
			for each(var AlignmentCoordinate:int in AlignmentCoordinateV){
				i++;
				
				data[data.length]=AlignmentCoordinate;
				data[data.length]=AlignmentCoordinate>>8;
				
				data[data.length]=RangeV[i];
				data[data.length]=RangeV[i]>>8;
				
			}
			
			var flags:int=0;
			//flags|=Reserved;//11111100
			flags|=ZoneMaskY<<1;//00000010
			flags|=ZoneMaskX;//00000001
			data[data.length]=flags;
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.records.texts.ZONERECORD"
					ZoneMaskY={ZoneMaskY}
					ZoneMaskX={ZoneMaskX}
				/>;
				
				if(AlignmentCoordinateV.length){
					var i:int=-1;
					var AlignmentCoordinateAndRangeListXML:XML=<AlignmentCoordinateAndRangeList count={AlignmentCoordinateV.length}/>;
					for each(var AlignmentCoordinate:int in AlignmentCoordinateV){
						i++;
						
						AlignmentCoordinateAndRangeListXML.appendChild(<AlignmentCoordinate value={AlignmentCoordinate}/>);
						
						AlignmentCoordinateAndRangeListXML.appendChild(<Range value={RangeV[i]}/>);
						
					}
					xml.appendChild(AlignmentCoordinateAndRangeListXML);
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				var i:int=-1;
				var RangeXMLList:XMLList=xml.AlignmentCoordinateAndRangeList.Range;
				AlignmentCoordinateV=new Vector.<int>();
				RangeV=new Vector.<int>();
				for each(var AlignmentCoordinateXML:XML in xml.AlignmentCoordinateAndRangeList.AlignmentCoordinate){
					i++;
					
					AlignmentCoordinateV[i]=int(AlignmentCoordinateXML.@value.toString());
					
					RangeV[i]=int(RangeXMLList[i].@value.toString());
					
				}
				
				ZoneMaskY=int(xml.@ZoneMaskY.toString());
				ZoneMaskX=int(xml.@ZoneMaskX.toString());
				
			}
		//}//end of CONFIG::USE_XML
	}
}