package com.makeit.display 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import com.makeit.display.scroll;
	import com.makeit.display.silder;
	import flash.geom.Rectangle;
	import com.greensock.*
	import com.makeit.utils.DisplayObjectUtilities;
	public class list extends MovieClip
	{
		public var listMC:MovieClip;
		public var listBg:MovieClip;
		public var maskMC:MovieClip;
		public var dragMC:MovieClip;
		public var barMC:MovieClip;
		public var showLabel:String;
		public var showID:uint;
		public static const ITEM_CLICK:String="item_click";
		
		private var silderObj:silder;
		private var scrollObj:scroll;
		public function list() 
		{
			setData([]);
		}
		public function setData(data:Array):void {
			clearList();
			for (var i:uint = 0; i < data.length; i++ ) {
				var mc:MovieClip = new listItem();
				mc.y = i * 16;
				mc.label_t.text = data[i];
				mc.label_t.width =this.listBg.width-7;
				mc.bgMC.width = this.listBg.width - 7;
				mc.id=i;
			
				mc.bgMC.alpha = 0;
				mc.buttonMode=true;
				mc.addEventListener(MouseEvent.ROLL_OVER, itemRollOverHandler);
				mc.addEventListener(MouseEvent.ROLL_OUT, itemRollOutHandler);
				mc.addEventListener(MouseEvent.CLICK,itemClickHandler);
				listMC.addChild(mc);
			}
			if (data.length > 0) {
				showLabel=data[0];
				this.dispatchEvent(new Event(list.ITEM_CLICK,true));
			}
			if (listMC.numChildren == 0) {
				listBg.height=0;
			}else if (maskMC.height > listMC.height) {
				listBg.height=listMC.height+5;
			}else {
				listBg.scaleY=1;
			}
			silderObj=new silder(stage,dragMC,barMC,new Rectangle(dragMC.x,dragMC.y,0,barMC.height-dragMC.height));
			scrollObj=new scroll(silderObj,listMC,2,maskMC.height);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeStageHandler);
		}
		
		private function clearList():void {
			showLabel="";
			showID=0;
			DisplayObjectUtilities.removeAllChildren(listMC);
			listMC.y=2;
			
		}
		private function itemRollOverHandler(e:MouseEvent):void {
			var target:MovieClip=e.currentTarget as MovieClip;
			TweenLite.to(target.bgMC,.3,{alpha:1});
		}
		private function itemRollOutHandler(e:MouseEvent):void {
			var target:MovieClip=e.currentTarget as MovieClip;
			TweenLite.to(target.bgMC,.3,{alpha:0});
		}
		private function itemClickHandler(e:MouseEvent):void {
			var target:MovieClip=e.currentTarget as MovieClip;
			showLabel = target.label_t.text;
			showID=target.id;
			this.dispatchEvent(new Event(list.ITEM_CLICK,true));
			
		}
		private function removeStageHandler(e:Event):void{
			if(scrollObj){
				scrollObj.destroy();
				scrollObj=null;
			}
			if(silderObj){
				silderObj.destroy();
				silderObj=null;
			}
			
		}
	}

}