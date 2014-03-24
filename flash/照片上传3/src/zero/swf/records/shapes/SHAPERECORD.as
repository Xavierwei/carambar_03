/***
SHAPERECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 14:09:00
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//StraightEdgeRecord
//The StraightEdgeRecord stores the edge as an X-Y delta. The delta is added to the current
//drawing position, and this becomes the new drawing position. The edge is rendered between
//the old and new drawing positions.
//Straight edge records support three types of lines:
//1. General lines.
//2. Horizontal lines.
//3. Vertical lines.
//General lines store both X and Y deltas, the horizontal and vertical lines store only the X delta
//and Y delta respectively.
//STRAIGHTEDGERECORD
//Field 				Type 															Comment
//TypeFlag 				UB[1] 															This is an edge record. Always 1.
//StraightFlag 			UB[1] 															Straight edge. Always 1.
//NumBits 				UB[4] 															Number of bits per value(2 less than the actual number).
//GeneralLineFlag 		UB[1] 															General Line equals 1.
//																						Vert/Horz Line equals 0.
//VertLineFlag 			If GeneralLineFlag = 0, SB[1]									Vertical Line equals 1.
//																						Horizontal Line equals 0.
//DeltaX 				If GeneralLineFlag = 1 or if VertLineFlag = 0, SB[NumBits+2]	X delta.
//DeltaY 				If GeneralLineFlag = 1 or if VertLineFlag = 1, SB[NumBits+2]	Y delta.

//CurvedEdgeRecord
//The SWF file format differs from most vector file formats by using Quadratic Bezier curves
//rather than Cubic Bezier curves. PostScript™ uses Cubic Bezier curves, as do most drawing
//applications.The SWF file format uses Quadratic Bezier curves because they can be stored
//more compactly, and can be rendered more efficiently.
//The following diagram shows a Quadratic Bezier curve and a Cubic Bezier curve.
//A Quadratic Bezier curve has 3 points: 2 on-curve anchor points, and 1 off-curve control
//point. A Cubic Bezier curve has 4 points: 2 on-curve anchor points, and 2 off-curve control
//points.
//The curved-edge record stores the edge as two X-Y deltas. The three points that define the
//Quadratic Bezier are calculated like this:
//1. The first anchor point is the current drawing position.
//2. The control point is the current drawing position + ControlDelta.
//3. The last anchor point is the current drawing position + ControlDelta + AnchorDelta.
//The last anchor point becomes the current drawing position.
//CURVEDEDGERECORD
//Field 			Type 			Comment
//TypeFlag 			UB[1] 			This is an edge record. Always 1.
//StraightFlag 		UB[1] 			Curved edge. Always 0.
//NumBits 			UB[4] 			Number of bits per value(2 less than the actual number).
//ControlDeltaX 	SB[NumBits+2] 	X control point change.
//ControlDeltaY 	SB[NumBits+2] 	Y control point change.
//AnchorDeltaX 		SB[NumBits+2] 	X anchor point change.
//AnchorDeltaY 		SB[NumBits+2] 	Y anchor point change.

//StyleChangeRecord
//The style change record is also a non-edge record. It can be used to do the following:
//1. Select a fill or line style for drawing.
//2. Move the current drawing position (without drawing).
//3. Replace the current fill and line style arrays with a new set of styles.
//Because fill and line styles often change at the start of a new path, it is useful to perform more
//than one action in a single record. For example, say a DefineShape tag defines a red circle and
//a blue square. After the circle is closed, it is necessary to move the drawing position, and
//replace the red fill with the blue fill. The style change record can achieve this with a single
//shape record.
//STYLECHANGERECORD
//Field 				Type 								Comment
//TypeFlag 				UB[1] 								Non-edge record flag. Always 0.
//StateNewStyles 		UB[1] 								New styles flag. Used by DefineShape2 and DefineShape3 only.
//StateLineStyle 		UB[1] 								Line style change flag.
//StateFillStyle1 		UB[1] 								Fill style 1 change flag.
//StateFillStyle0 		UB[1] 								Fill style 0 change flag.
//StateMoveTo 			UB[1] 								Move to flag.
//MoveBits 				If StateMoveTo, UB[5] 				Move bit count.
//MoveDeltaX 			If StateMoveTo, SB[MoveBits] 		Delta X value.
//MoveDeltaY 			If StateMoveTo, SB[MoveBits] 		Delta Y value.
//FillStyle0 			If StateFillStyle0, UB[FillBits] 	Fill 0 Style.
//FillStyle1 			If StateFillStyle1, UB[FillBits] 	Fill 1 Style.
//LineStyle 			If StateLineStyle, UB[LineBits] 	Line Style.
//FillStyles 			If StateNewStyles, FILLSTYLEARRAY	Array of new fill styles.
//LineStyles 			If StateNewStyles, LINESTYLEARRAY	Array of new line styles.
//NumFillBits 			If StateNewStyles, UB[4] 			Number of fill index bits for new styles.
//NumLineBits 			If StateNewStyles, UB[4] 			Number of line index bits for new styles.
//In the first shape record MoveDeltaX and MoveDeltaY are relative to the shape origin.
//In subsequent shape records, MoveDeltaX and MoveDeltaY are relative to the current
//drawing position.
//The style arrays begin at index 1, not index 0. FillStyle = 1 refers to the first style in the fill
//style array, FillStyle = 2 refers to the second style in the fill style array, and so on. A fill style
//index of zero means the path is not filled, and a line style index of zero means the path has no
//stroke. Initially the fill and line style indices are set to zero—no fill or stroke.


package zero.swf.records.shapes{
	import flash.utils.ByteArray;
	public class SHAPERECORD{
		
		public var type:String;
		
		public var DeltaX:int;
		public var DeltaY:int;
		
		public var ControlDeltaX:int;
		public var ControlDeltaY:int;
		public var AnchorDeltaX:int;
		public var AnchorDeltaY:int;
		
		public var MoveDeltaXY:Array;
		//public var MoveDeltaX:int;
		//public var MoveDeltaY:int;
		public var FillStyle0:int;//从 1 开始（0 表示没有填充）
		public var FillStyle1:int;//从 1 开始（0 表示没有填充）
		public var LineStyle:int;//从 1 开始（0 表示没有笔触）
		public var FillStyleV:Vector.<FILLSTYLE>;
		public var LineStyleV:Vector.<LINESTYLE>;
		public var LineStyle2V:Vector.<LINESTYLE2>;
		
		public function SHAPERECORD(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			throw new Error("直接在 SHAPEWITHSTYLE 里 initByData");
		}
		public function toData(_toDataOptions:Object):ByteArray{
			throw new Error("直接在 SHAPEWITHSTYLE 里 toData");
		}
		
		////
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.shapes.SHAPERECORD"
					type={type}
				/>;
				switch(type){
					case ShapeRecordTypes.STRAIGHTEDGERECORD:
						xml.@DeltaX=DeltaX;
						xml.@DeltaY=DeltaY;
					break;
					case ShapeRecordTypes.CURVEDEDGERECORD:
						xml.@ControlDeltaX=ControlDeltaX;
						xml.@ControlDeltaY=ControlDeltaY;
						xml.@AnchorDeltaX=AnchorDeltaX;
						xml.@AnchorDeltaY=AnchorDeltaY;
					break;
					case ShapeRecordTypes.STYLECHANGERECORD:
						if(MoveDeltaXY){
							xml.@MoveDeltaX=MoveDeltaXY[0];
							xml.@MoveDeltaY=MoveDeltaXY[1];
						}
						//if(MoveDeltaX||MoveDeltaY){
						//	xml.@MoveDeltaX=MoveDeltaX;
						//	xml.@MoveDeltaY=MoveDeltaY;
						//}
						if(FillStyle0>-1){
							xml.@FillStyle0=FillStyle0;
						}
						if(FillStyle1>-1){
							xml.@FillStyle1=FillStyle1;
						}
						if(LineStyle>-1){
							xml.@LineStyle=LineStyle;
						}
						if(FillStyleV&&FillStyleV.length){
							var FillStyleListXML:XML=<FillStyleList count={FillStyleV.length}/>
							for each(var FillStyle:FILLSTYLE in FillStyleV){
								FillStyleListXML.appendChild(FillStyle.toXML("FillStyle",_toXMLOptions));
							}
							xml.appendChild(FillStyleListXML);
						}
						if(LineStyle2V&&LineStyle2V.length){
							var LineStyle2ListXML:XML=<LineStyle2List count={LineStyle2V.length}/>
							for each(var LineStyle2:LINESTYLE2 in LineStyle2V){
								LineStyle2ListXML.appendChild(LineStyle2.toXML("LineStyle2",_toXMLOptions));
							}
							xml.appendChild(LineStyle2ListXML);
						}
						if(LineStyleV&&LineStyleV.length){
							var LineStyleListXML:XML=<LineStyleList count={LineStyleV.length}/>
							for each(var LineStyle:LINESTYLE in LineStyleV){
								LineStyleListXML.appendChild(LineStyle.toXML("LineStyle",_toXMLOptions));
							}
							xml.appendChild(LineStyleListXML);
						}
					break;
					case ShapeRecordTypes.ENDSHAPERECORD:
					break;
				}
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				type=xml.@type.toString();
				switch(type){
					case ShapeRecordTypes.STRAIGHTEDGERECORD:
						DeltaX=int(xml.@DeltaX.toString());
						DeltaY=int(xml.@DeltaY.toString());
					break;
					case ShapeRecordTypes.CURVEDEDGERECORD:
						ControlDeltaX=int(xml.@ControlDeltaX.toString());
						ControlDeltaY=int(xml.@ControlDeltaY.toString());
						AnchorDeltaX=int(xml.@AnchorDeltaX.toString());
						AnchorDeltaY=int(xml.@AnchorDeltaY.toString());
					break;
					case ShapeRecordTypes.STYLECHANGERECORD:
						var MoveDeltaXXML:XML=xml.@MoveDeltaX[0];
						var MoveDeltaYXML:XML=xml.@MoveDeltaY[0];
						if(MoveDeltaXXML&&MoveDeltaYXML){
							MoveDeltaXY=[int(MoveDeltaXXML.toString()),int(MoveDeltaYXML.toString())];
						}else{
							MoveDeltaXY=null;
						}
						//MoveDeltaX=int(xml.@MoveDeltaX.toString());
						//MoveDeltaY=int(xml.@MoveDeltaY.toString());
						var FillStyle0XML:XML=xml.@FillStyle0[0];
						if(FillStyle0XML){
							FillStyle0=int(xml.@FillStyle0.toString());
						}else{
							FillStyle0=-1;
						}
						var FillStyle1XML:XML=xml.@FillStyle1[0];
						if(FillStyle1XML){
							FillStyle1=int(xml.@FillStyle1.toString());
						}else{
							FillStyle1=-1;
						}
						var LineStyleXML:XML=xml.@LineStyle[0];
						if(LineStyleXML){
							LineStyle=int(xml.@LineStyle.toString());
						}else{
							LineStyle=-1;
						}
						
						var i:int=-1;
						FillStyleV=new Vector.<FILLSTYLE>();
						for each(var FillStyleXML:XML in xml.FillStyleList.FillStyle){
							i++;
							FillStyleV[i]=new FILLSTYLE();
							FillStyleV[i].initByXML(FillStyleXML,_initByXMLOptions);
						}
						if(FillStyleV.length){
						}else{
							FillStyleV=null;
						}
						i=-1;
						LineStyle2V=new Vector.<LINESTYLE2>();
						for each(var LineStyle2XML:XML in xml.LineStyle2List.LineStyle2){
							i++;
							LineStyle2V[i]=new LINESTYLE2();
							LineStyle2V[i].initByXML(LineStyle2XML,_initByXMLOptions);
						}
						if(LineStyle2V.length){
						}else{
							LineStyle2V=null;
							LineStyleV=new Vector.<LINESTYLE>();
							for each(LineStyleXML in xml.LineStyleList.LineStyle){
								i++;
								LineStyleV[i]=new LINESTYLE();
								LineStyleV[i].initByXML(LineStyleXML,_initByXMLOptions);
							}
							if(LineStyleV.length){
							}else{
								LineStyleV=null;
							}
						}
					break;
					case ShapeRecordTypes.ENDSHAPERECORD:
						//
					break;
				}
			}
		//}//end of CONFIG::USE_XML
	}
}