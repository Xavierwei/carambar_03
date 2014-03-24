/***
ABCFile
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月19日 22:11:40（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The constant pool is a block of array-based entries(entry 条目) that reflect the constants used by all methods.
//Each of the count entries (for example, int_count) must be one more than the number of entries in the corresponding
//array, 
//每个条目数组的 count 都是比数组长度多1(1表示0,2表示1,...因为0表示了特别的意义，下面有提及)
//and the first entry in the array is element "1". 
//For all constant pools, the index "0" has a special meaning,
//typically a sensible default value. For example, the "0" entry is used to represent the empty sting (""), the any
//namespace, or the any type (*) depending on the context it is used in. When "0" has a special meaning it is
//described in the text below.

//cpool_info
//{
//	u30 			int_count
//	s32 			integer[int_count]
//	u30 			uint_count
//	u32 			uinteger[uint_count]
//	u30 			double_count
//	d64 			double[double_count]
//	u30 			string_count
//	string_info 	string[string_count]
//	u30 			namespace_count
//	namespace_info 	namespace[namespace_count]
//	u30 			ns_set_count
//	ns_set_info 	ns_set[ns_set_count]
//	u30 			multiname_count
//	multiname_info 	multiname[multiname_count]
//}

//The value of int_count is the number of entries in the integer array, plus one. The integer array
//holds integer constants referenced by the bytecode. The "0" entry of the integer array is not present in
//the abcFile; it represents the zero value for the purposes of providing values for optional parameters and
//field initialization.

//The value of uint_count is the number of entries in the uinteger array, plus one. The uinteger array
//holds unsigned integer constants referenced by the bytecode. The "0" entry of the uinteger array is not
//present in the abcFile; it represents the zero value for the purposes of providing values for optional
//parameters and field initialization.

//The value of double_count is the number of entries in the double array, plus one. The double array
//holds IEEE double-precision floating point constants referenced by the bytecode. 
//The "0" entry of the double array is not present in the abcFile; it represents the NaN (Not-a-Number) value for the purposes of providing values for optional parameters and field initialization.
//0 代表 NaN	

//The value of string_count is the number of entries in the string array, plus one. The string array
//holds UTF-8 encoded strings referenced by the compiled code and by many other parts of the abcFile.
//In addition to describing string constants in programs, string data in the constant pool are used in the
//description of names of many kinds. Entry "0" of the string array is not present in the abcFile; it
//represents the empty string in most contexts but is also used to represent the "any" name in others
//(known as "*" in ActionScript).

//The value of namespace_count is the number of entries in the namespace array, plus one. The
//namespace array describes the namespaces used by the bytecode and also for names of many kinds. Entry
//"0" of the namespace array is not present in the abcFile; it represents the "any" namespace (known as
//"*" in ActionScript).

//The value of ns_set_count is the number of entries in the ns_set array, plus one. The ns_set array
//describes namespace sets used in the descriptions of multinames. The "0" entry of the ns_set array is not
//present in the abcFile.

//The value of multiname_count is the number of entries in the multiname array, plus one. The
//multiname array describes names used by the bytecode. The "0" entry of the multiname array is not
//present in the abcFile.

//abcFile
//{
//	u16 				minor_version

//	u16 				major_version
//	cpool_info 			constant_pool
//	u30 				method_count
//	method_info 		method[method_count]
//	u30 				metadata_count
//	metadata_info 		metadata[metadata_count]
//	u30 				class_count
//	instance_info 		instance[class_count]
//	class_info 			class[class_count]
//	u30 				script_count
//	script_info 		script[script_count]
//	u30 				method_body_count
//	method_body_info	method_body[method_body_count]
//}

//The values of major_version and minor_version are the major and minor version numbers of the
//abcFile format. A change in the minor version number signifies a change in the file format that is
//backward compatible, in the sense that an implementation of the AVM2 can still make use of a file of an
//older version. A change in the major version number denotes an incompatible adjustment to the file
//format.
//As of the publication of this overview, the major version is 46 and the minor version is 16.
//minor_version一般就是16
//major_version一般就是46

//The constant_pool is a variable length structure composed of integers, doubles, strings, namespaces,
//namespace sets, and multinames. These constants are referenced from other parts of the abcFile
//structure.
//常量池

//The value of method_count is the number of entries in the method array. Each entry in the method array
//is a variable length method_info structure. The array holds information about every method defined in
//this abcFile. The code for method bodies is held separately in the method_body array (see below).
//Some entries in method may have no body—this is the case for native methods, for example.

//The value of metadata_count is the number of entries in the metadata array. Each metadata entry is a
//metadata_info structure that maps a name to a set of string values.

//The value of class_count is the number of entries in the instance and class arrays.

//Each instance entry is a variable length instance_info structure which specifies the characteristics of
//object instances created by a particular class.

//Each class entry defines the characteristics of a class. It is used in conjunction with the instance field to
//derive a full description of an AS Class.

//The value of script_count is the number of entries in the script array.

//Each script entry is a script_info structure that defines the characteristics of a single script in this file. As explained in the
//previous chapter, the last entry in this array is the entry point for execution in the abcFile.

//The value of method_body_count is the number of entries in the method_body array. Each method_body

//entry consists of a variable length method_body_info structure which contains the instructions for an
//individual method or function.
package zero.swf.avm2{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import zero.BytesAndStr16;

	public class ABCFile{
		
		public var minor_version:int;
		public var major_version:int;
		public var integerV:Vector.<int>;
		public var uintegerV:Vector.<int>;
		public var doubleV:Vector.<Number>;
		private var stringHexV:Vector.<String>;
		
		public var stringV:Vector.<String>;
		private var stringBytesArr:Array;//20131205
		
		public var namespace_infoV:Vector.<Namespace_info>;
		public var ns_set_infoV:Vector.<Ns_set_info>;
		public var multiname_infoV:Vector.<Multiname_info>;
		public var method_infoV:Vector.<Method_info>;
		public var metadata_infoV:Vector.<Metadata_info>;
		public var instance_infoV:Vector.<Instance_info>;
		public var class_infoV:Vector.<Class_info>;
		public var script_infoV:Vector.<Script_info>;
		public var method_body_infoV:Vector.<Method_body_info>;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			minor_version=data[offset++]|(data[offset++]<<8);
			
			major_version=data[offset++]|(data[offset++]<<8);
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				integerV=new Vector.<int>(count);
				for(var i:int=1;i<count;i++){
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{integerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{integerV[i]=data[offset++];}
				}
			}else{
				integerV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				uintegerV=new Vector.<int>(count);
				for(i=1;i<count;i++){
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{uintegerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{uintegerV[i]=data[offset++];}
				}
			}else{
				uintegerV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				doubleV=new Vector.<Number>(count);
				data.endian=Endian.LITTLE_ENDIAN;
				data.position=offset;
				for(i=1;i<count;i++){
					doubleV[i]=data.readDouble();
				}
				offset=data.position;
			}else{
				doubleV=null;
			}
			
			if(_initByDataOptions&&_initByDataOptions.ABCDataGetHexArr){
				stringHexV=new Vector.<String>();
			}else{
				stringHexV=null;
			}
			data.position=offset;
			stringV=Strings.read(data,stringHexV);
			offset=data.position;
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				namespace_infoV=new Vector.<Namespace_info>(count);
				for(i=1;i<count;i++){
					namespace_infoV[i]=new Namespace_info();
					offset=namespace_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				namespace_infoV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				ns_set_infoV=new Vector.<Ns_set_info>(count);
				for(i=1;i<count;i++){
					ns_set_infoV[i]=new Ns_set_info();
					offset=ns_set_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				ns_set_infoV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				multiname_infoV=new Vector.<Multiname_info>(count);
				for(i=1;i<count;i++){
					multiname_infoV[i]=new Multiname_info();
					offset=multiname_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				multiname_infoV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				method_infoV=new Vector.<Method_info>(count);
				for(i=0;i<count;i++){
					method_infoV[i]=new Method_info();
					offset=method_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				method_infoV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				metadata_infoV=new Vector.<Metadata_info>(count);
				for(i=0;i<count;i++){
					metadata_infoV[i]=new Metadata_info();
					offset=metadata_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				metadata_infoV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				instance_infoV=new Vector.<Instance_info>(count);
				for(i=0;i<count;i++){
					instance_infoV[i]=new Instance_info();
					offset=instance_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
				class_infoV=new Vector.<Class_info>(count);
				for(i=0;i<count;i++){
					class_infoV[i]=new Class_info();
					offset=class_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				instance_infoV=null;
				class_infoV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				script_infoV=new Vector.<Script_info>(count);
				for(i=0;i<count;i++){
					script_infoV[i]=new Script_info();
					offset=script_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				script_infoV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				method_body_infoV=new Vector.<Method_body_info>(count);
				for(i=0;i<count;i++){
					method_body_infoV[i]=new Method_body_info();
					offset=method_body_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				method_body_infoV=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			data[offset++]=minor_version;
			data[offset++]=minor_version>>8;
			
			data[offset++]=major_version;
			data[offset++]=major_version>>8;
			
			if(integerV){
				var count:int=integerV.length;
				if(count>1){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					for(var i:int=1;i<count;i++){
						var integer:int=integerV[i];
						if(integer>>>7){if(integer>>>14){if(integer>>>21){if(integer>>>28){data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=((integer>>>14)&0x7f)|0x80;data[offset++]=((integer>>>21)&0x7f)|0x80;data[offset++]=integer>>>28;}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=((integer>>>14)&0x7f)|0x80;data[offset++]=integer>>>21;}}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=integer>>>14;}}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=integer>>>7;}}else{data[offset++]=integer;}
					}
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(uintegerV){
				count=uintegerV.length;
				if(count>1){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					for(i=1;i<count;i++){
						var uinteger:int=uintegerV[i];
						if(uinteger>>>7){if(uinteger>>>14){if(uinteger>>>21){if(uinteger>>>28){data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=((uinteger>>>14)&0x7f)|0x80;data[offset++]=((uinteger>>>21)&0x7f)|0x80;data[offset++]=uinteger>>>28;}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=((uinteger>>>14)&0x7f)|0x80;data[offset++]=uinteger>>>21;}}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=uinteger>>>14;}}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=uinteger>>>7;}}else{data[offset++]=uinteger;}
					}
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(doubleV){
				count=doubleV.length;
				if(count>1){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.endian=Endian.LITTLE_ENDIAN;
					data.position=offset;
					for(i=1;i<count;i++){
						data.writeDouble(doubleV[i]);
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			data.position=offset;
			Strings.write(data,stringV,stringBytesArr);
			offset=data.position;
			
			if(namespace_infoV){
				count=namespace_infoV.length;
				if(count>1){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var namespace_info:Namespace_info in namespace_infoV){
						if(namespace_info){
							data.writeBytes(namespace_info.toData(_toDataOptions));
						}
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(ns_set_infoV){
				count=ns_set_infoV.length;
				if(count>1){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var ns_set_info:Ns_set_info in ns_set_infoV){
						if(ns_set_info){
							data.writeBytes(ns_set_info.toData(_toDataOptions));
						}
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(multiname_infoV){
				count=multiname_infoV.length;
				if(count>1){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var multiname_info:Multiname_info in multiname_infoV){
						if(multiname_info){
							data.writeBytes(multiname_info.toData(_toDataOptions));
						}
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(method_infoV){
				count=method_infoV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var method_info:Method_info in method_infoV){
						data.writeBytes(method_info.toData(_toDataOptions));
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(metadata_infoV){
				count=metadata_infoV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var metadata_info:Metadata_info in metadata_infoV){
						data.writeBytes(metadata_info.toData(_toDataOptions));
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(instance_infoV){
				count=instance_infoV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var instance_info:Instance_info in instance_infoV){
						data.writeBytes(instance_info.toData(_toDataOptions));
					}
					for each(var class_info:Class_info in class_infoV){
						data.writeBytes(class_info.toData(_toDataOptions));
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(script_infoV){
				count=script_infoV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var script_info:Script_info in script_infoV){
						data.writeBytes(script_info.toData(_toDataOptions));
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(method_body_infoV){
				count=method_body_infoV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var method_body_info:Method_body_info in method_body_infoV){
						data.writeBytes(method_body_info.toData(_toDataOptions));
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName} class="zero.swf.avm2.ABCFile"
				minor_version={minor_version}
				major_version={major_version}
			/>;
			
			if(integerV){
				var count:int=integerV.length;
				if(count>1){
					var childXML:XML=<integerV count={count}/>;
					for(var i:int=1;i<count;i++){
						childXML.appendChild(<integer id={i} value={integerV[i]}/>);
					}
					xml.appendChild(childXML);
				}
			}
			
			if(uintegerV){
				count=uintegerV.length;
				if(count>1){
					childXML=<uintegerV count={count}/>;
					for(i=1;i<count;i++){
						childXML.appendChild(<uinteger id={i} value={uintegerV[i]}/>);
					}
					xml.appendChild(childXML);
				}
			}
			
			if(doubleV){
				count=doubleV.length;
				if(count>1){
					childXML=<doubleV count={count}/>;
					for(i=1;i<count;i++){
						childXML.appendChild(<double id={i} value={doubleV[i]}/>);
					}
					xml.appendChild(childXML);
				}
			}
			
			if(stringV){
				count=stringV.length;
				if(count>1){
					childXML=<stringV count={count}/>;
					for(i=1;i<count;i++){
						var stringXML:XML=<string id={i} value={stringV[i]}/>;
						if(stringHexV){
							stringXML.@hex=stringHexV[i];
						}
						childXML.appendChild(stringXML);
					}
					xml.appendChild(childXML);
				}
			}
			
			if(namespace_infoV){
				count=namespace_infoV.length;
				if(count>1){
					childXML=<namespace_infoV count={count}/>;
					for(i=1;i<count;i++){
						var namespace_infoXML:XML=namespace_infoV[i].toXML("namespace_info",_toXMLOptions);
						namespace_infoXML.@id=i;
						childXML.appendChild(namespace_infoXML);
					}
					xml.appendChild(childXML);
				}
			}
			
			if(ns_set_infoV){
				count=ns_set_infoV.length;
				if(count>1){
					childXML=<ns_set_infoV count={count}/>;
					for(i=1;i<count;i++){
						var ns_set_infoXML:XML=ns_set_infoV[i].toXML("ns_set_info",_toXMLOptions);
						ns_set_infoXML.@id=i;
						childXML.appendChild(ns_set_infoXML);
					}
					xml.appendChild(childXML);
				}
			}
			
			if(multiname_infoV){
				count=multiname_infoV.length;
				if(count>1){
					childXML=<multiname_infoV count={count}/>;
					for(i=1;i<count;i++){
						var multiname_infoXML:XML=multiname_infoV[i].toXML("multiname_info",_toXMLOptions);
						multiname_infoXML.@id=i;
						childXML.appendChild(multiname_infoXML);
					}
					xml.appendChild(childXML);
				}
			}
			
			if(method_infoV){
				count=method_infoV.length;
				if(count){
					childXML=<method_infoV count={count}/>;
					for each(var method_info:Method_info in method_infoV){
						childXML.appendChild(method_info.toXML("method_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(metadata_infoV){
				count=metadata_infoV.length;
				if(count){
					childXML=<metadata_infoV count={count}/>;
					for each(var metadata_info:Metadata_info in metadata_infoV){
						childXML.appendChild(metadata_info.toXML("metadata_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(instance_infoV){
				count=instance_infoV.length;
				if(count){
					childXML=<instance_infoV count={count}/>;
					for each(var instance_info:Instance_info in instance_infoV){
						childXML.appendChild(instance_info.toXML("instance_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
					childXML=<class_infoV count={count}/>;
					for each(var class_info:Class_info in class_infoV){
						childXML.appendChild(class_info.toXML("class_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(script_infoV){
				count=script_infoV.length;
				if(count){
					childXML=<script_infoV count={count}/>;
					for each(var script_info:Script_info in script_infoV){
						childXML.appendChild(script_info.toXML("script_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(method_body_infoV){
				count=method_body_infoV.length;
				if(count){
					childXML=<method_body_infoV count={count}/>;
					for each(var method_body_info:Method_body_info in method_body_infoV){
						childXML.appendChild(method_body_info.toXML("method_body_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			minor_version=int(xml.@minor_version.toString());
			
			major_version=int(xml.@major_version.toString());
			
			var list:XMLList=xml.integerV.integer;
			var count:int=list.length();
			if(count){
				var i:int=0;
				integerV=new Vector.<int>(count+1);
				for each(var childXML:XML in list){
					integerV[++i]=int(childXML.@value.toString());
				}
			}else{
				integerV=null;
			}
			
			list=xml.uintegerV.uinteger;
			count=list.length();
			if(count){
				i=0;
				uintegerV=new Vector.<int>(count+1);
				for each(childXML in list){
					uintegerV[++i]=int(childXML.@value.toString());
				}
			}else{
				uintegerV=null;
			}
			
			list=xml.doubleV.double;
			count=list.length();
			if(count){
				i=0;
				doubleV=new Vector.<Number>(count+1);
				for each(childXML in list){
					doubleV[++i]=Number(childXML.@value.toString());
				}
			}else{
				doubleV=null;
			}
			
			stringHexV=null;
			stringBytesArr=null;
			list=xml.stringV.string;
			count=list.length();
			if(count){
				i=0;
				stringV=new Vector.<String>(count+1);
				for each(childXML in list){
					var valueXML:XML=childXML.@value[0];
					if(valueXML){
						stringV[++i]=valueXML.toString();
					}else{
						stringV[++i]="";
						if(stringBytesArr){
						}else{
							stringBytesArr=new Array();
						}
						stringBytesArr[i]=BytesAndStr16.str162bytes(childXML.@hex.toString());
					}
				}
			}else{
				stringV=null;
			}
			
			list=xml.namespace_infoV.namespace_info;
			count=list.length();
			if(count){
				i=0;
				namespace_infoV=new Vector.<Namespace_info>(count+1);
				for each(childXML in list){
					namespace_infoV[++i]=new Namespace_info();
					namespace_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				namespace_infoV=null;
			}
			
			list=xml.ns_set_infoV.ns_set_info;
			count=list.length();
			if(count){
				i=0;
				ns_set_infoV=new Vector.<Ns_set_info>(count+1);
				for each(childXML in list){
					ns_set_infoV[++i]=new Ns_set_info();
					ns_set_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				ns_set_infoV=null;
			}
			
			list=xml.multiname_infoV.multiname_info;
			count=list.length();
			if(count){
				i=0;
				multiname_infoV=new Vector.<Multiname_info>(count+1);
				for each(childXML in list){
					multiname_infoV[++i]=new Multiname_info();
					multiname_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				multiname_infoV=null;
			}
			
			list=xml.method_infoV.method_info;
			count=list.length();
			if(count){
				i=-1;
				method_infoV=new Vector.<Method_info>(count);
				for each(childXML in list){
					method_infoV[++i]=new Method_info();
					method_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				method_infoV=null;
			}
			
			list=xml.metadata_infoV.metadata_info;
			count=list.length();
			if(count){
				i=-1;
				metadata_infoV=new Vector.<Metadata_info>(count);
				for each(childXML in list){
					metadata_infoV[++i]=new Metadata_info();
					metadata_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				metadata_infoV=null;
			}
			
			list=xml.instance_infoV.instance_info;
			count=list.length();
			if(count){
				i=-1;
				instance_infoV=new Vector.<Instance_info>(count);
				for each(childXML in list){
					instance_infoV[++i]=new Instance_info();
					instance_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
				list=xml.class_infoV.class_info;
				i=-1;
				class_infoV=new Vector.<Class_info>(count);
				for each(childXML in list){
					class_infoV[++i]=new Class_info();
					class_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				instance_infoV=null;
				class_infoV=null;
			}
			
			list=xml.script_infoV.script_info;
			count=list.length();
			if(count){
				i=-1;
				script_infoV=new Vector.<Script_info>(count);
				for each(childXML in list){
					script_infoV[++i]=new Script_info();
					script_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				script_infoV=null;
			}
			
			list=xml.method_body_infoV.method_body_info;
			count=list.length();
			if(count){
				i=-1;
				method_body_infoV=new Vector.<Method_body_info>(count);
				for each(childXML in list){
					method_body_infoV[++i]=new Method_body_info();
					method_body_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				method_body_infoV=null;
			}
			
		}
		
	}
}
