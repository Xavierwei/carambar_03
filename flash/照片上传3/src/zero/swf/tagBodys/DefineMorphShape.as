/***
DefineMorphShape
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 20:46:36（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The DefineMorphShape tag defines the start and end states of a morph sequence. A morph
//object should be displayed with the PlaceObject2 tag, where the ratio field specifies how far
//the morph has progressed.
//
//The minimum file format version is SWF 3.
//
//DefineMorphShape
//Field 				Type 					Comment
//Header 				RECORDHEADER 			Tag type = 46
//CharacterId 			UI16 					ID for this character
//StartBounds 			RECT 					Bounds of the start shape
//EndBounds 			RECT 					Bounds of the end shape
//Offset 				UI32 					Indicates offset to EndEdges
//MorphFillStyles 		MORPHFILLSTYLEARRAY 	Fill style information is stored in the same manner as for a standard shape; however, each fill consists of interleaved information based on a single style type to accommodate morphing.
//MorphLineStyles 		MORPHLINESTYLEARRAY 	Line style information is stored in the same manner as for a standard shape; however, each line consists of interleaved information based on a single style type to accommodate morphing.
//StartEdges 			SHAPE 					Contains the set of edges and the style bits that indicate style changes (for example, MoveTo, FillStyle, and LineStyle). Number of edges must equal the number of edges in EndEdges.
//EndEdges 				SHAPE 					Contains only the set of edges, with no style information. Number of edges must equal the number of edges in StartEdges.
//
//StartBounds This defines the bounding-box of the shape at the start of the morph.
//EndBounds This defines the bounding-box at the end of the morph.
//MorphFillStyles This contains an array of interleaved fill styles for the start and end shapes. The fill style for the start shape is followed by the corresponding fill style for the end shape.
//MorphLineStyles This contains an array of interleaved line styles.
//StartEdges This array specifies the edges for the start shape, and the style change records for both shapes. Because the StyleChangeRecords must be the same for the start and end shapes, they are defined only in the StartEdges array.
//EndEdges This array specifies the edges for the end shape, and contains no style change records. The number of edges specified in StartEdges must equal the number of edges in EndEdges.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.MORPHFILLSTYLE;
	import zero.swf.records.shapes.MORPHLINESTYLE;
	import zero.swf.records.shapes.SHAPE;
	
	public class DefineMorphShape{
		
		public var id:int;//UI16
		public var StartBounds:RECT;
		public var EndBounds:RECT;
		public var MorphFillStyleV:Vector.<MORPHFILLSTYLE>;
		public var MorphLineStyleV:Vector.<MORPHLINESTYLE>;
		public var StartEdges:SHAPE;
		public var EndEdges:SHAPE;
		
		public function DefineMorphShape(){
			//id=0;
			//StartBounds=null;
			//EndBounds=null;
			//MorphFillStyleV=null;
			//MorphLineStyleV=null;
			//StartEdges=null;
			//EndEdges=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			/*if(_initByDataOptions){
			}else{
				_initByDataOptions=new Object();
			}
			_initByDataOptions.ColorUseRGBA=false;//20130712
			_initByDataOptions.LineStyleUseLINESTYLE2=false;//20130712*/
			
			id=data[offset++]|(data[offset++]<<8);
			
			StartBounds=new RECT();
			offset=StartBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			EndBounds=new RECT();
			offset=EndBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			//var Offset:int=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			offset+=4;
			
			var FillStyleCount:int=data[offset++];
			if(FillStyleCount==0xff){
				FillStyleCount=data[offset++]|(data[offset++]<<8);
			}
			MorphFillStyleV=new Vector.<MORPHFILLSTYLE>();
			for(var i:int=0;i<FillStyleCount;i++){
				
				MorphFillStyleV[i]=new MORPHFILLSTYLE();
				offset=MorphFillStyleV[i].initByData(data,offset,endOffset,_initByDataOptions);
				
			}
			
			var LineStyleCount:int=data[offset++];
			if(LineStyleCount==0xff){
				LineStyleCount=data[offset++]|(data[offset++]<<8);
			}
			MorphLineStyleV=new Vector.<MORPHLINESTYLE>();
			for(i=0;i<LineStyleCount;i++){
				
				MorphLineStyleV[i]=new MORPHLINESTYLE();
				offset=MorphLineStyleV[i].initByData(data,offset,endOffset,_initByDataOptions);
				
			}
			
			StartEdges=new SHAPE();
			offset=StartEdges.initByData(data,offset,endOffset,_initByDataOptions);
			
			EndEdges=new SHAPE();
			return EndEdges.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data.position=2;
			data.writeBytes(StartBounds.toData(_toDataOptions));
			
			data.writeBytes(EndBounds.toData(_toDataOptions));
			
			var Offset_offset:int=data.length;
			data[Offset_offset]=0x00;
			data[Offset_offset+1]=0x00;
			data[Offset_offset+2]=0x00;
			data[Offset_offset+3]=0x00;
			
			var FillStyleCount:int=MorphFillStyleV.length;
			if(FillStyleCount<0xff){
				data[data.length]=FillStyleCount;
			}else{
				data[data.length]=0xff;
				data[data.length]=FillStyleCount;
				data[data.length]=FillStyleCount>>8;
			}
			data.position=data.length;
			for each(var MorphFillStyle:MORPHFILLSTYLE in MorphFillStyleV){
				
				data.writeBytes(MorphFillStyle.toData(_toDataOptions));
				
			}
			
			var LineStyleCount:int=MorphLineStyleV.length;
			if(LineStyleCount<0xff){
				data[data.length]=LineStyleCount;
			}else{
				data[data.length]=0xff;
				data[data.length]=LineStyleCount;
				data[data.length]=LineStyleCount>>8;
			}
			data.position=data.length;
			for each(var MorphLineStyle:MORPHLINESTYLE in MorphLineStyleV){
				
				data.writeBytes(MorphLineStyle.toData(_toDataOptions));
				
			}
			
			data.position=data.length;
			data.writeBytes(StartEdges.toData(_toDataOptions));
			
			var Offset:int=data.length-Offset_offset-4;
			data[Offset_offset]=Offset;
			data[Offset_offset+1]=Offset>>8;
			data[Offset_offset+2]=Offset>>16;
			data[Offset_offset+3]=Offset>>24;
			
			data.writeBytes(EndEdges.toData(_toDataOptions));
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineMorphShape"
					id={id}
				/>;
				
				xml.appendChild(StartBounds.toXML("StartBounds",_toXMLOptions));
				
				xml.appendChild(EndBounds.toXML("EndBounds",_toXMLOptions));
				
				if(MorphFillStyleV.length){
					var MorphFillStyleListXML:XML=<MorphFillStyleList count={MorphFillStyleV.length}/>;
					for each(var MorphFillStyle:MORPHFILLSTYLE in MorphFillStyleV){
						
						MorphFillStyleListXML.appendChild(MorphFillStyle.toXML("MorphFillStyle",_toXMLOptions));
						
					}
					xml.appendChild(MorphFillStyleListXML);
				}
				
				if(MorphLineStyleV.length){
					var MorphLineStyleListXML:XML=<MorphLineStyleList count={MorphLineStyleV.length}/>;
					for each(var MorphLineStyle:MORPHLINESTYLE in MorphLineStyleV){
						
						MorphLineStyleListXML.appendChild(MorphLineStyle.toXML("MorphLineStyle",_toXMLOptions));
						
					}
					xml.appendChild(MorphLineStyleListXML);
				}
				
				xml.appendChild(StartEdges.toXML("StartEdges",_toXMLOptions));
				
				xml.appendChild(EndEdges.toXML("EndEdges",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				StartBounds=new RECT();
				StartBounds.initByXML(xml.StartBounds[0],_initByXMLOptions);
				
				EndBounds=new RECT();
				EndBounds.initByXML(xml.EndBounds[0],_initByXMLOptions);
				
				var i:int=-1;
				MorphFillStyleV=new Vector.<MORPHFILLSTYLE>();
				for each(var MorphFillStyleXML:XML in xml.MorphFillStyleList.MorphFillStyle){
					i++;
					
					MorphFillStyleV[i]=new MORPHFILLSTYLE();
					MorphFillStyleV[i].initByXML(MorphFillStyleXML,_initByXMLOptions);
					
				}
				
				i=-1;
				MorphLineStyleV=new Vector.<MORPHLINESTYLE>();
				for each(var MorphLineStyleXML:XML in xml.MorphLineStyleList.MorphLineStyle){
					i++;
					
					MorphLineStyleV[i]=new MORPHLINESTYLE();
					MorphLineStyleV[i].initByXML(MorphLineStyleXML,_initByXMLOptions);
					
				}
				
				StartEdges=new SHAPE();
				StartEdges.initByXML(xml.StartEdges[0],_initByXMLOptions);
				
				EndEdges=new SHAPE();
				EndEdges.initByXML(xml.EndEdges[0],_initByXMLOptions);
				
			}
		//}//end of CONFIG::USE_XML
	}
}