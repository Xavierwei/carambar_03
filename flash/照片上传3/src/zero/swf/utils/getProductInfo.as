/***
getProductInfo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月08日 11:08:45
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import flash.utils.ByteArray;
	
	import zero.swf.SWF;
	import zero.swf.Tag;
	import zero.swf.TagTypes;
	import zero.swf.tagBodys.ProductIDAndEditions;
	import zero.swf.tagBodys.ProductInfo;
	import zero.utils.getTime;
	
	/**
	 * 获取 swf 的产品信息
	 * @param swfData 需要分析的swf数据<br/>
	 * 如要获取当前 swf 的产品信息，可以 getProductInfo(stage.loaderInfo.bytes);
	 * 
	 */
	public function getProductInfo(swfData:ByteArray):XML{
		var swf:SWF=new SWF();
		try{
			swf.initBySWFData(swfData,null);
		}catch(e:Error){
			trace("SWF 已加密或已损坏");
			return null;
		}
		for each(var tag:Tag in swf.tagV){
			if(tag.type==TagTypes.ProductInfo){
				var productInfo:ProductInfo=tag.getBody(ProductInfo,null);
				return <ProductInfo
					ProductID={ProductIDAndEditions.productIDV[productInfo.ProductID]}
					Edition={ProductIDAndEditions.editionV[productInfo.Edition]}
					MajorVersion={productInfo.MajorVersion}
					MinorVersion={productInfo.MinorVersion}
					BuildLow={productInfo.BuildLow}
					BuildHigh={productInfo.BuildHigh}
					CompilationDate={getTime("Y年m月d日 H:i:s.ms",new Date(productInfo.CompilationDate))}
				/>;
			}
		}
		return null;
	}
}