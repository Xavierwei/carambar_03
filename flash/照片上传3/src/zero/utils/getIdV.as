/***
getIdV
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月29日 20:29:30
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	public function getIdV(total:int,L:int):Vector.<int>{
		var i:int;
		
		if(total>L){
			total=L;
		}
		
		i=L;
		var idArr:Array=new Array();
		while(--i>=0){
			idArr[i]=i;
		}
		
		i=L;
		while(--i>=0){
			var ran:int=int(Math.random()*L);
			var temp:int=idArr[i];
			idArr[i]=idArr[ran];
			idArr[ran]=temp;
		}
		
		i=total;
		var idV:Vector.<int>=new Vector.<int>();
		while(--i>=0){
			idV.push(idArr[i]);
		}
		
		return idV;
	}
}
		