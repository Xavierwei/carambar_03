/***
getDate
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年10月09日 17:59:01
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	public function getDate(time:String):Date{
		var arr:Array=time.replace(/^\D*|\D*$/g,"").split(/\D+/);
		return new Date(
			int(arr[0]),
			int(arr[1])-1,
			int(arr[2]),
			int(arr[3]),
			int(arr[4]),
			int(arr[5]),
			int(arr[6])
		);
	}
}