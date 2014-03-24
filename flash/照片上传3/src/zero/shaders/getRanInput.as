/***
getRanInput
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月16日 13:55:18
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders{
	public function getRanInput(num:int):Vector.<Number>{
		var input:Vector.<Number>=ranInputArr[num];
		if(input){
		}else{
			//import flash.utils.getTimer;
			//var t:int=getTimer();
			ranInputArr[num]=input=new Vector.<Number>(num);
			input.fixed=true;
			var i:int=num;
			while(i--){
				input[i]=i;
			}
			i=num;
			while(i--){
				var ran:int=Math.random()*num;
				var temp:int=input[i];
				input[i]=input[ran];
				input[ran]=temp;
			}
			//trace("input="+input);
			//trace("getRanArr("+num+")耗时 "+(getTimer()-t)+" 毫秒");
		}
		return input;
	}
}
const ranInputArr:Array=new Array();