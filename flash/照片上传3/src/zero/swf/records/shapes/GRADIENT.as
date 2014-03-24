/***
GRADIENT 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 21:46:22 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//SWF 8 and later supports up to 15 gradient control points, spread modes and a new
//interpolation type.
//Note that for the DefineShape, DefineShape2 or DefineShape3 tags, the SpreadMode and
//InterpolationMode fields must be 0, and the NumGradients field can not exceed 8.
//GRADIENT
//Field 				Type 				Comment
//SpreadMode 			UB[2] 				0 = Pad mode
//											1 = Reflect mode
//											2 = Repeat mode
//											3 = Reserved
//InterpolationMode 	UB[2] 				0 = Normal RGB mode interpolation
//											1 = Linear RGB mode interpolation
//											2 and 3 = Reserved
//NumGradients 			UB[4] 				1 to 15
//GradientRecords 		GRADRECORD[nGrads] 	Gradient records (see following)

//The GRADRECORD defines a gradient control point:
//GRADRECORD
//Field 		Type 					Comment
//Ratio 		UI8 					Ratio value
//Color 		RGB (Shape1 or Shape2)	Color of gradient
//				RGBA (Shape3)
package zero.swf.records.shapes{
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	public class GRADIENT{
		public var SpreadMode:int;
		public var InterpolationMode:int;
		public var RatioV:Vector.<int>;
		public var ColorV:Vector.<uint>;
		//
		
		public function GRADIENT(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			var flags:int=data[offset++];
			SpreadMode=(flags<<24)>>>30;				//11000000
			InterpolationMode=(flags<<26)>>>30;			//00110000
			var NumGradients:int=flags&0x0f;			//00001111
			RatioV=new Vector.<int>();
			ColorV=new Vector.<uint>();
			for(var i:int=0;i<NumGradients;i++){
				RatioV[i]=data[offset++];
				if(_initByDataOptions&&_initByDataOptions.ColorUseRGBA){//20110813
					ColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				}else{
					ColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
				}
			}
			return offset;
		}
		public function toData(_toDataOptions:Object):ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			flags|=SpreadMode<<6;						//11000000
			flags|=InterpolationMode<<4;				//00110000
			flags|=RatioV.length;//NumGradients;		//00001111
			data[0]=flags;
			
			var offset:int=1;
			var i:int=-1;
			for each(var Color:uint in ColorV){
				i++;
				data[offset++]=RatioV[i];
				if(_toDataOptions&&_toDataOptions.ColorUseRGBA){//20110813
					data[offset++]=Color>>16;
					data[offset++]=Color>>8;
					data[offset++]=Color;
					data[offset++]=Color>>24;
				}else{
					data[offset++]=Color>>16;
					data[offset++]=Color>>8;
					data[offset++]=Color;
				}
			}
			return data;
		}

		////
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.shapes.GRADIENT"
					SpreadMode={SpreadMode}
					InterpolationMode={InterpolationMode}
				/>;
				if(ColorV.length){
					var RatioAndColorListXML:XML=<RatioAndColorList count={ColorV.length}/>
					var i:int=-1;
					for each(var Color:uint in ColorV){
						i++;
						RatioAndColorListXML.appendChild(<Ratio value={RatioV[i]}/>);
						if(_toXMLOptions&&_toXMLOptions.ColorUseRGBA){//20110813
							RatioAndColorListXML.appendChild(<Color value={"0x"+BytesAndStr16._16V[(Color>>24)&0xff]+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff]}/>);
						}else{
							RatioAndColorListXML.appendChild(<Color value={"0x"+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff]}/>);
						}
					}
					xml.appendChild(RatioAndColorListXML);
				}
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				SpreadMode=int(xml.@SpreadMode.toString());
				InterpolationMode=int(xml.@InterpolationMode.toString());
				RatioV=new Vector.<int>();
				ColorV=new Vector.<uint>();
				var i:int=-1;
				var RatioXMLList:XMLList=xml.RatioAndColorList.Ratio;
				for each(var ColorXML:XML in xml.RatioAndColorList.Color){
					i++;
					RatioV[i]=int(RatioXMLList[i].@value.toString());
					ColorV[i]=uint(ColorXML.@value.toString());
				}
			}
		//}//end of CONFIG::USE_XML
	}
}