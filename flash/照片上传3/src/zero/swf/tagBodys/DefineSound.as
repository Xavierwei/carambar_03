/***
DefineSound
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月24日 18:00:10（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineSound
//The DefineSound tag defines an event sound. It includes the audio coding format, sampling
//rate, size of each sample (8 or 16 bit), a stereo/mono flag, and an array of audio samples. Note
//that not all of these parameters will be honored depending on the audio coding format.
//The minimum file format version is SWF 1.
//Define Sound
//Field 			Type 						Comment
//Header 			RECORDHEADER 				Tag type = 14
//SoundId 			UI16 						ID for this sound.
//SoundFormat 		UB[4] 						Format of SoundData. See "Audio coding formats" on page 201.
//SoundRate 		UB[2] 						The sampling rate. This is ignored for Nellymoser and Speex codecs.
//												5.5kHz is not allowed for MP3.
//												0 = 5.5 kHz
//												1 = 11 kHz
//												2 = 22 kHz
//												3 = 44 kHz
//SoundSize 		UB[1] 						Size of each sample. This parameter only pertains to uncompressed formats. This is ignored for compressed formats which always decode to 16 bits internally.
//												0 = snd8Bit
//												1 = snd16Bit
//SoundType 		UB[1] 						Mono or stereo sound This is ignored for Nellymoser and Speex.
//												0 = sndMono
//												1 = sndStereo
//SoundSampleCount 	UI32 						Number of samples. Not affected by mono/stereo setting; for stereo sounds this is the number of sample pairs.
//SoundData 		UI8[size of sound data] 	The sound data; varies by format.

//The SoundId field uniquely identifies the sound so it can be played by StartSound.
//Format 0 (uncompressed) and Format 3 (uncompressed little-endian) are similar. Both
//encode uncompressed audio samples. For 8-bit samples, the two formats are identical. For 16-
//bit samples, the two formats differ in byte ordering. Using format 0, 16-bit samples are
//encoded and decoded according to the native byte ordering of the platform on which the
//encoder and Flash Player, respectively, are running. Using format 3, 16-bit samples are always
//encoded in little-endian order (least significant byte first), and are byte-swapped if necessary
//in Flash Player before playback. Format 0 is clearly disadvantageous because it introduces a
//playback platform dependency. For 16-bit samples, format 3 is highly preferable to format 0
//for SWF 4 or later.
//The contents of SoundData vary depending on the value of the SoundFormat field in the
//SoundStreamHead tag:
//■ If SoundFormat is 0 or 3, SoundData contains raw, uncompressed samples.
//■ If SoundFormat is 1, SoundData contains an ADPCM sound data record.
//■ If SoundFormat is 2, SoundData contains an MP3 sound data record.
//■ If SoundFormat is 4, 5, or 6, SoundData contains Nellymoser data (see "Nellymoser
//compression" on page 219).
//■ If SoundFormat is 11, SoundData contains Speex data (see "Speex compression"
//on page 220).

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	import zero.swf.BytesData;
	
	public class DefineSound{
		
		public var id:int;//UI16
		public var SoundFormat:int;//11110000
		public var SoundRate:int;//00001100
		public var SoundSize:int;//00000010
		public var SoundType:int;//00000001
		public var SoundSampleCount:uint;//UI32
		public var SoundData:BytesData;
		
		//20120926
		private static const samplePreFrameArr:Array=[
			[384,1152,1152],
			[384,1152,576],
			[384,1152,576]
		];
		private static const bitrateArr:Array=[
			[
				[0,32000,64000,96000,128000,160000,192000,224000,256000,288000,320000,352000,384000,416000,448000,-1],
				[0,32000,48000,56000,64000,80000,96000,112000,128000,160000,192000,224000,256000,320000,384000,-1],
				[0,32000,40000,48000,56000,64000,80000,96000,112000,128000,160000,192000,224000,256000,320000,-1]
			],[
				[0,32000,48000,56000,64000,80000,96000,112000,128000,144000,160000,176000,192000,224000,256000,-1],
				[0,8000,16000,24000,32000,40000,48000,56000,64000,80000,96000,112000,128000,144000,160000,-1],
				[0,8000,16000,24000,32000,40000,48000,56000,64000,80000,96000,112000,128000,144000,160000,-1]
			]
		];
		private static const samplingRateArr:Array=[
			[44100,48000,32000,-1],
			[22050,24000,16000,-1],
			[11025,12000,8000,-1]
		];
		
		//■ If SoundFormat is 2, SoundData contains an MP3 sound data record.
		//MP3 sound data
		//MP3 sound data is described in the following table:
		//MP3SOUNDDATA
		//Field Type Comment
		//SeekSamples SI16 Number of samples to skip.
		//Mp3Frames MP3FRAME[zero or more] Array of MP3 frames.
		//For an explanation of the the SeekSamples field, see “Frame subdivision for streaming sound”
		//on page 211.
		//NOTE
		//For event sounds, SeekSamples is limited to specifying initial latency（指定的初始延迟）.
		
		public function DefineSound(){
			//id=0;
			//SoundFormat=0;
			//SoundRate=0;
			//SoundSize=0;
			//SoundType=0;
			//SoundSampleCount=0;
			//SoundData=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			var flags:int=data[offset++];
			SoundFormat=(flags&0xf0)>>>4;//11110000
			SoundRate=(flags&0x0c)>>>2;//00001100
			SoundSize=(flags&0x02)>>>1;//00000010
			SoundType=flags&0x01;//00000001
			
			SoundSampleCount=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			
			SoundData=new BytesData();
			return SoundData.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			var flags:int=0;
			flags|=SoundFormat<<4;//11110000
			flags|=SoundRate<<2;//00001100
			flags|=SoundSize<<1;//00000010
			flags|=SoundType;//00000001
			data[2]=flags;
			
			data[3]=SoundSampleCount;
			data[4]=SoundSampleCount>>8;
			data[5]=SoundSampleCount>>16;
			data[6]=SoundSampleCount>>24;
			
			data.position=7;
			data.writeBytes(SoundData.toData(_toDataOptions));
			
			return data;
			
		}
		
		//20120926
		public function getMP3Data():ByteArray{
			
			if(SoundData){
			}else{
				trace("SoundData="+SoundData);
				return null;
			}
			
			if(SoundFormat==2){
			}else{
				trace("SoundFormat="+SoundFormat,"不是MP3");
				return null;
			}
			
			var mp3Data:ByteArray=new ByteArray();
			mp3Data.writeBytes(SoundData.toData(null),2);
			return mp3Data;
		}
		public function setMP3Data(_mp3Data:ByteArray):void{
			
			var mp3Data:ByteArray=new ByteArray();
			mp3Data.writeBytes(_mp3Data);
			
			var offset:int=mp3Data.length-128;
			if(offset<0){
			}else{
				if(
					mp3Data[offset]==0x54//T
					&&
					mp3Data[offset+1]==0x41//A
					&&
					mp3Data[offset+2]==0x47//G
				){
					mp3Data.length=offset;
				}
			}
			
			if(
				mp3Data[0]==0x49//I
				&&
				mp3Data[1]==0x44//D
				&&
				mp3Data[2]==0x33//3
				&&
				mp3Data[3]==0x03//3
			){
				var id3Size:int=(((mp3Data[6]&0x7f)<<21)|((mp3Data[7]&0x7f)<<14)|((mp3Data[8]&0x7f)<<7)|(mp3Data[9]&0x7f))+10;
				var newMP3Data:ByteArray=new ByteArray();
				newMP3Data.writeBytes(mp3Data,id3Size);
				mp3Data=newMP3Data;
			}
			
			SoundFormat=2;
			SoundRate=-1;
			SoundSize=1;
			SoundType=-1;
			SoundSampleCount=0;
			
			newMP3Data=new ByteArray();
			offset=0;
			var endOffset:int=mp3Data.length;
			while(offset<endOffset){
				if(mp3Data[offset]==0xff){//11111111
					if((mp3Data[offset+1]&0xe0)==0xe0){//11100000
						var flags:int=(mp3Data[offset]<<24)|(mp3Data[offset+1]<<16)|(mp3Data[offset+2]<<8)|mp3Data[offset+3];//AAAAAAAA AAABBCCD EEEEFFGH IIJJKLMM
						
						//trace("flags="+uint(flags).toString(16));
						
						switch(flags&0x00180000){//00000000 00011000 00000000 00000000
							case 0x00000000:
								//trace("00 - MPEG Version 2.5");
								subSamplePreFrameArr=samplePreFrameArr[2];
								subBitrateArr=bitrateArr[1];
								subSamplingRateArr=samplingRateArr[2];
							break;
							case 0x00080000:
								//trace("01 - reserved");
								subSamplePreFrameArr=null;
								subBitrateArr=null
								subSamplingRateArr=null;
							break;
							case 0x00100000:
								//trace("10 - MPEG Version 2");
								subSamplePreFrameArr=samplePreFrameArr[1];
								subBitrateArr=bitrateArr[1];
								subSamplingRateArr=samplingRateArr[1];
							break;
							case 0x00180000:
								//trace("11 - MPEG Version 1");
								var subSamplePreFrameArr:Array=samplePreFrameArr[0];
								var subBitrateArr:Array=bitrateArr[0];
								var subSamplingRateArr:Array=samplingRateArr[0];
							break;
						}
						
						
						var samplingRate:int=subSamplingRateArr[(flags>>10)&0x03];
						
						switch(samplingRate){
							case 44100:
								var _SoundRate:int=3;
							break;
							case 22050:
								_SoundRate=2;
							break;
							case 11025:
								_SoundRate=1;
							break;
							default:
								throw new Error("不支持的 samplingRate："+samplingRate);
							break;
						}
						if(SoundRate>-1){
							if(SoundRate==_SoundRate){
							}else{
								throw new Error("SoundRate="+SoundRate+"，_SoundRate="+_SoundRate+"，SoundRate!=_SoundRate");
							}
						}else{
							SoundRate=_SoundRate;
						}
						
						switch(flags&0x00060000){//00000000 00000110 00000000 00000000
							case 0x00000000:
								//trace("00 - reserved");
								var samplePreFrame:int=-1;
								subBitrateArr=null;
							break;
							case 0x00020000:
								//trace("01 - Layer III");
								samplePreFrame=subSamplePreFrameArr[2];
								subBitrateArr=subBitrateArr[2];
							break;
							case 0x00040000:
								//trace("10 - Layer II");
								samplePreFrame=subSamplePreFrameArr[1];
								subBitrateArr=subBitrateArr[1];
							break;
							case 0x00060000:
								//trace("11 - Layer I");
								samplePreFrame=subSamplePreFrameArr[0];
								subBitrateArr=subBitrateArr[0];
							break;
						}
						
						//Channel Mode
						switch(flags&0x000000c0){//00000000 00000000 00000000 11000000
							case 0x00000000:
								//trace("00 - Stereo");
								var _SoundType:int=1;
							break;
							case 0x00000040:
								//trace("01 - Joint stereo (Stereo)");
								_SoundType=1;
							break;
							case 0x00000080:
								//trace("10 - Dual channel (Stereo)");
								_SoundType=1;
							break;
							case 0x000000c0:
								//trace("11 - Single channel (Mono)");
								_SoundType=0;
							break;
						}
						if(SoundType>-1){
							if(SoundType==_SoundType){
							}else{
								throw new Error("SoundType="+SoundType+"，_SoundType="+_SoundType+"，SoundType!=_SoundType");
							}
						}else{
							SoundType=_SoundType;
						}
						
						SoundSampleCount+=samplePreFrame;
						
						//Frame Size = ( (Samples Per Frame / 8 * Bitrate) / Sampling Rate) + Padding Size
						//帧大小 = （（每帧的采样数 ÷ 8 × 比特率） ÷ 采样率）+ 填充大小 【公式1】
						
						var FrameSize:int=samplePreFrame/8*subBitrateArr[(flags>>12)&0x0f]/samplingRate+((flags>>9)&0x01);
						//trace("FrameSize="+FrameSize);
						
						//import zero.BytesAndStr16;
						//trace(BytesAndStr16.bytes2str16(mp3Data,frameOffset,FrameSize));
						
						newMP3Data.writeBytes(mp3Data,offset,FrameSize);
						offset+=FrameSize;
						//trace(BytesAndStr16.bytes2str16(mp3Data,offset,4));
					}else{
						break;
					}
				}else{
					offset++;
				}
			}
			
			var soundData:ByteArray=new ByteArray();
			soundData.writeShort(0x0000);//SeekSamples ?
			soundData.writeBytes(newMP3Data);
			SoundData=new BytesData();
			SoundData.initByData(soundData,0,soundData.length,null);
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineSound"
					id={id}
					SoundFormat={SoundFormat}
					SoundRate={SoundRate}
					SoundSize={SoundSize}
					SoundType={SoundType}
					SoundSampleCount={SoundSampleCount}
				/>;
				
				xml.appendChild(SoundData.toXML("SoundData",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				SoundFormat=int(xml.@SoundFormat.toString());
				SoundRate=int(xml.@SoundRate.toString());
				SoundSize=int(xml.@SoundSize.toString());
				SoundType=int(xml.@SoundType.toString());
				
				SoundSampleCount=uint(xml.@SoundSampleCount.toString());
				
				SoundData=new BytesData();
				SoundData.initByXML(xml.SoundData[0],_initByXMLOptions);
				
			}
		//}//end of CONFIG::USE_XML
	}
}