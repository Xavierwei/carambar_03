/***
killAllTweens
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年09月04日 16:11:16
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public function killAllTweens(obj:DisplayObjectContainer):void{
		//^_^
		
		//停止一个容器里的所有 Tween
		TweenMax.killTweensOf(obj);
		var i:int=obj.numChildren;
		while(--i>=0){
			try{
				var child:DisplayObject=obj.getChildAt(i);
			}catch(e:Error){
				continue;
			}
			if(child is DisplayObjectContainer){
				killAllTweens(child as DisplayObjectContainer);
			}
		}
	}
}