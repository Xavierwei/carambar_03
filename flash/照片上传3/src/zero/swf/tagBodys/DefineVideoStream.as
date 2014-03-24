/***
DefineVideoStream
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 19:53:41（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineVideoStream
//DefineVideoStream defines a video character that can later be placed on the display list (see
//The Display List).

//DefineVideoStream
//Field 					Type 			Comment
//Header 					RECORDHEADER 	Tag type = 60
//CharacterID 				UI16 			ID for this video character
//NumFrames 				UI16 			Number of VideoFrame tags that makes up this stream
//Width 					UI16 			Width in pixels
//Height 					UI16 			Height in pixels
//VideoFlagsReserved 		UB[4] 			Must be 0
//VideoFlagsDeblocking 		UB[3] 			000 = use VIDEOPACKET value
//											001 = off
//											010 = Level 1 (Fast deblocking filter)
//											011 = Level 2 (VP6 only, better deblocking filter)
//											100 = Level 3 (VP6 only, better deblocking plus fast deringing filter)
//											101 = Level 4 (VP6 only, better deblocking plus better deringing filter)
//											110 = Reserved
//											111 = Reserved
//VideoFlagsSmoothing 		UB[1] 			0 = smoothing off (faster)
//											1 = smoothing on (higher quality)
//CodecID 					UI8 			2 = Sorenson H.263
//											3 = Screen video (SWF 7 and later only)
//											4 = VP6 (SWF 8 and later only)
//											5 = VP6 video with alpha channel (SWF 8 and later only)

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	public class DefineVideoStream{
		
		public var id:int;//UI16
		public var NumFrames:int;//UI16
		public var Width:int;//UI16
		public var Height:int;//UI16
		private var Reserved:int;//11110000
		public var VideoFlagsDeblocking:int;//00001110
		public var VideoFlagsSmoothing:Boolean;//00000001
		public var CodecID:int;//UI8
		
		public function DefineVideoStream(){
			//id=0;
			//NumFrames=0;
			//Width=0;
			//Height=0;
			//Reserved=0;
			//VideoFlagsDeblocking=0;
			//VideoFlagsSmoothing=false;
			//CodecID=0;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			NumFrames=data[offset++]|(data[offset++]<<8);
			
			Width=data[offset++]|(data[offset++]<<8);
			
			Height=data[offset++]|(data[offset++]<<8);
			
			var flags:int=data[offset++];
			Reserved=flags&0xf0;//11110000
			VideoFlagsDeblocking=(flags&0x0e)>>>1;//00001110
			VideoFlagsSmoothing=((flags&0x01)?true:false);//00000001
			
			CodecID=data[offset++];
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data[2]=NumFrames;
			data[3]=NumFrames>>8;
			
			data[4]=Width;
			data[5]=Width>>8;
			
			data[6]=Height;
			data[7]=Height>>8;
			
			var flags:int=0;
			flags|=Reserved;//11110000
			flags|=VideoFlagsDeblocking<<1;//00001110
			if(VideoFlagsSmoothing){
				flags|=0x01;//00000001
			}
			data[8]=flags;
			
			data[9]=CodecID;
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.tagBodys.DefineVideoStream"
					id={id}
					NumFrames={NumFrames}
					Width={Width}
					Height={Height}
					Reserved={Reserved}
					VideoFlagsDeblocking={VideoFlagsDeblocking}
					VideoFlagsSmoothing={VideoFlagsSmoothing}
					CodecID={CodecID}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				NumFrames=int(xml.@NumFrames.toString());
				
				Width=int(xml.@Width.toString());
				
				Height=int(xml.@Height.toString());
				
				Reserved=int(xml.@Reserved.toString());
				VideoFlagsDeblocking=int(xml.@VideoFlagsDeblocking.toString());
				VideoFlagsSmoothing=(xml.@VideoFlagsSmoothing.toString()=="true");
				
				CodecID=int(xml.@CodecID.toString());
				
			}
		//}//end of CONFIG::USE_XML
	}
}