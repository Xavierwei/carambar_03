/***
getM
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月26日 14:36:50
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import flash.geom.Matrix;
	/**
	 * 求得 m，此 m 的功能具体描述就是：假如进行以下操作：cankaoDspObj.addChild(dspObj);dspObj.transform.matrix=m; 那么 dspObj 将会和操作前看上去一样
	 * 此算法可简单描述为：
	 * var m:Matrix=dspObj.transform.concatenatedMatrix;
	 * var m1:Matrix=cankaoDspObj.transform.concatenatedMatrix;
	 * m1.invert();
	 * m.concat(m1);
	 * return m;
	 * 由于 concatenatedMatrix 不总是能获取，所以不采用此算法
	 */	
	public function getM(dspObj:DisplayObject,cankaoDspObj:DisplayObject,useSameParentMatrix:Boolean):Matrix{
		//找到共同的 parent
		var sameParent:DisplayObjectContainer=null;
		var parentDict:Dictionary=new Dictionary();
		var parent:DisplayObjectContainer;
		
		parent=dspObj.parent;
		while(parent){
			parentDict[parent]=true;
			parent=parent.parent;
		}
		parent=cankaoDspObj.parent;
		while(parent){
			if(parentDict[parent]){
				sameParent=parent;
				break;
			}
			parent=parent.parent;
		}
		//
		
		if(sameParent){
			var m:Matrix=dspObj.transform.matrix;
			if(m){
				parent=dspObj.parent;
				while(parent){
					if(parent==sameParent){
						break;
					}
					if(parent.transform.matrix){
						m.concat(parent.transform.matrix);
					}
					parent=parent.parent;
				}
				
				if(useSameParentMatrix){
					if(sameParent.transform.matrix){
						m.concat(sameParent.transform.matrix);
					}
				}
				
				var m1:Matrix=cankaoDspObj.transform.matrix;
				if(m1){
					parent=cankaoDspObj.parent;
					while(parent){
						if(parent==sameParent){
							break;
						}
						if(parent.transform.matrix){
							m1.concat(parent.transform.matrix);
						}
						parent=parent.parent;
					}
					
					m1.invert();
					m.concat(m1);
				}
				
				return m;
			}
			
			throw new Error("m="+m);
		}
		
		throw new Error("找不到 sameParent");
	}
}