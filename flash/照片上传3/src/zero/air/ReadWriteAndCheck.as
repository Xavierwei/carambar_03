/***
ReadWriteAndCheck
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年10月10日 16:03:29
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.air{
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import zero.utils.getTime;

	public class ReadWriteAndCheck{
		
		public static var hasChangeSystemTime:Boolean=false;
		public static var onCheck:Function;
		
		public static function read(fileOrPath:*,readAsString:Boolean,charSet:String="utf-8"):*{
			if(fileOrPath is File){
				var file:File=fileOrPath;
			}else{
				file=new File(fileOrPath);
			}
			check(file);
			if(readAsString){
				return ReadAndWriteFile.readStrFromFile(file,charSet);
			}
			return ReadAndWriteFile.readDataFromFile(file);
		}
		
		public static function write(data:*,fileOrPath:*):void{
			if(fileOrPath is File){
				var file:File=fileOrPath;
			}else{
				file=new File(fileOrPath);
			}
			check(file);
			if(hasChangeSystemTime){
				if(onCheck==null){
				}else{
					if(onCheck()){
						return;
					}
				}
			}
			if(data is ByteArray){
				ReadAndWriteFile.writeDataToFile(data,file);
			}else{
				ReadAndWriteFile.writeStrToFile(data,file);
			}
		}
		
		private static function check(file:File):void{
			if(file.exists){
				var currDate:Date=new Date();
				var fileDate:Date=file.modificationDate;
				//trace(file.name,getTime(null,currDate),getTime(null,fileDate));
				if(currDate.time<fileDate.time){
					trace("修改了系统时间");
					hasChangeSystemTime=true;
				}
			}
		}
		
	}
}