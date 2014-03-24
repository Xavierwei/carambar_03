/***
MORPHFILLSTYLE
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月23日 07:05:21
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//MORPHFILLSTYLE
//A fill style represents how a closed shape is filled in.
//
//MORPHFILLSTYLE
//Field 				Type 										Comment
//FillStyleType 		UI8 										Type of fill style
//																	0x00 = solid fill
//																	0x10 = linear gradient fill
//																	0x12 = radial gradient fill
//																	0x40 = repeating bitmap
//																	0x41 = clipped bitmap fill
//																	0x42 = non-smoothed repeating bitmap
//																	0x43 = non-smoothed clipped bitmap
//StartColor 			If type = 0x00, RGBA 						Solid fill color with opacity information for start shape.
//EndColor 				If type = 0x00, RGBA 						Solid fill color with opacity information for end shape.
//StartGradientMatrix 	If type = 0x10 or 0x12, MATRIX 				Matrix for gradient fill for start shape.
//EndGradientMatrix 	If type = 0x10 or 0x12, MATRIX 				Matrix for gradient fill for end shape.
//Gradient 				If type = 0x10 or 0x12, MORPHGRADIENT 		Gradient fill.
//BitmapId 				If type = 0x40, 0x41, 0x42 or 0x43, UI16	ID of bitmap character for fill.
//StartBitmapMatrix 	If type = 0x40, 0x41, 0x42 or 0x43, MATRIX	Matrix for bitmap fill for start shape.
//EndBitmapMatrix 		If type = 0x40, 0x41, 0x42 or 0x43, MATRIX	Matrix for bitmap fill for end shape.

package zero.swf.records.shapes{
	
	import flash.utils.ByteArray;
	import zero.BytesAndStr16;
	import zero.swf.records.MATRIX;
	
	public class MORPHFILLSTYLE{
		
		public var FillStyleType:int;
		
		public var StartColor:uint;
		public var EndColor:uint;
		
		public var StartGradientMatrix:MATRIX;
		public var EndGradientMatrix:MATRIX;
		public var Gradient:MORPHGRADIENT;
		public var FocalGradient:MORPHFOCALGRADIENT;
		
		public var BitmapId:int;
		public var StartBitmapMatrix:MATRIX;
		public var EndBitmapMatrix:MATRIX;
		
		public function MORPHFILLSTYLE(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			FillStyleType=data[offset++];
			
			switch(FillStyleType){
				case 0x00:
					
					StartColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
					
					EndColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
					
				break;
				case 0x10:
				case 0x12:
					
					StartGradientMatrix=new MATRIX();
					offset=StartGradientMatrix.initByData(data,offset,endOffset,_initByDataOptions);
					
					EndGradientMatrix=new MATRIX();
					offset=EndGradientMatrix.initByData(data,offset,endOffset,_initByDataOptions);
					
					Gradient=new MORPHGRADIENT();
					offset=Gradient.initByData(data,offset,endOffset,_initByDataOptions);
					
				break;
				case 0x13:
					//20110915
					//貌似是文档里漏写的
					
					StartGradientMatrix=new MATRIX();
					offset=StartGradientMatrix.initByData(data,offset,endOffset,_initByDataOptions);
					
					EndGradientMatrix=new MATRIX();
					offset=EndGradientMatrix.initByData(data,offset,endOffset,_initByDataOptions);
					
					FocalGradient=new MORPHFOCALGRADIENT();
					offset=FocalGradient.initByData(data,offset,endOffset,_initByDataOptions);
					
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					
					BitmapId=data[offset++]|(data[offset++]<<8);
					
					StartBitmapMatrix=new MATRIX();
					offset=StartBitmapMatrix.initByData(data,offset,endOffset,_initByDataOptions);
					
					EndBitmapMatrix=new MATRIX();
					offset=EndBitmapMatrix.initByData(data,offset,endOffset,_initByDataOptions);
					
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=FillStyleType;
			
			switch(FillStyleType){
				case 0x00:
					
					data[1]=StartColor>>16;
					data[2]=StartColor>>8;
					data[3]=StartColor;
					data[4]=StartColor>>24;
					
					data[5]=EndColor>>16;
					data[6]=EndColor>>8;
					data[7]=EndColor;
					data[8]=EndColor>>24;
					
				break;
				case 0x10:
				case 0x12:
					
					data.position=1;
					data.writeBytes(StartGradientMatrix.toData(_toDataOptions));
					
					data.writeBytes(EndGradientMatrix.toData(_toDataOptions));
					
					data.writeBytes(Gradient.toData(_toDataOptions));
					
				break;
				case 0x13:
					//20110915
					//貌似是文档里漏写的
					
					data.position=1;
					data.writeBytes(StartGradientMatrix.toData(_toDataOptions));
					
					data.writeBytes(EndGradientMatrix.toData(_toDataOptions));
					
					data.writeBytes(FocalGradient.toData(_toDataOptions));
					
				break;
				case 0x40:
				case 0x41:
				case 0x42:
				case 0x43:
					
					data[1]=BitmapId;
					data[2]=BitmapId>>8;
					
					data.position=3;
					data.writeBytes(StartBitmapMatrix.toData(_toDataOptions));
					
					data.writeBytes(EndBitmapMatrix.toData(_toDataOptions));
					
				break;
				default:
					throw new Error("未知 FillStyleType: "+FillStyleType);
				break;
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.records.shapes.MORPHFILLSTYLE"/>;
				
				xml.@FillStyleType="0x"+BytesAndStr16._16V[FillStyleType];
				
				switch(FillStyleType){
					case 0x00:
						
						xml.@StartColor="0x"+BytesAndStr16._16V[(StartColor>>24)&0xff]+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff];
						
						xml.@EndColor="0x"+BytesAndStr16._16V[(EndColor>>24)&0xff]+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff];
						
					break;
					case 0x10:
					case 0x12:
						
						xml.appendChild(StartGradientMatrix.toXML("StartGradientMatrix",_toXMLOptions));
						
						xml.appendChild(EndGradientMatrix.toXML("EndGradientMatrix",_toXMLOptions));
						
						xml.appendChild(Gradient.toXML("Gradient",_toXMLOptions));
						
					break;
					case 0x13:
						//20110915
						//貌似是文档里漏写的
						
						xml.appendChild(StartGradientMatrix.toXML("StartGradientMatrix",_toXMLOptions));
						
						xml.appendChild(EndGradientMatrix.toXML("EndGradientMatrix",_toXMLOptions));
						
						xml.appendChild(FocalGradient.toXML("FocalGradient",_toXMLOptions));
						
					break;
					case 0x40:
					case 0x41:
					case 0x42:
					case 0x43:
						
						xml.@BitmapId=BitmapId;
						
						xml.appendChild(StartBitmapMatrix.toXML("StartBitmapMatrix",_toXMLOptions));
						
						xml.appendChild(EndBitmapMatrix.toXML("EndBitmapMatrix",_toXMLOptions));
						
					break;
					default:
						throw new Error("未知 FillStyleType: "+FillStyleType);
					break;
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				FillStyleType=int(xml.@FillStyleType.toString());
				
				switch(FillStyleType){
					case 0x00:
						
						StartColor=uint(xml.@StartColor.toString());
						
						EndColor=uint(xml.@EndColor.toString());
						
					break;
					case 0x10:
					case 0x12:
						
						StartGradientMatrix=new MATRIX();
						StartGradientMatrix.initByXML(xml.StartGradientMatrix[0],_initByXMLOptions);
						
						EndGradientMatrix=new MATRIX();
						EndGradientMatrix.initByXML(xml.EndGradientMatrix[0],_initByXMLOptions);
						
						Gradient=new MORPHGRADIENT();
						Gradient.initByXML(xml.Gradient[0],_initByXMLOptions);
						
					break;
					case 0x13:
						//20110915
						//貌似是文档里漏写的
						
						StartGradientMatrix=new MATRIX();
						StartGradientMatrix.initByXML(xml.StartGradientMatrix[0],_initByXMLOptions);
						
						EndGradientMatrix=new MATRIX();
						EndGradientMatrix.initByXML(xml.EndGradientMatrix[0],_initByXMLOptions);
						
						FocalGradient=new MORPHFOCALGRADIENT();
						FocalGradient.initByXML(xml.FocalGradient[0],_initByXMLOptions);
						
					break;
					case 0x40:
					case 0x41:
					case 0x42:
					case 0x43:
						
						BitmapId=int(xml.@BitmapId.toString());
						
						StartBitmapMatrix=new MATRIX();
						StartBitmapMatrix.initByXML(xml.StartBitmapMatrix[0],_initByXMLOptions);
						
						EndBitmapMatrix=new MATRIX();
						EndBitmapMatrix.initByXML(xml.EndBitmapMatrix[0],_initByXMLOptions);
						
					break;
					default:
						throw new Error("未知 FillStyleType: "+FillStyleType);
					break;
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}