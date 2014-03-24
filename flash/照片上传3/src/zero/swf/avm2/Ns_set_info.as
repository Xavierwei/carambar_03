/***
Ns_set_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//An ns_set_info entry defines a set of namespaces, allowing the set to be used as a unit in the definition of multinames.

//			ns_set_info
//			{
//				u30 count
//				u30 ns[count]
//			}

//The count field defines how many ns's are identified for the entry, while each ns is an integer that indexes into
//the namespace array of the constant pool.
//ns是在 constant_pool.ns_v 中的id
//No entry in the ns array may be zero.
package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	public class Ns_set_info{
		
		public var nsV:Vector.<int>;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				nsV=new Vector.<int>(count);
				for(var i:int=0;i<count;i++){
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){nsV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{nsV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{nsV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{nsV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{nsV[i]=data[offset++];}
				}
			}else{
				nsV=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			if(nsV){
				var count:int=nsV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					for each(var ns:int in nsV){
						if(ns>>>7){if(ns>>>14){if(ns>>>21){if(ns>>>28){data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=((ns>>>14)&0x7f)|0x80;data[offset++]=((ns>>>21)&0x7f)|0x80;data[offset++]=ns>>>28;}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=((ns>>>14)&0x7f)|0x80;data[offset++]=ns>>>21;}}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=ns>>>14;}}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=ns>>>7;}}else{data[offset++]=ns;}
					}
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName}/>;
			
			if(nsV){
				var count:int=nsV.length;
				if(count){
					var childXML:XML=<nsV count={count}/>;
					for each(var ns:int in nsV){
						childXML.appendChild(<ns value={ns}/>);
					}
					xml.appendChild(childXML);
				}
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			var list:XMLList=xml.nsV.ns;
			var count:int=list.length();
			if(count){
				var i:int=-1;
				nsV=new Vector.<int>(count);
				for each(var childXML:XML in list){
					nsV[++i]=int(childXML.@value.toString());
				}
			}else{
				nsV=null;
			}
			
		}
		
	}
}
