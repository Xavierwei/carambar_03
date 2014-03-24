/***
arrangement
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月31日 10:03:12
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	public function arrangement(v:*,m:int=-1):Array{
		
		//排列 Array 或 Vector 或字符串
		
		//trace(arrangement("1234").join("\n"));
		//trace(arrangement("123456",4).join("\n"));
		//trace(arrangement("1234",6).join("\n"));
		//trace(arrangement(["1",2,"3",4,"5",6],4).join("\n"));
		//trace(arrangement(new <int>[1,2,3,4,5,6],4).join("\n"));
		
		var _v:*;
		if(v is String){
			_v=v.split("");
		}else{
			_v=v;
		}
		
		var arr:Array=new Array();
		var c:*;
		
		if(m>-1){
		}else{
			m=_v.length;
		}
		if(m>1){
			for each(var subArr:Array in arrangement(_v,m-1)){
				for each(c in _v){
					arr.push(subArr.concat([c]));
				}
			}
			
		}else if(m>0){
			for each(c in _v){
				arr.push([c]);
			}
		}
		
		if(v is String){
			var i:int=arr.length;
			while(--i>=0){
				arr[i]=arr[i].join("");
			}
		}
		return arr;
	}
}