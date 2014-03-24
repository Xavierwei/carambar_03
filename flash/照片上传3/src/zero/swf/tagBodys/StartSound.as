/***
StartSound
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月25日 06:59:14（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//StartSound is a control tag that either starts (or stops) playing a sound defined by
//DefineSound. The SoundId field identifies which sound is to be played. The SoundInfo field
//defines how the sound is played. Stop a sound by setting the SyncStop flag in the
//SOUNDINFO record.
//
//The minimum file format version is SWF 1.
//
//StartSound
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 15.
//SoundId 			UI16 			ID of sound character to play.
//SoundInfo 		SOUNDINFO 		Sound style information.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.sounds.SOUNDINFO;
	
	public class StartSound{
		
		public var SoundId:int;//UI16
		public var SoundInfo:SOUNDINFO;
		
		public function StartSound(){
			//SoundId=0;
			//SoundInfo=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			SoundId=data[offset++]|(data[offset++]<<8);
			
			SoundInfo=new SOUNDINFO();
			return SoundInfo.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=SoundId;
			data[1]=SoundId>>8;
			
			data.position=2;
			data.writeBytes(SoundInfo.toData(_toDataOptions));
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.StartSound"
					SoundId={SoundId}
				/>;
				
				xml.appendChild(SoundInfo.toXML("SoundInfo",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				SoundId=int(xml.@SoundId.toString());
				
				SoundInfo=new SOUNDINFO();
				SoundInfo.initByXML(xml.SoundInfo[0],_initByXMLOptions);
				
			}
		//}//end of CONFIG::USE_XML
	}
}