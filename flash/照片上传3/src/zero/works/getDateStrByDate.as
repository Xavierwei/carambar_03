/***
getDateStrByDate
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年11月25日 15:36:44
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	public function getDateStrByDate(date:Date):String{
		return date.fullYear+"-"+
			(date.month<9?"0"+(date.month+1):(date.month+1))+"-"+
			(date.date<10?"0"+date.date:date.date)+" "+
			(date.hours<10?"0"+date.hours:date.hours)+":"+
			(date.minutes<10?"0"+date.minutes:date.minutes)+":"+
			(date.seconds<10?"0"+date.seconds:date.seconds)
	}
}