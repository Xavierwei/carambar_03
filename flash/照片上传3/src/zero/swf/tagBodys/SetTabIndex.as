/***
SetTabIndex
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 20:04:30（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//SetTabIndex
//Flash Player maintains a concept of tab order of the interactive and textual objects displayed.
//Tab order is used both for actual tabbing and, in SWF 6 and later, to determine the order in
//which objects are exposed to accessibility aids (such as screen readers). The SWF 7
//SetTabIndex tag sets the index of an object within the tab order.
//If no character is currently placed at the specified depth, this tag is ignored.
//You can also use using the ActionScript tabIndex property to establish tab ordering, but this
//does not provide a way to set a tab index for a static text object, because the player does not
//provide a scripting reflection of static text objects. Fortunately, this is not a problem for the
//purpose of tabbing, because static text objects are never actually tab stops. However, this is a
//problem for the purpose of accessibility ordering, because static text objects are exposed to
//accessibility aids. When generating SWF content that is intended to be accessible and
//contains static text objects, the SetTabIndex tag is more useful than the tabIndex property.
//The minimum file format version is SWF 7.

//SetTabIndex
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 66
//Depth 			UI16 			Depth of character
//TabIndex 			UI16 			Tab order value

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	public class SetTabIndex{
		
		public var Depth:int;//UI16
		public var TabIndex:int;//UI16
		
		public function SetTabIndex(){
			//Depth=0;
			//TabIndex=0;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			Depth=data[offset++]|(data[offset++]<<8);
			
			TabIndex=data[offset++]|(data[offset++]<<8);
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=Depth;
			data[1]=Depth>>8;
			
			data[2]=TabIndex;
			data[3]=TabIndex>>8;
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.tagBodys.SetTabIndex"
					Depth={Depth}
					TabIndex={TabIndex}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				Depth=int(xml.@Depth.toString());
				
				TabIndex=int(xml.@TabIndex.toString());
				
			}
		//}//end of CONFIG::USE_XML
	}
}