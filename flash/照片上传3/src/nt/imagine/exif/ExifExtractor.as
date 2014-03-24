/*@
***summary***
Copyright (c) 2007 Frank@2solo.cn
URL:www.2solo.cn
Create date:2008.03.18
Last modified by:frank
Last modified at:2008.03.28
File version:v1.21
Framework ID:Novattack Ver3.0.1
Path:nt.imagine.exif.core
Info:Exif提取器(Exif Extrator)
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
package nt.imagine.exif{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import nt.imagine.exif.core.ExifCore;
	import nt.imagine.exif.prototype.IFDEntry;
	import nt.imagine.exif.prototype.Tags;
	import nt.imagine.exif.tools.Logger;

	public class ExifExtractor extends EventDispatcher  {
		private var imgData:ByteArray;//image数据流
		private var headdata:ByteArray=new ByteArray();//文件头数据流
		private var headlength:uint=0;//头数据流长度
		private var imgExif=new ExifCore;//解析中心
		private var ExifType:uint;//1为JIJF+EXIF,2为EXIF2
		public var hasthumb:Boolean=false;//是否有预览图
		public function ExifExtractor(_imgData:ByteArray) {
			imgData=_imgData;
			Logger.clearLog();
			getHeader();
		}
		/*
		获取Exif头
		*/
		private function getHeader() {
			//取图片流的前12位并检查是否JPEG和Exif2
			//默认为ExifII型
			var jpgChk=chkJpeg(imgData);
			var exifiiChk=ExifII(imgData);
			//验证日志
			if (! jpgChk) {
				Logger.addLog("Not a Jpeg file");
				//trace("Not a Jpeg file");
			}
			//
			if (jpgChk && exifiiChk) {

				if (ExifType == 1) {

				} else if (ExifType == 2) {
					imgData.readBytes(headdata,0,12);//12为一个IFD标准Entry长度
					headdata.position=4;
				}//headdata位置指针4
				headlength=headdata.readUnsignedShort();//返回该位置的16位整数值作为头数据流长度
				Logger.addLog("EXIF head length: " + headlength + " bytes");
				imgData.readBytes(headdata, 0, headlength);//取图片数据流中（从0到第一个IFD的位置），该新数据流为所要的头文件流
				getIFDArray();
			}
		}
		/*
		//获取IFD数据数组
		*/
		private function getIFDArray() {
			imgExif.setDataHeader(headdata);
			imgExif.goAnalyse();
			hasthumb=imgExif.iniThumb();
		}
		/*
		//获取IFD数据
		*/
		private function getIFD() {
			imgExif.setDataHeader(headdata);
		}
		
		//判断是否Jpeg格式文件
		private function chkJpeg(bytedata:ByteArray):Boolean {
			if (bytedata[0] == 255 && bytedata[1] == 216 && bytedata[2] == 255 && bytedata[3] == 225 || bytedata[3] == 224) {
				return true;
			} else {
				return false;
			}
		}
		//判断是否有ExifII信息
		private function ExifII(bytedata:ByteArray):Boolean {
			if (bytedata[6] == 69 && bytedata[7] == 120 && bytedata[8] == 105 && bytedata[9] == 102) {
				ExifType=2;
				Logger.addLog("Get EXIF II successfully");
				return true;
			} else if (bytedata[24] == 69 && bytedata[25] == 120 && bytedata[26] == 105 && bytedata[27] == 102) {
				ExifType=1;
				Logger.addLog("The current Exif Format is not supported.Only Exif2.2 is supported.");
				return false;
			} else {
				Logger.addLog("Don't have any ExifII information");
				return false;
			}
		}
		/*
		//获取截图数据
		*/
		public function getThumb():ByteArray {
			return imgExif.tbnStream;
		}
		/*
		通过代码获取IFD
		*/
		public function getTagByTag(tagNum:uint):Object {
			var obj=new Object();
			for each (var temp_ifd:IFDEntry in imgExif.entryArr) {
				if (temp_ifd.tag == tagNum) {
					obj=temp_ifd;
					if(Tags.EXIF_TAGS[temp_ifd.tag]){
						obj.EN=Tags.EXIF_TAGS[temp_ifd.tag].EN;
						obj.CN=Tags.EXIF_TAGS[temp_ifd.tag].CN;
					}
					return obj;
				}
			}
			return null;
		}
		/*
		获取全部IFD
		*/
		public function getAllTag():Array {
			var obj=new Object();
			for (var i=0; i<imgExif.entryArr.length; i++) {
				if(Tags.EXIF_TAGS[imgExif.entryArr[i].tag]){
					imgExif.entryArr[i].EN=Tags.EXIF_TAGS[imgExif.entryArr[i].tag].EN;
					imgExif.entryArr[i].CN=Tags.EXIF_TAGS[imgExif.entryArr[i].tag].CN;
				}
			}
			return imgExif.entryArr;
		}
		/*
		获取日志
		*/
		public function getLog():Array {
			return Logger.allLog();
		}
	}
}