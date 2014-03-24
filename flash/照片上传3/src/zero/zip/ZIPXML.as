/***
ZIPXML
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月22日 13:23:24
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zip{
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	
	public class ZIPXML{
		
		/**
		 * 
		 * 尝试把 zip 数据解析成 xml
		 * @param data zip 数据
		 * @param src 不输出 value，代之以 src
		 * 
		 */		
		public static function zip2xml(
			data:ByteArray,
			file_name_charset:String="gb2312",
			comment_charset:String="gb2312",
			src:String=""
		):XML{
			var endOffset:int=data.length;
			var offset:int=0;
			var xml:XML=<zip length={data.length}/>;
			var rest:Array=new Array();
			while(offset<endOffset){
				if(data[offset]==0x50){
					if(data[offset+1]==0x4b){
						if(
							data[offset+2]==0x01
							&&
							data[offset+3]==0x02
						){
							if(rest.length){
								if(src){
									xml.appendChild(<rest offset={offset-rest.length} length={rest.length} src={src}/>);
								}else{
									xml.appendChild(<rest offset={offset-rest.length} length={rest.length} value={rest}/>);
								}
								rest.length=0;
							}
							blockXML=<block
								offset={offset}
								signature="0x504b0102"
								version_made_by={"0x"+BytesAndStr16._16V[data[offset+5]]+BytesAndStr16._16V[data[offset+4]]}
								version_needed_to_extract={"0x"+BytesAndStr16._16V[data[offset+7]]+BytesAndStr16._16V[data[offset+6]]}
								general_purpose_bit_flag={"0x"+BytesAndStr16._16V[data[offset+9]]+BytesAndStr16._16V[data[offset+8]]}
								compression_method={"0x"+BytesAndStr16._16V[data[offset+11]]+BytesAndStr16._16V[data[offset+10]]}
								date_and_time_fields={"0x"+BytesAndStr16._16V[data[offset+15]]+BytesAndStr16._16V[data[offset+14]]+BytesAndStr16._16V[data[offset+13]]+BytesAndStr16._16V[data[offset+12]]}
								crc32={"0x"+BytesAndStr16._16V[data[offset+19]]+BytesAndStr16._16V[data[offset+18]]+BytesAndStr16._16V[data[offset+17]]+BytesAndStr16._16V[data[offset+16]]}
								compressed_size={"0x"+BytesAndStr16._16V[data[offset+23]]+BytesAndStr16._16V[data[offset+22]]+BytesAndStr16._16V[data[offset+21]]+BytesAndStr16._16V[data[offset+20]]}
								uncompressed_size={"0x"+BytesAndStr16._16V[data[offset+27]]+BytesAndStr16._16V[data[offset+26]]+BytesAndStr16._16V[data[offset+25]]+BytesAndStr16._16V[data[offset+24]]}
								file_name_length={"0x"+BytesAndStr16._16V[data[offset+29]]+BytesAndStr16._16V[data[offset+28]]}
								extra_field_length={"0x"+BytesAndStr16._16V[data[offset+31]]+BytesAndStr16._16V[data[offset+30]]}
								file_comment_length={"0x"+BytesAndStr16._16V[data[offset+33]]+BytesAndStr16._16V[data[offset+32]]}
								disk_number_start={"0x"+BytesAndStr16._16V[data[offset+35]]+BytesAndStr16._16V[data[offset+34]]}
								internal_file_attributes={"0x"+BytesAndStr16._16V[data[offset+37]]+BytesAndStr16._16V[data[offset+36]]}
								external_file_attributes={"0x"+BytesAndStr16._16V[data[offset+41]]+BytesAndStr16._16V[data[offset+40]]+BytesAndStr16._16V[data[offset+39]]+BytesAndStr16._16V[data[offset+38]]}
								relative_offset_of_local_header={data[offset+42]|(data[offset+43]<<8)|(data[offset+44]<<16)|(data[offset+45]<<24)}
							/>;
							
							var file_name_length:int=data[offset+28]|(data[offset+29]<<8);
							var extra_field_length:int=data[offset+30]|(data[offset+31]<<8);
							var file_comment_length:int=data[offset+32]|(data[offset+33]<<8);
							
							offset+=46;
							
							if(file_name_length){
								data.position=offset;
								blockXML.appendChild(<file_name offset={offset} length={file_name_length} value={BytesAndStr16.bytes2str16(data,offset,file_name_length)} info={data.readMultiByte(file_name_length,file_name_charset)}/>);
								offset+=file_name_length;
							}
							if(extra_field_length){
								data.position=offset;
								if(src){
									blockXML.appendChild(<extra_field offset={offset} length={extra_field_length} src={src}/>);
								}else{
									blockXML.appendChild(<extra_field offset={offset} length={extra_field_length} value={BytesAndStr16.bytes2str16(data,offset,extra_field_length)}/>);
								}
								offset+=extra_field_length;
							}
							if(file_comment_length){
								data.position=offset;
								blockXML.appendChild(<file_comment offset={offset+46} length={file_comment_length} value={BytesAndStr16.bytes2str16(data,offset,file_comment_length)} info={data.readMultiByte(file_comment_length,comment_charset)}/>);
								offset+=file_comment_length;
							}
							xml.appendChild(blockXML);
							continue;
						}
						if(
							data[offset+2]==0x03
							&&
							data[offset+3]==0x04
						){
							if(rest.length){
								if(src){
									xml.appendChild(<rest offset={offset-rest.length} length={rest.length} src={src}/>);
								}else{
									xml.appendChild(<rest offset={offset-rest.length} length={rest.length} value={rest}/>);
								}
								rest.length=0;
							}
							
							var blockXML:XML=<block
								offset={offset}
								signature="0x504b0304"
								version_needed_to_extract={"0x"+BytesAndStr16._16V[data[offset+5]]+BytesAndStr16._16V[data[offset+4]]}
								general_purpose_bit_flag={"0x"+BytesAndStr16._16V[data[offset+7]]+BytesAndStr16._16V[data[offset+6]]}
								compression_method={"0x"+BytesAndStr16._16V[data[offset+9]]+BytesAndStr16._16V[data[offset+8]]}
								date_and_time_fields={"0x"+BytesAndStr16._16V[data[offset+13]]+BytesAndStr16._16V[data[offset+12]]+BytesAndStr16._16V[data[offset+11]]+BytesAndStr16._16V[data[offset+10]]}
								crc32={"0x"+BytesAndStr16._16V[data[offset+17]]+BytesAndStr16._16V[data[offset+16]]+BytesAndStr16._16V[data[offset+15]]+BytesAndStr16._16V[data[offset+14]]}
								compressed_size={"0x"+BytesAndStr16._16V[data[offset+21]]+BytesAndStr16._16V[data[offset+20]]+BytesAndStr16._16V[data[offset+19]]+BytesAndStr16._16V[data[offset+18]]}
								uncompressed_size={"0x"+BytesAndStr16._16V[data[offset+25]]+BytesAndStr16._16V[data[offset+24]]+BytesAndStr16._16V[data[offset+23]]+BytesAndStr16._16V[data[offset+22]]}
								file_name_length={"0x"+BytesAndStr16._16V[data[offset+27]]+BytesAndStr16._16V[data[offset+26]]}
								extra_field_length={"0x"+BytesAndStr16._16V[data[offset+29]]+BytesAndStr16._16V[data[offset+28]]}
							/>;
							
							var general_purpose_bit_flag:int=data[offset+6]|(data[offset+7]<<8);
							var compressed_size:int=data[offset+18]|(data[offset+19]<<8)|(data[offset+20]<<16)|(data[offset+21]<<24);
							file_name_length=data[offset+26]|(data[offset+27]<<8);
							extra_field_length=data[offset+28]|(data[offset+29]<<8);
							
							offset+=30;
							
							if(file_name_length){
								data.position=offset;
								blockXML.appendChild(<file_name offset={offset} length={file_name_length} value={BytesAndStr16.bytes2str16(data,offset,file_name_length)} info={data.readMultiByte(file_name_length,file_name_charset)}/>);
								offset+=file_name_length;
							}
							if(extra_field_length){
								if(src){
									blockXML.appendChild(<extra_field offset={offset} length={extra_field_length} src={src}/>);
								}else{
									blockXML.appendChild(<extra_field offset={offset} length={extra_field_length} value={BytesAndStr16.bytes2str16(data,offset,extra_field_length)}/>);
								}
								offset+=extra_field_length;
							}
							
							var data_compressed_size:int=-1;
							var scan_offset:int=offset;
							while(scan_offset<endOffset){
								if(data[scan_offset]==0x50){
									if(data[scan_offset+1]==0x4b){
										if(
											data[scan_offset+2]==0x01
											&&
											data[scan_offset+3]==0x02
											||
											data[scan_offset+2]==0x03
											&&
											data[scan_offset+3]==0x04
											||
											data[scan_offset+2]==0x05
											&&
											data[scan_offset+3]==0x06
										){
											if(general_purpose_bit_flag&0x08){
												//b.  data descriptor:
												//crc-32                          4 bytes
												//compressed size                 4 bytes
												//uncompressed size               4 bytes
												if(0x08074b50==(data[scan_offset-16]|(data[scan_offset-15]<<8)|(data[scan_offset-14]<<16)|(data[scan_offset-13]<<24))){
													data_compressed_size=scan_offset-offset-16;
												}else{
													data_compressed_size=scan_offset-offset-12;
												}
												//var crc32:uint=data[scan_offset-12]|(data[scan_offset-11]<<8)|(data[scan_offset-10]<<16)|(data[scan_offset-9]<<24);
												//compressed_size=data[scan_offset-8]|(data[scan_offset-7]<<8)|(data[scan_offset-6]<<16)|(data[scan_offset-5]<<24);
												//var uncompressed_size:int=data[scan_offset-4]|(data[scan_offset-3]<<8)|(data[scan_offset-2]<<16)|(data[scan_offset-1]<<24);
												if(data_compressed_size==(data[scan_offset-8]|(data[scan_offset-7]<<8)|(data[scan_offset-6]<<16)|(data[scan_offset-5]<<24))){
													break;
												}
											}else{
												data_compressed_size=scan_offset-offset;
												if(data_compressed_size==compressed_size){
													break;
												}
											}
											data_compressed_size=-1;
										}
									}
								}
								scan_offset++;
							}
							
							if(data_compressed_size>0){
								if(src){
									blockXML.appendChild(<data offset={offset} length={data_compressed_size} src={src}/>);
								}else{
									blockXML.appendChild(<data offset={offset} length={data_compressed_size} value={BytesAndStr16.bytes2str16(data,offset,data_compressed_size)}/>);
								}
								offset+=data_compressed_size;
							}
							
							if(general_purpose_bit_flag&0x08){
								//b.  data descriptor:
								//crc-32                          4 bytes
								//compressed size                 4 bytes
								//uncompressed size               4 bytes
								var crc32:String="0x"+BytesAndStr16._16V[data[offset+3]]+BytesAndStr16._16V[data[offset+2]]+BytesAndStr16._16V[data[offset+1]]+BytesAndStr16._16V[data[offset]];
								var dataDescriptorXML:XML=<data_descriptor/>;
								if(crc32=="0x08074b50"){
									dataDescriptorXML.@_08074b50="0x08074b50";
									dataDescriptorXML.@crc32="0x"+BytesAndStr16._16V[data[offset+7]]+BytesAndStr16._16V[data[offset+6]]+BytesAndStr16._16V[data[offset+5]]+BytesAndStr16._16V[data[offset+4]];
									offset+=8;
								}else{
									dataDescriptorXML.@crc32=crc32;
									offset+=4;
								}
								dataDescriptorXML.@compressed_size="0x"+BytesAndStr16._16V[data[offset+3]]+BytesAndStr16._16V[data[offset+2]]+BytesAndStr16._16V[data[offset+1]]+BytesAndStr16._16V[data[offset]];
								dataDescriptorXML.@uncompressed_size="0x"+BytesAndStr16._16V[data[offset+7]]+BytesAndStr16._16V[data[offset+6]]+BytesAndStr16._16V[data[offset+5]]+BytesAndStr16._16V[data[offset+4]];
								offset+=8;
								blockXML.appendChild(dataDescriptorXML);
							}
							
							xml.appendChild(blockXML);
							continue;
						}
						if(
							data[offset+2]==0x05
							&&
							data[offset+3]==0x06
						){
							if(rest.length){
								if(src){
									xml.appendChild(<rest offset={offset-rest.length} length={rest.length} src={src}/>);
								}else{
									xml.appendChild(<rest offset={offset-rest.length} length={rest.length} value={rest}/>);
								}
								rest.length=0;
							}
							
							blockXML=<block
								offset={offset}
								signature="0x504b0506"
								number_of_this_disk={"0x"+BytesAndStr16._16V[data[offset+5]]+BytesAndStr16._16V[data[offset+4]]}
								number_of_the_disk_with_the_start_of_the_central_directory={"0x"+BytesAndStr16._16V[data[offset+7]]+BytesAndStr16._16V[data[offset+6]]}
								total_number_of_entries_in_the_central_dir_on_this_disk={"0x"+BytesAndStr16._16V[data[offset+9]]+BytesAndStr16._16V[data[offset+8]]}
								total_number_of_entries_in_the_central_dir={"0x"+BytesAndStr16._16V[data[offset+11]]+BytesAndStr16._16V[data[offset+10]]}
								size_of_the_central_directory={"0x"+BytesAndStr16._16V[data[offset+15]]+BytesAndStr16._16V[data[offset+14]]+BytesAndStr16._16V[data[offset+13]]+BytesAndStr16._16V[data[offset+12]]}
								offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number={"0x"+BytesAndStr16._16V[data[offset+19]]+BytesAndStr16._16V[data[offset+18]]+BytesAndStr16._16V[data[offset+17]]+BytesAndStr16._16V[data[offset+16]]}
								zipfile_comment_length={"0x"+BytesAndStr16._16V[data[offset+21]]+BytesAndStr16._16V[data[offset+20]]}
							/>
							
							var zipfile_comment_length:int=data[offset+20]|(data[offset+21]<<8);
							
							offset+=22;
							if(zipfile_comment_length){
								data.position=offset;
								blockXML.appendChild(<zipfile_comment offset={offset} length={zipfile_comment_length} value={BytesAndStr16.bytes2str16(data,offset,zipfile_comment_length)} info={data.readMultiByte(zipfile_comment_length,comment_charset)}/>);
								offset+=zipfile_comment_length;
							}
							xml.appendChild(blockXML);
							continue;
						}
					}
				}
				rest.push(BytesAndStr16._16V[data[offset]]);
				offset++;
			}
			if(rest.length){
				if(src){
					xml.appendChild(<rest offset={offset-rest.length} length={rest.length} src={src}/>);
				}else{
					xml.appendChild(<rest offset={offset-rest.length} length={rest.length} value={rest}/>);
				}
				rest.length=0;
			}
			
			return xml;
		}
		
		/**
		 * 
		 * 尝试把 xml 编码成 zip
		 * @param repair 如果为 false，将严格按照 xml 生成 zip；如果为 true，将尝试按标准 zip 格式编码
		 * 
		 */		
		public static function xml2zip(xml:XML,repair:Boolean=false):ByteArray{
			return null;
		}
	}
}