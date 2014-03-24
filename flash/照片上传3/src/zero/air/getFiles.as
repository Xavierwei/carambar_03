/***
getFiles
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年5月17日 11:11:07
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.air{
	import flash.filesystem.File;
	
	public function getFiles(file:File,extension:*=null):Array{
		
		var reg:RegExp;
		if(extension){
			if(extension is RegExp){
				reg=extension;
			}else{
				reg=new RegExp(
					"^"+extension
					.replace(/^\s*|\s*$/g,"")
					.replace(/^;*|;*$/g,"")
					.replace(/;/g,"|")
					.replace(/\./g,"\\.")
					.replace(/\*/g,".*")
					+"$"
				);
			}
		}else{
			reg=/^.*$/;
		}
			
		if(file.exists){
			if(file.isDirectory){
				var arr:Array=new Array();
				for each(var subFile:File in file.getDirectoryListing()){
					arr.push.apply(arr,getFiles(subFile,reg));
				}
				return arr;
			}
			if(reg.test(decodeURI(file.url))){
				return [file];
			}
		}
		return [];
	}
}