/***
HScrollSwitch
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月28日 16:09:37
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
	
	/**
	 * 
	 * init 后将会自动依次加载所有 page
	 * 
	 */	
	public class HScrollSwitch extends BaseSwitch{
		
		private var loaderV:Vector.<Loader>;
		
		public function HScrollSwitch(){
		}
		internal function inited():void{
			loaderV=new Vector.<Loader>(navXMLV.length);
			loaderV.fixed=true;
			currLoadId=-1;
			loadNextPage();
		}
		private function loadNextPage():void{
			if(++currLoadId>=navXMLV.length){
				return;
			}
			
			loadPage(currLoadId);
			this.addChild(currLoader);
			loaderV[currLoadId]=currLoader;
			var y:int=0;
			var i:int=-1;
			for each(var navXML:XML in navXMLV){
				i++;
				if(i>=currLoadId){
					break;
				}
				y+=int(navXML.@height.toString())||loaderV[i].contentLoaderInfo.height;
			}
			loaderV[currLoadId].y=y;
		}
		internal function loadingPage():void{
			//
		}
		internal function loadPageCompleted():void{
			showPage(currLoader.content);
		}
		internal function pageFadeInCompleted():void{
			loadNextPage();
		}
		internal function pageFadeOutCompleted():void{
			//
		}
	}
}