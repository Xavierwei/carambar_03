/***
DefineButtonSound
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月25日 07:33:34（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineButtonSound
//The DefineButtonSound tag defines which sounds (if any) are played on state transitions.
//
//The minimum file format version is SWF 2.
//
//DefineButtonSound
//Field 				Type 										Comment
//Header 				RECORDHEADER 								Tag type = 17
//ButtonId 				UI16 										The ID of the button these sounds apply to.
//ButtonSoundChar0 		UI16 										Sound ID for OverUpToIdle
//ButtonSoundInfo0 		SOUNDINFO (if ButtonSoundChar0 is nonzero)	Sound style for OverUpToIdle
//ButtonSoundChar1 		UI16 										Sound ID for IdleToOverUp
//ButtonSoundInfo1 		SOUNDINFO (if ButtonSoundChar1 is nonzero)	Sound style for IdleToOverUp
//ButtonSoundChar2 		UI16 										Sound ID for OverUpToOverDown
//ButtonSoundInfo2 		SOUNDINFO (if ButtonSoundChar2 is nonzero)	Sound style for OverUpToOverDown
//ButtonSoundChar3 		UI16 										Sound ID for OverDownToOverUp
//ButtonSoundInfo3 		SOUNDINFO (if ButtonSoundChar3 is nonzero)	Sound style for OverDownToOverUp

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.sounds.SOUNDINFO;
	
	public class DefineButtonSound{
		
		public var ButtonId:int;//UI16
		public var ButtonSoundChar0:int;//UI16
		public var ButtonSoundInfo0:SOUNDINFO;
		public var ButtonSoundChar1:int;//UI16
		public var ButtonSoundInfo1:SOUNDINFO;
		public var ButtonSoundChar2:int;//UI16
		public var ButtonSoundInfo2:SOUNDINFO;
		public var ButtonSoundChar3:int;//UI16
		public var ButtonSoundInfo3:SOUNDINFO;
		
		public function DefineButtonSound(){
			//ButtonId=0;
			//ButtonSoundChar0=0;
			//ButtonSoundInfo0=null;
			//ButtonSoundChar1=0;
			//ButtonSoundInfo1=null;
			//ButtonSoundChar2=0;
			//ButtonSoundInfo2=null;
			//ButtonSoundChar3=0;
			//ButtonSoundInfo3=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			ButtonId=data[offset++]|(data[offset++]<<8);
			
			ButtonSoundChar0=data[offset++]|(data[offset++]<<8);
			
			if(ButtonSoundChar0){
				ButtonSoundInfo0=new SOUNDINFO();
				offset=ButtonSoundInfo0.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ButtonSoundInfo0=null;
			}
			
			ButtonSoundChar1=data[offset++]|(data[offset++]<<8);
			
			if(ButtonSoundChar1){
				ButtonSoundInfo1=new SOUNDINFO();
				offset=ButtonSoundInfo1.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ButtonSoundInfo1=null;
			}
			
			ButtonSoundChar2=data[offset++]|(data[offset++]<<8);
			
			if(ButtonSoundChar2){
				ButtonSoundInfo2=new SOUNDINFO();
				offset=ButtonSoundInfo2.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ButtonSoundInfo2=null;
			}
			
			ButtonSoundChar3=data[offset++]|(data[offset++]<<8);
			
			if(ButtonSoundChar3){
				ButtonSoundInfo3=new SOUNDINFO();
				offset=ButtonSoundInfo3.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ButtonSoundInfo3=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=ButtonId;
			data[1]=ButtonId>>8;
			
			data[2]=ButtonSoundChar0;
			data[3]=ButtonSoundChar0>>8;
			
			if(ButtonSoundInfo0){
				data.position=4;
				data.writeBytes(ButtonSoundInfo0.toData(_toDataOptions));
			}
			
			data[data.length]=ButtonSoundChar1;
			data[data.length]=ButtonSoundChar1>>8;
			
			if(ButtonSoundInfo1){
				data.position=data.length;
				data.writeBytes(ButtonSoundInfo1.toData(_toDataOptions));
			}
			
			data[data.length]=ButtonSoundChar2;
			data[data.length]=ButtonSoundChar2>>8;
			
			if(ButtonSoundInfo2){
				data.position=data.length;
				data.writeBytes(ButtonSoundInfo2.toData(_toDataOptions));
			}
			
			data[data.length]=ButtonSoundChar3;
			data[data.length]=ButtonSoundChar3>>8;
			
			if(ButtonSoundInfo3){
				data.position=data.length;
				data.writeBytes(ButtonSoundInfo3.toData(_toDataOptions));
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineButtonSound"
					ButtonId={ButtonId}
					ButtonSoundChar0={ButtonSoundChar0}
					ButtonSoundChar1={ButtonSoundChar1}
					ButtonSoundChar2={ButtonSoundChar2}
					ButtonSoundChar3={ButtonSoundChar3}
				/>;
				
				if(ButtonSoundInfo0){
					xml.appendChild(ButtonSoundInfo0.toXML("ButtonSoundInfo0",_toXMLOptions));
				}
				
				if(ButtonSoundInfo1){
					xml.appendChild(ButtonSoundInfo1.toXML("ButtonSoundInfo1",_toXMLOptions));
				}
				
				if(ButtonSoundInfo2){
					xml.appendChild(ButtonSoundInfo2.toXML("ButtonSoundInfo2",_toXMLOptions));
				}
				
				if(ButtonSoundInfo3){
					xml.appendChild(ButtonSoundInfo3.toXML("ButtonSoundInfo3",_toXMLOptions));
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				ButtonId=int(xml.@ButtonId.toString());
				
				ButtonSoundChar0=int(xml.@ButtonSoundChar0.toString());
				
				var ButtonSoundInfo0XML:XML=xml.ButtonSoundInfo0[0];
				if(ButtonSoundInfo0XML){
					ButtonSoundInfo0=new SOUNDINFO();
					ButtonSoundInfo0.initByXML(ButtonSoundInfo0XML,_initByXMLOptions);
				}else{
					ButtonSoundInfo0=null;
				}
				
				ButtonSoundChar1=int(xml.@ButtonSoundChar1.toString());
				
				var ButtonSoundInfo1XML:XML=xml.ButtonSoundInfo1[0];
				if(ButtonSoundInfo1XML){
					ButtonSoundInfo1=new SOUNDINFO();
					ButtonSoundInfo1.initByXML(ButtonSoundInfo1XML,_initByXMLOptions);
				}else{
					ButtonSoundInfo1=null;
				}
				
				ButtonSoundChar2=int(xml.@ButtonSoundChar2.toString());
				
				var ButtonSoundInfo2XML:XML=xml.ButtonSoundInfo2[0];
				if(ButtonSoundInfo2XML){
					ButtonSoundInfo2=new SOUNDINFO();
					ButtonSoundInfo2.initByXML(ButtonSoundInfo2XML,_initByXMLOptions);
				}else{
					ButtonSoundInfo2=null;
				}
				
				ButtonSoundChar3=int(xml.@ButtonSoundChar3.toString());
				
				var ButtonSoundInfo3XML:XML=xml.ButtonSoundInfo3[0];
				if(ButtonSoundInfo3XML){
					ButtonSoundInfo3=new SOUNDINFO();
					ButtonSoundInfo3.initByXML(ButtonSoundInfo3XML,_initByXMLOptions);
				}else{
					ButtonSoundInfo3=null;
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}