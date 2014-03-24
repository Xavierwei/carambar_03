/***
StartSound2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 09:57:10（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//StartSound2
//StartSound is a control tag that either starts (or stops) playing a sound defined by
//DefineSound. The SoundId field identifies which sound is to be played. The SoundInfo field
//defines how the sound is played. Stop a sound by setting the SyncStop flag in the
//SOUNDINFO record.
//The minimum file format version is SWF 9. Supported in Flash Player 9.0.45.0 and later.

//StartSound
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 89.
//SoundClassName 	STRING 			Name of the sound class to play.
//SoundInfo 		SOUNDINFO 		Sound style information.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.sounds.SOUNDINFO;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class StartSound2{
		
		public var SoundClassName:String;//STRING
		public var SoundInfo:SOUNDINFO;
		
		public function StartSound2(){
			//SoundClassName=null;
			//SoundInfo=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			SoundClassName=ignoreBOMReadUTFBytes(data,get_str_size);
			offset+=get_str_size;
			
			SoundInfo=new SOUNDINFO();
			return SoundInfo.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data.writeUTFBytes(SoundClassName+"\x00");
			
			data.writeBytes(SoundInfo.toData(_toDataOptions));
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.StartSound2"
					SoundClassName={SoundClassName}
				/>;
				
				xml.appendChild(SoundInfo.toXML("SoundInfo",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				SoundClassName=xml.@SoundClassName.toString();
				
				SoundInfo=new SOUNDINFO();
				SoundInfo.initByXML(xml.SoundInfo[0],_initByXMLOptions);
				
			}
		//}//end of CONFIG::USE_XML
	}
}