/*@
***summary***
Copyright (c) 2007 Frank@2solo.cn
URL:www.2solo.cn
Create date:2008.03.18
Last modified by:frank
Last modified at:2008.03.28
File version:v1.12
Framework ID:Novattack Ver3.0.1
Path:nt.imagine.exif.core
Info:Exif提取器核心解析部分(Exif Extrator core)
Location:shanghai,china

使用本代码库请参照GNU GENERAL PUBLIC LICENSE(通用公共授权).
允许每个人复制和发布本授权文件的完整副本，但不允许对它进行任何修改。
如果您有好的建议，欢迎来http://code.google.com/p/exif-as3/留言.

Please use this library with the GNU GENERAL PUBLIC LICENSE(GNU GPL)
Everyone is permitted to copy and distribute verbatim copies of this license document, but changing it is not allowed.
If you have any suggestion,You're welcome to leave a message at http://code.google.com/p/exif-as3/

GNU General Public License
http://www.gnu.org/licenses/gpl.html

Exif2-2
http://www.exif.org/Exif2-2.PDF
*/
package nt.imagine.exif.core{
	import flash.display.*;
	import flash.utils.*;
	import nt.imagine.exif.prototype.*;
	import nt.utils.ByteEncoder;


	public class ExifCore extends Sprite {

		private var bytedata:ByteArray=null;//数据流
		private var IFDN_POS:uint=0;//下一个IFD的位置
		private var IFD0:uint;//0thIFD的指针位
		private var Exif0:uint;//0thIFD的Exif指针位
		private var Gps0:uint;//0thIFD的Gps指针位
		private var InteroIFD:uint;//InteroIFD指针位
		private var IFD1:uint;//1stIFD的指针位
		public var entryArr=new Array;//存放IFDEntry的数组
		private var tbnPos:uint;//预览图指针位
		private var tbnLen:uint;//预览图数据长度
		public var tbnStream:ByteArray=new ByteArray()//预览图数据流


		public function ExifCore() {
			//
		}
		
		/*
		设定文件头流
		*/
		public function setDataHeader(temp_bytedata:ByteArray) {
			bytedata=temp_bytedata;
			if (bytedata[0]==73) {
				bytedata.endian=Endian.LITTLE_ENDIAN;
			} else {
				bytedata.endian=Endian.BIG_ENDIAN;
			}
		}
		
		/*
		开始解析
		*/
		public function goAnalyse() {
			//一般IFD分两段前段为主图片的描述，后段为thumbsnail的描述
			IFD0=getIFD0();

			if (IFDN_POS<bytedata.length) {//过滤超长后没有IFD1的情况
				IFD1=getIFDN(IFDN_POS);
			}
			listEntry(IFD0);
			if (IFD1<bytedata.length) {//防止有IFD1指针有没数据的情况．
				listEntry(IFD1);
			}
			chkExif0();
			chkGPS0();
			//目前还不做对Interoperability IFD的支持
		}
		/*
		检查0thIFD,返回指针位置
		*/
		private function getIFD0():uint {//第一个IFD(0thIFD)
			bytedata.position=4;
			IFDN_POS=bytedata.readUnsignedInt();
			return IFDN_POS;
		}
		/*
		检查1stIFD,返回指针位置
		*/
		private function getIFDN(startPos:uint):uint {//第N个IFD(其实只有1stIFD)
			var entries:uint=bytedata.readUnsignedShort();//entry的个数
			bytedata.position=startPos + 2 + 12 * entries;//算法
			IFDN_POS=bytedata.readUnsignedInt();
			return IFDN_POS;
		}
		/*
		发布所有Entry
		*/
		private function listEntry(ifdoffset:uint) {
			var entriesNum:uint=0;//项目数
			var EntryObj=new Object;

			bytedata.position=ifdoffset;//定义位置

			try {
				entriesNum=bytedata.readUnsignedShort();//取该位置的值做为所拥有项目的长度
				if (entriesNum<bytedata.length) {
					for (var i:int=0; i < entriesNum; i++) {
						EntryObj=getEntry(bytedata,ifdoffset + 2 + 12 * i,i);
						entryArr.push(EntryObj);
						//trace(EntryObj.tag + " | " + Tags.EXIF_TAGS[EntryObj.tag].CN + " | type:" + EntryObj.type + " | value:" + EntryObj.values);
					}
				}
			} catch (e:Error) {
				throw new CustomError("listEntryError");
			}
		}
		/*
		逐个解析Entry
		*/
		private function getEntry(bytedata:ByteArray,posNum:uint,countNum:uint):Object {
			var Obj=new Object;
			var mtag:uint=0;//标签号
			var mtype:uint=0;//类型号
			var mvalue;//对应IFD的value
			var temp_data:ByteArray;//临时ByteArray装载器
			var temp_count:uint;//对应IFD的Count
			var temp_mark:uint;//对应IFD的位置
			try {
				bytedata.position=posNum;//算法

				mtag=bytedata.readUnsignedShort();//取tag
				mtype=bytedata.readUnsignedShort();//取type

				temp_count=bytedata.readUnsignedInt();

				switch (mtype) {
					case 1 ://取全整byte类型(Byte)
						mvalue=bytedata.readUnsignedByte();
						break;
					case 2 ://取ASCII(ASCII)
						if (temp_count <= 4) {
							mvalue=get4ASCII(temp_count);
						} else {
							temp_data=new ByteArray  ;
							temp_mark=bytedata.readUnsignedInt();
							bytedata.position=temp_mark;
							bytedata.readBytes(temp_data,0,temp_count);
							mvalue=ByteEncoder.EncodeUtf8(temp_data.toString());
						}
						break;
					case 3 ://取全整uint类型(SHORT)
						mvalue=bytedata.readUnsignedShort();
						break;
					case 4 ://取全整INT类型(LONG)
						mvalue=bytedata.readUnsignedInt();
						break;
					case 5 ://取全整INT类型分数(RATIONAL)
						temp_mark=bytedata.readUnsignedInt();
						bytedata.position=temp_mark;
						mvalue=new RATIONAL(bytedata.readUnsignedInt(),bytedata.readUnsignedInt()).getNum();
						break;
					case 7 ://取任意字节(UNDEFINED)
						if (temp_count <= 4) {
							mvalue=get4ASCII(temp_count);
						} else {
							temp_data=new ByteArray  ;
							temp_mark=bytedata.readUnsignedInt();
							bytedata.position=temp_mark;
							bytedata.readBytes(temp_data,0,temp_count);
							mvalue=ByteEncoder.EncodeUtf8(temp_data.toString());

						}
						break;
					case 9 ://取INT类型(SLONG)
						mvalue=bytedata.readInt();
						break;
					case 10 ://取INT类型分数(SRATIONAL)
						temp_mark=bytedata.readInt();
						bytedata.position=temp_mark;
						mvalue=new RATIONAL(bytedata.readInt(),bytedata.readInt()).getNum();
						break;
				}
				//提取Exif和GPS的指针位置
				if (mtag == 34665) {
					Exif0=mvalue;//提取Exif指针位置
				} else if(mtag == 34853) {
					Gps0=mvalue;//提取GPS的指针位置
				} else if(mtag == 513) {
					tbnPos=mvalue;//提取Thumbnail的指针位置
				} else if(mtag == 514) {
					tbnLen=mvalue;//提取Thumbnail长度的指针位置
				}
			} catch (e:Error) {
				throw new CustomError("getEntryError");
			}
			Obj=new IFDEntry(mtag,mtype,mvalue);
			return Obj;
		}
		/*
		返回四位以下ASCII类型数据的方法
		*/
		private function get4ASCII(count:uint):String {
			var tempStr=new String("");

			for (var j=0; j<count; j++) {
				var asc=bytedata.readUnsignedByte();
				tempStr+=String.fromCharCode(asc);
			}
			return tempStr;
		}
		/*
		检查0thIFD里的Exif指针
		*/
		private function chkExif0() {
			if (Exif0 != 0) {
				listEntry(Exif0);
			}
		}
		/*
		检查0thIFD里的GPS指针
		*/
		private function chkGPS0() {
			if (Gps0 != 0) {
				listEntry(Gps0);
			}
		}
		/*
		检查并返回Thumbnail
		*/
		public function iniThumb():Boolean {
			if (tbnPos & tbnLen) {
				bytedata.position = tbnPos
				bytedata.readBytes(tbnStream, 0, tbnLen);
				return true
			}else{
				return false
			}
		}
	}
}

import nt.imagine.exif.tools.Logger;
class CustomError extends Error {
	public function CustomError(message:String) {
		switch (message) {
			case "listEntryError" :
				Logger.addLog("Get IFD list error")
				break;
			case "getEntryError" :
				Logger.addLog("Get entry list  error")
				break;
		}
	}
}