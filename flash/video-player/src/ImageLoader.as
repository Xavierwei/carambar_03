/***
ImageLoader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月22日 09:12:28
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import zero.ui.ImgLoader;

	public class ImageLoader extends ImgLoader{
		public function ImageLoader(){
		}
		override public function load(data:*, _dataType:String=null, _wid:int=0, _hei:int=0):void{
			if(data){
				if(xml&&xml.@src.toString()==data){
				}else{
					super.load(<img src={data} width={_wid} height={_hei} smoothing="true"/>);
				}
			}else{
				super.load("");
			}
		}
		public function setSize(wid:int,hei:int):void{
			if(
				loader
				&&
				loader.content
			){
				loader.scaleX=wid/loader.contentLoaderInfo.width;
				loader.scaleY=hei/loader.contentLoaderInfo.height;
			}else if(
				video
				&&
				video_is_showing
			){
				video.width=wid;
				video.height=hei;
			}else if(xml){
				xml.@width=wid;
				xml.@height=hei;
			}
		}
	}
}