/***
replaceStrs
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月08日 17:32:31
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.strs{
	import flash.utils.ByteArray;
	
	import zero.swf.SWF;
	
	/**
	 *替换SWF里的字符串（包名，类名，元件实例名等）
	 */	
	public function replaceStrs(swfData:ByteArray,str0Arr:Array,strtArr:Array):ByteArray{
		var swf:SWF=new SWF();
		swf.initBySWFData(swfData,null);
		
		var mark:Object=new Object();
		var i:int=-1;
		for each(var str0:String in str0Arr){
			i++;
			mark["~"+str0]=strtArr[i];
		}
		
		var arr:Array=product(swf);
		for each(var subArr:Array in arr){
			str0=subArr[2];
			var strt:String=mark["~"+str0];
			if(strt){
				subArr[0][subArr[1]]=strt;
			}else{
				var subStrArr:Array=str0.split(/[\.:]+/);
				i=subStrArr.length;
				var hasChange:Boolean=false;
				while(--i>=0){
					strt=mark["~"+subStrArr[i]];
					if(strt){
						subStrArr[i]=strt;
						hasChange=true;
					}
				}
				if(hasChange){
					subArr[0][subArr[1]]=subStrArr.join(".");
				}
			}
		}
		
		return swf.toSWFData(null);
	}
}