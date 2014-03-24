/***
ZipFile
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月20日 09:53:24
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zip{
	import flash.utils.ByteArray;
	//import flash.utils.CompressionAlgorithm;
	
	import zero.BytesAndStr16;
	import zero.codec.MyCRC32;
	import zero.codec.DOSTime;
	
	/**
	 * 
	 * zip包里的单个文件
	 * 
	 */	
	public class ZipFile{
		
		private var version_made_by:int;
		private var version_needed_to_extract:int;
		private var general_purpose_bit_flag:int;
		private var compression_method:int;
		private var date_and_time_fields:int;
		private var crc32:uint;
		private var compressed_size:int;
		private var uncompressed_size:int;
		private var disk_number_start:int;
		private var internal_file_attributes:int;
		private var external_file_attributes:int;
		internal var relative_offset_of_local_header:int;
		private var file_name:ByteArray;
		private var file_name_charset:String;
		private var extra_field1:ByteArray;
		private var extra_field2:ByteArray;
		private var file_data0:ByteArray;
		private var file_data:ByteArray;
		private var file_comment:ByteArray;
		private var file_comment_charset:String;
		
		private var _08074b50:Boolean;//发现于 .swc 文件
		
		/**
		 * 
		 * 文件名，可能需要在 zip.decode() 时正确的传入 file_name_charset 才可以正确的获取和设置
		 * 
		 */		
		public function get name():String{
			if(file_name){
				if(file_name.length){
					file_name.position=0;
					return file_name.readMultiByte(file_name.length,file_name_charset);
				}
				file_name=null;
			}
			return "";
		}
		public function set name(_name:String):void{
			if(_name){
				file_name=new ByteArray();
				file_name.writeMultiByte(_name,file_name_charset);
			}else{
				file_name=null;
			}
		}
		
		/**
		 * 
		 * 文件是否目录，原理是判断文件名的最后一个字符是否“/”
		 * 
		 */		
		public function get isDirectory():Boolean{
			var _name:String=name;
			if(_name){
				return _name.lastIndexOf("/")==_name.length-1;
			}
			return false;
		}
		public function set isDirectory(_isDirectory:Boolean):void{
			var _name:String=name;
			if(_name){
				if(_name.lastIndexOf("/")==_name.length-1){
					if(_isDirectory){
						//
					}else{
						name=_name.substr(0,_name.length-1);
					}
				}else{
					if(_isDirectory){
						name=_name+"/";
					}else{
						//
					}
				}
			}else{
				if(_isDirectory){
					throw new Error('name 为 "" 时不允许 isDirectory=true');
				}
			}
		}
		
		/**
		 * 
		 * 文件的修改时间
		 * 
		 */		
		public function get date():Date{
			return DOSTime.decode(date_and_time_fields);
		}
		public function set date(_date:Date):void{
			date_and_time_fields=DOSTime.encode(_date);
		}
		
		/**
		 * 
		 * 文件数据
		 * 
		 */		
		public function get data():ByteArray{
			if(file_data){
				if(file_data.length){
					var _data:ByteArray=new ByteArray();
					_data.writeBytes(file_data);
					return _data;
				}
				file_data=null;
			}
			return new ByteArray();
		}
		public function set data(_data:ByteArray):void{
			general_purpose_bit_flag&=0xfffffff0;//“很好”，“最好”神马的都转成“标准”
			//trace("general_purpose_bit_flag="+(0x10000+general_purpose_bit_flag).toString(2).substr(1));
			if(_data&&_data.length){
				file_data=new ByteArray();
				file_data.writeBytes(_data);
				file_data0=new ByteArray();
				file_data0.writeBytes(file_data);
				//file_data0.compress(CompressionAlgorithm.DEFLATE);//尝试压缩
				file_data0.deflate();
				if(file_data0.length<file_data.length){//如果压缩后比原数据要小
					compression_method=8;
				}else{
					file_data0=file_data;
					compression_method=0;
				}
				//trace("compression_method="+compression_method);
				//trace("file_data0="+BytesAndStr16.bytes2str16(file_data0,0,file_data0.length));
				crc32=MyCRC32.crc32(file_data);
			}else{
				file_data0=null;
				file_data=null;
				compression_method=0;
				crc32=0x00000000;
			}
		}
		
		/**
		 * 
		 * 文件注释，可能需要在 zip.decode() 时正确的传入 comment_charset 才可以正确的获取和设置
		 * 
		 */		
		public function get comment():String{
			if(file_comment){
				if(file_comment.length){
					file_comment.position=0;
					return file_comment.readMultiByte(file_comment.length,file_comment_charset);
				}
				file_comment=null;
			}
			return "";
		}
		public function set comment(_comment:String):void{
			if(_comment){
				file_comment=new ByteArray();
				file_comment.writeMultiByte(_comment,file_comment_charset);
			}else{
				file_comment=null;
			}
		}
		
		public function ZipFile(_file_name_charset:String="gb2312",_file_comment_charset:String="gb2312"){
			version_made_by=0x0014;
			version_needed_to_extract=0x0014;
			general_purpose_bit_flag=0x0000;
			disk_number_start=0;
			internal_file_attributes=0x0000;
			external_file_attributes=0x00000000;
			file_name_charset=_file_name_charset;
			file_comment_charset=_file_comment_charset;
			date=new Date();
		}
		
		/**
		 *清除此 zipFile 以便回收
		 * 
		 */		
		public function clear():void{
			file_name=null;
			extra_field1=null;
			extra_field2=null;
			file_data0=null;
			file_data=null;
			file_comment=null;
		}
		
		internal function initByCentralDirectoryData(zipData:ByteArray,offset:int):int{
			//c.  central directory structure:
			//[file header] . . .  end of central dir record
			//file header:
			//central file header signature   4 bytes  (0x02014b50)
			//version made by                 2 bytes
			//version needed to extract       2 bytes
			//general purpose bit flag        2 bytes
			//compression method              2 bytes
			//last mod file time              2 bytes
			//last mod file date              2 bytes
			//crc-32                          4 bytes
			//compressed size                 4 bytes
			//uncompressed size               4 bytes
			//filename length                 2 bytes
			//extra field length              2 bytes
			//file comment length             2 bytes
			//disk number start               2 bytes
			//internal file attributes        2 bytes
			//external file attributes        4 bytes
			//relative offset of local header 4 bytes
			//filename (variable size)
			//extra field (variable size)
			//file comment (variable size)
			
			version_made_by=zipData[offset++]|(zipData[offset++]<<8);
			//trace("version_made_by="+version_made_by);
			//version made by (2 bytes)
			//the upper byte indicates the compatibility of the file
			//attribute information.  if the external file attributes 
			//are compatible with ms-dos and can be read by pkzip for 
			//dos version 2.04g then this value will be zero.  if these 
			//attributes are not compatible, then this value will identify 
			//the host system on which the attributes are compatible.
			//	software can use this information to determine the line 
			//record format for text files etc.  the current
			//mappings are:
			//0 - ms-dos and os/2 (fat / vfat / fat32 file systems)
			//1 - amiga                     2 - vax/vms
			//3 - unix                      4 - vm/cms
			//5 - atari st                  6 - os/2 h.p.f.s.
			//7 - macintosh                 8 - z-system
			//9 - cp/m                     10 - windows ntfs
			//11 thru 255 - unused
			//the lower byte indicates the version number of the
			//software used to encode the file.  the value/10
			//indicates the major version number, and the value
			//mod 10 is the minor version number.
			
			version_needed_to_extract=zipData[offset++]|(zipData[offset++]<<8);
			//trace("version_needed_to_extract="+version_needed_to_extract);
			
			general_purpose_bit_flag=zipData[offset++]|(zipData[offset++]<<8);
			//trace("general_purpose_bit_flag="+(0x10000+general_purpose_bit_flag).toString(2).substr(1));
			//general purpose bit flag: (2 bytes)
			
			//bit 0: if set, indicates that the file is encrypted.
			
			//(for method 6 - imploding)
			//bit 1: 	if the compression method used was type 6,
			//			imploding, then this bit, if set, indicates
			//			an 8k sliding dictionary was used.  if clear,
			//			then a 4k sliding dictionary was used.
			//bit 2: 	if the compression method used was type 6,
			//			imploding, then this bit, if set, indicates
			//			an 3 shannon-fano trees were used to encode the
			//			sliding dictionary output.  if clear, then 2
			//			shannon-fano trees were used.
			
			//(for method 8 - deflating)
			//bit 2  bit 1
			//0      0    	normal (-en) compression option was used.
			//0      1    	maximum (-ex) compression option was used.
			//1      0    	fast (-ef) compression option was used.
			//1      1    	super fast (-es) compression option was used.
			
			//note: 	bits 1 and 2 are undefined if the compression
			//			method is any other.
			
			//bit 3: 	if this bit is set, the fields crc-32, compressed size
			//			and uncompressed size are set to zero in the local
			//			header.  the correct values are put in the data descriptor
			//			immediately following the compressed data.  (note: pkzip
			//			version 2.04g for dos only recognizes this bit for method 8
			//			compression, newer versions of pkzip recognize this bit
			//			for any compression method.)
			
			//the upper three bits are reserved and used internally
			//by the software when processing the zipfile.  the
			//remaining bits are unused.
			
			compression_method=zipData[offset++]|(zipData[offset++]<<8);
			//trace("compression_method="+compression_method);
			//compression method: (2 bytes)
			//(see accompanying documentation for algorithm descriptions)
			//0 - the file is stored (no compression)
			//1 - the file is shrunk
			//2 - the file is reduced with compression factor 1
			//3 - the file is reduced with compression factor 2
			//4 - the file is reduced with compression factor 3
			//5 - the file is reduced with compression factor 4
			//6 - the file is imploded
			//7 - reserved for tokenizing compression algorithm
			//8 - the file is deflated
			//9 - reserved for enhanced deflating
			//10 - pkware date compression library imploding
			
			date_and_time_fields=zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24);
			//trace("date_and_time_fields="+date_and_time_fields);
			//date and time fields: (2 bytes each)
			//the date and time are encoded in standard ms-dos format.
			//if input came from standard input, the date and time are
			//those at which compression was started for this data.
			
			crc32=zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24);
			//crc-32: (4 bytes)
			//the crc-32 algorithm was generously contributed by
			//david schwaderer and can be found in his excellent
			//book "c programmers guide to netbios" published by
			//howard w. sams & co. inc.  the 'magic number' for
			//the crc is 0xdebb20e3.  the proper crc pre and post
			//conditioning is used, meaning that the crc register
			//is pre-conditioned with all ones (a starting value
			//of 0xffffffff) and the value is post-conditioned by
			//taking the one's complement of the crc residual.
			//if bit 3 of the general purpose flag is set, this
			//field is set to zero in the local header and the correct
			//value is put in the data descriptor and in the central
			//directory.
			
			compressed_size=zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24);
			uncompressed_size=zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24);
			//compressed size: (4 bytes)
			//uncompressed size: (4 bytes)
			//the size of the file compressed and uncompressed,
			//respectively.  if bit 3 of the general purpose bit flag
			//is set, these fields are set to zero in the local header
			//and the correct values are put in the data descriptor and
			//in the central directory.
			
			//trace("crc32="+(0x100000000+uint(crc32)).toString(16).substr(1));
			//trace((0x100000000+uint(data_crc32)).toString(16).substr(1));
			//trace("compressed_size="+compressed_size,"uncompressed_size="+uncompressed_size);
			
			var file_name_length:int=zipData[offset++]|(zipData[offset++]<<8);
			var extra_field_length:int=zipData[offset++]|(zipData[offset++]<<8);
			var file_comment_length:int=zipData[offset++]|(zipData[offset++]<<8);
			//filename length: (2 bytes)
			//extra field length: (2 bytes)
			//file comment length: (2 bytes)
			//the length of the filename, extra field, and comment
			//fields respectively.  the combined length of any
			//directory record and these three fields should not
			//generally exceed 65,535 bytes.  if input came from standard
			//input, the filename length is set to zero.
			
			disk_number_start=zipData[offset++]|(zipData[offset++]<<8);
			internal_file_attributes=zipData[offset++]|(zipData[offset++]<<8);
			external_file_attributes=zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24);
			relative_offset_of_local_header=zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24);
			//disk number start: (2 bytes)
			//	the number of the disk on which this file begins.
			//internal file attributes: (2 bytes)
			//	the lowest bit of this field indicates, if set, that
			//	the file is apparently an ascii or text file.  if not
			//	set, that the file apparently contains binary data.
			//	the remaining bits are unused in version 1.0.
			//external file attributes: (4 bytes)
			//	the mapping of the external attributes is
			//	host-system dependent (see 'version made by').  for
			//	ms-dos, the low order byte is the ms-dos directory
			//	attribute byte.  if input came from standard input, this
			//	field is set to zero.
			//relative offset of local header: (4 bytes)
			//	this is the offset from the start of the first disk on
			//	which this file appears, to where the local header should
			//	be found.
			
			//trace("disk_number_start="+disk_number_start);
			//trace("internal_file_attributes="+internal_file_attributes);
			//trace("external_file_attributes="+external_file_attributes);
			//trace("relative_offset_of_local_header="+relative_offset_of_local_header);
			
			if(file_name_length){
				file_name=new ByteArray();
				file_name.writeBytes(zipData,offset,file_name_length);
				offset+=file_name_length;
			}else{
				file_name=null;
			}
			//filename: (variable)
			//	the name of the file, with optional relative path.
			//	the path stored should not contain a drive or
			//	device letter, or a leading slash.  all slashes
			//	should be forward slashes '/' as opposed to
			//	backwards slashes '\' for compatibility with amiga
			//	and unix file systems etc.  if input came from standard
			//	input, there is no filename field.
			//文件名，必须是相对路径（不能包含盘符，第一个字符不能是斜杠），所有斜框必须是正斜扛（不能是反斜杠）；如果数据来源是从标准输入，则可以没有文件名。
			
			if(extra_field_length){
				//extra field: (variable)
				//
				//      this is for future expansion.  if additional information
				//      needs to be stored in the future, it should be stored
				//      here.  earlier versions of the software can then safely
				//      skip this file, and find the next file or header.  this
				//      field will be 0 length in version 1.0.
				//
				//      in order to allow different programs and different types
				//      of information to be stored in the 'extra' field in .zip
				//      files, the following structure should be used for all
				//      programs storing data in this field:
				//
				//      header1+data1 + header2+data2 . . .
				//
				//      each header should consist of:
				//
				//        header id - 2 bytes
				//        data size - 2 bytes
				//
				//      note: all fields stored in intel low-byte/high-byte order.
				//
				//      the header id field indicates the type of data that is in
				//      the following data block.
				//
				//      header id's of 0 thru 31 are reserved for use by pkware.
				//      the remaining id's can be used by third party vendors for
				//      proprietary usage.
				//
				//      the current header id mappings defined by pkware are:
				//
				//      0x0007        av info
				//      0x0009        os/2
				//      0x000c        vax/vms
				//      0x000d        reserved for unix
				//
				//      several third party mappings commonly used are:
				//
				//      0x4b46        fwkcs md5 (see below)
				//      0x07c8        macintosh
				//      0x4341        acorn/sparkfs 
				//      0x4453        windows nt security descriptor (binary acl)
				//      0x4704        vm/cms
				//      0x470f        mvs
				//      0x4c41        os/2 access control list (text acl)
				//      0x4d49        info-zip vms (vax or alpha)
				//      0x5455        extended timestamp
				//      0x5855        info-zip unix (original, also os/2, nt, etc)
				//      0x6542        beos/bebox
				//      0x756e        asi unix
				//      0x7855        info-zip unix (new)
				//      0xfd4a        sms/qdos
				//
				//      the data size field indicates the size of the following
				//      data block. programs can use this value to skip to the
				//      next header block, passing over any data blocks that are
				//      not of interest.
				//
				//      note: as stated above, the size of the entire .zip file
				//            header, including the filename, comment, and extra
				//            field should not exceed 64k in size.
				//
				//      in case two different programs should appropriate the same
				//      header id value, it is strongly recommended that each
				//      program place a unique signature of at least two bytes in
				//      size (and preferably 4 bytes or bigger) at the start of
				//      each data area.  every program should verify that its
				//      unique signature is present, in addition to the header id
				//      value being correct, before assuming that it is a block of
				//      known type.
				//
				//     -os/2 extra field:
				//
				//      the following is the layout of the os/2 attributes "extra" block.
				//      (last revision  09/05/95)
				//
				//      note: all fields stored in intel low-byte/high-byte order.
				//
				//      value         size            description
				//      -----         ----            -----------
				//(os/2)  0x0009        short           tag for this "extra" block type
				//      tsize         short           size for the following data block
				//      bsize         long            uncompressed block size
				//      ctype         short           compression type
				//      eacrc         long            crc value for uncompress block
				//      (var)         variable        compressed block
				//
				//    the os/2 extended attribute structure (fea2list) is compressed and then stored
				//    in it's entirety within this structure.  there will only ever be one "block" of data
				//    in varfields[].
				//
				//     -vax/vms extra field:
				//
				//      the following is the layout of the vax/vms attributes "extra"
				//      block.  (last revision 12/17/91)
				//
				//      note: all fields stored in intel low-byte/high-byte order.
				//
				//      value         size            description
				//      -----         ----            -----------
				//(vms)   0x000c        short           tag for this "extra" block type
				//      tsize         short           size of the total "extra" block
				//      crc           long            32-bit crc for remainder of the block
				//      tag1          short           vms attribute tag value #1
				//      size1         short           size of attribute #1, in bytes
				//      (var.)        size1           attribute #1 data
				//      .
				//      .
				//      .
				//      tagn          short           vms attribute tage value #n
				//      sizen         short           size of attribute #n, in bytes
				//      (var.)        sizen           attribute #n data
				//
				//      rules:
				//
				//      1. there will be one or more of attributes present, which will
				//         each be preceded by the above tagx & sizex values.  these
				//         values are identical to the atr$c_xxxx and atr$s_xxxx constants
				//         which are defined in atr.h under vms c.  neither of these values
				//         will ever be zero.
				//
				//      2. no word alignment or padding is performed.
				//
				//      3. a well-behaved pkzip/vms program should never produce more than
				//         one sub-block with the same tagx value.  also, there will never
				//         be more than one "extra" block of type 0x000c in a particular
				//         directory record.
				//
				//      - fwkcs md5 extra field:
				//
				//      the fwkcs contents_signature system, used in
				//      automatically identifying files independent of filename,
				//      optionally adds and uses an extra field to support the
				//      rapid creation of an enhanced contents_signature:
				//
				//          header id = 0x4b46
				//          data size = 0x0013
				//          preface   = 'm','d','5'
				//          followed by 16 bytes containing the uncompressed
				//              file's 128_bit md5 hash(1), low byte first.
				//
				//      when fwkcs revises a zipfile central directory to add
				//      this extra field for a file, it also replaces the
				//      central directory entry for that file's uncompressed
				//      filelength with a measured value.
				//
				//      fwkcs provides an option to strip this extra field, if
				//      present, from a zipfile central directory. in adding
				//      this extra field, fwkcs preserves zipfile authenticity
				//      verification; if stripping this extra field, fwkcs
				//      preserves all versions of av through pkzip version 2.04g.
				//
				//      fwkcs, and fwkcs contents_signature system, are
				//      trademarks of frederick w. kantor.
				//
				//      (1) r. rivest, rfc1321.txt, mit laboratory for computer
				//          science and rsa data security, inc., april 1992.
				//          ll.76-77: "the md5 algorithm is being placed in the
				//          public domain for review and possible adoption as a
				//          standard."
				
				extra_field1=new ByteArray();
				extra_field1.writeBytes(zipData,offset,extra_field_length);
				offset+=extra_field_length;
			}else{
				extra_field1=null;
			}
			if(file_comment_length){
				file_comment=new ByteArray();
				file_comment.writeBytes(zipData,file_comment_length);
				//file comment: (variable)
				//	the comment for this file.
				offset+=file_comment_length;
			}else{
				file_comment=null;
			}
			return offset;
		}
		private function outputError(msg:String,_throw:Boolean):void{
			msg=name+"，"+msg;
			if(_throw){
				throw new Error(msg);
			}
			trace(msg);
		}
		internal function initByZipData(zipData:ByteArray,offset:int,strict_mode:Boolean):int{
			//a.  local file header:
			//local file header signature     4 bytes  (0x04034b50)
			//version needed to extract       2 bytes
			//general purpose bit flag        2 bytes
			//compression method              2 bytes
			//last mod file time              2 bytes
			//last mod file date              2 bytes
			//crc-32                          4 bytes
			//compressed size                 4 bytes
			//uncompressed size               4 bytes
			//filename length                 2 bytes
			//extra field length              2 bytes
			//filename (variable size)
			//extra field (variable size)
			//b.  data descriptor:
			//crc-32                          4 bytes
			//compressed size                 4 bytes
			//uncompressed size               4 bytes
			
			if(version_needed_to_extract==(zipData[offset++]|(zipData[offset++]<<8))){
			}else{
				outputError("version_needed_to_extract 不一致",strict_mode);
			}
			//version needed to extract (2 bytes)
			//the minimum software version needed to extract the
			//file, mapped as above.
			
			if(general_purpose_bit_flag==(zipData[offset++]|(zipData[offset++]<<8))){
			}else{
				outputError("general_purpose_bit_flag 不一致",strict_mode);
			}
			
			if(compression_method==(zipData[offset++]|(zipData[offset++]<<8))){
			}else{
				outputError("compression_method 不一致",strict_mode);
			}
			
			if(date_and_time_fields==(zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24))){
			}else{
				outputError("date_and_time_fields 不一致",strict_mode);
			}
				
			if(general_purpose_bit_flag&0x08){
				offset+=12;
			}else{
				
				//trace("crc32="+(0x100000000+uint(crc32)).toString(16).substr(1));
				//trace(BytesAndStr16.bytes2str16(zipData,offset,12));
				
				if(crc32==uint((zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24)))){
				}else{
					outputError("crc32 不一致",strict_mode);
				}
				
				if(compressed_size==(zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24))){
				}else{
					outputError("compressed_size 不一致",strict_mode);
				}
				
				if(uncompressed_size==(zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24))){
				}else{
					outputError("uncompressed_size 不一致",strict_mode);
				}
			}
			var file_name_length:int=zipData[offset++]|(zipData[offset++]<<8);
			var extra_field_length:int=zipData[offset++]|(zipData[offset++]<<8);
			if(file_name_length){
				if(
					BytesAndStr16.bytes2str16(file_name,0,file_name.length)
					==
					BytesAndStr16.bytes2str16(zipData,offset,file_name_length)
				){
				}else{
					zipData.position=offset;
					outputError("file_name 不一致（"+zipData.readMultiByte(file_name_length,file_name_charset)+"）",strict_mode);
				}
				offset+=file_name_length;
			}else{
				if(file_name){
					outputError("file_name 不一致",strict_mode);
				}
			}
			
			if(extra_field_length){
				extra_field2=new ByteArray();
				extra_field2.writeBytes(zipData,offset,extra_field_length);
				offset+=extra_field_length;
			}else{
				extra_field2=null;
			}
			if(compressed_size){
				file_data0=new ByteArray();
				file_data0.writeBytes(zipData,offset,compressed_size);
				switch(compression_method){
					case 0:
						file_data=file_data0;
					break;
					case 8:
						file_data=new ByteArray();
						file_data.writeBytes(file_data0);
						//file_data.uncompress(CompressionAlgorithm.DEFLATE);
						file_data.inflate();
					break;
					default:
						throw new Error("暂不支持的压缩方式："+compression_method);
					break;
				}
				var data_crc32:uint=MyCRC32.crc32(file_data);
				offset+=compressed_size;
			}else{
				file_data0=null;
				file_data=null;
				data_crc32=0x00000000;
			}
			
			if(general_purpose_bit_flag&0x08){
				var _crc32:uint=zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24);
				if(_crc32==0x08074b50){//发现于 .swc 文件
					_08074b50=true;
					_crc32=zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24);
				}else{
					_08074b50=false;
				}
				
				if(crc32==_crc32){
				}else{
					outputError("crc32 不一致",strict_mode);
				}
				
				if(compressed_size==(zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24))){
				}else{
					outputError("compressed_size 不一致",strict_mode);
				}
				
				if(uncompressed_size==(zipData[offset++]|(zipData[offset++]<<8)|(zipData[offset++]<<16)|(zipData[offset++]<<24))){
				}else{
					outputError("uncompressed_size 不一致",strict_mode);
				}
			}
			
			if(crc32==data_crc32){
			}else{
				outputError("crc32 和 data_crc32 不一致",strict_mode);
			}
			
			return offset;
		}
		
		internal function toZipDataArr(
			relative_offset_of_local_header:int
		):Array{
			
			var localFileData:ByteArray=new ByteArray();
			var centralFileData:ByteArray=new ByteArray();
			
			//a.  local file header:
			//local file header signature     4 bytes  (0x04034b50)
			//version needed to extract       2 bytes
			//general purpose bit flag        2 bytes
			//compression method              2 bytes
			//last mod file time              2 bytes
			//last mod file date              2 bytes
			//crc-32                          4 bytes
			//compressed size                 4 bytes
			//uncompressed size               4 bytes
			//filename length                 2 bytes
			//extra field length              2 bytes
			//filename (variable size)
			//extra field (variable size)
			//b.  data descriptor:
			//crc-32                          4 bytes
			//compressed size                 4 bytes
			//uncompressed size               4 bytes
			
			//c.  central directory structure:
			//[file header] . . .  end of central dir record
			//file header:
			//central file header signature   4 bytes  (0x02014b50)
			//version made by                 2 bytes
			//version needed to extract       2 bytes
			//general purpose bit flag        2 bytes
			//compression method              2 bytes
			//last mod file time              2 bytes
			//last mod file date              2 bytes
			//crc-32                          4 bytes
			//compressed size                 4 bytes
			//uncompressed size               4 bytes
			//filename length                 2 bytes
			//extra field length              2 bytes
			//file comment length             2 bytes
			//disk number start               2 bytes
			//internal file attributes        2 bytes
			//external file attributes        4 bytes
			//relative offset of local header 4 bytes
			//filename (variable size)
			//extra field (variable size)
			//file comment (variable size)
			
			//trace("version_made_by="+version_made_by);
			centralFileData[0]=version_made_by;
			centralFileData[1]=version_made_by>>8;
			
			centralFileData[2]=localFileData[0]=version_needed_to_extract;
			centralFileData[3]=localFileData[1]=version_needed_to_extract>>8;
			
			centralFileData[4]=localFileData[2]=general_purpose_bit_flag;
			centralFileData[5]=localFileData[3]=general_purpose_bit_flag>>8;
			
			if(file_data&&file_data.length){
				var compressed_size:int=file_data0.length;
				var uncompressed_size:int=file_data.length;
			}else{
				compressed_size=0;
				uncompressed_size=0;
			}
			
			//trace("crc32="+(0x100000000+uint(crc32)).toString(16).substr(1));
			//trace("compression_method="+compression_method);
			
			centralFileData[6]=localFileData[4]=compression_method;
			centralFileData[7]=localFileData[5]=compression_method>>8;
			
			centralFileData[8]=localFileData[6]=date_and_time_fields;
			centralFileData[9]=localFileData[7]=date_and_time_fields>>8;
			centralFileData[10]=localFileData[8]=date_and_time_fields>>16;
			centralFileData[11]=localFileData[9]=date_and_time_fields>>24;
			
			if(general_purpose_bit_flag&0x08){
				
				localFileData[10]=0x00;
				localFileData[11]=0x00;
				localFileData[12]=0x00;
				localFileData[13]=0x00;
				
				localFileData[14]=0x00;
				localFileData[15]=0x00;
				localFileData[16]=0x00;
				localFileData[17]=0x00;
				
				localFileData[18]=0x00;
				localFileData[19]=0x00;
				localFileData[20]=0x00;
				localFileData[21]=0x00;
			}else{
				
				localFileData[10]=crc32;
				localFileData[11]=crc32>>8;
				localFileData[12]=crc32>>16;
				localFileData[13]=crc32>>24;
				
				localFileData[14]=compressed_size;
				localFileData[15]=compressed_size>>8;
				localFileData[16]=compressed_size>>16;
				localFileData[17]=compressed_size>>24;
				
				localFileData[18]=uncompressed_size;
				localFileData[19]=uncompressed_size>>8;
				localFileData[20]=uncompressed_size>>16;
				localFileData[21]=uncompressed_size>>24;
			}
			
			centralFileData[12]=crc32;
			centralFileData[13]=crc32>>8;
			centralFileData[14]=crc32>>16;
			centralFileData[15]=crc32>>24;
			
			centralFileData[16]=compressed_size;
			centralFileData[17]=compressed_size>>8;
			centralFileData[18]=compressed_size>>16;
			centralFileData[19]=compressed_size>>24;
			
			centralFileData[20]=uncompressed_size;
			centralFileData[21]=uncompressed_size>>8;
			centralFileData[22]=uncompressed_size>>16;
			centralFileData[23]=uncompressed_size>>24;
			
			if(file_name&&file_name.length){
				
				localFileData.position=26;
				localFileData.writeBytes(file_name);
				var offset:int=localFileData.length;
				
				centralFileData.position=42;
				centralFileData.writeBytes(file_name);
				var offset2:int=centralFileData.length;
				
				var file_name_length:int=offset-26;
				centralFileData[24]=localFileData[22]=file_name_length;
				centralFileData[25]=localFileData[23]=file_name_length>>8;
			}else{
				file_name=null;
				offset=26;
				offset2=42;
				centralFileData[24]=localFileData[22]=0x00;
				centralFileData[25]=localFileData[23]=0x00;
			}
			
			//extra_field2=new ByteArray();
			//extra_field2.writeMultiByte("我顶你个肺","gb2312");trace("测试 extra_field2");
			
			if(extra_field2&&extra_field2.length){
				localFileData.position=offset;
				localFileData.writeBytes(extra_field2);
				var extra_field_length:int=extra_field2.length;
				offset+=extra_field_length;
				localFileData[24]=extra_field_length;
				localFileData[25]=extra_field_length>>8;
			}else{
				extra_field2=null;
				localFileData[24]=0x00;
				localFileData[25]=0x00;
			}
			
			//extra_field1=new ByteArray();
			//extra_field1.writeMultiByte("我顶你个肺","gb2312");trace("测试 extra_field1");
			
			if(extra_field1&&extra_field1.length){
				centralFileData.position=offset2;
				centralFileData.writeBytes(extra_field1);
				extra_field_length=extra_field1.length;
				offset2+=extra_field_length;
				centralFileData[26]=extra_field_length;
				centralFileData[27]=extra_field_length>>8;
			}else{
				extra_field1=null;
				centralFileData[26]=0x00;
				centralFileData[27]=0x00;
			}
			
			//file_comment=new ByteArray();
			//file_comment.writeMultiByte("我顶你个肺","gb2312");trace("测试 file_comment");
			
			if(file_comment&&file_comment.length){
				
				centralFileData.position=offset2;
				centralFileData.writeBytes(file_comment);
				var file_comment_length:int=centralFileData.length-offset2;
				offset2+=file_comment_length;
				
				centralFileData[28]=file_comment_length;
				centralFileData[29]=file_comment_length>>8;
			}else{
				file_comment=null;
				centralFileData[28]=0x00;
				centralFileData[29]=0x00;
			}
			
			centralFileData[30]=disk_number_start;
			centralFileData[31]=disk_number_start>>8;
			
			centralFileData[32]=internal_file_attributes;
			centralFileData[33]=internal_file_attributes>>8;
			
			centralFileData[34]=external_file_attributes;
			centralFileData[35]=external_file_attributes>>8;
			centralFileData[36]=external_file_attributes>>16;
			centralFileData[37]=external_file_attributes>>24;
			
			centralFileData[38]=relative_offset_of_local_header;
			centralFileData[39]=relative_offset_of_local_header>>8;
			centralFileData[40]=relative_offset_of_local_header>>16;
			centralFileData[41]=relative_offset_of_local_header>>24;
			
			if(file_data0){
				localFileData.position=offset;
				localFileData.writeBytes(file_data0);
				offset+=compressed_size;
			}
			
			if(general_purpose_bit_flag&0x08){
				if(_08074b50){//发现于 .swc 文件
					localFileData[offset++]=0x50;
					localFileData[offset++]=0x4b;
					localFileData[offset++]=0x07;
					localFileData[offset++]=0x08;
				}
				
				localFileData[offset++]=crc32;
				localFileData[offset++]=crc32>>8;
				localFileData[offset++]=crc32>>16;
				localFileData[offset++]=crc32>>24;
				
				localFileData[offset++]=compressed_size;
				localFileData[offset++]=compressed_size>>8;
				localFileData[offset++]=compressed_size>>16;
				localFileData[offset++]=compressed_size>>24;
				
				localFileData[offset++]=uncompressed_size;
				localFileData[offset++]=uncompressed_size>>8;
				localFileData[offset++]=uncompressed_size>>16;
				localFileData[offset++]=uncompressed_size>>24;
			}
			
			return [localFileData,centralFileData];
		}
		
		/**
		 * 
		 * 获取文本数据 
		 * 
		 */
		public function getText(charSet:String="utf-8"):String{
			//internal_file_attributes&0x00000001;//the lowest bit of this field indicates, if set, that the file is apparently an ascii or text file.
			var _data:ByteArray=data;
			_data.position=0;
			return _data.readMultiByte(_data.length,charSet);
		}
		
		/**
		 * 
		 * 设置文本数据 
		 * 
		 */
		public function setText(_text:String,charSet:String="utf-8"):void{
			var _data:ByteArray=new ByteArray();
			_data.writeMultiByte(_text,charSet);
			data=_data;
		}
	}
}