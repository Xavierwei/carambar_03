/***
MORPHGRADIENT
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月23日 07:23:23
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

package zero.swf.records.shapes{
	
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	
	public class MORPHGRADIENT{
		
		public var NumGradients:int;//20130712 NumGradients>StartRatioV.length 表示循环使用
		public var StartRatioV:Vector.<int>;
		public var StartColorV:Vector.<uint>;
		public var EndRatioV:Vector.<int>;
		public var EndColorV:Vector.<uint>;
		
		public function MORPHGRADIENT(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			NumGradients=data[offset++];
			
			StartRatioV=new Vector.<int>();
			StartColorV=new Vector.<uint>();
			EndRatioV=new Vector.<int>();
			EndColorV=new Vector.<uint>();
			for(var i:int=0;i<NumGradients;i++){
				
				StartRatioV[i]=data[offset++];
				
				StartColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				
				EndRatioV[i]=data[offset++];
				
				EndColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
				
				if(EndRatioV[i]==255){//20130712
					break;
				}
				
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=NumGradients;
			
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
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.shapes.MORPHGRADIENT" NumGradients={NumGradients}/>;
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
				
				NumGradients=int(xml.@NumGradients.toString());
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
			}
		//}//end of CONFIG::USE_XML
	}
}