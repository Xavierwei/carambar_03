/***
stackGetCode
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月15日 13:38:46
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	public function stackGetCode(code:String,left:String,right:String):String{
		if(code){
			var stackTop:int=0;
			var i:int=-1;
			for each(var c:String in code.split("")){
				i++;
				switch(c){
					case left:
						stackTop++;
					break;
					case right:
						if(--stackTop>0){
						}else{
							return code.substr(0,i+1);
						}
					break;
					default:
						//
					break;
				}
			}
		}
		return code;
	}
}