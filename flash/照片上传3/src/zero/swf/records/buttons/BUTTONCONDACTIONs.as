/***
BUTTONCONDACTIONs
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月6日 09:00:22
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//Actions 							BUTTONCONDACTION[zero or more]	Actions to execute at particular button events field to the first BUTTONCONDACTION, or 0 if no actions occur
package zero.swf.records.buttons{
	import flash.utils.ByteArray;
	public class BUTTONCONDACTIONs{
		public var ButtonCondActionV:Vector.<BUTTONCONDACTION>;
		//
		
		public function BUTTONCONDACTIONs(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			var i:int=-1;
			ButtonCondActionV=new Vector.<BUTTONCONDACTION>();
			while(offset<endOffset){
				i++;
				ButtonCondActionV[i]=new BUTTONCONDACTION();
				offset=ButtonCondActionV[i].initByData(data,offset,endOffset,_initByDataOptions);
			}
			return offset;
		}
		public function toData(_toDataOptions:Object):ByteArray{
			var data:ByteArray=new ByteArray();
			if(ButtonCondActionV.length){
				for each(var ButtonCondAction:BUTTONCONDACTION in ButtonCondActionV){
					var ButtonCondActionData:ByteArray=ButtonCondAction.toData(_toDataOptions);
					var CondActionSize:int=ButtonCondActionData.length;
					if(CondActionSize<0x10000){
						ButtonCondActionData[0]=CondActionSize;
						ButtonCondActionData[1]=CondActionSize>>8;
					}else{
						throw new Error("CondActionSize="+CondActionSize+"，超出范围");
					}
					data.writeBytes(ButtonCondActionData);
				}
				data[data.length-CondActionSize]=0x00;
				data[data.length-CondActionSize+1]=0x00;
			}
			return data;
		}
		
		////
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.buttons.BUTTONCONDACTIONs"/>;
				if(ButtonCondActionV.length){
					var ButtonCondActionListXML:XML=<ButtonCondActionList count={ButtonCondActionV.length}/>
					for each(var ButtonCondAction:BUTTONCONDACTION in ButtonCondActionV){
						ButtonCondActionListXML.appendChild(ButtonCondAction.toXML("ButtonCondAction",_toXMLOptions));
					}
					xml.appendChild(ButtonCondActionListXML);
				}
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				var i:int=-1;
				ButtonCondActionV=new Vector.<BUTTONCONDACTION>();
				for each(var ButtonCondActionXML:XML in xml.ButtonCondActionList.ButtonCondAction){
					i++;
					ButtonCondActionV[i]=new BUTTONCONDACTION();
					ButtonCondActionV[i].initByXML(ButtonCondActionXML,_initByXMLOptions);
				}
			}
		//}//end of CONFIG::USE_XML
	}
}	