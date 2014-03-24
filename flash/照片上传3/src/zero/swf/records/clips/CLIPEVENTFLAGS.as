/***
CLIPEVENTFLAGS
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:17（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The CLIPEVENTFLAGS sequence specifies one or more sprite events to which an event
//handler applies. In SWF 5 and earlier, CLIPEVENTFLAGS is 2 bytes; in SWF 6 and later, it
//is 4 bytes.

//CLIPEVENTFLAGS
//Field 					Type 						Comment
//ClipEventKeyUp 			UB[1] 						Key up event
//ClipEventKeyDown 			UB[1] 						Key down event
//ClipEventMouseUp 			UB[1] 						Mouse up event
//ClipEventMouseDown 		UB[1] 						Mouse down event
//ClipEventMouseMove 		UB[1] 						Mouse move event
//ClipEventUnload 			UB[1] 						Clip unload event
//ClipEventEnterFrame 		UB[1] 						Frame event
//ClipEventLoad 			UB[1] 						Clip load event

//ClipEventDragOver 		UB[1] 						SWF 6 and later: mouse drag over event Otherwise: always 0
//ClipEventRollOut 			UB[1] 						SWF 6 and later: mouse rollout event Otherwise: always 0
//ClipEventRollOver 		UB[1] 						SWF 6 and later: mouse rollover event Otherwise: always 0
//ClipEventReleaseOutside 	UB[1] 						SWF 6 and later: mouse release outside event Otherwise: always 0
//ClipEventRelease 			UB[1] 						SWF 6 and later: mouse release inside event Otherwise: always 0
//ClipEventPress 			UB[1] 						SWF 6 and later: mouse press event Otherwise: always 0
//ClipEventInitialize 		UB[1] 						SWF 6 and later: initialize event Otherwise: always 0
//ClipEventData 			UB[1] 						Data received event

//Reserved 					If SWF version >= 6, UB[5] 	Always 0
//ClipEventConstruct 		If SWF version >= 6, UB[1] 	SWF 7 and later: construct event Otherwise: always 0
//ClipEventKeyPress 		If SWF version >= 6, UB[1] 	Key press event
//ClipEventDragOut 			If SWF version >= 6, UB[1] 	Mouse drag out event
//Reserved 					If SWF version >= 6, UB[8] 	Always 0
package zero.swf.records.clips{
	import flash.utils.ByteArray;
	public class CLIPEVENTFLAGS{
		public var ClipEventKeyUp:Boolean;
		public var ClipEventKeyDown:Boolean;
		public var ClipEventMouseUp:Boolean;
		public var ClipEventMouseDown:Boolean;
		public var ClipEventMouseMove:Boolean;
		public var ClipEventUnload:Boolean;
		public var ClipEventEnterFrame:Boolean;
		public var ClipEventLoad:Boolean;
		public var ClipEventDragOver:Boolean;
		public var ClipEventRollOut:Boolean;
		public var ClipEventRollOver:Boolean;
		public var ClipEventReleaseOutside:Boolean;
		public var ClipEventRelease:Boolean;
		public var ClipEventPress:Boolean;
		public var ClipEventInitialize:Boolean;
		public var ClipEventData:Boolean;
		public var ClipEventConstruct:Boolean;
		public var ClipEventKeyPress:Boolean;
		public var ClipEventDragOut:Boolean;
		//
		
		public function CLIPEVENTFLAGS(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			if(_initByDataOptions&&_initByDataOptions.swf_Version>0){
			}else{
				throw new Error("需要提供 swf_Version 信息");
			}
			
			var flags:int=data[offset];
			ClipEventKeyUp=((flags&0x80)?true:false);				//10000000
			ClipEventKeyDown=((flags&0x40)?true:false);			//01000000
			ClipEventMouseUp=((flags&0x20)?true:false);			//00100000
			ClipEventMouseDown=((flags&0x10)?true:false);			//00010000
			ClipEventMouseMove=((flags&0x08)?true:false);			//00001000
			ClipEventUnload=((flags&0x04)?true:false);			//00000100
			ClipEventEnterFrame=((flags&0x02)?true:false);		//00000010
			ClipEventLoad=((flags&0x01)?true:false);				//00000001
			
			flags=data[offset+1];
			ClipEventDragOver=((flags&0x80)?true:false);			//10000000
			ClipEventRollOut=((flags&0x40)?true:false);			//01000000
			ClipEventRollOver=((flags&0x20)?true:false);			//00100000
			ClipEventReleaseOutside=((flags&0x10)?true:false);	//00010000
			ClipEventRelease=((flags&0x08)?true:false);			//00001000
			ClipEventPress=((flags&0x04)?true:false);				//00000100
			ClipEventInitialize=((flags&0x02)?true:false);		//00000010
			ClipEventData=((flags&0x01)?true:false);				//00000001
			
			if(_initByDataOptions.swf_Version<6){
				ClipEventConstruct=false;
				ClipEventKeyPress=false;
				ClipEventDragOut=false;
				return offset+2;
			}
			
			flags=data[offset+2];
			//Reserved=flags&0xf8;							//11111000
			ClipEventConstruct=((flags&0x04)?true:false);			//00000100
			ClipEventKeyPress=((flags&0x02)?true:false);			//00000010
			ClipEventDragOut=((flags&0x01)?true:false);			//00000001
			//Reserved=data[offset+3];
			
			//trace("initByData ClipEventRelease="+ClipEventRelease);
			
			return offset+4;
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			//trace("toData ClipEventRelease="+ClipEventRelease);
			
			var data:ByteArray=new ByteArray();
			if(_toDataOptions&&_toDataOptions.swf_Version>0){
			}else{
				throw new Error("需要提供 swf_Version 信息");
			}
			
			var flags:int=0;
			if(ClipEventKeyUp){
				flags|=0x80;								//10000000
			}
			if(ClipEventKeyDown){
				flags|=0x40;								//01000000
			}
			if(ClipEventMouseUp){
				flags|=0x20;								//00100000
			}
			if(ClipEventMouseDown){
				flags|=0x10;								//00010000
			}
			if(ClipEventMouseMove){
				flags|=0x08;								//00001000
			}
			if(ClipEventUnload){
				flags|=0x04;								//00000100
			}
			if(ClipEventEnterFrame){
				flags|=0x02;								//00000010
			}
			if(ClipEventLoad){
				flags|=0x01;								//00000001
			}
			data[0]=flags;
			
			flags=0;
			if(ClipEventDragOver){
				flags|=0x80;								//10000000
			}
			if(ClipEventRollOut){
				flags|=0x40;								//01000000
			}
			if(ClipEventRollOver){
				flags|=0x20;								//00100000
			}
			if(ClipEventReleaseOutside){
				flags|=0x10;								//00010000
			}
			if(ClipEventRelease){
				flags|=0x08;								//00001000
			}
			if(ClipEventPress){
				flags|=0x04;								//00000100
			}
			if(ClipEventInitialize){
				flags|=0x02;								//00000010
			}
			if(ClipEventData){
				flags|=0x01;								//00000001
			}
			data[1]=flags;
			
			if(_toDataOptions.swf_Version<6){
			}else{
				flags=0;
				//flags|=Reserved;							//11111000
				if(ClipEventConstruct){
					flags|=0x04;							//00000100
				}
				if(ClipEventKeyPress){
					flags|=0x02;							//00000010
				}
				if(ClipEventDragOut){
					flags|=0x01;							//00000001
				}
				data[2]=flags;
			
				data[3]=0x00;
			}
			
			return data;
		}

		////
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				//trace("toXML ClipEventRelease="+ClipEventRelease);
				
				return <{xmlName} class="zero.swf.records.clips.CLIPEVENTFLAGS"
					ClipEventKeyUp={ClipEventKeyUp}
					ClipEventKeyDown={ClipEventKeyDown}
					ClipEventMouseUp={ClipEventMouseUp}
					ClipEventMouseDown={ClipEventMouseDown}
					ClipEventMouseMove={ClipEventMouseMove}
					ClipEventUnload={ClipEventUnload}
					ClipEventEnterFrame={ClipEventEnterFrame}
					ClipEventLoad={ClipEventLoad}
				
					ClipEventDragOver={ClipEventDragOver}
					ClipEventRollOut={ClipEventRollOut}
					ClipEventRollOver={ClipEventRollOver}
					ClipEventReleaseOutside={ClipEventReleaseOutside}
					ClipEventRelease={ClipEventRelease}
					ClipEventPress={ClipEventPress}
					ClipEventInitialize={ClipEventInitialize}
					ClipEventData={ClipEventData}
					
					ClipEventConstruct={ClipEventConstruct}
					ClipEventKeyPress={ClipEventKeyPress}
					ClipEventDragOut={ClipEventDragOut}
				/>;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				ClipEventKeyUp=(xml.@ClipEventKeyUp.toString()=="true");
				ClipEventKeyDown=(xml.@ClipEventKeyDown.toString()=="true");
				ClipEventMouseUp=(xml.@ClipEventMouseUp.toString()=="true");
				ClipEventMouseDown=(xml.@ClipEventMouseDown.toString()=="true");
				ClipEventMouseMove=(xml.@ClipEventMouseMove.toString()=="true");
				ClipEventUnload=(xml.@ClipEventUnload.toString()=="true");
				ClipEventEnterFrame=(xml.@ClipEventEnterFrame.toString()=="true");
				ClipEventLoad=(xml.@ClipEventLoad.toString()=="true");
				
				ClipEventDragOver=(xml.@ClipEventDragOver.toString()=="true");
				ClipEventRollOut=(xml.@ClipEventRollOut.toString()=="true");
				ClipEventRollOver=(xml.@ClipEventRollOver.toString()=="true");
				ClipEventReleaseOutside=(xml.@ClipEventReleaseOutside.toString()=="true");
				ClipEventRelease=(xml.@ClipEventRelease.toString()=="true");
				ClipEventPress=(xml.@ClipEventPress.toString()=="true");
				ClipEventInitialize=(xml.@ClipEventInitialize.toString()=="true");
				ClipEventData=(xml.@ClipEventData.toString()=="true");
				
				ClipEventConstruct=(xml.@ClipEventConstruct.toString()=="true");
				ClipEventKeyPress=(xml.@ClipEventKeyPress.toString()=="true");
				ClipEventDragOut=(xml.@ClipEventDragOut.toString()=="true");
				
				//trace("initByXML ClipEventRelease="+ClipEventRelease);
				
			}
		//}//end of CONFIG::USE_XML
	}
}
