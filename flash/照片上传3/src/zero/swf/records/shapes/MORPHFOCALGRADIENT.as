/***
MORPHFOCALGRADIENT
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月15日 13:17:33
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//MORPHGRADIENT
//The format of gradient information is described in the following table:
//
//MORPHGRADIENT
//Field 				Type 							Comment
//NumGradients 			UI8 							1 to 8.
//GradientRecords 		MORPHGRADRECORD[NumGradients]	Gradient records (see following).

//MORPHGRADRECORD
//The gradient record format is described in the following table:
//
//MORPHGRADRECORD
//Field 			Type 			Comment
//StartRatio 		UI8 			Ratio value for start shape.
//StartColor 		RGBA 			Color of gradient for start shape.
//EndRatio 			UI8 			Ratio value for end shape.
//EndColor 			RGBA 			Color of gradient for end shape.

//A FOCALGRADIENT must be declared in DefineShape4—not DefineShape, DefineShape2
//or DefineShape3.
//The value range is from -1.0 to 1.0, where -1.0 means the focal point is close to the left border
//of the radial gradient circle, 0.0 means that the focal point is in the center of the radial
//gradient circle, and 1.0 means that the focal point is close to the right border of the radial
//gradient circle.
//FOCALGRADIENT
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
//FocalPoint 			FIXED8 				Focal point location

//The GRADRECORD defines a gradient control point:
//GRADRECORD
//Field 		Type 					Comment
//Ratio 		UI8 					Ratio value
//Color 		RGB (Shape1 or Shape2)	Color of gradient
//				RGBA (Shape3)

package zero.swf.records.shapes{
	
	import flash.utils.ByteArray;
	import zero.BytesAndStr16;
	
	public class MORPHFOCALGRADIENT{
		
		public var SpreadMode:int;
		public var InterpolationMode:int;
		public var StartRatioV:Vector.<int>;
		public var StartColorV:Vector.<uint>;
		public var EndRatioV:Vector.<int>;
		public var EndColorV:Vector.<uint>;
		public var StartFocalPoint:Number;
		public var EndFocalPoint:Number;
		
		public function MORPHFOCALGRADIENT(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			var flags:int=data[offset++];
			SpreadMode=(flags<<24)>>>30;				//11000000
			InterpolationMode=(flags<<26)>>>30;			//00110000
			var NumGradients:int=flags&0x0f;			//00001111
			StartRatioV=new Vector.<int>();
			StartColorV=new Vector.<uint>();
			EndRatioV=new Vector.<int>();
			EndColorV=new Vector.<uint>();
			for(var i:int=0;i<NumGradients;i++){
				
				StartRatioV[i]=data[offset++];
				
				StartColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				
				EndRatioV[i]=data[offset++];
				
				EndColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				
			}
			
			StartFocalPoint=data[offset++]/256+data[offset++];
			
			EndFocalPoint=data[offset++]/256+data[offset++];
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			flags|=SpreadMode<<6;						//11000000
			flags|=InterpolationMode<<4;				//00110000
			flags|=StartRatioV.length;//NumGradients;	//00001111
			data[0]=flags;
			
			var offset:int=1;
			var i:int=-1;
			for each(var StartColor:uint in StartColorV){
				i++;
				
				data[offset++]=StartRatioV[i];
				
				data[offset++]=StartColor>>16;
				data[offset++]=StartColor>>8;
				data[offset++]=StartColor;
				data[offset++]=StartColor>>24;
				
				data[offset++]=EndRatioV[i];
				
				var EndColor:uint=EndColorV[i];
				
				data[offset++]=EndColor>>16;
				data[offset++]=EndColor>>8;
				data[offset++]=EndColor;
				data[offset++]=EndColor>>24;
			}
			
			data[offset++]=StartFocalPoint*256;
			data[offset++]=StartFocalPoint;
			
			data[offset++]=EndFocalPoint*256;
			data[offset++]=EndFocalPoint;
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.shapes.MORPHFOCALGRADIENT"
					SpreadMode={SpreadMode}
					InterpolationMode={InterpolationMode}
					StartFocalPoint={StartFocalPoint}
					EndFocalPoint={EndFocalPoint}
				/>;
				if(StartColorV.length){
					var RatioAndColorListXML:XML=<RatioAndColorList count={StartColorV.length}/>;
					var i:int=-1;
					for each(var StartColor:uint in StartColorV){
						i++;
						RatioAndColorListXML.appendChild(<StartRatio value={StartRatioV[i]}/>);
						RatioAndColorListXML.appendChild(<StartColor value={"0x"+BytesAndStr16._16V[(StartColor>>24)&0xff]+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff]}/>);
						RatioAndColorListXML.appendChild(<EndRatio value={EndRatioV[i]}/>);
						var EndColor:uint=EndColorV[i];
						RatioAndColorListXML.appendChild(<EndColor value={"0x"+BytesAndStr16._16V[(EndColor>>24)&0xff]+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff]}/>);
					}
					xml.appendChild(RatioAndColorListXML);
				}
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				SpreadMode=int(xml.@SpreadMode.toString());
				InterpolationMode=int(xml.@InterpolationMode.toString());
				StartRatioV=new Vector.<int>();
				StartColorV=new Vector.<uint>();
				EndRatioV=new Vector.<int>();
				EndColorV=new Vector.<uint>();
				var i:int=-1;
				var StartRatioXMLList:XMLList=xml.RatioAndColorList.StartRatio;
				var EndRatioXMLList:XMLList=xml.RatioAndColorList.EndRatio;
				var EndColorXMLList:XMLList=xml.RatioAndColorList.EndColor;
				for each(var StartColorXML:XML in xml.RatioAndColorList.StartColor){
					i++;
					StartRatioV[i]=int(StartRatioXMLList[i].@value.toString());
					StartColorV[i]=uint(StartColorXML.@value.toString());
					EndRatioV[i]=int(EndRatioXMLList[i].@value.toString());
					EndColorV[i]=uint(EndColorXMLList[i].@value.toString());
				}
				StartFocalPoint=Number(xml.@StartFocalPoint.toString());
				EndFocalPoint=Number(xml.@EndFocalPoint.toString());
			}
		//}//end of CONFIG::USE_XML
	}
}