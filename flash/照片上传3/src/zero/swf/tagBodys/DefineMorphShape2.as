/***
DefineMorphShape2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月29日 15:53:56（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineMorphShape2
//The DefineMorphShape2 tag extends the capabilities of DefineMorphShape by using a new
//morph line style record in the morph shape. MORPHLINESTYLE2 allows the use of new
//types of joins and caps as well as scaling options and the ability to fill the strokes of the morph
//shape.
//DefineMorphShape2 specifies not only the shape bounds but also the edge bounds of the
//shape. While the shape bounds are calculated along the outside of the strokes, the edge
//bounds are taken from the outside of the edges. For an example of shape bounds versus edge
//bounds, see the diagram in DefineShape4. The new StartEdgeBounds and EndEdgeBounds
//fields assist Flash Player in accurately determining certain layouts.
//In addition, DefineMorphShape2 includes new hinting information, UsesNonScalingStrokes
//and UsesScalingStrokes. These flags assist Flash Player in creating the best possible area for
//invalidation.
//
//The minimum file format version is SWF 8.
//
//DefineMorphShape2
//Field 					Type 					Comment
//Header 					RECORDHEADER 			Tag type = 84
//CharacterId 				UI16 					ID for this character
//StartBounds 				RECT 					Bounds of the start shape
//EndBounds 				RECT 					Bounds of the end shape
//StartEdgeBounds 			RECT 					Bounds of the start shape, excluding strokes
//EndEdgeBounds 			RECT 					Bounds of the end shape, excluding strokes
//Reserved 					UB[6] 					Must be 0
//UsesNonScalingStrokes 	UB[1] 					If 1, the shape contains at least one non-scaling stroke.
//UsesScalingStrokes 		UB[1] 					If 1, the shape contains at least one scaling stroke.
//Offset 					UI32 					Indicates offset to EndEdges
//MorphFillStyles 			MORPHFILLSTYLEARRAY 	Fill style information is stored in the same manner as for a standard shape; however, each fill consists of interleaved information based on a single style type to accommodate morphing.
//MorphLineStyles 			MORPHLINESTYLEARRAY 	Line style information is stored in the same manner as for a standard shape; however, each line consists of interleaved information based on a single style type to accommodate morphing.
//StartEdges 				SHAPE 					Contains the set of edges and the style bits that indicate style changes (for example, MoveTo, FillStyle, and LineStyle). Number of edges must equal the number of edges in EndEdges.
//EndEdges 					SHAPE 					Contains only the set of edges, with no style information. Number of edges must equal the number of edges in StartEdges.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.MORPHFILLSTYLE;
	import zero.swf.records.shapes.MORPHLINESTYLE2;
	import zero.swf.records.shapes.SHAPE;
	
	public class DefineMorphShape2{
		
		public var id:int;//UI16
		public var StartBounds:RECT;
		public var EndBounds:RECT;
		public var StartEdgeBounds:RECT;
		public var EndEdgeBounds:RECT;
		private var Reserved:int;//11111100
		public var UsesNonScalingStrokes:Boolean;//00000010
		public var UsesScalingStrokes:Boolean;//00000001
		public var MorphFillStyleV:Vector.<MORPHFILLSTYLE>;
		public var MorphLineStyle2V:Vector.<MORPHLINESTYLE2>;
		public var StartEdges:SHAPE;
		public var EndEdges:SHAPE;
		
		public function DefineMorphShape2(){
			//id=0;
			//StartBounds=null;
			//EndBounds=null;
			//StartEdgeBounds=null;
			//EndEdgeBounds=null;
			//Reserved=0;
			//UsesNonScalingStrokes=false;
			//UsesScalingStrokes=false;
			//MorphFillStyleV=null;
			//MorphLineStyle2V=null;
			//StartEdges=null;
			//EndEdges=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			/*if(_initByDataOptions){
			}else{
				_initByDataOptions=new Object();
			}
			_initByDataOptions.ColorUseRGBA=true;//20130712
			_initByDataOptions.LineStyleUseLINESTYLE2=true;//20130712*/
			
			id=data[offset++]|(data[offset++]<<8);
			
			StartBounds=new RECT();
			offset=StartBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			EndBounds=new RECT();
			offset=EndBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			StartEdgeBounds=new RECT();
			offset=StartEdgeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			EndEdgeBounds=new RECT();
			offset=EndEdgeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			var flags:int=data[offset++];
			Reserved=flags&0xfc;//11111100
			UsesNonScalingStrokes=((flags&0x02)?true:false);//00000010
			UsesScalingStrokes=((flags&0x01)?true:false);//00000001
			
			//var Offset:int=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			//trace(Offset.toString(16));
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
			MorphLineStyle2V=new Vector.<MORPHLINESTYLE2>();
			for(i=0;i<LineStyleCount;i++){
				
				MorphLineStyle2V[i]=new MORPHLINESTYLE2();
				offset=MorphLineStyle2V[i].initByData(data,offset,endOffset,_initByDataOptions);
				
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
			
			data.writeBytes(StartEdgeBounds.toData(_toDataOptions));
			
			data.writeBytes(EndEdgeBounds.toData(_toDataOptions));
			
			var flags:int=0;
			flags|=Reserved;//11111100
			if(UsesNonScalingStrokes){
				flags|=0x02;//00000010
			}
			if(UsesScalingStrokes){
				flags|=0x01;//00000001
			}
			data[data.length]=flags;
			
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
			
			var LineStyleCount:int=MorphLineStyle2V.length;
			if(LineStyleCount<0xff){
				data[data.length]=LineStyleCount;
			}else{
				data[data.length]=0xff;
				data[data.length]=LineStyleCount;
				data[data.length]=LineStyleCount>>8;
			}
			data.position=data.length;
			for each(var MorphLineStyle2:MORPHLINESTYLE2 in MorphLineStyle2V){
				
				data.writeBytes(MorphLineStyle2.toData(_toDataOptions));
				
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
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineMorphShape2"
					id={id}
					Reserved={Reserved}
					UsesNonScalingStrokes={UsesNonScalingStrokes}
					UsesScalingStrokes={UsesScalingStrokes}
				/>;
				
				xml.appendChild(StartBounds.toXML("StartBounds",_toXMLOptions));
				
				xml.appendChild(EndBounds.toXML("EndBounds",_toXMLOptions));
				
				xml.appendChild(StartEdgeBounds.toXML("StartEdgeBounds",_toXMLOptions));
				
				xml.appendChild(EndEdgeBounds.toXML("EndEdgeBounds",_toXMLOptions));
				
				if(MorphFillStyleV.length){
					var MorphFillStyleListXML:XML=<MorphFillStyleList count={MorphFillStyleV.length}/>;
					for each(var MorphFillStyle:MORPHFILLSTYLE in MorphFillStyleV){
						
						MorphFillStyleListXML.appendChild(MorphFillStyle.toXML("MorphFillStyle",_toXMLOptions));
						
					}
					xml.appendChild(MorphFillStyleListXML);
				}
				
				if(MorphLineStyle2V.length){
					var MorphLineStyle2ListXML:XML=<MorphLineStyle2List count={MorphLineStyle2V.length}/>;
					for each(var MorphLineStyle2:MORPHLINESTYLE2 in MorphLineStyle2V){
						
						MorphLineStyle2ListXML.appendChild(MorphLineStyle2.toXML("MorphLineStyle2",_toXMLOptions));
						
					}
					xml.appendChild(MorphLineStyle2ListXML);
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
				
				StartEdgeBounds=new RECT();
				StartEdgeBounds.initByXML(xml.StartEdgeBounds[0],_initByXMLOptions);
				
				EndEdgeBounds=new RECT();
				EndEdgeBounds.initByXML(xml.EndEdgeBounds[0],_initByXMLOptions);
				
				Reserved=int(xml.@Reserved.toString());
				UsesNonScalingStrokes=(xml.@UsesNonScalingStrokes.toString()=="true");
				UsesScalingStrokes=(xml.@UsesScalingStrokes.toString()=="true");
				
				var i:int=-1;
				MorphFillStyleV=new Vector.<MORPHFILLSTYLE>();
				for each(var MorphFillStyleXML:XML in xml.MorphFillStyleList.MorphFillStyle){
					i++;
					
					MorphFillStyleV[i]=new MORPHFILLSTYLE();
					MorphFillStyleV[i].initByXML(MorphFillStyleXML,_initByXMLOptions);
					
				}
				
				i=-1;
				MorphLineStyle2V=new Vector.<MORPHLINESTYLE2>();
				for each(var MorphLineStyle2XML:XML in xml.MorphLineStyle2List.MorphLineStyle2){
					i++;
					
					MorphLineStyle2V[i]=new MORPHLINESTYLE2();
					MorphLineStyle2V[i].initByXML(MorphLineStyle2XML,_initByXMLOptions);
					
				}
				
				StartEdges=new SHAPE();
				StartEdges.initByXML(xml.StartEdges[0],_initByXMLOptions);
				
				EndEdges=new SHAPE();
				EndEdges.initByXML(xml.EndEdges[0],_initByXMLOptions);
				
			}
		//}//end of CONFIG::USE_XML
	}
}