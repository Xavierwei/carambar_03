/***
Zip
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月19日 17:17:07
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zip{
	import flash.utils.ByteArray;
	public class Zip{
		
		public var fileV:Vector.<ZipFile>;
		
		private var number_of_this_disk:int;
		private var number_of_the_disk_with_the_start_of_the_central_directory:int;
		private var zipfile_comment:ByteArray;
		private var zipfile_comment_charset:String;
		
		/**
		 * 
		 * 文件注释，可能需要在 zip.decode() 时正确的传入 zipfile_comment_charset 才可以正确的获取和设置
		 * 
		 */		
		public function get comment():String{
			if(zipfile_comment){
				if(zipfile_comment.length){
					zipfile_comment.position=0;
					return zipfile_comment.readMultiByte(zipfile_comment.length,zipfile_comment_charset);
				}
				zipfile_comment=null;
			}
			return "";
		}
		public function set comment(_comment:String):void{
			if(_comment){
				zipfile_comment=new ByteArray();
				zipfile_comment.writeMultiByte(_comment,zipfile_comment_charset);
			}else{
				zipfile_comment=null;
			}
		}
		
		public function Zip(){
			fileV=new Vector.<ZipFile>();
			
			number_of_this_disk=0;
			number_of_the_disk_with_the_start_of_the_central_directory=0;
			zipfile_comment_charset="gb2312";
		}
		
		/**
		 *清除此 zip 以便回收
		 * 
		 */		
		public function clear():void{
			if(fileV){
				var i:int=fileV.length;
				while(--i>=0){
					fileV[i].clear();
					fileV[i]=null;
				}
				fileV.length=0;
				fileV=null;
			}
			zipfile_comment=null;
		}
		
		/**
		 * 
		 * 解码（解压）zip 或 fla 或 swc 等文件
		 * @param zipData 传入需要解压的ByteArray；
		 * @param file_name_charset 文件名的编码方式，默认 "gb2312"（zip等），如果是 fla，可能需要传入 "utf-8"，swc 未知（可能是 "utf-8"）；
		 * @param comment_charset 文件注释的编码方式，默认 "gb2312"；
		 * @param strict_mode 若 true，则以严格模式解码，稍不符合规范的 zip 文件（如普通的 fla 文件）将可能解码失败，默认 false。
		 * 
		 * .zip 文件应该都是 file_name_charset="gb2312"，所以 zip.decode(zipData) 即可；
		 * .fla 文件应该都是 file_name_charset="utf-8"，所以 zip.decode(flaData,"utf-8") 即可，如果不需要获取和设置文件名，也可以 zip.decode(flaData)；
		 * .swc 未有时间考证，接触到的 .swc 解压后的文件都是英文名，所以 zip.decode(swcData) 即可。
		 * 
		 * comment_charset 应该都是 "gb2312"。
		 * 
		 */
		public function decode(
			zipData:ByteArray,
			file_name_charset:String="gb2312",
			comment_charset:String="gb2312",
			strict_mode:Boolean=false
		):void{
			var scan_offset:int=zipData.length;
			while(--scan_offset>0){
				if(zipData[scan_offset]==0x50){
					if(zipData[scan_offset+1]==0x4b){
						if(zipData[scan_offset+2]==0x05){
							if(zipData[scan_offset+3]==0x06){//end of central dir signature    4 bytes  (0x06054b50)
								var zipfile_comment_length:int=zipData[scan_offset+20]|(zipData[scan_offset+21]<<8);
								if(scan_offset+22+zipfile_comment_length==zipData.length){
									//end of central dir record:
									//end of central dir signature    4 bytes  (0x06054b50)
									//number of this disk             2 bytes
									//number of the disk with the
									//start of the central directory  2 bytes
									//total number of entries in
									//the central dir on this disk    2 bytes
									//total number of entries in
									//the central dir                 2 bytes
									//size of the central directory   4 bytes
									//offset of start of central
									//directory with respect to
									//the starting disk number        4 bytes
									//zipfile comment length          2 bytes
									//zipfile comment (variable size)
									
									number_of_this_disk=zipData[scan_offset+4]|(zipData[scan_offset+5]<<8);
									number_of_the_disk_with_the_start_of_the_central_directory=zipData[scan_offset+6]|(zipData[scan_offset+7]<<8);
									
									var total_number_of_entries_in_the_central_dir_on_this_disk:int=zipData[scan_offset+8]|(zipData[scan_offset+9]<<8);
									var total_number_of_entries_in_the_central_dir:int=zipData[scan_offset+10]|(zipData[scan_offset+11]<<8);
									var size_of_the_central_directory:int=zipData[scan_offset+12]|(zipData[scan_offset+13]<<8)|(zipData[scan_offset+14]<<16)|(zipData[scan_offset+15]<<24);
									var offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number:int=zipData[scan_offset+16]|(zipData[scan_offset+17]<<8)|(zipData[scan_offset+18]<<16)|(zipData[scan_offset+19]<<24);
									
									//number of this disk: (2 bytes)
									//	the number of this disk, which contains central
									//	directory end record.
									//number of the disk with the start of the central directory: (2 bytes)
									//	the number of the disk on which the central
									//	directory starts.
									//total number of entries in the central dir on this disk: (2 bytes)
									//	the number of central directory entries on this disk.
									//total number of entries in the central dir: (2 bytes)
									//	the total number of files in the zipfile.
									//size of the central directory: (4 bytes)
									//	the size (in bytes) of the entire central directory.
									//offset of start of central directory with respect to the starting disk number:  (4 bytes)
									//	offset of the start of the central directory on the
									//	disk on which the central directory starts.
									
									if(zipfile_comment_length){
										zipfile_comment=new ByteArray();
										zipfile_comment.writeBytes(zipData,scan_offset+22,zipfile_comment_length);
										//zipfile comment length: (2 bytes)
										//	the length of the comment for this zipfile.
										//zipfile comment: (variable)
										//	the comment for this zipfile.
									}else{
										zipfile_comment=null;
									}
									
									//trace("number_of_this_disk="+number_of_this_disk);
									//trace("number_of_the_disk_with_the_start_of_the_central_directory="+number_of_the_disk_with_the_start_of_the_central_directory);
									//trace("total_number_of_entries_in_the_central_dir_on_this_disk="+total_number_of_entries_in_the_central_dir_on_this_disk);
									//trace("total_number_of_entries_in_the_central_dir="+total_number_of_entries_in_the_central_dir);
									//trace("size_of_the_central_directory="+size_of_the_central_directory);
									//trace("offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number="+offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number);
									//trace("zipfile_comment="+zipfile_comment);
									
									if(file_name_charset){
									}else{
										file_name_charset="gb2312";
									}
									if(comment_charset){
										zipfile_comment_charset=comment_charset;
									}else{
										zipfile_comment_charset="gb2312";
									}
									
									if(
										!strict_mode
										||
										offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number+size_of_the_central_directory==scan_offset
									){
										var offset:int=0;
										var offset2:int=offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number;
										fileV=new Vector.<ZipFile>();
										while(offset2<scan_offset){
											if(
												zipData[offset2++]==0x50
												&&
												zipData[offset2++]==0x4b
												&&
												zipData[offset2++]==0x01
												&&
												zipData[offset2++]==0x02
											){//central file header signature   4 bytes  (0x02014b50)
												var file:ZipFile=new ZipFile(file_name_charset,comment_charset);
												offset2=file.initByCentralDirectoryData(zipData,offset2);
												if(
													!strict_mode
													||
													offset==file.relative_offset_of_local_header
												){
													if(strict_mode){
													}else{
														offset=file.relative_offset_of_local_header;
													}
													
													if(
														zipData[offset++]==0x50
														&&
														zipData[offset++]==0x4b
														&&
														zipData[offset++]==0x03
														&&
														zipData[offset++]==0x04
													){//local file header signature     4 bytes  (0x04034b50)
														//trace("offset="+offset,"offset2="+offset2);
														offset=file.initByZipData(zipData,offset,strict_mode);
														//trace("file.name="+file.name);
														fileV.push(file);
													}else{
														trace("local file header signature 异常");
														break;
													}
												}else{
													trace("relative offset of local header 异常");
													break;
												}
											}else{
												trace("central file header signature 异常");
												break;
											}
										}
										if((
												!strict_mode
												||
												offset==offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number
											)&&
											offset2==scan_offset
										){
											//trace("fileV="+fileV);
											return;
										}
										trace("offset2="+offset2+"，scan_offset="+scan_offset+"，offset2!=scan_offset");
										fileV=null;
									}//else{
									//	trace("offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number="+offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number);
									//	trace("size_of_the_central_directory="+size_of_the_central_directory);
									//	trace("scan_offset="+scan_offset);
									//	trace("(offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number+size_of_the_central_directory)="+(offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number+size_of_the_central_directory));
									//	trace("offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number+size_of_the_central_directory!=scan_offset");
									//}
								}
							}
						}
					}
				}
			}
			
			if(strict_mode){
				throw new Error("严格模式下解压 zip 失败");
			}
			throw new Error("非严格模式下解压 zip 失败");
		}
		
		/**
		 * 
		 * 编码（压缩为）zip 或 fla 或 swc 等文件
		 * 
		 */		
		public function encode():ByteArray{
			
			var zipData:ByteArray=new ByteArray();
			var centralFilesData:ByteArray=new ByteArray();
			var offset:int=0;
			var offset2:int=0;
			for each(var file:ZipFile in fileV){
				
				var toDataResult:Array=file.toZipDataArr(offset);
				
				zipData[offset++]=0x50;
				zipData[offset++]=0x4b;
				zipData[offset++]=0x03;
				zipData[offset++]=0x04;
				
				zipData.position=offset;
				zipData.writeBytes(toDataResult[0]);
				offset=zipData.length;
				
				centralFilesData[offset2++]=0x50;
				centralFilesData[offset2++]=0x4b;
				centralFilesData[offset2++]=0x01;
				centralFilesData[offset2++]=0x02;
				
				centralFilesData.position=offset2;
				centralFilesData.writeBytes(toDataResult[1]);
				offset2=centralFilesData.length;
			}
			
			var total_number_of_entries_in_the_central_dir_on_this_disk:int=fileV.length;
			var total_number_of_entries_in_the_central_dir:int=fileV.length;
			var size_of_the_central_directory:int=centralFilesData.length;
			var offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number:int=offset;
			zipData.position=offset;
			zipData.writeBytes(centralFilesData);
			offset=zipData.length;
			
			zipData[offset++]=0x50;
			zipData[offset++]=0x4b;
			zipData[offset++]=0x05;
			zipData[offset++]=0x06;
			
			zipData[offset++]=number_of_this_disk;
			zipData[offset++]=number_of_this_disk>>8;
			
			zipData[offset++]=number_of_the_disk_with_the_start_of_the_central_directory;
			zipData[offset++]=number_of_the_disk_with_the_start_of_the_central_directory>>8;
			
			zipData[offset++]=total_number_of_entries_in_the_central_dir_on_this_disk;
			zipData[offset++]=total_number_of_entries_in_the_central_dir_on_this_disk>>8;
			
			zipData[offset++]=total_number_of_entries_in_the_central_dir;
			zipData[offset++]=total_number_of_entries_in_the_central_dir>>8;
			
			zipData[offset++]=size_of_the_central_directory;
			zipData[offset++]=size_of_the_central_directory>>8;
			zipData[offset++]=size_of_the_central_directory>>16;
			zipData[offset++]=size_of_the_central_directory>>24;
			
			zipData[offset++]=offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number;
			zipData[offset++]=offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number>>8;
			zipData[offset++]=offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number>>16;
			zipData[offset++]=offset_of_start_of_central_directory_with_respect_to_the_starting_disk_number>>24;
			
			//zipfile_comment=new ByteArray();
			//zipfile_comment.writeMultiByte("我顶你个肺","gb2312");trace("测试 zipfile_comment");
			
			if(zipfile_comment&&zipfile_comment.length){
				
				zipData.position=offset+2;
				zipData.writeBytes(zipfile_comment);
				var zipfile_comment_length:int=zipData.length-offset-2;
				zipData[offset++]=zipfile_comment_length;
				zipData[offset++]=zipfile_comment_length>>8;
			}else{
				zipfile_comment=null;
				zipData[offset++]=0x00;
				zipData[offset++]=0x00;
			}
			
			return zipData;
			
		}
		
		public function getFileById(id:int):ZipFile{
			return fileV[id];
		}
		
		public function getFileByName(name:String):ZipFile{
			for each(var file:ZipFile in fileV){
				if(file.name==name){
					return file;
				}
			}
			return null;
		}
		public function removeFileByName(name:String):void{
			for each(var file:ZipFile in fileV){
				if(file.name==name){
					removeFile(file);
					return;
				}
			}
		}
		
		/**
		 * 
		 * value 可以是 String，ByteArray，或 ZipFile
		 * 
		 */		
		public function add(value:*,name:String=null,date:Date=null):void{
			if(value is ZipFile){
				var file:ZipFile=value;
			}else{
				file=new ZipFile();
				if(name&&(name.lastIndexOf("/")==name.length-1)){
				}else{
					if(value is String){
						file.setText(value);
					}else{
						file.data=value;
					}
				}
			}
			if(name is String){
				file.name=name;
			}
			if(date){
				file.date=date;
			}
			addFile(file);
		}
		
		public function addFile(file:ZipFile):void{
			fileV.push(file);
		}
		public function removeFile(file:ZipFile):void{
			var id:int=fileV.indexOf(file);
			if(id>-1){
				fileV.splice(id,1);
			}
		}
	}
}