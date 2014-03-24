/***
DefineSceneAndFrameLabelData
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 21:53:50（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineSceneAndFrameLabelData
//The DefineSceneAndFrameLabelData tag contains scene and frame label data for a
//MovieClip. Scenes are supported for the main timeline only, for all other movie clips a single
//scene is exported.
//
//DefineSceneAndFrameLabelData
//Field 				Type 				Comment
//Header 				RECORDHEADER 		Tag type = 86
//SceneCount 			EncodedU32 			Number of scenes
//Offset1 				EncodedU32 			Frame offset for scene 1
//Name1 				STRING 				Name of scene 1
//... ... ...
//OffsetN 				EncodedU32 			Frame offset for scene N
//NameN 				STRING 				Name of scene N
//FrameLabelCount 		EncodedU32 			Number of frame labels
//FrameNum1 			EncodedU32 			Frame number of frame label #1 (zero-based, global to symbol)
//FrameLabel1 			STRING 				Frame label string of frame label #1
//... ... ...
//FrameNumN 			EncodedU32 			Frame number of frame label #N (zero-based, global to symbol)
//FrameLabelN 			STRING 				Frame label string of frame label #N

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class DefineSceneAndFrameLabelData{
		
		public var OffsetV:Vector.<int>;//EncodedU32
		public var NameV:Vector.<String>;//STRING
		public var FrameNumV:Vector.<int>;//EncodedU32
		public var FrameLabelV:Vector.<String>;//STRING
		
		public function DefineSceneAndFrameLabelData(){
			//OffsetV=null;
			//NameV=null;
			//FrameNumV=null;
			//FrameLabelV=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var SceneCount:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{SceneCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{SceneCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{SceneCount=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{SceneCount=data[offset++];}
			//SceneCount
			
			OffsetV=new Vector.<int>();
			NameV=new Vector.<String>();
			for(var i:int=0;i<SceneCount;i++){
				
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){OffsetV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{OffsetV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{OffsetV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{OffsetV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{OffsetV[i]=data[offset++];}
				//OffsetV[i]
				
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=ignoreBOMReadUTFBytes(data,get_str_size);
				offset+=get_str_size;
				
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var FrameLabelCount:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{FrameLabelCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{FrameLabelCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{FrameLabelCount=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{FrameLabelCount=data[offset++];}
			//FrameLabelCount
			
			FrameNumV=new Vector.<int>();
			FrameLabelV=new Vector.<String>();
			for(i=0;i<FrameLabelCount;i++){
				
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){FrameNumV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{FrameNumV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{FrameNumV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{FrameNumV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{FrameNumV[i]=data[offset++];}
				//FrameNumV[i]
				
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				FrameLabelV[i]=ignoreBOMReadUTFBytes(data,get_str_size);
				offset+=get_str_size;
				
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			var SceneCount:int=OffsetV.length;
			if(SceneCount>>>7){if(SceneCount>>>14){if(SceneCount>>>21){if(SceneCount>>>28){data[data.length]=(SceneCount&0x7f)|0x80;data[data.length]=((SceneCount>>>7)&0x7f)|0x80;data[data.length]=((SceneCount>>>14)&0x7f)|0x80;data[data.length]=((SceneCount>>>21)&0x7f)|0x80;data[data.length]=SceneCount>>>28;}else{data[data.length]=(SceneCount&0x7f)|0x80;data[data.length]=((SceneCount>>>7)&0x7f)|0x80;data[data.length]=((SceneCount>>>14)&0x7f)|0x80;data[data.length]=SceneCount>>>21;}}else{data[data.length]=(SceneCount&0x7f)|0x80;data[data.length]=((SceneCount>>>7)&0x7f)|0x80;data[data.length]=SceneCount>>>14;}}else{data[data.length]=(SceneCount&0x7f)|0x80;data[data.length]=SceneCount>>>7;}}else{data[data.length]=SceneCount;}
			//SceneCount
			
			var i:int=-1;
			for each(var Offset:int in OffsetV){
				i++;
				
				if(Offset>>>7){if(Offset>>>14){if(Offset>>>21){if(Offset>>>28){data[data.length]=(Offset&0x7f)|0x80;data[data.length]=((Offset>>>7)&0x7f)|0x80;data[data.length]=((Offset>>>14)&0x7f)|0x80;data[data.length]=((Offset>>>21)&0x7f)|0x80;data[data.length]=Offset>>>28;}else{data[data.length]=(Offset&0x7f)|0x80;data[data.length]=((Offset>>>7)&0x7f)|0x80;data[data.length]=((Offset>>>14)&0x7f)|0x80;data[data.length]=Offset>>>21;}}else{data[data.length]=(Offset&0x7f)|0x80;data[data.length]=((Offset>>>7)&0x7f)|0x80;data[data.length]=Offset>>>14;}}else{data[data.length]=(Offset&0x7f)|0x80;data[data.length]=Offset>>>7;}}else{data[data.length]=Offset;}
				//Offset
				
				data.position=data.length;
				data.writeUTFBytes(NameV[i]+"\x00");
//				//20110912
//				if(NameV[i]){
//					for each(var c:String in NameV[i].split("")){
//						if(c.charCodeAt(0)>0xff){
//							data.writeUTFBytes(c);
//						}else{
//							data.writeByte(c.charCodeAt(0));
//						}
//					}
//				}
//				data.writeByte(0x00);
				
			}
			
			var FrameLabelCount:int=FrameNumV.length;
			if(FrameLabelCount>>>7){if(FrameLabelCount>>>14){if(FrameLabelCount>>>21){if(FrameLabelCount>>>28){data[data.length]=(FrameLabelCount&0x7f)|0x80;data[data.length]=((FrameLabelCount>>>7)&0x7f)|0x80;data[data.length]=((FrameLabelCount>>>14)&0x7f)|0x80;data[data.length]=((FrameLabelCount>>>21)&0x7f)|0x80;data[data.length]=FrameLabelCount>>>28;}else{data[data.length]=(FrameLabelCount&0x7f)|0x80;data[data.length]=((FrameLabelCount>>>7)&0x7f)|0x80;data[data.length]=((FrameLabelCount>>>14)&0x7f)|0x80;data[data.length]=FrameLabelCount>>>21;}}else{data[data.length]=(FrameLabelCount&0x7f)|0x80;data[data.length]=((FrameLabelCount>>>7)&0x7f)|0x80;data[data.length]=FrameLabelCount>>>14;}}else{data[data.length]=(FrameLabelCount&0x7f)|0x80;data[data.length]=FrameLabelCount>>>7;}}else{data[data.length]=FrameLabelCount;}
			//FrameLabelCount
			
			i=-1;
			for each(var FrameNum:int in FrameNumV){
				i++;
				
				if(FrameNum>>>7){if(FrameNum>>>14){if(FrameNum>>>21){if(FrameNum>>>28){data[data.length]=(FrameNum&0x7f)|0x80;data[data.length]=((FrameNum>>>7)&0x7f)|0x80;data[data.length]=((FrameNum>>>14)&0x7f)|0x80;data[data.length]=((FrameNum>>>21)&0x7f)|0x80;data[data.length]=FrameNum>>>28;}else{data[data.length]=(FrameNum&0x7f)|0x80;data[data.length]=((FrameNum>>>7)&0x7f)|0x80;data[data.length]=((FrameNum>>>14)&0x7f)|0x80;data[data.length]=FrameNum>>>21;}}else{data[data.length]=(FrameNum&0x7f)|0x80;data[data.length]=((FrameNum>>>7)&0x7f)|0x80;data[data.length]=FrameNum>>>14;}}else{data[data.length]=(FrameNum&0x7f)|0x80;data[data.length]=FrameNum>>>7;}}else{data[data.length]=FrameNum;}
				//FrameNum
				
				data.position=data.length;
				data.writeUTFBytes(FrameLabelV[i]+"\x00");
//				//20111208
//				if(FrameLabelV[i]){
//					for each(c in FrameLabelV[i].split("")){
//						if(c.charCodeAt(0)>0xff){
//							data.writeUTFBytes(c);
//						}else{
//							data.writeByte(c.charCodeAt(0));
//						}
//					}
//				}
//				data.writeByte(0x00);
				
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineSceneAndFrameLabelData"/>;
				
				if(OffsetV.length){
					var i:int=-1;
					var OffsetAndNameListXML:XML=<OffsetAndNameList count={OffsetV.length}/>;
					for each(var Offset:int in OffsetV){
						i++;
						
						OffsetAndNameListXML.appendChild(<Offset value={Offset}/>);
						
						OffsetAndNameListXML.appendChild(<Name value={NameV[i]}/>);
						
					}
					xml.appendChild(OffsetAndNameListXML);
				}
				
				if(FrameNumV.length){
					i=-1;
					var FrameNumAndFrameLabelListXML:XML=<FrameNumAndFrameLabelList count={FrameNumV.length}/>;
					for each(var FrameNum:int in FrameNumV){
						i++;
						
						FrameNumAndFrameLabelListXML.appendChild(<FrameNum value={FrameNum}/>);
						
						FrameNumAndFrameLabelListXML.appendChild(<FrameLabel value={FrameLabelV[i]}/>);
						
					}
					xml.appendChild(FrameNumAndFrameLabelListXML);
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				var i:int=-1;
				var NameXMLList:XMLList=xml.OffsetAndNameList.Name;
				OffsetV=new Vector.<int>();
				NameV=new Vector.<String>();
				for each(var OffsetXML:XML in xml.OffsetAndNameList.Offset){
					i++;
					
					OffsetV[i]=int(OffsetXML.@value.toString());
					
					NameV[i]=NameXMLList[i].@value.toString();
					
				}
				
				i=-1;
				var FrameLabelXMLList:XMLList=xml.FrameNumAndFrameLabelList.FrameLabel;
				FrameNumV=new Vector.<int>();
				FrameLabelV=new Vector.<String>();
				for each(var FrameNumXML:XML in xml.FrameNumAndFrameLabelList.FrameNum){
					i++;
					
					FrameNumV[i]=int(FrameNumXML.@value.toString());
					
					FrameLabelV[i]=FrameLabelXMLList[i].@value.toString();
					
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}