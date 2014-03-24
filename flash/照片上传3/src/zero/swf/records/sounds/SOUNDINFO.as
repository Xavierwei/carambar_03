/***
SOUNDINFO
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 18:23:12（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The SOUNDINFO record modifies how an event sound is played. An event sound is defined
//with the DefineSound tag. Sound characteristics that can be modified include:
//■ Whether the sound loops (repeats) and how many times it loops.
//■ Where sound playback begins and ends.
//■ A sound envelope for time-based volume control.
//
//SOUNDINFO
//Field 				Type 										Comment
//Reserved 				UB[2] 										Always 0.
//SyncStop 				UB[1] 										Stop the sound now.
//SyncNoMultiple 		UB[1] 										Don't start the sound if already playing.
//HasEnvelope 			UB[1] 										Has envelope information.
//HasLoops 				UB[1] 										Has loop information.
//HasOutPoint 			UB[1] 										Has out-point information.
//HasInPoint 			UB[1] 										Has in-point information.
//InPoint 				If HasInPoint, UI32 						Number of samples to skip at beginning of sound.
//OutPoint 				If HasOutPoint, UI32 						Position in samples of last sample to play.
//LoopCount 			If HasLoops, UI16 							Sound loop count.
//EnvPoints 			If HasEnvelope, UI8 						Sound Envelope point count.
//EnvelopeRecords 		If HasEnvelope, SOUNDENVELOPE[EnvPoints]	Sound Envelope records.

package zero.swf.records.sounds{
	
	import flash.utils.ByteArray;
	
	public class SOUNDINFO{
		
		//public var Reserved:int;//11000000
		public var SyncStop:Boolean;//00100000
		public var SyncNoMultiple:Boolean;//00010000
		public var HasOutPoint:Boolean;//00000010
		public var HasInPoint:Boolean;//00000001
		public var InPoint:uint;//UI32
		public var OutPoint:uint;//UI32
		public var LoopCount:int;//UI16
		public var EnvelopeRecordV:Vector.<SOUNDENVELOPE>;
		
		public function SOUNDINFO(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var flags:int=data[offset++];
			//Reserved=flags&0xc0;//11000000
			SyncStop=((flags&0x20)?true:false);//00100000
			SyncNoMultiple=((flags&0x10)?true:false);//00010000
			var HasEnvelope:Boolean=((flags&0x08)?true:false);//00001000
			var HasLoops:Boolean=((flags&0x04)?true:false);//00000100
			HasOutPoint=((flags&0x02)?true:false);//00000010
			HasInPoint=((flags&0x01)?true:false);//00000001
			
			if(HasInPoint){
				InPoint=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			}
			
			if(HasOutPoint){
				OutPoint=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			}
			
			if(HasLoops){
				LoopCount=data[offset++]|(data[offset++]<<8);
			}else{
				LoopCount=-1;
			}
			
			if(HasEnvelope){
				var EnvPoints:int=data[offset++];
				if(EnvPoints){
					EnvelopeRecordV=new Vector.<SOUNDENVELOPE>();
					for(var i:int=0;i<EnvPoints;i++){
						
						EnvelopeRecordV[i]=new SOUNDENVELOPE();
						offset=EnvelopeRecordV[i].initByData(data,offset,endOffset,_initByDataOptions);
						
					}
				}else{
					EnvelopeRecordV=null;
				}
			}else{
				EnvelopeRecordV=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			var flags:int=0;
			//flags|=Reserved;//11000000
			if(SyncStop){
				flags|=0x20;//00100000
			}
			if(SyncNoMultiple){
				flags|=0x10;//00010000
			}
			if(EnvelopeRecordV&&EnvelopeRecordV.length){
				flags|=0x08;//HasEnvelope//00001000
			}
			if(LoopCount>-1){
				flags|=0x04;//HasLoops//00000100
			}
			if(HasOutPoint){
				flags|=0x02;//00000010
			}
			if(HasInPoint){
				flags|=0x01;//00000001
			}
			data[0]=flags;
			
			if(HasInPoint){
				data[1]=InPoint;
				data[2]=InPoint>>8;
				data[3]=InPoint>>16;
				data[4]=InPoint>>24;
			}
			
			if(HasOutPoint){
				data[data.length]=OutPoint;
				data[data.length]=OutPoint>>8;
				data[data.length]=OutPoint>>16;
				data[data.length]=OutPoint>>24;
			}
			
			if(LoopCount>-1){
				data[data.length]=LoopCount;
				data[data.length]=LoopCount>>8;
			}
			
			if(EnvelopeRecordV){
				var EnvPoints:int=EnvelopeRecordV.length;
				if(EnvPoints){
					
					data[data.length]=EnvPoints;
					
					data.position=data.length;
					for each(var EnvelopeRecord:SOUNDENVELOPE in EnvelopeRecordV){
						
						data.writeBytes(EnvelopeRecord.toData(_toDataOptions));
						
					}
				}
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.records.sounds.SOUNDINFO"
					SyncStop={SyncStop}
					SyncNoMultiple={SyncNoMultiple}
				/>;
				
				if(HasInPoint){
					xml.@InPoint=InPoint;
				}
				
				if(HasOutPoint){
					xml.@OutPoint=OutPoint;
				}
				
				if(LoopCount>-1){
					xml.@LoopCount=LoopCount;
				}
				
				if(EnvelopeRecordV){
					if(EnvelopeRecordV.length){
						var EnvelopeRecordListXML:XML=<EnvelopeRecordList count={EnvelopeRecordV.length}/>;
						for each(var EnvelopeRecord:SOUNDENVELOPE in EnvelopeRecordV){
							
							EnvelopeRecordListXML.appendChild(EnvelopeRecord.toXML("EnvelopeRecord",_toXMLOptions));
							
						}
						xml.appendChild(EnvelopeRecordListXML);
					}
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				SyncStop=(xml.@SyncStop.toString()=="true");
				SyncNoMultiple=(xml.@SyncNoMultiple.toString()=="true");
				
				var InPointXML:XML=xml.@InPoint[0];
				if(InPointXML){
					HasInPoint=true;
					InPoint=uint(InPointXML.toString());
				}else{
					HasInPoint=false;
				}
				
				var OutPointXML:XML=xml.@OutPoint[0];
				if(OutPointXML){
					HasOutPoint=true;
					OutPoint=uint(OutPointXML.toString());
				}else{
					HasOutPoint=false;
				}
				
				var LoopCountXML:XML=xml.@LoopCount[0];
				if(LoopCountXML){
					LoopCount=int(LoopCountXML.toString());
				}else{
					LoopCount=-1;
				}
				
				var EnvelopeRecordXMLList:XMLList=xml.EnvelopeRecordList.EnvelopeRecord;
				if(EnvelopeRecordXMLList.length()){
					var i:int=-1;
					EnvelopeRecordV=new Vector.<SOUNDENVELOPE>();
					for each(var EnvelopeRecordXML:XML in EnvelopeRecordXMLList){
						i++;
						
						EnvelopeRecordV[i]=new SOUNDENVELOPE();
						EnvelopeRecordV[i].initByXML(EnvelopeRecordXML,_initByXMLOptions);
						
					}
				}else{
					EnvelopeRecordV=null;
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}