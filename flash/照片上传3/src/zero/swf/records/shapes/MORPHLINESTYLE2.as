/***
MORPHLINESTYLE2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月23日 15:36:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//MORPHLINESTYLE2
//MORPHLINESTYLE2 builds upon the capabilities of the MORPHLINESTYLE record by
//allowing the use of new types of joins and caps as well as scaling options and the ability to fill
//morph strokes. In order to use MORPHLINESTYLE2, the shape must be defined with
//DefineMorphShape2—not DefineMorphShape.
//While the MORPHLINESTYLE record permits only rounded joins and round caps,
//MORPHLINESTYLE2 also supports miter and bevel joins, and square caps and no caps. For
//an illustration of the available joins and caps, see the diagram in the LINESTYLE2
//description.
//When using MORPHLINESTYLE for a miter join, a MiterLimitFactor must be specified
//and is used along with StartWidth or EndWidth to calculate the maximum miter length:
//Max miter length = MORPHLINESTYLE2 MiterLimitFactor * MORPHLINESTYLE2
//Width
//If the miter join exceeds the maximum miter length, Flash Player will cut off the miter. Note
//that MiterLimitFactor is an 8.8 fixed-point value.
//MORPHLINESTYLE2 also includes the option for pixel hinting in order to correct blurry
//vertical or horizontal lines.
//
//MORPHLINESTYLE2
//Field 			Type 								Comment
//StartWidth 		UI16 								Width of line in start shape in twips.
//EndWidth 			UI16 								Width of line in end shape in twips.
//StartCapStyle 	UB[2] 								Start-cap style:
//														0 = Round cap
//														1 = No cap
//														2 = Square cap
//JoinStyle 		UB[2] 								Join style:
//														0 = Round join
//														1 = Bevel join
//														2 = Miter join
//HasFillFlag 		UB[1] 								If 1, fill is defined in FillType.
//														If 0, uses StartColor and EndColor fields.
//NoHScaleFlag 		UB[1] 								If 1, stroke thickness will not scale if the object is scaled horizontally.
//NoVScaleFlag 		UB[1] 								If 1, stroke thickness will not scale if the object is scaled vertically.
//PixelHintingFlag 	UB[1] 								If 1, all anchors will be aligned to full pixels.
//Reserved 			UB[5] 								Must be 0.
//NoClose 			UB[1] 								If 1, stroke will not be closed if the stroke's last point matches its first point. Flash Player will apply caps instead of a join.
//EndCapStyle 		UB[2] 								End-cap style:
//														0 = Round cap
//														1 = No cap
//														2 = Square cap
//MiterLimitFactor 	If JoinStyle = 2, UI16 				Miter limit factor as an 8.8 fixed-point value.
//StartColor 		If HasFillFlag = 0, RGBA 			Color value including alpha channel information for start shape.
//EndColor 			If HasFillFlag = 0, RGBA 			Color value including alpha channel information for end shape.
//FillType 			If HasFillFlag = 1, MORPHFILLSTYLE	Fill style.

package zero.swf.records.shapes{
	
	import flash.utils.ByteArray;
	import zero.BytesAndStr16;
	
	public class MORPHLINESTYLE2{
		
		public var StartWidth:int;//UI16
		public var EndWidth:int;//UI16
		public var StartCapStyle:int;//11000000
		public var JoinStyle:int;//00110000
		public var NoHScaleFlag:Boolean;//00000100
		public var NoVScaleFlag:Boolean;//00000010
		public var PixelHintingFlag:Boolean;//00000001
		//public var Reserved:int;//11111000
		public var NoClose:Boolean;//00000100
		public var EndCapStyle:int;//00000011
		public var MiterLimitFactor:int;//UI16
		public var StartColor:uint;//RGBA
		public var EndColor:uint;//RGBA
		public var FillType:MORPHFILLSTYLE;
		
		public function MORPHLINESTYLE2(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			StartWidth=data[offset++]|(data[offset++]<<8);
			
			EndWidth=data[offset++]|(data[offset++]<<8);
			
			var flags:int=data[offset++];
			StartCapStyle=(flags&0xc0)>>>6;//11000000
			JoinStyle=(flags&0x30)>>>4;//00110000
			var HasFillFlag:Boolean=((flags&0x08)?true:false);//00001000
			NoHScaleFlag=((flags&0x04)?true:false);//00000100
			NoVScaleFlag=((flags&0x02)?true:false);//00000010
			PixelHintingFlag=((flags&0x01)?true:false);//00000001
			
			flags=data[offset++];
			//Reserved=flags&0xf8;//11111000
			NoClose=((flags&0x04)?true:false);//00000100
			EndCapStyle=flags&0x03;//00000011
			
			if(JoinStyle==2){
				MiterLimitFactor=data[offset++]|(data[offset++]<<8);
			}
			
			if(HasFillFlag){
				
				FillType=new MORPHFILLSTYLE();
				offset=FillType.initByData(data,offset,endOffset,_initByDataOptions);
				
			}else{
				
				StartColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				
				EndColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=StartWidth;
			data[1]=StartWidth>>8;
			
			data[2]=EndWidth;
			data[3]=EndWidth>>8;
			
			var flags:int=0;
			flags|=StartCapStyle<<6;//11000000
			flags|=JoinStyle<<4;//00110000
			if(FillType){
				flags|=0x08;//HasFillFlag//00001000
			}
			if(NoHScaleFlag){
				flags|=0x04;//00000100
			}
			if(NoVScaleFlag){
				flags|=0x02;//00000010
			}
			if(PixelHintingFlag){
				flags|=0x01;//00000001
			}
			data[4]=flags;
			
			flags=0;
			//flags|=Reserved;//11111000
			if(NoClose){
				flags|=0x04;//00000100
			}
			flags|=EndCapStyle;//00000011
			data[5]=flags;
			
			if(JoinStyle==2){
				data[6]=MiterLimitFactor;
				data[7]=MiterLimitFactor>>8;
			}
			
			if(FillType){
				
				data.position=data.length;
				data.writeBytes(FillType.toData(_toDataOptions));
				
			}else{
				
				data[data.length]=StartColor>>16;
				data[data.length]=StartColor>>8;
				data[data.length]=StartColor;
				data[data.length]=StartColor>>24;
				
				data[data.length]=EndColor>>16;
				data[data.length]=EndColor>>8;
				data[data.length]=EndColor;
				data[data.length]=EndColor>>24;
				
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.records.shapes.MORPHLINESTYLE2"
					StartWidth={StartWidth}
					EndWidth={EndWidth}
					StartCapStyle={StartCapStyle}
					JoinStyle={JoinStyle}
					NoHScaleFlag={NoHScaleFlag}
					NoVScaleFlag={NoVScaleFlag}
					PixelHintingFlag={PixelHintingFlag}
					NoClose={NoClose}
					EndCapStyle={EndCapStyle}
				/>;
				
				if(JoinStyle==2){
					xml.@MiterLimitFactor=MiterLimitFactor;
				}
				
				if(FillType){
					
					xml.appendChild(FillType.toXML("FillType",_toXMLOptions));
					
				}else{
					
					xml.@StartColor="0x"+BytesAndStr16._16V[(StartColor>>24)&0xff]+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff];
					
					xml.@EndColor="0x"+BytesAndStr16._16V[(EndColor>>24)&0xff]+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff];
					
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				StartWidth=int(xml.@StartWidth.toString());
				
				EndWidth=int(xml.@EndWidth.toString());
				
				StartCapStyle=int(xml.@StartCapStyle.toString());
				JoinStyle=int(xml.@JoinStyle.toString());
				NoHScaleFlag=(xml.@NoHScaleFlag.toString()=="true");
				NoVScaleFlag=(xml.@NoVScaleFlag.toString()=="true");
				PixelHintingFlag=(xml.@PixelHintingFlag.toString()=="true");
				
				NoClose=(xml.@NoClose.toString()=="true");
				EndCapStyle=int(xml.@EndCapStyle.toString());
				
				if(JoinStyle==2){
					MiterLimitFactor=int(xml.@MiterLimitFactor.toString());
				}
				
				var FillTypeXML:XML=xml.FillType[0];
				if(FillTypeXML){
					
					FillType=new MORPHFILLSTYLE();
					FillType.initByXML(FillTypeXML,_initByXMLOptions);
					
				}else{
					
					StartColor=uint(xml.@StartColor.toString());
					
					EndColor=uint(xml.@EndColor.toString());
					
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}