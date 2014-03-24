/***
getDocScript
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月5日 21:38:55
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.swf.SWF;
	import zero.swf.avm2.ABCClass;
	import zero.swf.avm2.ABCClasses;
	import zero.swf.avm2.ABCScript;
	import zero.swf.avm2.ABCTrait;
	import zero.swf.avm2.TraitTypeAndAttributes;
	
	public function getDocScript(swf:SWF):ABCScript{
		var docClassName:String=getDocClassName(swf);
		if(docClassName){
			for each(var ABCData:ABCClasses in getABCClasseses(swf,null)){
				for each(var script:ABCScript in ABCData.scriptV){
					for each(var trait:ABCTrait in script.traitV){
						if(
							trait.kind_trait_type==TraitTypeAndAttributes.Class_
							&&
							trait.classi
							&&
							docClassName==nameComplexString.unescape(trait.classi.toStr(null)).replace(/\:+/g,".")
						){
							return script;
						}
					}
				}
			}
		}
		return null;
	}
}