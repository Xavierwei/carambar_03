/***
DefineFont
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月24日 14:05:30（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineFont
//The DefineFont tag defines the shape outlines of each glyph used in a particular font. 
//DefineFont tag 定义了一个特定的字体中每个字形的形状轮廓
//Only the glyphs that are used by subsequent DefineText tags are actually defined.
//只有那些被后来的 DefineText tag 中使用的字形才被定义（也就是不会把这个字体的所有字形都存进来）
//DefineFont tags cannot be used for dynamic text. Dynamic text requires the DefineFont2 tag.
//The minimum file format version is SWF 1.
//
//DefineFont
//Field 				Type 				Comment
//Header 				RECORDHEADER 		Tag type = 10
//FontID 				UI16 				ID for this font character
//OffsetTable 			UI16[nGlyphs] 		Array of shape offsets
//GlyphShapeTable 		SHAPE[nGlyphs] 		Array of shapes
//
//The font ID uniquely identifies the font. It can be used by subsequent DefineText tags to
//select the font. Like all SWF character IDs, font IDs must be unique among all character IDs
//in a SWF file.
//If you provide a DefineFontInfo tag to go along with a DefineFont tag, be aware that the
//order of the glyphs in the DefineFont tag must match the order of the character codes in the
//DefineFontInfo tag, which must be sorted by code point order.
//The OffsetTable and GlyphShapeTable are used together. These tables have the same number
//of entries, and there is a one-to-one ordering match between the order of the offsets and the
//order of the shapes. The OffsetTable points to locations in the GlyphShapeTable. Each offset
//entry stores the difference (in bytes) between the start of the offset table and the location of
//the corresponding shape. Because the GlyphShapeTable immediately follows the OffsetTable,
//the number of entries in each table (the number of glyphs in the font) can be inferred by
//dividing the first entry in the OffsetTable by two.
//The first STYLECHANGERECORD of each SHAPE in the GlyphShapeTable does not use
//the LineStyle and LineStyles fields. In addition, the first STYLECHANGERECORD of each
//shape must have both fields StateFillStyle0 and FillStyle0 set to 1.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.shapes.SHAPE;
	
	public class DefineFont{
		
		public var id:int;//UI16
		public var GlyphShapeV:Vector.<SHAPE>;
		
		public function DefineFont(){
			//id=0;
			//GlyphShapeV=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			var GlyphShapeCount:int=(data[offset++]|(data[offset++]<<8))/2;//- -
			offset+=GlyphShapeCount*2-2;
			
			GlyphShapeV=new Vector.<SHAPE>();
			for(var i:int=0;i<GlyphShapeCount;i++){
				
				GlyphShapeV[i]=new SHAPE();
				offset=GlyphShapeV[i].initByData(data,offset,endOffset,_initByDataOptions);
				
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data.position=data.length=2+GlyphShapeV.length*2;
			var j:int=2;
			for each(var GlyphShape:SHAPE in GlyphShapeV){
				
				var Offset:int=data.length-2;
				data[j++]=Offset;
				data[j++]=Offset>>8;
				
				data.writeBytes(GlyphShape.toData(_toDataOptions));
			
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineFont"
					id={id}
				/>;
				
				if(GlyphShapeV.length){
					var GlyphShapeListXML:XML=<GlyphShapeList count={GlyphShapeV.length}/>;
					for each(var GlyphShape:SHAPE in GlyphShapeV){
						
						GlyphShapeListXML.appendChild(GlyphShape.toXML("GlyphShape",_toXMLOptions));
						
					}
					xml.appendChild(GlyphShapeListXML);
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				var i:int=-1;
				GlyphShapeV=new Vector.<SHAPE>();
				for each(var GlyphShapeXML:XML in xml.GlyphShapeList.GlyphShape){
					i++;
					
					GlyphShapeV[i]=new SHAPE();
					GlyphShapeV[i].initByXML(GlyphShapeXML,_initByXMLOptions);
					
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}