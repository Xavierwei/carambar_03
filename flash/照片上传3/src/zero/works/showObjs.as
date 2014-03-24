/***
showObjs
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月20日 17:55:35
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	
	import com.greensock.*;
	
	public function showObjs(objs:Array,d1:Number,d2:Number,onShowFinished:Function=null,type:String=null):void{
		if(type){
		}else{
			type="透明";
		}
		var i:int=-1;
		for each(var obj:* in objs){
			i++;
			var vars:Object={delay:i*d2};
			for each(var subType:String in type.split("|")){
				switch(subType){
					case "错y":
						vars.y=obj.y;
						obj.y+=(i%2-0.5)*200;
					break;
					default:
						obj.alpha=0;
						vars.alpha=1;
					break;
				}
			}
			if(i==objs.length-1){
				vars.onComplete=onShowFinished;
			}
			TweenMax.to(obj,d1,vars);
		}
	}
}