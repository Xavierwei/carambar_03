/*@
***summary***
Copyright (c) 2007 Frank@2solo.cn
URL:www.2solo.cn
Create date:2008.03.18
Last modified by:frank
Last modified at:2008.03.28
File version:v1.00
Framework ID:Novattack Ver3.0.1
Path:nt.imagine.exif.tools
Info:日志记录器(An log recorder)
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
package nt.imagine.exif.tools{
	import flash.display.Sprite;
	public class Logger extends Sprite {
		private static  var logArr:Array=new Array();
		/*
		*添加日志
		*/
		public static function addLog(str : String){
			logArr.push("Log : "+str);
		}
		/*
		*清空日志
		*/
		public static function clearLog() {
			logArr=new Array();
		}
		/*
		*获取全部日志
		*/
		public static function allLog():Array {
			return logArr
		}
	}
}