/*@
***summary***
Copyright (c) 2007 Frank@2solo.cn
URL:www.2solo.cn
Create date:2008.03.18
Last modified by:frank
Last modified at:2008.03.28
File version:v1.00
Framework ID:Novattack Ver3.0.1
Path:nt.imagine.exif.prototype
Info:Enrty of IFD
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
package nt.imagine.exif.prototype {
	public class IFDEntry {
		public var tag:uint = 0;
		public var type:uint = 0;
		public var values:Object = null;
		public var EN:String =""
		public var CN:String = ""
		
		public function IFDEntry( tag:uint, type:uint, values:Object ) {
			this.tag = tag;
			this.type = type;
			this.values = values;
		}
	}
}