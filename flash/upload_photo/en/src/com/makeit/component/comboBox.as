package com.makeit.component {
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.BevelFilterPlugin;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.BezierThroughPlugin;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.CacheAsBitmapPlugin;
	import com.greensock.plugins.CirclePath2DPlugin;
	import com.greensock.plugins.ColorMatrixFilterPlugin;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.DropShadowFilterPlugin;
	import com.greensock.plugins.EndArrayPlugin;
	import com.greensock.plugins.EndVectorPlugin;
	import com.greensock.plugins.FilterPlugin;
	import com.greensock.plugins.FrameBackwardPlugin;
	import com.greensock.plugins.FrameForwardPlugin;
	import com.greensock.plugins.FrameLabelPlugin;
	import com.greensock.plugins.FramePlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.HexColorsPlugin;
	import com.greensock.plugins.QuaternionsPlugin;
	import com.greensock.plugins.RemoveTintPlugin;
	import com.greensock.plugins.RoundPropsPlugin;
	import com.greensock.plugins.ScalePlugin;
	import com.greensock.plugins.ScrollRectPlugin;
	import com.greensock.plugins.SetActualSizePlugin;
	import com.greensock.plugins.SetSizePlugin;
	import com.greensock.plugins.ShortRotationPlugin;
	import com.greensock.plugins.SoundTransformPlugin;
	import com.greensock.plugins.StageQualityPlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TransformMatrixPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VisiblePlugin;
	import com.greensock.plugins.VolumePlugin;
	import com.makeit.display.scroll;
	import com.makeit.display.slider;
	import com.makeit.utils.DisplayObjectUtilities;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Happy
	 */
	public class comboBox extends MovieClip {
		public static const ITEM_CLLICK:String="item_cllick";
		public var label_t:TextField;
		public var listMC:MovieClip;
		public var listBg:MovieClip;
		public var maskMC:MovieClip;
		//public var upBtn:MovieClip;
		//public var downBtn:MovieClip;
		//public var dragMC:MovieClip;
	//	public var barMC:MovieClip;
		public var boxRectMC:MovieClip;
		public var arrowMC:MovieClip;
		private var _isExtend:Boolean=false;
		private var _scrollObj:scroll;
		private var _silderObj:slider;
		private var _selectID:uint;
		private var _per:Number;
		private var _dataArr:Array=new Array();
		
		public function comboBox() {
			
			TweenPlugin.activate([FramePlugin,TintPlugin, ColorTransformPlugin,RemoveTintPlugin]);
			arrowMC.mouseEnabled=arrowMC.mouseChildren=false;
			this.addEventListener(Event.ADDED_TO_STAGE, addStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeStageHandler);
			this.addFrameScript(0,frame1,this.totalFrames-1,lastFrame);
		}
		private function addStageHandler(e:Event):void{
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		private function removeStageHandler(e:Event):void{
			if(_silderObj){
				_silderObj.destroy();
				_silderObj=null;
			}
			if(_scrollObj){
				_scrollObj.destroy();
				_scrollObj=null;
			}
		
		}
		private function mouseUpHandler(e:Event):void{
			if(listMC){
				listMC.removeEventListener(MouseEvent.MOUSE_MOVE, listMouseMoveHandler);
			}
			TweenLite.to(this, .5, {frame:1});
		}
		private function frame1():void{
			_isExtend=false;
			label_t.mouseEnabled=false;
			boxRectMC.buttonMode=true;
			boxRectMC.addEventListener(MouseEvent.CLICK, rectClickHandler);
			stop();
		}
		private function lastFrame():void{
			setData(_dataArr);
			stop();
		
		}
		private function rectClickHandler(e:MouseEvent):void{
			if(_dataArr.length==0){
				return;
			}
			if(_isExtend){
				//TweenLite.to(this, .5, {frame:1});
				mouseUpHandler(null);
			}else{
				TweenLite.to(this, .5, {frame:this.totalFrames});
			}
			_isExtend=!_isExtend;
		}
		private function setData(dataArr:Array):void{
			DisplayObjectUtilities.removeAllChildren(listMC);
			for(var i:uint=0;i<dataArr.length;i++){
				var tempClass:Class=getDefinitionByName("listItem") as Class;
				var mc:MovieClip=new tempClass() as MovieClip;
				mc.x=0;
				mc.y=i*15;
				mc.label_t.mouseEnabled=false;
				mc.label_t.text=dataArr[i];
				mc.buttonMode=true;
				mc.id=i;
				mc.addEventListener(MouseEvent.ROLL_OVER, listRollOverHandler);
				mc.addEventListener(MouseEvent.ROLL_OUT, listRollOutHandler);
				mc.addEventListener(MouseEvent.CLICK, listClickHandler);
				listMC.addChild(mc);
			}
			_per=(listMC.height-maskMC.height)/maskMC.height;
			TweenLite.from(listMC, .3, {alpha:0,onComplete:moveFunc});
		}
		private function moveFunc():void{
			if(listMC.height>maskMC.height){
				listMC.addEventListener(MouseEvent.MOUSE_MOVE, listMouseMoveHandler);
			}
		}
		private function listMouseMoveHandler(e:MouseEvent):void{
			var _y:Number=-(maskMC.mouseY)*_per+maskMC.y;
			TweenLite.to(listMC, .3, {y:_y});
		
		
		}
		private function listRollOverHandler(e:MouseEvent):void{
			var target:MovieClip=e.currentTarget as MovieClip;
			TweenMax.to(target,.3, {colorTransform:{tint:0xff0000, tintAmount:1}});
			//#960909
		}
		private function listRollOutHandler(e:MouseEvent):void{
			var target:MovieClip=e.currentTarget as MovieClip;
			TweenLite.to(target,.3, {removeTint:true});
		}
		private function listClickHandler(e:MouseEvent):void{
			var target:MovieClip=e.currentTarget as MovieClip;
		
			_selectID=target.id;
			label=target.label_t.text;
			dispatchEvent(new Event(ITEM_CLLICK));
			
			mouseUpHandler(null);
			//TweenLite.to(this, .5, {frame:1});
		}
		
		/*
		 * ===========================setter getter====================================================
		 */
		 public function set label(value:String):void{
		 	label_t.text=value;
		 }
		 public function get label():String{
		 	return label_t.text;
		 }
		 public function get selectID():uint{
		 	return _selectID;
		 }
		 public function set labelRestrict(value:String):void{
		 	label_t.restrict=value;
		 }
		 public function set data(arr:Array):void{
		 	_dataArr=arr;
		 }
		
	}
}
