/***
Nav
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年8月12日 14:10:29
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import assets.BtnNav;
	import assets.NavClip;
	
	import com.greensock.TweenMax;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	import zero.getfonts.GetFont;
	import zero.ui.ImgLoader;
	
	public class Nav{
		public var clip:NavClip;
		private var xml:XML;
		public function Nav(){
		}
		
		public var btnNavV:Vector.<BtnNav>;
		
		public function init(_clip:*,_xml:XML):void{
			clip=_clip;
			xml=_xml;
			
			var i:int=-1;
			btnNavV=new Vector.<BtnNav>();
			while(++i<clip.numChildren){
				var btnNav:BtnNav=clip.getChildAt(i) as BtnNav;
				if(btnNav){
					btnNavV.push(btnNav);
				}
			}
			
			if(btnNavV.length==2){
				var autoAdjustXY:Boolean=true;
				var dx:int=btnNavV[1].x-btnNavV[0].x;
				var dy:int=btnNavV[1].y-btnNavV[0].y;
			}else{
				autoAdjustXY=false;
			}
			
			if(autoAdjustXY){
				var x:int=btnNavV[0].x;
				var y:int=btnNavV[0].y;
			}
			i=-1;
			if(clip.bg){
				var b:Rectangle=btnNavV[0].getBounds(clip);
			}
			for each(var navXML:XML in xml.nav){
				i++;
				if(i<btnNavV.length){
					btnNav=btnNavV[i];
				}else{
					btnNavV[i]=btnNav=new BtnNav();
					clip.addChild(btnNav);
				}
				if(autoAdjustXY){
					btnNav.x=x;
					btnNav.y=y;
				}
				if(clip.bg){
					b=b.union(btnNav.getBounds(clip));
				}
				var labelXML:XML=navXML.label[0];
				if(labelXML&&btnNav.label){
					GetFont.initTxt(btnNav.label["txt"],labelXML);
				}
				labelXML=navXML.label2[0]||labelXML;
				if(labelXML&&btnNav.label2){
					GetFont.initTxt(btnNav.label2["txt"],labelXML);
				}
				var enLabelXML:XML=navXML.enLabel[0];
				if(enLabelXML&&btnNav.enLabel){
					GetFont.initTxt(btnNav.enLabel["txt"],enLabelXML);
				}
				enLabelXML=navXML.enLabel2[0]||enLabelXML;
				if(enLabelXML&&btnNav.enLabel2){
					GetFont.initTxt(btnNav.enLabel2["txt"],enLabelXML);
				}
				if(autoAdjustXY){
					x+=dx;
					y+=dy;
				}
				if(navXML.@href.toString()||navXML.@js.toString()){
					btnNav.href=navXML;
				}else{
					btnNav.addEventListener(MouseEvent.CLICK,click);
				}
				if(navXML.@visible.toString()=="false"){
					btnNav.visible=false;
				}
				var iconXML:XML=navXML.icon[0];
				if(iconXML){
					var icon:ImgLoader=new ImgLoader();
					btnNav.icon.addChild(icon);
					icon.load(iconXML);
				}
				var iconXML2:XML=navXML.icon2[0];
				if(iconXML2){
					var icon2:ImgLoader=new ImgLoader();
					btnNav.icon2.addChild(icon2);
					icon2.load(iconXML2);
				}
			}
			if(btnNav.line){
				btnNav.line.visible=false;
			}
			while(++i<btnNavV.length){
				btnNavV[i].visible=false;
			}
			
			btnNav=btnNavV[getSelectedId()];
			btnNav.selected=true;
			btnNav.mouseEnabled=false;
			
			i=-1;
			for each(navXML in xml.nav){
				i++;
				if(
					navXML.@autoHide.toString()=="true"
					&&
					navXML.@selected.toString()=="true"
				){
					btnNavV[i].alpha=0;
				}
			}
			
			if(clip.btnPrev&&clip.btnNext){
				btnNav=btnNavV[0];
				dy=btnNav.y-clip.btnPrev.y;
				btnNav=btnNavV[btnNavV.length-1];
				clip.btnNext.y=btnNav.y+dy;
				clip.btnPrev.release=prev;
				clip.btnNext.release=next;
			}
			
			if(clip.bg){
				var d:int=20;
				clip.bg.x=b.x-d;
				clip.bg.y=b.y-d;
				clip.bg.width=b.width+d*2;
				clip.bg.height=b.height+d*2;
			}
			
			clip.mouseEnabled=false;
		}
		private function prev():void{
			select(xml.nav[getSelectedId()-1]);
		}
		private function next():void{
			select(xml.nav[getSelectedId()+1]);
		}
		private function updateBtns():void{
			if(clip.btnPrev&&clip.btnNext){
				var currId:int=getSelectedId();
				if(currId>0){
					clip.btnPrev.mouseEnabled=true;
					clip.btnPrev.alpha=1;
				}else{
					clip.btnPrev.mouseEnabled=false;
					clip.btnPrev.alpha=0.5;
				}
				if(currId<btnNavV.length-1){
					clip.btnNext.mouseEnabled=true;
					clip.btnNext.alpha=1;
				}else{
					clip.btnNext.mouseEnabled=false;
					clip.btnNext.alpha=0.5;
				}
			}
		}
		private function click(event:MouseEvent):void{
			var btnNav:BtnNav=event.target as BtnNav;
			if(btnNav){
				var i:int=-1;
				for each(var navXML:XML in xml.nav){
					i++;
					var _btnNav:BtnNav=btnNavV[i];
					if(btnNav==_btnNav){
						select(navXML);
						return;
					}
				}
			}
		}
		public function select(navXML:XML):void{
			var i:int=-1;
			for each(var _navXML:XML in xml.nav){
				i++;
				var _btnNav:BtnNav=btnNavV[i];
				if(navXML===_navXML){
					_navXML.@selected=true;
					_btnNav.selected=true;
					_btnNav.mouseEnabled=false;
				}else{
					_navXML.@selected=false;
					_btnNav.selected=false;
					_btnNav.mouseEnabled=true;
				}
			}
			i=-1;
			for each(_navXML in xml.nav){
				i++;
				_btnNav=btnNavV[i];
				if(_navXML.@autoHide.toString()=="true"){
					if(_navXML.@selected.toString()=="true"){
						TweenMax.to(_btnNav,12,{alpha:0,useFrames:true});
					}else{
						TweenMax.to(_btnNav,12,{alpha:1,useFrames:true});
					}
				}
			}
			updateBtns();
		}
		private function getSelectedId():int{
			var i:int=-1;
			for each(var navXML:XML in xml.nav){
				i++;
				if(navXML.@selected.toString()=="true"){
					return i;
				}
			}
			xml.nav[0].@selected=true;
			return 0;
		}
	}
}