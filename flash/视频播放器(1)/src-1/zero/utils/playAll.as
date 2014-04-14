/***
playAll
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月4日 17:47:03
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import flash.display.*;
	public function playAll(obj:DisplayObjectContainer):void{
		//^_^
		
		//播放一个容器里的所有 MovieClip 动画
		if(obj is MovieClip){
			(obj as MovieClip).play();
		}
		var i:int=obj.numChildren;
		while(--i>=0){
			try{
				var child:DisplayObject=obj.getChildAt(i);
			}catch(e:Error){
				continue;
			}
			if(child is DisplayObjectContainer){
				playAll(child as DisplayObjectContainer);
			}
		}
	}
}