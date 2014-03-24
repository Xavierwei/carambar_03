/***
LunboImages
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年7月21日 18:05:41
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import akdcl.media.MediaPlayer;
	
	import com.greensock.TweenMax;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.*;
	
	import ui.Btn;
	
	import zero.ui.*;
	
	public class LunboImages extends Sprite{
		
		public var xml:XML;
		
		public var btnPrev:Btn;
		public var btnNext:Btn;
		
		public var icons:Sprite;
		
		private var IconClass:Class;
		
		private var iconArea:Sprite;
		private var scrollMaskSp:Sprite;
		private var num:int;
		private var d:int;
		
		public var currId:int;
		
		private var direction:String;
		
		private var imgNodeName:String;
		
		private var timeoutId:int;
		
		public function LunboImages(mask_inflate_dx:int=4,mask_inflate_dy:int=4){
			if(icons){
				IconClass=icons.getChildAt(0)["constructor"];
				switch(IconClass){
					case Shape:
					case Bitmap:
					case Sprite:
					case MovieClip:
						throw new Error("需要 IconClass");
					break;
				}
			}
			
			direction="横向";
			initIcons(icons,mask_inflate_dx,mask_inflate_dy);
			initBtns(btnPrev,btnNext);
		}
		public function initIcons(_icons:Sprite,mask_inflate_dx:int,mask_inflate_dy:int):void{
			icons=_icons;
			if(icons){
				d=icons.getChildAt(1).x-icons.getChildAt(0).x;
				if(d*d<4){
					direction="纵向";
					d=icons.getChildAt(1).y-icons.getChildAt(0).y;
				}
				
				var b:Rectangle=icons.getBounds(icons);
				//向外扩展几像素
				b.inflate(mask_inflate_dx,mask_inflate_dy);
				
				num=icons.numChildren;
				
				var i:int=num;
				while(--i>=0){
					icons.removeChildAt(i);
				}
				
				iconArea=new Sprite();
				icons.addChild(iconArea);
				scrollMaskSp=new Sprite();
				icons.addChild(scrollMaskSp);
				scrollMaskSp.graphics.clear();
				scrollMaskSp.graphics.beginFill(0x000000);
				//scrollMaskSp.graphics.beginFill(0xff0000,0.3);trace("测试");
				scrollMaskSp.graphics.drawRect(b.x,b.y,b.width,b.height);
				scrollMaskSp.graphics.endFill();
				icons.mask=scrollMaskSp;
			}else{
				num=1;
			}
		}
		public function initBtns(...btns):void{
			for each(var btn:Btn in btns){
				if(btn){
					switch(btn.name){
						case "btnPrev":
							btnPrev=btn;
							btnPrev.release=prev;
						break;
						case "btnNext":
							btnNext=btn;
							btnNext.release=next;
						break;
					}
				}
			}
		}
		
		public function clear():void{
			clearTimeout(timeoutId);
			
			clearIcons();
			
			IconClass=null;
			
			xml=null;
		}
		private function clearIcons():void{
			if(iconArea){
				var i:int=iconArea.numChildren;
				while(--i>=0){
					iconArea.getChildAt(i)["clear"]();
					iconArea.removeChildAt(i);
				}
			}
		}
		
		public function init(_xml:XML,_imgNodeName:String=null):void{
			
			clearTimeout(timeoutId);
			
			clearIcons();
			
			xml=_xml;
			imgNodeName=_imgNodeName||"img";
			
			if(iconArea){
				iconArea.x=0;
				iconArea.y=0;
			}
			currId=0;
			
			var imgXML:XML,i:int;
			
			if(iconArea){
				var pos:int=0;
				i=-1;
				for each(imgXML in xml[imgNodeName]){
					i++;
					var icon:Btn=new IconClass();
					iconArea.addChild(icon);
					switch(direction){
						case "横向":
							icon.x=pos;
						break;
						case "纵向":
							icon.y=pos;
						break;
					}
					icon["initXML"](imgXML,imgXML.@icon.toString()||imgXML.@src.toString());
					pos+=d;
				}
			}
			
			timeoutId=setTimeout(lunbo,int(Number(xml.@time.toString())*1000));
		}
		private function scroll():void{
			clearTimeout(timeoutId);
			if(iconArea){
				switch(direction){
					case "横向":
						TweenMax.to(iconArea,12,{x:-currId*d,useFrames:true});
					break;
					case "纵向":
						TweenMax.to(iconArea,12,{y:-currId*d,useFrames:true});
					break;
				}
			}
			timeoutId=setTimeout(lunbo,int(Number(xml.@time.toString())*1000));
		}
		private function prev():void{
			currId--;
			var icon:Btn=iconArea.getChildAt(iconArea.numChildren-1) as Btn;
			iconArea.addChildAt(icon,0);
			icon.x=currId*d;
			scroll();
		}
		private function next():void{
			var icon:Btn=iconArea.getChildAt(0) as Btn;
			iconArea.addChild(icon);
			icon.x=(currId+xml[imgNodeName].length())*d;
			currId++;
			scroll();
		}
		
		private function lunbo():void{
			next();
		}
	}
}