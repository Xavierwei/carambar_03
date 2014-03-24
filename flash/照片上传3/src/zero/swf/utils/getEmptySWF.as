/***
getEmptySWF
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年05月02日 15:39:14
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.swf.SWF;
	import zero.swf.Tag;
	import zero.swf.TagTypes;
	import zero.swf.tagBodys.FileAttributes;
	import zero.swf.tagBodys.SetBackgroundColor;

	public function getEmptySWF(as3:Boolean):SWF{
		
		var setBackgroundColor:SetBackgroundColor=new SetBackgroundColor();
		setBackgroundColor.BackgroundColor=0xffffff;
		var setBackgroundColorTag:Tag=new Tag();
		setBackgroundColorTag.setBody(setBackgroundColor);
		
		var swf:SWF=new SWF();
		swf.tagV=new <Tag>[setBackgroundColorTag,new Tag(TagTypes.ShowFrame),new Tag(TagTypes.End)];
		
		if(as3){
			var fileAttributes:FileAttributes=new FileAttributes();
			fileAttributes.ActionScript3=true;
			var fileAttributesTag:Tag=new Tag();
			fileAttributesTag.setBody(fileAttributes);
			swf.tagV.unshift(fileAttributesTag);
		}
		
		return swf;
		
	}
}