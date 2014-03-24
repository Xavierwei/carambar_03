/***
BaseSwitch
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月28日 14:29:30
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station.switchs{
	import com.greensock.TweenMax;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.utils.TempFun;
	
	public class BaseSwitch extends Sprite{
		
		public var navXMLV:Vector.<XML>;
		
		private var simulateDownload:Boolean;
		private var simulateDownload_bytesLoaded:int;
		
		internal var currLoadId:int;
		public var currLoader:Loader;
		
		private var onLoadPage:Function;
		private var onLoadPageProgress:Function;
		private var onLoadPageComplete:Function;
		private var onShowingPage:Function;
		private var onPageFadeInComplete:Function;
		private var onPageFadeOutComplete:Function;
		
		public function BaseSwitch(){
		}
		public function init(
			navXMLList:XMLList,
			_simulateDownload:Boolean,
			_onLoadPage:Function,
			_onLoadPageProgress:Function,
			_onLoadPageComplete:Function,
			_onShowingPage:Function,
			_onPageFadeInComplete:Function,
			_onPageFadeOutComplete:Function
		):void{
			
			simulateDownload=_simulateDownload;
			if(simulateDownload){
				trace("测试，模拟加载");
			}
			
			this.mouseEnabled=false;
			
			navXMLV=new Vector.<XML>();
			for each(var navXML:XML in navXMLList){
				navXMLV.push(navXML);
			}
			navXMLV.fixed=true;
			
			onLoadPage=_onLoadPage;
			onLoadPageProgress=_onLoadPageProgress;
			onLoadPageComplete=_onLoadPageComplete;
			onShowingPage=_onShowingPage;
			onPageFadeInComplete=_onPageFadeInComplete;
			onPageFadeOutComplete=_onPageFadeOutComplete;
			
			this["inited"]();
		}
		internal function loadPage(_currLoadId:int):void{
			this["loadingPage"]();
			currLoadId=_currLoadId;
			if(currLoader){
				try{
					currLoader.close();
				}catch(e:Error){};
				currLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loadPageProgress);
				currLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadPageComplete);
				currLoader=null;
			}
			currLoader=new Loader();
			currLoader.visible=false;
			
			if(simulateDownload){
				simulateDownload_bytesLoaded=0;
				this.addEventListener(Event.ENTER_FRAME,simulateDownload_step);
			}else{
				currLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,loadPageProgress);
				currLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadPageComplete);
			}
			
			currLoader.load(new URLRequest(navXMLV[currLoadId].swf[0].@src.toString()));
			//currLoader.load(new URLRequest(navXMLV[currLoadId].swf[0].@src.toString()+"?"+Math.random()));trace("测试，添加随机数字");
			
			
			if(onLoadPage==null){
			}else{
				onLoadPage();
			}
		}
		private function simulateDownload_step(...args):void{
			if(currLoader.contentLoaderInfo.bytesTotal>0){
				if((simulateDownload_bytesLoaded+=10000)>currLoader.contentLoaderInfo.bytesTotal){
					simulateDownload_bytesLoaded=currLoader.contentLoaderInfo.bytesTotal;
				}
				var event:ProgressEvent=new ProgressEvent(ProgressEvent.PROGRESS);
				event.bytesLoaded=simulateDownload_bytesLoaded;
				event.bytesTotal=currLoader.contentLoaderInfo.bytesTotal;
				loadPageProgress(event);
				
				if(simulateDownload_bytesLoaded==currLoader.contentLoaderInfo.bytesTotal){
					this.removeEventListener(Event.ENTER_FRAME,simulateDownload_step);
					loadPageComplete();
				}
			}
		}
		private function loadPageProgress(event:ProgressEvent):void{
			if(event.bytesTotal>0){
				if(onLoadPageProgress==null){
				}else{
					onLoadPageProgress(event.bytesLoaded/event.bytesTotal);
				}
			}
		}
		internal function loadPageComplete(...args):void{
			currLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loadPageProgress);
			currLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadPageComplete);
			if(onLoadPageComplete==null){
			}else{
				onLoadPageComplete();
			}
			this["loadPageCompleted"]();
		}
		internal function showPage(page:DisplayObject):void{
			if(onShowingPage==null){
			}else{
				onShowingPage();
			}
			currLoader.visible=true;
			if(page.hasOwnProperty("init")){
				page["init"](navXMLV[currLoadId]);
			}
			if(page.hasOwnProperty("resize")){
				page["resize"](stage.stageWidth,stage.stageHeight);
			}
			if(page.hasOwnProperty("fadeIn")){
				page["fadeIn"](new TempFun(pageFadeInComplete,page).fun);
			}else{
				TweenMax.from(page,12,{alpha:0,useFrames:true,onComplete:new TempFun(pageFadeInComplete,page).fun});//默认 fadeIn 是 透明渐显
			}
		}
		internal function hidePage(page:DisplayObject):void{
			if(page.hasOwnProperty("fadeOut")){
				page["fadeOut"](new TempFun(pageFadeOutComplete,page).fun);
			}else{
				//TweenMax.to(page,12,{alpha:0,useFrames:true,onComplete:new TempFun(pageFadeOutComplete,page).fun});//默认 fadeOut 是 透明渐隐
				pageFadeOutComplete(page);//默认直接完事
			}
		}
		private function pageFadeInComplete(page:DisplayObject):void{
			if(onPageFadeInComplete==null){
			}else{
				onPageFadeInComplete();
			}
			this["pageFadeInCompleted"]();
		}
		private function pageFadeOutComplete(page:DisplayObject):void{
			if(onPageFadeOutComplete==null){
			}else{
				onPageFadeOutComplete();
			}
			this["pageFadeOutCompleted"]();
		}
	}
}