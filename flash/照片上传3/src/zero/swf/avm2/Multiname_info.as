/***
Multiname_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月19日 23:00:39（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//A multiname_info entry is a variable length item that is used to define multiname entities used by the
//bytecode. There are many kinds of multinames. The kind field acts as a tag: its value determines how the
//loader should see the variable-length data field. The layout of the contents of the data field under a particular
//kind is described below by the multiname_kind_ structures.
//multiname_info
//{
//u8 kind
//u8 data[]
//}
//
//Multiname Kind 		Value
//CONSTANT_QName 		0x07
//CONSTANT_QNameA 		0x0D
//CONSTANT_RTQName 		0x0F
//CONSTANT_RTQNameA 	0x10
//CONSTANT_RTQNameL 	0x11
//CONSTANT_RTQNameLA 	0x12
//CONSTANT_Multiname 	0x09
//CONSTANT_MultinameA 	0x0E
//CONSTANT_MultinameL 	0x1B
//CONSTANT_MultinameLA 	0x1C
//
//Those constants ending in "A" (such as CONSTANT_QNameA) represent the names of attributes.

//multiname_kind_QName
//{
//	u30 ns
//	u30 name
//}

//The ns and name fields are indexes into the namespace and string arrays of the constant_pool entry,
//respectively. A value of zero for the ns field indicates the any ("*") namespace, and a value of zero for the name
//field indicates the any ("*") name.
//ns是在 constant_pool.namespace_info_v 中的id
//name是在 constant_pool.string_v 中的id
//ns或name如果是 0 则表示 "*"

//multiname_kind_Multiname
//{
//	u30 name
//	u30 ns_set
//}

//The name field is an index into the string array, and the ns_set field is an index into the ns_set array. A
//value of zero for the name field indicates the any ("*") name. The value of ns_set cannot be zero.
//name是在 constant_pool.string_v 中的id
//ns_set是在 constant_pool.ns_set_info_v 中的id
//name如果是 0 则表示 "*"
//ns_set不能是 0

//multiname_kind_RTQName
//{
//	u30 name
//}

//The single field, name, is an index into the string array of the constant pool. A value of zero indicates the any ("*") name.
//name是在 constant_pool.string_v 中的id
//name如果是 0 则表示 "*"

//multiname_kind_RTQNameL
//{
//}

//This kind has no associated data.
//什么都没有...

//multiname_kind_MultinameL
//{
//	u30 ns_set
//}

//The ns_set field is an index into the ns_set array of the constant pool. The value of ns_set cannot be zero.
//ns_set是在 constant_pool.ns_set_info_v 中的id
//ns_set不能是 0

//0x1D can be considered a GenericName multiname, and is declared as such: 

//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 

//Where 
//[TypeDefinition] is a U30 into the multiname table 
//[ParamCount] is a U8 (U30?) of how many parameters there are 
//[ParamX] is a U30 into the multiname table. 
package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	public class Multiname_info{
		public var kind:int;							//u8
		public var value:*;
		//QName，QNameA				value[0] 表现为：ns，value[1] 表现为：name
		//Multiname，MultinameA		value[0] 表现为：name，value[1] 表现为：ns_set
		//RTQName，RTQNameA			value 表现为：name
		//RTQNameL，RTQNameLA		value 不使用
		//MultinameL，MultinameLA	value 表现为：ns_set
		//GenericName				value[0] 表现为：TypeDefinition，value[1] 表现为 ParamV
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			kind=data[offset++];
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){value=[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)];}else{value=[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)];}}else{value=[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)];}}else{value=[(data[offset++]&0x7f)|(data[offset++]<<7)];}}else{value=[data[offset++]];}
					//value[0]
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){value[1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{value[1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{value[1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{value[1]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{value[1]=data[offset++];}
					//value[1]
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){value=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{value=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{value=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{value=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{value=data[offset++];}
					//value
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					value=undefined;
				break;
				case MultinameKinds.GenericName:
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){value=[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)];}else{value=[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)];}}else{value=[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)];}}else{value=[(data[offset++]&0x7f)|(data[offset++]<<7)];}}else{value=[data[offset++]];}
					//value[0]
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
					//count
					if(count){
						value[1]=new Vector.<int>(count);
						for(var i:int=0;i<count;i++){
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){value[1][i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{value[1][i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{value[1][i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{value[1][i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{value[1][i]=data[offset++];}
							//value[1][i]
						}
					}else{
						value[1]=null;
					}
				break;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			data[offset++]=kind;
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					if(value[0]>>>7){if(value[0]>>>14){if(value[0]>>>21){if(value[0]>>>28){data[offset++]=(value[0]&0x7f)|0x80;data[offset++]=((value[0]>>>7)&0x7f)|0x80;data[offset++]=((value[0]>>>14)&0x7f)|0x80;data[offset++]=((value[0]>>>21)&0x7f)|0x80;data[offset++]=value[0]>>>28;}else{data[offset++]=(value[0]&0x7f)|0x80;data[offset++]=((value[0]>>>7)&0x7f)|0x80;data[offset++]=((value[0]>>>14)&0x7f)|0x80;data[offset++]=value[0]>>>21;}}else{data[offset++]=(value[0]&0x7f)|0x80;data[offset++]=((value[0]>>>7)&0x7f)|0x80;data[offset++]=value[0]>>>14;}}else{data[offset++]=(value[0]&0x7f)|0x80;data[offset++]=value[0]>>>7;}}else{data[offset++]=value[0];}
					//value[0]
					
					if(value[1]>>>7){if(value[1]>>>14){if(value[1]>>>21){if(value[1]>>>28){data[offset++]=(value[1]&0x7f)|0x80;data[offset++]=((value[1]>>>7)&0x7f)|0x80;data[offset++]=((value[1]>>>14)&0x7f)|0x80;data[offset++]=((value[1]>>>21)&0x7f)|0x80;data[offset++]=value[1]>>>28;}else{data[offset++]=(value[1]&0x7f)|0x80;data[offset++]=((value[1]>>>7)&0x7f)|0x80;data[offset++]=((value[1]>>>14)&0x7f)|0x80;data[offset++]=value[1]>>>21;}}else{data[offset++]=(value[1]&0x7f)|0x80;data[offset++]=((value[1]>>>7)&0x7f)|0x80;data[offset++]=value[1]>>>14;}}else{data[offset++]=(value[1]&0x7f)|0x80;data[offset++]=value[1]>>>7;}}else{data[offset++]=value[1];}
					//value[1]
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					if(value>>>7){if(value>>>14){if(value>>>21){if(value>>>28){data[offset++]=(value&0x7f)|0x80;data[offset++]=((value>>>7)&0x7f)|0x80;data[offset++]=((value>>>14)&0x7f)|0x80;data[offset++]=((value>>>21)&0x7f)|0x80;data[offset++]=value>>>28;}else{data[offset++]=(value&0x7f)|0x80;data[offset++]=((value>>>7)&0x7f)|0x80;data[offset++]=((value>>>14)&0x7f)|0x80;data[offset++]=value>>>21;}}else{data[offset++]=(value&0x7f)|0x80;data[offset++]=((value>>>7)&0x7f)|0x80;data[offset++]=value>>>14;}}else{data[offset++]=(value&0x7f)|0x80;data[offset++]=value>>>7;}}else{data[offset++]=value;}
					//value
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//
				break;
				case MultinameKinds.GenericName:
					if(value[0]>>>7){if(value[0]>>>14){if(value[0]>>>21){if(value[0]>>>28){data[offset++]=(value[0]&0x7f)|0x80;data[offset++]=((value[0]>>>7)&0x7f)|0x80;data[offset++]=((value[0]>>>14)&0x7f)|0x80;data[offset++]=((value[0]>>>21)&0x7f)|0x80;data[offset++]=value[0]>>>28;}else{data[offset++]=(value[0]&0x7f)|0x80;data[offset++]=((value[0]>>>7)&0x7f)|0x80;data[offset++]=((value[0]>>>14)&0x7f)|0x80;data[offset++]=value[0]>>>21;}}else{data[offset++]=(value[0]&0x7f)|0x80;data[offset++]=((value[0]>>>7)&0x7f)|0x80;data[offset++]=value[0]>>>14;}}else{data[offset++]=(value[0]&0x7f)|0x80;data[offset++]=value[0]>>>7;}}else{data[offset++]=value[0];}
					//value[0]
					
					if(value[1]){
						var count:int=value[1].length;
						if(count){
							if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
							//ParamCount
							for each(var Param:int in value[1]){
								if(Param>>>7){if(Param>>>14){if(Param>>>21){if(Param>>>28){data[offset++]=(Param&0x7f)|0x80;data[offset++]=((Param>>>7)&0x7f)|0x80;data[offset++]=((Param>>>14)&0x7f)|0x80;data[offset++]=((Param>>>21)&0x7f)|0x80;data[offset++]=Param>>>28;}else{data[offset++]=(Param&0x7f)|0x80;data[offset++]=((Param>>>7)&0x7f)|0x80;data[offset++]=((Param>>>14)&0x7f)|0x80;data[offset++]=Param>>>21;}}else{data[offset++]=(Param&0x7f)|0x80;data[offset++]=((Param>>>7)&0x7f)|0x80;data[offset++]=Param>>>14;}}else{data[offset++]=(Param&0x7f)|0x80;data[offset++]=Param>>>7;}}else{data[offset++]=Param;}
								//Param
							}
						}else{
							data[offset++]=0;
						}
					}else{
						data[offset++]=0;
					}
				break;
			}
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName}
				kind={MultinameKinds.kindV[kind]}
			/>;
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
					xml.@ns=value[0];
					xml.@name=value[1];
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					xml.@name=value[0];
					xml.@ns_set=value[1];
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					xml.@name=value;
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					xml.@ns_set=value;
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//
				break;
				case MultinameKinds.GenericName:
					xml.@TypeDefinition=value[0];
					
					if(value[1]){
						var count:int=value[1].length;
						if(count){
							var childXML:XML=<ParamV count={count}/>
							for each(var Param:int in value[1]){
								childXML.appendChild(<Param value={Param}/>);
							}
							xml.appendChild(childXML);
						}
					}
				break;
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			kind=MultinameKinds[xml.@kind.toString()];
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
					value=[
						int(xml.@ns.toString()),
						int(xml.@name.toString())
					];
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					value=[
						int(xml.@name.toString()),
						int(xml.@ns_set.toString())
					];
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					value=int(xml.@name.toString());
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					value=int(xml.@ns_set.toString());
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					value=undefined;
				break;
				case MultinameKinds.GenericName:
					value=[int(xml.@TypeDefinition.toString())];
					
					var list:XMLList=xml.ParamV.Param;
					var count:int=list.length();
					if(count){
						var i:int=-1;
						value[1]=new Vector.<int>(count);
						for each(var childXML:XML in list){
							value[1][++i]=int(childXML.@value.toString());
						}
					}else{
						value[1]=null;
					}
				break;
			}
			
		}
		
	}
}
