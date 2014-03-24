/***
SingleBtn
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月2日 14:04:09
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	public class SingleBtn extends BaseCom{
		
		public var defaultXMLStr:String='<xml href="http://zero.flashwing.net" target="_blank" js="" btnGra=""/>';
		
		public var btn:Btn;
		
		public function SingleBtn(){
		}
		public function initComplete():void{
			if(xml.@btnGra.toString()){
				loadAsset(xml.@btnGra.toString(),loadBtnGraDataComplete);
			}else if(assets&&assets.btnGraData){
				loadAsset("btnGraData",loadBtnGraDataComplete);
			}
		}
		private function loadBtnGraDataComplete(btnGraLoader:Loader):void{
			trace("btn.numChildren="+btn.numChildren);
			trace("btn.getChildAt(0)['numChildren']="+btn.getChildAt(0)['numChildren']);
			((btn.getChildAt(0) as Sprite).getChildAt(0) as Sprite).addChild(btnGraLoader);
			btnGraLoader.x=-btnGraLoader.contentLoaderInfo.width/2;
			btnGraLoader.y=-btnGraLoader.contentLoaderInfo.height/2;
			
			if(xml.@href.toString()){
				btn.href=<xml href={xml.@href.toString()} target={xml.@target.toString()||"_blank"}/>;
			}else if(xml.@js.toString()){
				btn.href=<xml js={xml.@js.toString()}/>;
			}
		}
	}
}