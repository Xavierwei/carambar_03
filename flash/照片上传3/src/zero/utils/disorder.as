/***
disorder
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月29日 20:11:58
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	public function disorder(v:*):void{
		//打乱 Array 或 Vector 或 ByteArray
		var L:int=v.length;
		var i:int=L;
		while(--i>=0){
			var ran:int=int(Math.random()*L);
			var temp:*=v[i];
			v[i]=v[ran];
			v[ran]=temp;
		}
	}
}
		