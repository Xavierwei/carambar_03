/***
DefineSprite
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月7日 16:23:31
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineSprite
//The DefineSprite tag defines a sprite character. It consists of a character ID and a frame count,
//followed by a series of control tags. The sprite is terminated with an End tag.
//The length specified in the Header reflects the length of the entire DefineSprite tag, including
//the ControlTags field.
//Definition tags (such as DefineShape) are not allowed in the DefineSprite tag. All of the
//characters that control tags refer to in the sprite must be defined in the main body of the file
//before the sprite is defined.
//The minimum file format version is SWF 3.

//DefineSprite
//Field 			Type 				Comment
//Header 			RECORDHEADER 		Tag type = 39
//Sprite ID 		UI16 				Character ID of sprite
//FrameCount 		UI16 				Number of frames in sprite
//ControlTags 		TAG[one or more] 	A series of tags

//The following tags are valid within a DefineSprite tag:
//DefineSprite
//Field Type Comment
//Header RECORDHEADER Tag type = 39
//Sprite ID UI16 Character ID of sprite
//FrameCount UI16 Number of frames in sprite
//ControlTags TAG[one or more] A series of tags
//• ShowFrame 					• StartSound
//• PlaceObject 				• FrameLabel
//• PlaceObject2 				• SoundStreamHead
//• RemoveObject 				• SoundStreamHead2
//• RemoveObject2 				• SoundStreamBlock
//• All Actions (see Actions) 	• End
package zero.swf.tagBodys{
	
	import zero.output;
	
	import zero.swf.Tag;
	import zero.swf.Tags;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	public class DefineSprite{
		
		public var id:int;//UI16
		public var FrameCount:int;//帧数是一个int, 在SWF里以 UI16(Unsigned 16-bit integer value, 16位无符号整数) 的结构保存
		public var tagV:Vector.<Tag>;
		
		public function DefineSprite(){
			//id=0;
			//FrameCount=0;
			//tagV=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			//~~~~~
			id=data[offset++]|(data[offset++]<<8);
			FrameCount=data[offset++]|(data[offset++]<<8);//仅用于参考
			
			//tagV
			tagV=new Vector.<Tag>();
			if(offset<endOffset){//20120131
				Tags.getTagsByData(tagV,data,offset,endOffset,_initByDataOptions?_initByDataOptions.unknownTagV:null);
				
				//#####
				FrameCount=Tags.getRealFrameCount(tagV,FrameCount);
				
				//try{
					//@@@@@
					var tagId:int=0;
					while(tagId<tagV.length){
						tagId=Tags.initByData_step(
							tagV,
							tagId,
							tagV.length,
							10000,
							_initByDataOptions
						);
					}
				//}catch(e:Error){
				//	output("可能是垃圾tag e="+e,"brown");
				//	FrameCount=0;
				//	tagV=new Vector.<Tag>();
				//}
			}
			
			//$$$$$
			return endOffset;
		}
		
		public function toData(_toDataOptions:Object):ByteArray{
			//#####
			FrameCount=Tags.getRealFrameCount(tagV);
			
			//临时变量
			var tagsData:ByteArray=new ByteArray();
			
			//@@@@@
			var tagId:int=0;
			while(tagId<tagV.length){
				tagId=Tags.toData_step(
					tagV,
					tagsData,
					tagId,
					tagV.length,
					10000,
					_toDataOptions
				);
			}
			
			//~~~~~
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data[2]=FrameCount;
			data[3]=FrameCount>>8;
			
			//$$$$$
			data.position=4;
			data.writeBytes(tagsData);
			return data;
		}
		////
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				//临时变量
				var tagsXML:XML=<tags count={tagV.length}/>;
				
				//try{
					//@@@@@
					var tagId:int=0;
					while(tagId<tagV.length){
						tagId=Tags.toXML_step(
							tagV,
							tagsXML,
							tagId,
							tagV.length,
							10000,
							_toXMLOptions
						);
					}
				//}catch(e:Error){
				//	output("可能是垃圾tag e="+e,"brown");
				//	FrameCount=0;
				//	tagV=new Vector.<Tag>();
				//}
				
				//#####
				FrameCount=Tags.getRealFrameCount(tagV);
				
				//~~~~~
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineSprite"
					id={id}
					FrameCount={FrameCount}
				/>;
				
				//$$$$$
				xml.appendChild(tagsXML);
				
				if(_toXMLOptions&&_toXMLOptions.addToXMLInfos){//20130327
					_toXMLOptions.addToXMLInfos(this,xml);
				}
				
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				//~~~~~
				id=int(xml.@id.toString());
				FrameCount=int(xml.@FrameCount.toString());//仅用于参考
				
				//tagV
				tagV=new Vector.<Tag>();
				
				//临时变量
				var nodeXMLList:XMLList=xml.tags[0].children();
				
				//@@@@@
				var nodeId:int=0;
				var nodeCount:int=nodeXMLList.length();
				while(nodeId<nodeCount){
					nodeId=Tags.initByXML_step(
						tagV,
						nodeXMLList,
						nodeId,
						nodeCount,
						10000,
						_initByXMLOptions
					);
				}
				
				//#####
				FrameCount=Tags.getRealFrameCount(tagV);
				
				//$$$$$
			}
		//}//end of CONFIG::USE_XML
	}
}
