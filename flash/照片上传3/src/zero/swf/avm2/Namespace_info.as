/***
Namespace_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//A namespace_info entry defines a namespace. Namespaces have string names, represented by indices into the
//string array, and kinds. User-defined namespaces have kind CONSTANT_Namespace or
//CONSTANT_ExplicitNamespace and a non-empty name. System namespaces have empty names and one of the
//other kinds, and provides a means for the loader to map references to these namespaces onto internal entities.

//A single byte defines the type of entry that follows, thus identifying how the name field should be interpreted by the loader. 
//The name field is an index into the string section of the constant pool.
//name是在 constant_pool.string_v 中的id
//A value of zero denotes an empty string.
//The table below lists the legal values for kind.
//Namespace Kind 				Value
//CONSTANT_Namespace 			0x08
//CONSTANT_PackageNamespace 	0x16
//CONSTANT_PackageInternalNs 	0x17
//CONSTANT_ProtectedNamespace 	0x18
//CONSTANT_ExplicitNamespace 	0x19
//CONSTANT_StaticProtectedNs 	0x1A
//CONSTANT_PrivateNs 			0x05

//			namespace_info
//			{
//				u8 kind
//				u30 name
//			}
package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	public class Namespace_info{
		
		public var kind:int;
		public var name:int;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			kind=data[offset++];
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			data[offset++]=kind;
			
			if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			return <{xmlName}
				kind={NamespaceKinds.kindV[kind]}
				name={name}
			/>;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			kind=NamespaceKinds[xml.@kind.toString()];
			
			name=int(xml.@name.toString());
			
		}
		
	}
}
