/***
Station
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月27日 15:52:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import akdcl.utils.addContextMenu;
	
	import assets.BtnImg;
	import assets.Main;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	import zero.codec.MyCRC32;
	import zero.getfonts.GetFont;
	import zero.net.MultiLoader;
	import zero.ui.ImgLoader;
	import zero.utils.playAll;
	import zero.utils.stopAll;
	import zero.works.station.switchs.BaseSwitch;
	
	public class Station extends DocClass{
		
		public var main:Main;
		public var bg:ImgLoader;
		public var bottom:ImgLoader;
		public var nav:Nav;
		
		private var btnSkip_dy:int;
		private var kaitouIsPlaying:Boolean;
		
		protected var kaitouLoader:ImgLoader;
		private var kaitouLoaderGrid:Grid;
		
		private var prevloader:MultiLoader;
		private var prevloadPercent:Number;
		
		private var nav_layoutXML:XML;
		private var switch_layoutXML:XML;
		
		private var imgsSpV:Vector.<Sprite>;
		
		public var loading_value1:Number;
		private var loading_value2:Number;
		private var loading_time:int;
		
		public function Station(_optionsXMLPath:String,switchClass:Class,_loading_time:int){
			
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			optionsXMLPath=_optionsXMLPath;
			_switch=new switchClass();
			loading_time=_loading_time;
			onLoaded=loaded;
		}
		override protected function onInitHandler(_evt:Event):void{super.onInitHandler(_evt);
			setStageAlignAndScale(-1, -1, 0);//左上角对齐，不缩放
			stage.addEventListener(Event.RESIZE,resize);
			resize();
		}
		private function loaded():void{
			this.addEventListener(Event.ENTER_FRAME,checkXML);
		}
		private function checkXML(...args):void{
			if(optionsXML){
				this.removeEventListener(Event.ENTER_FRAME,checkXML);
				addContextMenu(this, "XML CRC32：#"+(0x100000000+MyCRC32.crc32string(optionsXML.toXMLString())).toString(16).substr(1).toUpperCase(),openXMLPage);
				GetFont.initBySWFData(this.loaderInfo.bytes);
				
				SubXMLLoader.loadSubXMLs(optionsXML,loadSubXMLsComplete);
			}
		}
		private function openXMLPage(...args):void{//右键 xml 版本，跳到 xml 页面
			navigateToURL(new URLRequest(optionsXMLPath),"_blank");
		}
		
		protected function loadSubXMLsComplete():void{
			
			//20130513
			if(ExternalInterface.available){
				try{
					var pageURL:String=ExternalInterface.call("top.location.href.toString")
				}catch(e:Error){
					pageURL=null;
				}
				if(pageURL){
				}else{
					try{
						pageURL=ExternalInterface.call("window.location.href.toString")
					}catch(e:Error){
						pageURL=null;
					}
				}
			}else{
				pageURL=null;
			}
			//pageURL="http://10.8.1.44/work/201305/%E7%A5%9E%E9%9B%95%E4%BE%A0%E4%BE%A35%E6%9C%88%E8%B5%84%E6%96%99%E7%89%87%E5%AE%98%E7%BD%91/web/index.htm#zuoxiangqicheng";
			if(pageURL){
				var matchArr:Array=pageURL.match(/#\w+/g);
				if(matchArr&&matchArr.length){
					var anchor:String=matchArr[0].substr(1);
					for each(var navXML:XML in optionsXML.nav){
						if(navXML.@anchor.toString()==anchor){
							var anchorNavXML:XML=navXML;
							for each(navXML in optionsXML.nav){
								navXML.@selected=false;
							}
							anchorNavXML.@selected=true;
							break;
						}
					}
				}
			}
			
			this.addChild(main=new Main());
			if(main.fade_ani){
				main.fade_ani.stop();
				main.fade_ani.addFrameScript(int(main.fade_ani.totalFrames/2)-1,main.fade_ani.stop);
				main.fade_ani.addFrameScript(main.fade_ani.totalFrames-1,main.fade_ani.stop);
			}
			
			var i:int=main.numChildren;
			while(--i>=0){
				var child:DisplayObject=main.getChildAt(i);
				if(child.hasOwnProperty("mouseEnabled")){
					child["mouseEnabled"]=false;
				}
				if(child.hasOwnProperty("mouseChildren")){
					child["mouseChildren"]=false;
				}
			}
			
			main.loading=main.mainLoading;
			if(optionsXML.loading[0]){
				main.loading.style=optionsXML.loading[0].style[0];
			}
			
			if(main.musicCtrl){
				main.musicCtrl.visible=false;
			}
			
			if(main.nav){
				nav=new Nav();
				
				nav.init(main.nav,optionsXML);
				nav.clip.mouseChildren=true;
				nav.clip.visible=false;
				nav_layoutXML=optionsXML.nav_layout[0];
				if(nav_layoutXML){
				}else{
					nav_layoutXML=getLayout(nav.clip,null,"center");
				}
			}
			switch_layoutXML=optionsXML.switch_layout[0];
			if(switch_layoutXML){
			}else{
				switch_layoutXML=getLayout(_switch,null,"center middle");
			}
			
			main.mouseEnabled=false;
			main.container.mouseChildren=true;
			if(main.btnSkip){
				main.btnSkip.alpha=0;
				btnSkip_dy=main.btnSkip.y-main.loading.y;
				
				var btnSkipXML:XML=optionsXML.kaitou[0].btnSkip[0];
				if(btnSkipXML&&btnSkipXML.@autoHide.toString()=="true"){
					main.btnSkip.addEventListener(MouseEvent.MOUSE_OVER,showBtnSkip);
					main.btnSkip.addEventListener(MouseEvent.MOUSE_OUT,hideBtnSkip);
				}
			}
			
			var prevloadXMLArr:Array=new Array();
			for each(var prevloadAttXML:XML in optionsXML..@prevload){
				var srcXML:XML=prevloadAttXML.parent();
				if(srcXML&&srcXML.@prevload.toString()=="true"){
					prevloadXMLArr.push(<node src={srcXML.@src.toString()}/>);
				}
			}
			
			loading_value1=0;
			TweenMax.to(this,loading_time*30,{loading_value1:1,useFrames:true});
			this.addEventListener(Event.ENTER_FRAME,checkMainLoading);
			main.loading.show();
			
			if(prevloadXMLArr.length){
				prevloadXMLArr.sort(sortPrevloadXMLArr);
				i=-1;
				var nodeXMLList:XMLList=new XMLList();
				for each(var prevloadXML:XML in prevloadXMLArr){
					i++;
					nodeXMLList[i]=prevloadXML;
				}
				trace("预加载：\n"+nodeXMLList.toXMLString());
				if(optionsXML.@prevloadPercent.toString()){
					prevloadPercent=Number(optionsXML.@prevloadPercent.toString());
				}else{
					prevloadPercent=0.2;
				}
				var kaitouXML:XML=optionsXML.kaitou[0];
				if(kaitouXML){
					if(kaitouXML.@skip.toString()=="true"){
						prevloadPercent=1;
					}
				}else{
					prevloadPercent=1;
				}
				prevloader=new MultiLoader();
				prevloader.onLoadProgress=prevloadProgress;
				prevloader.onLoadComplete=prevloadComplete;
				prevloader.load(nodeXMLList,MultiLoader.BINARY);
				resize();
			}else{
				prevloadPercent=0;
				prevloadComplete();
			}
		}
		private static const extOrders:Object={
			jpg:1,
			png:2,
			gif:3,
			swf:4,
			flv:5
		}
		private function sortPrevloadXMLArr(prevloadXML1:XML,prevloadXML2:XML):int{
			var ext1:String=prevloadXML1.@src.toString().replace(/^.*\.(\w+)$/,"$1").toLowerCase();
			var ext2:String=prevloadXML2.@src.toString().replace(/^.*\.(\w+)$/,"$1").toLowerCase();
			//trace("ext1="+ext1,"ext2="+ext2);
			var extOrder1:int=extOrders[ext1];//没有就自动0了
			var extOrder2:int=extOrders[ext2];//没有就自动0了
			if(extOrder1<extOrder2){
				return -1;
			}
			if(extOrder1>extOrder2){
				return 1;
			}
			return 0;
		}
		private function prevloadProgress(value:Number):void{
			loading_value2=value*prevloadPercent;
		}
		private function prevloadComplete(...args):void{
			//trace("预加载完毕");
			if(prevloader){
				prevloader.clear();
				prevloader=null;
			}
			
			if(main.btnSkip){
				main.btnSkip.mouseEnabled=true;
				TweenMax.killTweensOf(main.btnSkip);
				TweenMax.to(main.btnSkip,12,{alpha:1,useFrames:true});
				main.btnSkip.release=skipLoading;
			}
			
			var kaitouXML:XML=optionsXML.kaitou[0];
			if(kaitouXML){
				if(kaitouXML.@skip.toString()=="true"){
					//trace("跳过开头动画");
				}else{
					if(main.btnSkip){
						main.btnSkip.release=skipKaitou1;
					}
					main.container.addChild(kaitouLoader=new ImgLoader());
					kaitouLoader.visible=false;
					kaitouLoader.autoPlay=false;
					kaitouLoader.onLoadProgress=loadKaitouProgress;
					kaitouLoader.onLoadComplete=loadKaitouComplete;
					kaitouLoader.onPlayComplete=playKaitouComplete;
					kaitouLoader.load(kaitouXML.video[0]);
				}
			}else{
				//trace("没有开头动画");
			}
			
			resize();
		}
		
		private function skipLoading():void{
			main.btnSkip.mouseEnabled=false;
			main.btnSkip.removeEventListener(MouseEvent.MOUSE_OVER,showBtnSkip);
			main.btnSkip.removeEventListener(MouseEvent.MOUSE_OUT,hideBtnSkip);
			TweenMax.killTweensOf(main.btnSkip);
			TweenMax.to(main.btnSkip,12,{alpha:0,useFrames:true});
			TweenMax.killTweensOf(this);
			loading_value1=1;
		}
		private function loadKaitouProgress(value:Number):void{
			loading_value2=prevloadPercent+value*(1-prevloadPercent);
		}
		protected function loadKaitouComplete():void{
			loading_value2=1;
		}
		protected function playKaitou():void{
			//trace("playKaitou");
			if(main.btnSkip){
				main.btnSkip.release=skipKaitou2;
			}
			var btnSkipXML:XML=optionsXML.kaitou[0].btnSkip[0];
			if(btnSkipXML&&btnSkipXML.@autoHide.toString()=="true"){
				hideBtnSkip();
			}
			kaitouIsPlaying=true;
			kaitouLoader.visible=true;
			var kaitouXML:XML=optionsXML.kaitou[0];
			if(kaitouXML.@needGrid.toString()=="true"){
				main.container.addChild(kaitouLoaderGrid=new Grid());
			}
			kaitouLoader.resume();
			resize();
		}
		
		private function skipKaitou1():void{
			//开头动画未加载完毕，跳过
			main.btnSkip.mouseEnabled=false;
			main.btnSkip.removeEventListener(MouseEvent.MOUSE_OVER,showBtnSkip);
			main.btnSkip.removeEventListener(MouseEvent.MOUSE_OUT,hideBtnSkip);
			TweenMax.killTweensOf(main.btnSkip);
			TweenMax.to(main.btnSkip,12,{alpha:0,useFrames:true});
			kaitouLoader.clear();
			main.container.removeChild(kaitouLoader);
			kaitouLoader=null;
			if(kaitouLoaderGrid){
				main.container.removeChild(kaitouLoaderGrid);
				kaitouLoaderGrid.clear();
				kaitouLoaderGrid=null;
			}
			loading_value2=1;
		}
		private function checkMainLoading(...args):void{
			main.loading.value=Math.min(loading_value1,loading_value2);
			if(
				loading_value1>=1
				&&
				loading_value2>=1
			){
				this.removeEventListener(Event.ENTER_FRAME,checkMainLoading);
				main.loading.hide(kaitouLoader?playKaitou:showPages);
			}
		}
		
		private function skipKaitou2():void{
			//开头动画正在播放，跳过
			kaitouLoader.pause();
			playKaitouComplete();
		}
		
		private function showBtnSkip(...args):void{
			TweenMax.killTweensOf(main.btnSkip);
			TweenMax.to(main.btnSkip,12,{alpha:1,delay:30,useFrames:true});
		}
		private function hideBtnSkip(...args):void{
			TweenMax.killTweensOf(main.btnSkip);
			TweenMax.to(main.btnSkip,12,{alpha:0,useFrames:true});
		}
		
		private function playKaitouComplete():void{
			showPages();
		}
		protected function showPages():void{
			if(main.btnSkip){
				main.btnSkip.mouseEnabled=false;
				main.btnSkip.removeEventListener(MouseEvent.MOUSE_OVER,showBtnSkip);
				main.btnSkip.removeEventListener(MouseEvent.MOUSE_OUT,hideBtnSkip);
				TweenMax.killTweensOf(main.btnSkip);
				TweenMax.to(main.btnSkip,12,{alpha:0,useFrames:true});
			}
			
			var btnBackXML:XML=optionsXML.btnBack[0];
			if(btnBackXML){
				if(main.btnBack){
					getLayout(main.btnBack,btnBackXML,"center middle");
					if(btnBackXML.label[0]){
						GetFont.initTxt(main.btnBack["label"].txt,btnBackXML.label[0]);
					}
					if(btnBackXML.icon[0]){
						var btnBacn_icon:ImgLoader=new ImgLoader();
						main.btnBack["icon"].addChild(btnBacn_icon);
						btnBacn_icon.load(btnBackXML.icon[0]);
					}
					if(btnBackXML.bg[0]){
						var btnBacn_bg:ImgLoader=new ImgLoader();
						main.btnBack["bg"].addChild(btnBacn_bg);
						btnBacn_bg.load(btnBackXML.bg[0]);
					}
					main.btnBack.release=back;
					main.btnBack.alpha=0;
				}
			}
			
			var bgXML:XML=optionsXML.bg[0];
			if(bgXML){
				main.addChildAt(bg=new ImgLoader(),0);
				bg.onFadeComplete=fadeBgComplete;
				bg.load(bgXML);
				bg.mouseEnabled=bg.mouseChildren=false;
				resize();
			}else{
				fadeBgComplete();
			}
		}
		protected function showMusicCtrl():void{
			var musicXML:XML=optionsXML.music[0];
			if(musicXML){
				if(main.musicCtrl){
					main.musicCtrl.visible=true;
					main.musicCtrl.mouseChildren=true;
					getLayout(main.musicCtrl,musicXML);
					(main.musicCtrl as MusicCtrl).init(musicXML,getQualifiedClassName(this)+"_musicctrl");
				}
			}
		}
		protected function fadeBgComplete():void{
			
			BtnFullScreen;
			
			showMusicCtrl();
			
			var imgsXML:XML=optionsXML.imgs[0];
			if(imgsXML){
				if(main.imgs){
					imgsSpV=new Vector.<Sprite>();
					main.imgs.mouseChildren=true;
					for each(var subXML:XML in imgsXML.children()){
						
						var sp:Sprite=main.imgs[subXML.name().toString()];
						if(sp){
						}else{
							sp=new BtnImg();
							main.imgs.addChild(sp);
						}
						
						getLayout(sp,subXML);
						
						var btn:BtnImg=sp as BtnImg;
						if(btn){
							var img:ImgLoader=new ImgLoader();
							btn.container.addChild(img);
							img.load(subXML);
							if(subXML.@href.toString()||subXML.@js.toString()){
								btn.href=subXML;
								btn.mouseEnabled=true;
							}else{
								btn.href=null;
								btn.mouseEnabled=false;
							}
							if(subXML.@mouseChildren=="true"){
								btn.mouseChildren=true;
							}
						}else{
							GetFont.initTxt(sp["txt"],subXML);
						}
						
						imgsSpV.push(sp);
					}
				}
			}
			
			var bottomXML:XML=optionsXML.bottom[0];
			if(bottomXML){
				main.addChild(bottom=new ImgLoader());
				bottom.load(bottomXML);
				bottom.mouseEnabled=false;
				//var bottom_layoutXML:XML=bottomXML.layout[0];
				//if(bottom_layoutXML){
				//}else{
				//	bottomXML.layout[0]=bottom_layoutXML=getLayout(bottom,null,"left bottom");
				//}
			}
			
			showNav();
			
			if(main.subLoading){
				stopAll(main.loading);
				main.removeChild(main.loading);
				main.loading=main.subLoading;
				if(optionsXML.loading[0]){
					var style:XML=optionsXML.loading[0].style[1];
					if(style){
						main.loading.style=style;
					}
				}
			}
			
			main.container.addChild(_switch);
			_switch.init(optionsXML.nav,optionsXML.@simulateDownload.toString()=="true",loadPage,loadPageProgress,loadPageComplete,showingPage,pageFadeInComplete,pageFadeOutComplete);
			
			var prevloadsXML:XML=<prevloads/>;
			for each(var innerprevloadAttXML:XML in optionsXML..@innerprevload){
				var srcXML:XML=innerprevloadAttXML.parent();
				if(srcXML&&srcXML.@innerprevload.toString()=="true"){
					prevloadsXML.appendChild(<node src={srcXML.@src.toString()}/>);
				}
			}
			var nodeXMLList:XMLList=prevloadsXML.children();
			if(nodeXMLList.length()){
				trace("内页预加载：\n"+nodeXMLList.toXMLString());
				prevloader=new MultiLoader();
				//prevloader.onLoadProgress=innerprevloadProgress;
				//prevloader.onLoadComplete=innerPrevloadComplete;
				prevloader.load(nodeXMLList,MultiLoader.BINARY);
			}
			
			resize();
		}
		protected function showNav():void{
			if(nav){
				nav.clip.visible=true;
				TweenMax.killTweensOf(nav.clip);
				nav.clip.alpha=1;
				TweenMax.from(nav.clip,12,{alpha:0,useFrames:true});
			}
		}
		
		private function back():void{
			for each(var navXML:XML in optionsXML.nav){
				if(navXML.@isIndex.toString()=="true"){
					navXML.@selected=true;
				}else{
					navXML.@selected=false;
				}
			}
		}
		private function loadPage():void{
			//trace("loadPage");
			var btnBackXML:XML=optionsXML.btnBack[0];
			if(btnBackXML){
				if(main.btnBack){
					main.btnBack.mouseEnabled=false;
					TweenMax.to(main.btnBack,12,{alpha:0,useFrames:true});
				}
			}
			if(main.fade_ani){
				main.fade_ani.gotoAndPlay(int(main.fade_ani.totalFrames/2)+1);
			}
			for each(var navXML:XML in optionsXML.nav){
				//trace("navXML.@selected.toString()="+navXML.@selected.toString());
				if(navXML.@selected.toString()=="true"){
					if(navXML.@noShowLoading.toString()=="true"){
					}else{
						main.loading.visible=true;
						main.loading.show();
					}
					if(nav){
						nav.select(navXML);
					}
					return;
				}
			}
		}
		private function loadPageProgress(value:Number):void{
			main.loading.value=value;
		}
		private function loadPageComplete():void{
			main.loading.hide(null);
			resize();
		}
		protected function showingPage():void{
			if(nav){
				nav.clip.mouseChildren=false;
			}
		}
		protected function pageFadeInComplete():void{
			if(nav){
				nav.clip.mouseChildren=true;
			}
			if(kaitouLoader){
				kaitouLoader.clear();
				main.container.removeChild(kaitouLoader);
				kaitouLoader=null;
			}
			if(kaitouLoaderGrid){
				main.container.removeChild(kaitouLoaderGrid);
				kaitouLoaderGrid.clear();
				kaitouLoaderGrid=null;
			}
			if(main.fade_ani){
				main.fade_ani.gotoAndPlay(2);
			}
			var btnBackXML:XML=optionsXML.btnBack[0];
			if(btnBackXML){
				if(main.btnBack){
					for each(var navXML:XML in optionsXML.nav){
						if(navXML.@selected.toString()=="true"){
							if(navXML.@isIndex.toString()=="true"){
								main.btnBack.mouseEnabled=false;
								TweenMax.to(main.btnBack,12,{alpha:0,useFrames:true});
							}else{
								main.btnBack.mouseEnabled=true;
								TweenMax.to(main.btnBack,12,{alpha:1,useFrames:true});
							}
						}
					}
				}
			}
		}
		private function pageFadeOutComplete():void{
			
		}
		
		private function getLayout(sp:Sprite,xml:XML,align:String="auto"):XML{
			var layoutXML:XML=xml?xml.layout[0]:null;
			if(layoutXML){
			}else{
				layoutXML=<layout/>;
				if(xml){
					xml.appendChild(layoutXML);
				}
				
				if(align=="auto"){
					
					//if(sp.x<1920/2){
					//	layoutXML.@left=int(sp.x);
					//}else{
					//	layoutXML.@right=int(1920-sp.x);
					//}
					layoutXML.@horizontalCenter=int(sp.x-1920/2);
					
					if(sp.y<854/2){
						layoutXML.@top=int(sp.y);
					}else{
						layoutXML.@bottom=int(854-sp.y);
					}
					//layoutXML.@verticalCenter=int(sp.y-845/2);
				}else{
					if(align.indexOf("center")>-1){
						layoutXML.@horizontalCenter=int(sp.x-1920/2);
					}
					if(align.indexOf("left")>-1){
						layoutXML.@left=int(sp.x);
					}
					if(align.indexOf("right")>-1){
						layoutXML.@right=int(1920-sp.x);
					}
					
					if(align.indexOf("middle")>-1){
						layoutXML.@verticalCenter=int(sp.y-845/2);
					}
					if(align.indexOf("top")>-1){
						layoutXML.@top=int(sp.y);
					}
					if(align.indexOf("bottom")>-1){
						layoutXML.@bottom=int(854-sp.y);
					}
				}
			}
			return layoutXML;
		}
		private function updateSpByLayout(sp:Sprite,layoutXML:XML):void{
			if(layoutXML.@horizontalCenter.toString()){
				sp.x=stage.stageWidth/2+int(layoutXML.@horizontalCenter.toString());
			}else if(layoutXML.@left.toString()){
				sp.x=int(layoutXML.@left.toString());
			}else if(layoutXML.@right.toString()){
				sp.x=stage.stageWidth-int(layoutXML.@right.toString());
			}
			if(layoutXML.@verticalCenter.toString()){
				sp.y=stage.stageHeight/2+int(layoutXML.@verticalCenter.toString());
			}else if(layoutXML.@top.toString()){
				sp.y=int(layoutXML.@top.toString());
			}else if(layoutXML.@bottom.toString()){
				sp.y=stage.stageHeight-int(layoutXML.@bottom.toString());
			}
			
			if(layoutXML.@max_x.toString()){
				var max_x:int=int(layoutXML.@max_x.toString());
				if(sp.x>max_x){
					sp.x=max_x;
				}
			}
			if(layoutXML.@min_x.toString()){
				var min_x:int=int(layoutXML.@min_x.toString());
				if(sp.x<min_x){
					sp.x=min_x;
				}
			}
			
			if(layoutXML.@max_y.toString()){
				var max_y:int=int(layoutXML.@max_y.toString());
				if(sp.y>max_y){
					sp.y=max_y;
				}
			}
			if(layoutXML.@min_y.toString()){
				var min_y:int=int(layoutXML.@min_y.toString());
				if(sp.y<min_y){
					sp.y=min_y;
				}
			}
		}
		protected function resize(...args):void{
			
			//trace(stage.stageWidth,stage.stageHeight);
			
			//this.graphics.clear();
			//this.graphics.beginFill(0x000000);
			//this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			//this.graphics.endFill();
			
			if(main){
				
				//trace("nav_layoutXML="+nav_layoutXML.toXMLString());
				if(nav){
					updateSpByLayout(nav.clip,nav_layoutXML);
				}
				
				var btnBackXML:XML=optionsXML.btnBack[0];
				if(btnBackXML&&btnBackXML.layout[0]){
					if(main.btnBack){
						updateSpByLayout(main.btnBack,btnBackXML.layout[0]);
					}
				}
				
				var musicXML:XML=optionsXML.music[0];
				if(musicXML){
					if(main.musicCtrl){
						updateSpByLayout(main.musicCtrl,musicXML.layout[0]);
					}
				}
				
				var imgsXML:XML=optionsXML.imgs[0];
				if(imgsXML){
					if(main.imgs){
						if(imgsSpV){
							var i:int=-1;
							for each(var subXML:XML in imgsXML.children()){
								i++;
								updateSpByLayout(imgsSpV[i],subXML.layout[0]);
							}
						}
					}
				}
				
				if(bg){
					bg.x=-(1920-stage.stageWidth)/2;
					bg.y=-(854-stage.stageHeight)/2;
				}
				
				if(bottom){
					var bottomXML:XML=optionsXML.bottom[0];
					if(bottomXML){
						var bottom_layoutXML:XML=bottomXML.layout[0];
						if(bottom_layoutXML){
							updateSpByLayout(bottom,bottom_layoutXML);
						}else{
							bottom.y=stage.stageHeight;//底部左下角对齐
							if(bottomXML.@align.toString().indexOf("right")>-1){
								bottom.x=stage.stageWidth;
							}else if(bottomXML.@align.toString().indexOf("center")>-1){
								bottom.x=stage.stageWidth/2;
							}
						}
					}
				}
				
				main.loading.x=-(1920-stage.stageWidth)/2;
				main.loading.y=-(854-stage.stageHeight)/2;
				
				if(main.btnSkip){
					var btnSkipXML:XML=optionsXML.kaitou[0].btnSkip[0];
					main.btnSkip.x=stage.stageWidth/2;
					if(kaitouIsPlaying){
						if(btnSkipXML&&btnSkipXML.playing_layout[0]){
							updateSpByLayout(main.btnSkip,btnSkipXML.playing_layout[0]);
						}else{
							var b:Rectangle=main.btnSkip.getBounds(main);
							main.btnSkip.y+=stage.stageHeight-20-b.bottom;
						}
					}else{
						if(btnSkipXML&&btnSkipXML.layout[0]){
							updateSpByLayout(main.btnSkip,btnSkipXML.layout[0]);
						}else{
							main.btnSkip.y=main.loading.y+btnSkip_dy;
						}
					}
				}
				
				if(kaitouLoader){
					var videoWid0:int=int(optionsXML.kaitou[0].video[0].@width.toString());
					var videoHei0:int=int(optionsXML.kaitou[0].video[0].@height.toString());
					if(videoWid0/videoHei0<stage.stageWidth/stage.stageHeight){
						kaitouLoader.scaleX=kaitouLoader.scaleY=stage.stageWidth/videoWid0;
					}else{
						kaitouLoader.scaleX=kaitouLoader.scaleY=stage.stageHeight/videoHei0;
					}
					kaitouLoader.x=(stage.stageWidth-videoWid0*kaitouLoader.scaleX)/2;
					kaitouLoader.y=(stage.stageHeight-videoHei0*kaitouLoader.scaleY)/2;
				}
				
				if(main.fade_ani){
					main.fade_ani.x=-(1920-stage.stageWidth)/2;
					main.fade_ani.y=-(854-stage.stageHeight)/2;
				}
				if(main.others){
					main.others.x=-(1920-stage.stageWidth)/2;
					main.others.y=-(854-stage.stageHeight)/2;
				}
				
				if(_switch){
					updateSpByLayout(_switch,switch_layoutXML);
					
					_switch.x=Math.round(_switch.x);//20130510
					
					//trace("_switch.x="+_switch.x);
					
					if(
						_switch.currLoader
						&&
						_switch.currLoader.content
						&&
						_switch.currLoader.content.hasOwnProperty("resize")
					){
						_switch.currLoader.content["resize"](stage.stageWidth,stage.stageHeight);
					}
				}
			}
		}
	}
}