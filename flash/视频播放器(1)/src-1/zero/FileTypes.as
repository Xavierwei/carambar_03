/***
FileTypes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月11日 14:06:57
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	//尝试通过分析 ByteArray 的前 2 个字节获取文件类型
	public class FileTypes{
		//public static const UNKNOWN:String="unknown";
		public static const JPG:String="jpg";
		public static const PNG:String="png";
		public static const GIF:String="gif";
		public static const BMP:String="bmp";
		public static const SWF:String="swf";
		public static const MP3:String="mp3";
		public static const MP4:String="mp4";
		public static const FLV:String="flv";
		public static const F4V:String="f4v";
		public static const WAV:String="wav";
		public static const MID:String="mid";
		public static const ZIP:String="zip";
		public static const RAR:String="rar";
		public static const EXE:String="exe";
		
		public static const typeMark:Object={
			
			_255216:JPG,
			_13780:PNG,
			_7173:GIF,
			_6677:BMP,
			
			_7087:SWF,//FWS
			_6787:SWF,//CWS
			_9087:SWF,//ZWS
			
			//无法单方面通过头两个字节确认为MP3
			_7368:MP3,//ID3V2
			_0000:MP3,//??
			_255250:MP3,//FFFA
			_255251:MP3,//FFFB
			_255227:MP3,//FFE3
			//...
			
			_7076:FLV,
			//????:F4V,
			_8273:WAV,
			_7784:MID,
			_8075:ZIP,
			_8297:RAR,
			_7790:EXE
		}
		public static const contentTypeMark:Object=function():Object{
			var contentTypeMark:Object=new Object();
			contentTypeMark[JPG]="image/jpeg";
			contentTypeMark[PNG]="image/png";
			contentTypeMark[GIF]="image/gif";
			contentTypeMark[BMP]="image/bmp";
			contentTypeMark[SWF]="application/x-shockwave-flash";
			contentTypeMark[MP3]="audio/mpeg";
			contentTypeMark[FLV]="video/x-flv";
			//contentTypeMark[F4V]="video/x-f4v";//?
			contentTypeMark[WAV]="audio/x-wav";
			contentTypeMark[MID]="audio/midi";
			contentTypeMark[ZIP]="application/zip";
			contentTypeMark[RAR]="";//application/octet-stream
			contentTypeMark[EXE]="";//application/octet-stream
			return contentTypeMark;
		}();
		
		public static const DEFAULT_CONTENT_TYPE:String="application/octet-stream";
		
		public static function getType(fileData:ByteArray,fileName:String=null,offset:int=0):String{
			var type:String=typeMark["_"+fileData[offset]+fileData[offset+1]];
			if(type){
				return type;
			}
			
			//无法仅通过分析 fileData 获取文件类型
			if(fileName){
				var dotId:int=fileName.indexOf(".")+1;
				if(dotId>0){
					//获取文件后缀作为文件类型
					return fileName.substr(dotId).toLowerCase();
				}
			}
			
			trace("无法获取文件类型");
			return null;
		}
		
		public static function getContentType(fileData:ByteArray,fileName:String=null,offset:int=0):String{
			return contentTypeMark[getType(fileData,fileName,offset)]||DEFAULT_CONTENT_TYPE;
		}
	}
}

