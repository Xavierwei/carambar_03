/***
BasePage
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年8月12日 15:02:31
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.getfonts.GetFont;
	import zero.ui.ImgLoader;
	
	public class BasePage extends MovieClip{
		
		public var xml:XML;
		
		private var xmlLoader:URLLoader;
		
		protected var bg:ImgLoader;
		private var char:ImgLoader;
		
		private var onFadeInComplete:Function;
		private var onFadeOutComplete:Function;
		
		public var appArea:Sprite;
		
		private var fadeInTargetFrameLabel:FrameLabel;//20130511
		
		public function BasePage(){
			
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			this.stop();
			this.visible=false;
			var i:int=this.numChildren;
			while(--i>=0){
				var child:DisplayObject=this.getChildAt(i);
				if(child.hasOwnProperty("mouseEnabled")){
					child["mouseEnabled"]=false;
				}
				if(child.hasOwnProperty("mouseChildren")){
					child["mouseChildren"]=false;
				}
			}
			if(appArea){
				appArea.mouseChildren=true;
			}
			if(
				stage
				&&
				this.parent==stage
			){
				trace("测试");
				//GetFont.fontsFolderPath="../fonts/";trace("测试");
				stage.align=StageAlign.TOP_LEFT;
				stage.scaleMode=StageScaleMode.NO_SCALE;
				stage.addEventListener(Event.RESIZE,_resize);
				xmlLoader=new URLLoader();
				xmlLoader.addEventListener(Event.COMPLETE,loadXMLComplete);
				xmlLoader.load(new URLRequest("../xml/options.xml"));
			}
			
		}
		private function loadXMLComplete(...args):void{
			SubXMLLoader.loadSubXMLs(new XML(xmlLoader.data.replace(/\s+(src|href|xml|icon)="/g,' $1="../')),loadSubXMLsComplete);
			xmlLoader.removeEventListener(Event.COMPLETE,loadXMLComplete);
			xmlLoader=null;
		}
		private function loadSubXMLsComplete(xml0:XML):void{
			for each(var navXML:XML in xml0.nav){
				if(navXML.swf[0]&&navXML.swf[0].@src.toString().indexOf(getQualifiedClassName(this).split(/\W+/).pop().toLowerCase())>-1){
					xml=navXML;
					init(xml);
					_resize();
					return;
				}
			}
		}
		private function _resize(...args):void{
			this.x=-(1920-stage.stageWidth)/2;
			if(this.hasOwnProperty("resize")){
				this["resize"](stage.stageWidth,stage.stageHeight);
			}
		}
		public function init(_xml:XML):void{
			xml=_xml;
			//trace("xml="+xml);
			if(
				stage
				&&
				this.parent==stage
			){
				fadeIn(null);
			}
		}
		public function fadeIn(_onFadeInComplete:Function):void{
			this.visible=true;
			onFadeInComplete=_onFadeInComplete;
			var bgXML:XML=xml.bg[0];
			if(bgXML){
				this.addChildAt(bg=new ImgLoader(),0);
				bg.onFadeComplete=fadeInComplete;
				bg.load(bgXML);
			}else{
				this.alpha=0;
				TweenMax.to(this,12,{alpha:1,onComplete:fadeInComplete,useFrames:true});
			}
		}
		private function loadCharComplete():void{
			TweenMax.from(char,12,{alpha:0,x:100,ease:Back.easeOut,onComplete:fadeOutComplete,useFrames:true});
		}
		protected function fadeInComplete():void{
			if(this.currentLabels&&this.currentLabels.length==1){
				var frameLabel:FrameLabel=this.currentLabels[0];
				if(frameLabel.name=="fadeInTarget"){
					fadeInTargetFrameLabel=frameLabel;
				}
			}
			if(fadeInTargetFrameLabel){
				this.play();
				this.addFrameScript(frameLabel.frame-1,fadeInTargetFrame);
			}else{
				_fadeInComplete();
			}
		}
		protected function fadeInTargetFrame():void{
			this.addFrameScript(fadeInTargetFrameLabel.frame-1,null);
			this.stop();
			_fadeInComplete();
		}
		private function _fadeInComplete():void{
			var charXML:XML=xml.char[0];
			if(charXML){
				this.addChildAt(char=new ImgLoader(),bg?1:0);
				char.onLoadComplete=loadCharComplete;
				char.load(charXML);
			}
			if(onFadeInComplete==null){
			}else{
				onFadeInComplete();
				onFadeInComplete=null;
			}
		}
		public function fadeOut(_onFadeOutComplete:Function):void{
			onFadeOutComplete=_onFadeOutComplete;
			if(char){
				TweenMax.to(char,12,{alpha:0,x:100,ease:Back.easeIn,onComplete:fadeOutComplete,useFrames:true});
			}else{
				fadeOutComplete();
			}
		}
		protected function fadeOutComplete():void{
			if(fadeInTargetFrameLabel){
				this.addFrameScript(this.totalFrames-1,lastFrame);
				this.play();
			}else{
				_fadeOutComplete();
			}
		}
		private function lastFrame():void{
			this.addFrameScript(this.totalFrames-1,null);
			this.stop();
			_fadeOutComplete();
		}
		private function _fadeOutComplete():void{
			if(onFadeOutComplete==null){
			}else{
				onFadeOutComplete();
				onFadeOutComplete=null;
			}
		}
		
		protected var isPause:Boolean;
		public function pause():void{
			isPause=true;
		}
		public function resume():void{
			isPause=false;
		}
		
		public function clear():void{
			if(xml){
				xml=null;
				if(bg){
					bg.clear();
					bg=null;
				}
				if(char){
					char.clear();
					char=null;
				}
				onFadeInComplete=null;
				onFadeOutComplete=null;
			}
		}
	}
}