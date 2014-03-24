/***
FrameLabel_
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 07:06:33（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//FrameLabel
//The FrameLabel tag gives the specified Name to the current frame. ActionGoToLabel uses
//this name to identify the frame.
//The minimum file format version is SWF 3.

//FrameLabel
//Field 	Type 			Comment
//Header 	RECORDHEADER 	Tag type = 43
//Name 		STRING 			Label for frame

//In SWF files of version 6 or later, an extension to the FrameLabel tag called named anchors is
//available. A named anchor is a special kind of frame label that, in addition to labeling a frame
//for seeking using ActionGoToLabel, labels the frame for seeking using HTML anchor syntax.
//The browser plug-in versions of Adobe Flash Player, in version 6 and later, will inspect the
//URL in the browser's Location bar for an anchor specification (a trailing phrase of the form
//#anchorname). If an anchor specification is present in the Location bar, Flash Player will
//begin playback starting at the frame that contains a FrameLabel tag that specifies a named
//anchor of the same name, if one exists; otherwise playback will begin at Frame 1 as usual. In
//addition, when Flash Player arrives at a frame that contains a named anchor, it will add an
//anchor specification with the given anchor name to the URL in the browser's Location bar.
//This ensures that when users create a bookmark at such a time, they can later return to the
//same point in the SWF file, subject to the granularity at which named anchors are present
//within the file.
//To create a named anchor, insert one additional non-null byte after the null terminator of the
//anchor name. This is valid only for SWF 6 or later.

//NamedAnchor
//Field 			Type 								Comment
//Header 			RECORDHEADER 						Tag type = 43
//Name 				Null-terminated STRING.(0 is NULL)	Label for frame.
//Named Anchor flag UI8 								Always 1

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class FrameLabel_{
		
		public var Name:String;//STRING
		public var NamedAnchorflag:Boolean;//NamedAnchorflag
		
		public function FrameLabel_(){
			//Name=null;
			//NamedAnchorflag=false;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			Name=ignoreBOMReadUTFBytes(data,get_str_size);
			offset+=get_str_size;
			
			if(offset<endOffset){
				NamedAnchorflag=true;
				return offset+1;
			}
			NamedAnchorflag=false;
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data.writeUTFBytes(Name+"\x00");
//			//20111208
//			if(Name){
//				for each(var c:String in Name.split("")){
//					if(c.charCodeAt(0)>0xff){
//						data.writeUTFBytes(c);
//					}else{
//						data.writeByte(c.charCodeAt(0));
//					}
//				}
//			}
//			data.writeByte(0x00);
			
			if(NamedAnchorflag){
				data[data.length]=0x01;
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.tagBodys.FrameLabel_"
					Name={Name}
					NamedAnchorflag={NamedAnchorflag}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				Name=xml.@Name.toString();
				
				NamedAnchorflag=(xml.@NamedAnchorflag.toString()=="true");
				
			}
		//}//end of CONFIG::USE_XML
	}
}