/***
getProgramByByteV
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月11日 21:08:43
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public function getProgramByByteV(...byteV):ByteArray{
		var program:ByteArray=new ByteArray();
		program.endian=Endian.LITTLE_ENDIAN;
		var offset:int=0;
		for each(var byte:int in byteV.length==1?byteV[0]:byteV){
			program[offset++]=byte;
		}
		return program;
	}
}