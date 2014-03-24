/***
LINESTYLE2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月3日 12:11:24 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//LINESTYLE2
//LINESTYLE2 builds upon the capabilities of the LINESTYLE record by allowing the use of
//new types of joins and caps as well as scaling options and the ability to fill a stroke. In order to
//use LINESTYLE2, the shape must be defined with DefineShape4—not DefineShape,
//DefineShape2, or DefineShape3.
//While the LINESTYLE record permits only rounded joins and round caps, LINESTYLE2
//also supports miter and bevel joins, and square caps and no caps. The following diagram
//illustrates the complete array of joins and caps:
//When using LINESTYLE2 for a miter join, a MiterLimitFactor must be specified and is used
//to calculate the maximum miter length:
//Maximum miter length = LINESTYLE2 MiterLimitFactor * LINESTYLE2 Width
//If the miter join exceeds the maximum miter length, Flash Player will cut off the miter. Note
//that MiterLimitFactor is an 8.8 fixed-point value.
//LINESTYLE2 also includes the option for pixel hinting to correct blurry vertical or
//horizontal lines.
//LINESTYLE2
//Field 				Type 							Comment
//Width 				UI16 							Width of line in twips.
//StartCapStyle 		UB[2] 							Start cap style:
//														0 = Round cap
//														1 = No cap
//														2 = Square cap
//JoinStyle 			UB[2] 							Join style:
//														0 = Round join
//														1 = Bevel join
//														2 = Miter join
//HasFillFlag 			UB[1] 							If 1, fill is defined in FillType.
//														If 0, uses Color field.
//NoHScaleFlag 			UB[1] 							If 1, stroke thickness will not scale if the object is scaled horizontally.
//NoVScaleFlag 			UB[1] 							If 1, stroke thickness will not scale if the object is scaled vertically.
//PixelHintingFlag 		UB[1] 							If 1, all anchors will be aligned to full pixels.
//Reserved 				UB[5] 							Must be 0.
//NoClose 				UB[1] 							If 1, stroke will not be closed if the stroke's last point matches its first point. Flash Player will apply caps instead of a join.
//EndCapStyle 			UB[2] 							End cap style:
//														0 = Round cap
//														1 = No cap
//														2 = Square cap
//MiterLimitFactor 		If JoinStyle = 2, UI16 			Miter limit factor is an 8.8 fixed-point value.
//Color 				If HasFillFlag = 0, RGBA 		Color value including alpha channel.
//FillType 				If HasFillFlag = 1, FILLSTYLE 	Fill style for this stroke.
package zero.swf.records.shapes{
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	public class LINESTYLE2{
		public var Width:int;							//UI16
		public var StartCapStyle:int;
		public var JoinStyle:int;
		public var NoHScaleFlag:Boolean;
		public var NoVScaleFlag:Boolean;
		public var PixelHintingFlag:Boolean;
		public var NoClose:Boolean;
		public var EndCapStyle:int;
		public var MiterLimitFactor:int;				//UI16
		public var Color:uint;							//RGBA
		public var FillType:FILLSTYLE;
		//
		
		public function LINESTYLE2(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			Width=data[offset++]|(data[offset++]<<8);
			var flags:int=data[offset++];
			StartCapStyle=(flags<<24)>>>30;					//11000000
			JoinStyle=(flags<<26)>>>30;						//00110000
			NoHScaleFlag=((flags&0x04)?true:false);		//00000100
			NoVScaleFlag=((flags&0x02)?true:false);		//00000010
			PixelHintingFlag=((flags&0x01)?true:false);	//00000001
			var flags2:int=data[offset++];
			//Reserved=(flags2<<24)>>>27;					//11111000
			NoClose=((flags2&0x04)?true:false);			//00000100
			EndCapStyle=flags2&0x03;						//00000011
			
			if(JoinStyle==2){
				MiterLimitFactor=data[offset++]|(data[offset++]<<8);
			}
			
			if(flags&0x08){//HasFillFlag				//00001000
				FillType=new FILLSTYLE();
				offset=FillType.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				Color=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			}
			
			return offset;
		}
		public function toData(_toDataOptions:Object):ByteArray{
			var data:ByteArray=new ByteArray();
			
			data[0]=Width;
			data[1]=Width>>8;
			
			var flags:int=0;
			flags|=StartCapStyle<<6;					//11000000
			flags|=JoinStyle<<4;						//00110000
			if(FillType){
				flags|=0x08;							//00001000
			}	
			if(NoHScaleFlag){
				flags|=0x04;							//00000100
			}
			if(NoVScaleFlag){
				flags|=0x02;							//00000010
			}
			if(PixelHintingFlag){
				flags|=0x01;							//00000001
			}
			data[2]=flags;
			
			var flags2:int=0;
			//flags2|=Reserved<<3;						//11111000
			if(NoClose){
				flags2|=0x04;							//00000100
			}
			flags2|=EndCapStyle;							//00000011
			data[3]=flags2;
			
			var offset:int=4;
			
			if(JoinStyle==2){
				data[offset++]=MiterLimitFactor;
				data[offset++]=MiterLimitFactor>>8;
			}
			
			if(FillType){
				data.position=offset;
				data.writeBytes(FillType.toData(_toDataOptions));
			}else{
				data[offset++]=Color>>16;
				data[offset++]=Color>>8;
				data[offset++]=Color;
				data[offset++]=Color>>24;
			}
			return data;
		}

		////
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.shapes.LINESTYLE2"
					Width={Width}
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
					xml.@Color="0x"+BytesAndStr16._16V[(Color>>24)&0xff]+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff];
				}
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				Width=int(xml.@Width.toString());
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
					FillType=new FILLSTYLE();
					FillType.initByXML(FillTypeXML,_initByXMLOptions);
				}else{
					Color=uint(xml.@Color.toString());
				}
			}
		//}//end of CONFIG::USE_XML
	}
}
