/***
disorderIds
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年09月26日 12:45:48
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.ids{
	import zero.swf.SWF;
	import zero.utils.disorder;
	public function disorderIds(swf:SWF):void{
		var arr:Array=product(swf);
		
		var mark:Array=new Array();
		var i:int=-1;
		var idArr:Array=new Array();
		for each(var subArr:Array in arr){
			var id:int=subArr[2];
			if(mark[id]){
			}else{
				mark[id]=true;
				i++;
				idArr[i]=i+1;//从 1 开始
			}
		}
		
		disorder(idArr);
		
		mark=new Array();
		i=-1;
		for each(subArr in arr){
			id=subArr[2];
			if(id>0){
				if(mark[id]){
				}else{
					i++;
					mark[id]=idArr[i];
				}
				subArr[0][subArr[1]]=mark[id];
			}else{
				throw new Error("subArr="+subArr+",id="+id+",mark["+id+"]="+mark[id]);
			}
		}
	}
}