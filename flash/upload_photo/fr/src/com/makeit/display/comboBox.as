package com.makeit.display
{
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*
	import com.greensock.plugins.*;
	public class comboBox extends MovieClip
	{
		public var listMC:list;
		public var hotRect:MovieClip;
		public var label_t:TextField;
		public var showID:uint;
		private var selfAlpha:uint=0;
		
		public function comboBox() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE,addStageHandler);
		}
		private function addStageHandler(e:Event):void {
			init();
		}
		private function init():void {
			TweenPlugin.activate([AutoAlphaPlugin]);
			//label_t.mouseChildren=false
			listMC.visible = false;
			listMC.alpha = selfAlpha;
			hotRect.addEventListener(MouseEvent.CLICK,selfClickHandler);
			listMC.addEventListener(MouseEvent.CLICK, listClickHandler);
			listMC.addEventListener(list.ITEM_CLICK,itemClickHandler);
			
		}
		private function itemClickHandler(e:Event):void {
			label_t.text = listMC.showLabel;
			showID=listMC.showID;
			stageClickHandler(null);
		}
		public function setData(data:Array):void {
			
			listMC.setData(data);
			label_t.text = listMC.showLabel;
			showID=listMC.showID;
			
		}
		public  function set setLabel(str:String):void{
			label_t.text=str;
		}
		public  function get getLabel():String{
			return label_t.text;
		}
		private function listClickHandler(e:MouseEvent):void {
			e.stopImmediatePropagation();
		}
		private function selfClickHandler(e:MouseEvent):void {
			//e.stopImmediatePropagation()
			e.stopPropagation();
			selfAlpha = 1 - selfAlpha;

			TweenLite.to(listMC, .3, { autoAlpha:selfAlpha} );
			stage.addEventListener(MouseEvent.CLICK, stageClickHandler);
		}
		
		private function stageClickHandler(e:MouseEvent):void {
			selfAlpha=0;
			TweenLite.to(listMC, .3, { autoAlpha:selfAlpha } );
			if(stage){
				stage.removeEventListener(MouseEvent.CLICK, stageClickHandler);
			}
		}
		//
		public function set comboBoxWidth(value:Number):void {
			label_t.width = value-20;
			hotRect.width = value;
			listMC.listBg.width = value;
			listMC.maskMC.width = value;
			listMC.dragMC.x = value-2;
			listMC.barMC.x=value-2;
			
		}
		public function set comboBoxHeight(value:Number):void {
			listMC.maskMC.height = value;
			listMC.listBg.height = value;
			
			listMC.barMC.height = value-3;
			
		}
	}

}