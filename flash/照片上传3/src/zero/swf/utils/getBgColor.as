/***
getBgColor
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年01月07日 10:25:35
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.swf.SWF;
	import zero.swf.Tag;
	import zero.swf.TagTypes;
	import zero.swf.tagBodys.SetBackgroundColor;
	
	public function getBgColor(swf:SWF):int{
		for each(var tag:Tag in swf.tagV){
			if(tag.type==TagTypes.SetBackgroundColor){
				return (tag.getBody(SetBackgroundColor,null) as SetBackgroundColor).BackgroundColor;
			}
		}
		return 0xffffff;
	}
}