/***
getModificationDate
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月08日 11:26:13
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import flash.utils.ByteArray;
	
	import zero.utils.getDate;
	
	/**
	 * 获取 swf 的最后修改时间
	 * @param swfData 需要分析的swf数据<br/>
	 * 如要获取当前 swf 的最后修改时间，可以 getModificationDate(stage.loaderInfo.bytes);
	 * 
	 */	
	public function getModificationDate(swfData:ByteArray):Date{
		var metadataXML:XML=getMetadata(swfData);
		if(metadataXML){
			//尝试获取 flash cs 系列编译的 swf 里的修改时间
			var execResult:Array=/<xmp\:MetadataDate>(.+)<\/xmp\:MetadataDate>/.exec(metadataXML.toXMLString());
			if(execResult){
				var time:String=execResult[1];
			}
		}
		if(time){
		}else{
			var productInfoXML:XML=getProductInfo(swfData);
			if(productInfoXML){
				time=productInfoXML.@CompilationDate.toString();
			}
		}
		if(time){
			return zero.utils.getDate(time);
		}
		return null;
	}
}