/***
getAvalibleDefineObjIdV
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年09月25日 16:50:36
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.ids{
	
	import zero.swf.SWF;
		
	/**
	 * 传一个或多个 swf（类型是 zero.swf.SWF），获取可用的定义 id 列表（例如用在往里插入其它定义对象时不会有id冲突）
	 */
	public function getAvalibleDefineObjIdV(...swfs):Vector.<int>{
		var mark:Array=new Array();
		for each(var swf:SWF in swfs){
			var arr:Array=product(swf);
			for each(var subArr:Array in arr){
				mark[subArr[2]]=true;
			}
		}
		
		var avalibleDefineObjIdV:Vector.<int>=new Vector.<int>();
		for(var id:int=1;id<0x7fff;id++){
			if(mark[id]){
			}else{
				avalibleDefineObjIdV.push(id);
			}
		}
		return avalibleDefineObjIdV;
	}
}