/***
FadeSwitch
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月28日 14:35:17
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station.switchs{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.utils.killAllTweens;
	import zero.utils.removeAll;
	import zero.utils.stopAll;
	
	/**
	 * 
	 * init 后将会自动检测设置 selected 为 true 的 navXML 进行切换
	 * 
	 */	
	public class FadeSwitch extends BaseSwitch{
		
		private var bottomContainer:Sprite;
		private var container:Sprite;
		private var oldPage:DisplayObject;
		private var currPage:DisplayObject;
		
		public function FadeSwitch(){
		}
		internal function inited():void{
			currLoadId=-1;
			this.addChild(bottomContainer=new Sprite());
			bottomContainer.mouseEnabled=bottomContainer.mouseChildren=false;
			this.addChild(container=new Sprite());
			container.mouseEnabled=false;
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(...args):void{
			for each(var navXML:XML in navXMLV){
				if(navXML.@selected.toString()=="true"){
					if(currLoadId==navXMLV.indexOf(navXML)){
						return;
					}
					loadPage(navXMLV.indexOf(navXML));
					container.addChild(currLoader);
					return;
				}
			}
			navXMLV[0].@selected=true;//如果没有 selected 为 true 的 navXML，将会默认选中第一个
		}
		internal function loadingPage():void{
			if(currLoader){
				clearBottomContainer();
				bottomContainer.addChild(currLoader);
				stopAll(bottomContainer);
				oldPage=currLoader.content;
				if(oldPage.hasOwnProperty("pause")){
					oldPage["pause"]();
				}
			}
		}
		internal function loadPageCompleted():void{
			currPage=currLoader.content;
			if(oldPage){
				hidePage(oldPage);
				oldPage=null;
			}else{
				showCurrPage();
			}
		}
		internal function pageFadeInCompleted():void{
			clearBottomContainer();
		}
		internal function pageFadeOutCompleted():void{
			showCurrPage();
		}
		private function showCurrPage():void{
			if(currPage){
				showPage(currPage);
				currPage=null;
			}
		}
		private function clearBottomContainer():void{
			stopAll(bottomContainer);
			var i:int=bottomContainer.numChildren;
			while(--i>=0){
				oldPage=(bottomContainer.getChildAt(i) as Loader).content;
				if(oldPage.hasOwnProperty("clear")){
					oldPage["clear"]();
				}
				if(oldPage is DisplayObjectContainer){
					killAllTweens(oldPage as DisplayObjectContainer);
					stopAll(oldPage as DisplayObjectContainer);
					removeAll(oldPage as DisplayObjectContainer);
				}
				bottomContainer.removeChildAt(i);
			}
		}
	}
}