package com.makeit.display 
{
	import flash.events.*;
	import flash.display.*;
	public class radioGroup extends EventDispatcher
	{
		public static var SELECT_RADIO:String="select_radio";
		private var groupArr:Array = new Array();
		public var selectMC:MovieClip;
		public var selectID:int=-1;
		public function radioGroup() 
		{
			
		}

		public function addRadio(...args):void {
	
			for (var i:uint = 0; i < args.length; i++ ) {
				groupArr.push(args[i]);
				args[i].buttonMode=true;
				args[i].id=groupArr.length-1;
				args[i].addEventListener(MouseEvent.CLICK, selectClickHandler);
				args[i].addEventListener(Event.REMOVED_FROM_STAGE,removeStageHandler);
				args[i].gotoAndStop(1);
			}
		}
		public function selectRadio(mc:MovieClip):void {
			if(groupArr.indexOf(mc)==-1&&mc!=null){
				trace("该组没有这个raido");
			
				return;
			}
			if(mc==null){
				if(selectMC)selectMC.gotoAndStop(1);
				selectMC=null;
				selectID=undefined;
			}else{
				if(selectMC)selectMC.gotoAndStop(1);
				selectMC = mc;
				selectMC.gotoAndStop(2);
				selectID=selectMC.id;
			}
			
		}
		private function selectClickHandler(e:MouseEvent):void {
			var target:MovieClip = e.currentTarget as MovieClip;
			selectRadio(target);
			this.dispatchEvent(new Event(SELECT_RADIO));
				
		}
		private function removeStageHandler(e:Event):void {
			var target:MovieClip = e.currentTarget as MovieClip;
			target.removeEventListener(MouseEvent.CLICK, selectClickHandler);
			target.removeEventListener(Event.REMOVED_FROM_STAGE,removeStageHandler);
		}
		
	}

}