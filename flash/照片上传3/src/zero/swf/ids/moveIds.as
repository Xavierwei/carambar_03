/***
moveIds
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年09月26日 14:30:10
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.ids{
	import zero.swf.SWF;

	public function moveIds(cankaoSWF:SWF,swf:SWF):void{
		//移动 swf 的 id 以便插入到 cankaoSWF 中
		moveIdsByAvalibleDefineObjIdV(swf,getAvalibleDefineObjIdV(cankaoSWF));
	}
}