/***
complexArr2SimpleArr
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月05日 10:35:26
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	public function complexArr2SimpleArr(something:*):Array{
		var arr:Array=new Array();
		if(something is Array){
			for each(var subSomething:* in something){
				arr.push.apply(arr,complexArr2SimpleArr(subSomething));
			}
		}else{
			arr.push(something);
		}
		return arr;
	}
}