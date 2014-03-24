/***
getFirstActionInsertPos
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月05日 17:08:07
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.swf.SWF;
	import zero.swf.Tag;
	import zero.swf.TagTypes;

	public function getFirstActionInsertPos(swf:SWF):int{
		for each(var tag:Tag in swf.tagV){
			switch(tag.type){
				//case TagTypes.FileAttributes:
				//	//
				//break;
				case TagTypes.ShowFrame:
				case TagTypes.DoAction:
				case TagTypes.PlaceObject2:
				case TagTypes.ExportAssets:
				case TagTypes.ImportAssets:
				case TagTypes.DoInitAction:
				case TagTypes.PlaceObject3:
				case TagTypes.ImportAssets2:
				case TagTypes.DoABCWithoutFlagsAndName:
				case TagTypes.SymbolClass:
				case TagTypes.DoABC:
					return swf.tagV.indexOf(tag);
				break;
				default:
					if(DefineObjs[TagTypes.typeNameV[tag.type]]){
						return swf.tagV.indexOf(tag);
					}
				break;
			}
		}
		throw new Error("getFirstActionInsertPos() 找不到合适的插入点");
	}
}