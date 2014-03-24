/***
getABCFileWithSimpleConstant_pools
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月30日 13:32:57
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.swf.SWF;
	import zero.swf.Tag;
	import zero.swf.TagTypes;
	import zero.swf.avm2.ABCFileWithSimpleConstant_pool;
	import zero.swf.tagBodys.DoABC;
	import zero.swf.tagBodys.DoABCWithoutFlagsAndName;
	
	public function getABCFileWithSimpleConstant_pools(swf:SWF,_initByDataOptions:Object=null):Vector.<ABCFileWithSimpleConstant_pool>{
		
		if(_initByDataOptions){
		}else{
			_initByDataOptions={};
		}
		_initByDataOptions.ABCDataClass=ABCFileWithSimpleConstant_pool;
		
		var ABCDataV:Vector.<ABCFileWithSimpleConstant_pool>=new Vector.<ABCFileWithSimpleConstant_pool>();
		for each(var tag:Tag in swf.tagV){
			switch(tag.type){
				case TagTypes.DoABC:
					ABCDataV.push(tag.getBody(DoABC,_initByDataOptions).ABCData);
				break;
				case TagTypes.DoABCWithoutFlagsAndName:
					ABCDataV.push(tag.getBody(DoABCWithoutFlagsAndName,_initByDataOptions).ABCData);
				break;
			}
		}
		return ABCDataV;
	}
}