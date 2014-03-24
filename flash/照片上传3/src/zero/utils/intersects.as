/***
intersects
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月30日 17:09:47
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	/**
	 * 顺次连结p1,p3,p2,p4,如果是一个凸四边形则有交点,否则没有 
	 */	
	public function intersects(p1:*,p2:*,p3:*,p4:*):Boolean{
		var p13x:Number=p3.x-p1.x;
		var p13y:Number=p3.y-p1.y;
		var p32x:Number=p2.x-p3.x;
		var p32y:Number=p2.y-p3.y;
		var num1:Number=p13x*p32y-p13y*p32x;
		var p24x:Number=p4.x-p2.x;
		var p24y:Number=p4.y-p2.y;
		var num2:Number=p32x*p24y-p32y*p24x;
		if(num1*num2<=0){
			return false;
		}
		var p41x:Number=p1.x-p4.x;
		var p41y:Number=p1.y-p4.y;
		var num3:Number=p24x*p41y-p24y*p41x;
		if(num2*num3<=0){
			return false;
		}
		var num4:Number=p41x*p13y-p41y*p13x;
		if(num3*num4<=0){
			return false;
		}
		return true;
	}
}