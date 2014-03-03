package com.makeit.effects {
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.*;

	/**
	 * @author Happy
	 */
	public class rotationGroup extends EventDispatcher {
		public static const ROTATION_COMPLETE:String="rotation_complete";
		public static const SELECT:String="select";
		//自动点击播放
		private var _autoRelease:Boolean=true;
		private var _releaseID:int=0;
		//自动旋转
		private var _autoR:Boolean=true;
		//根据鼠标移动
		private var _isMouseMove:Boolean=false;
		private var _timer:Timer;
		private var _duration:Number=3;
		//
		private var _num:Number;
		private var _centerX:Number=0;
		private var _centerY:Number=0;
		private var _R1:Number=300;
		private var _R2:Number=100;
		private var _miniScale:Number=5;
		private var _maxScale:Number=30;
		private var _maxAlpha:Number=100;
		private var _miniAlpha:Number=0;
		
		private var _way:int=1;
		private var _orgSpeed:Number;
		private var _speed:Number=5;
		private var _angle:Number=(360/_num)*Math.PI/180;
		//是否在正在旋转
		private var isRoing:Boolean=false;
		//
		private var rollArr:Array=new Array();
		private var orgArr:Array=new Array();
		
		private var conSprite:Sprite;
		
		public function rotationGroup(container:Sprite,obj:Object=null):void {
				conSprite=container;
				
				_autoRelease=obj&&obj.autoRelease!=null?obj.autoRelease:false;
				_releaseID=obj&&obj.releaseID!=null?obj.releaseID:0;
				_autoR=obj&&obj.autoR!=null?obj.autoR:true;
				_duration=obj&&obj.duration!=null?obj.duration:3;
				_centerX=obj&&obj.centerX!=null?obj.centerX:0;
				_centerY=obj&&obj.centerY!=null?obj.centerY:0;
				_R1=obj&&obj.R1!=null?obj.R1:300;
				_R2=obj&&obj.R2?obj.R2:100;
				_miniScale=obj&&obj.miniScale!=null?obj.miniScale:0;
				_maxScale=obj&&obj.maxScale!=null?obj.maxScale:100;
				_maxAlpha=obj&&obj.maxAlpha!=null?obj.maxAlpha:100;
				_miniAlpha=obj&&obj.miniAlpha!=null?obj.miniAlpha:0;
				_orgSpeed=_speed=obj&&obj.speed!=null?obj.speed:5;
				_isMouseMove=obj&&obj.isMouseMove!=null?obj.isMouseMove:false;
				
		
		}
		private function speedEnter(e:Event):void{
			_speed=-conSprite.mouseX/10000;
		
		}
		
		
		public function leftArrowClick(e:Event):void{
			_releaseID--;
			if(_releaseID<0){
				_releaseID=_num-1;
			}
			rotationHandler(_releaseID);
			
		}
		public function rightArrowClick(e:Event):void{
			
			_releaseID++;
			if(_releaseID>=_num){
				_releaseID=0;
			}
			rotationHandler(_releaseID);
			
		}
		
		public function init(){
			_num=rollArr.length;
			_angle=(360/_num)*Math.PI/180;
			for(var i:Number=0;i<_num;i++){
				
				var mc:MovieClip=orgArr[i] as MovieClip;
		
				mc.x=Math.sin(_angle*i)*_R2+_centerX;
				mc.y=Math.cos(_angle*i)*_R1+_centerY;
				mc.r=_angle*i*180/Math.PI;
				mc.angle=_angle*i;
				mc.scaleX=mc.scaleY=getScale(shortRotation(mc.r));
				//mc.alpha=mc.scaleX
				mc.id=i;
				mc.alpha=getAlpha(shortRotation(mc.r));
				mc.targetAngle=mc.angle;
				mc.buttonMode=true;
				mc.addEventListener(MouseEvent.CLICK,clickHandler);
				//mc.addEventListener(MouseEvent.ROLL_OVER,rollOverHandler);
				//mc.addEventListener(MouseEvent.ROLL_OUT,rollOutHandler);
		
			}
			setDepth();
			recoverState();
			
			//autoReleaseHandler()
			
		}
		private function autoRelease():void{
			if(!isRoing&&_autoRelease){
				_timer=new Timer(_duration*1000,1);
				_timer.addEventListener(TimerEvent.TIMER,autoReleaseHandler);
				_timer.start();
			}
		}
		private function removeAutoRelease():void{
			if(_timer){
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,autoReleaseHandler);
				_timer=null;
			}
		}
		private function clickHandler(e:MouseEvent):void{
			var targetMC:MovieClip=e.currentTarget as MovieClip;

			//if(_releaseID!=targetMC.id){
				rotationHandler(targetMC.id);
			//}else{
				//this.dispatchEvent(new Event("select"));
			//}
		}
		private function rollOverHandler(e:MouseEvent):void{
			var targetMC:MovieClip=e.currentTarget as MovieClip;
			removeAutoRelease();
			if(_releaseID==targetMC.id){
				targetMC.addEventListener(Event.ENTER_FRAME,AdsorptionEnterHandler);
			}
			
		}
		private function rollOutHandler(e:MouseEvent):void{
			if(!isRoing&&_autoRelease){
				_timer=new Timer(_duration*1000,1);
				_timer.addEventListener(TimerEvent.TIMER,autoReleaseHandler);
				_timer.start();
			}
		}
		private function AdsorptionEnterHandler(e:Event):void{
			var targetMC:MovieClip=e.currentTarget as MovieClip;
			
		}
		private function shortRotation(value:Number):Number{
			var temp:Number;
			if(value>360){
				temp=value%360;
			}else if(value<0){
				temp=value%360+360;
			}else{
				temp=value;
			}
			return temp;
		}
		private function getScale(value:Number):Number{
			var temp:Number=Math.abs(180-value);
			var scale:Number=((_maxScale-_miniScale)/180)*temp+_miniScale;
			return scale/100;
		}
		private function getAlpha(value:Number):Number{
			var temp:Number=Math.abs(180-value);
			var _alpha:Number=((_maxAlpha-_miniAlpha)/180)*temp+_miniAlpha;
			return _alpha/100;
			
		}
		
		private function setDepth():void{
			rollArr.sortOn("scaleX");
			for(var i:uint=0;i<rollArr.length;i++){
				conSprite.setChildIndex(rollArr[i],i);
			}
		}
		
		private function rotationHandler(ID:Number){
			if(_timer){
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,autoReleaseHandler);
				_timer=null;
			}
			//clearTimeout(timeOutID)
			
		
			_releaseID=ID;
			var mc:MovieClip=orgArr[_releaseID] as MovieClip;
			var disR:Number=getDis(shortRotation(mc.r));
			
			//_tempSpeed=_speed;
			_speed=5;
			_way=disR/Math.abs(disR);
			//
			for(var i:Number=0;i<_num;i++){
				mc=orgArr[i] as MovieClip;
				mc.targetAngle=mc.r+disR;
				mc.removeEventListener(Event.ENTER_FRAME,autoRotationEnter);
				mc.addEventListener(Event.ENTER_FRAME,rotationEnter);
			}
		}
		private function rotationEnter(e:Event):void{
			var targetMC:MovieClip=e.target as MovieClip;
			targetMC.r+=(targetMC.targetAngle-targetMC.r)/_speed;
			targetMC.angle=targetMC.r*Math.PI/180;
			targetMC.x=Math.sin(targetMC.angle)*_R2+_centerX;
			isRoing=true;
			
			if(_isMouseMove){
				targetMC.y=Math.cos(targetMC.angle)*(conSprite.mouseY/2)-targetMC.x*(_speed/10)*(conSprite.mouseY/2)/2;
			}else{
				targetMC.y=Math.cos(targetMC.angle)*_R1+_centerY;
			}
			//trace(targetMC.r)
			targetMC.scaleX=targetMC.scaleY=getScale(shortRotation(targetMC.r));
			targetMC.alpha=getAlpha(shortRotation(targetMC.r));
			setDepth();
			if(Math.floor(Math.abs(targetMC.targetAngle-targetMC.r))==0){
				
				isRoing=false;
				/*
				if(Math.floor(shortRotation(targetMC.r))==0&&_autoRelease){
					
					_timer=new Timer(_duration*1000,1);
					_timer.addEventListener(TimerEvent.TIMER,autoReleaseHandler);
					_timer.start();
					
				}
				if(_autoR){
					autoRotation();
					_speed=_orgSpeed*_way;
				}
				 * 
				 */
				 recoverState();
				targetMC.removeEventListener(Event.ENTER_FRAME,rotationEnter);
				
				dispatchEvent(new Event(ROTATION_COMPLETE));
			
			}
			
		}
		private function autoRotation(){
			for(var i:Number=0;i<_num;i++){
				var mc:MovieClip=orgArr[i] as MovieClip;
				mc.removeEventListener(Event.ENTER_FRAME,rotationEnter);
				mc.removeEventListener(Event.ENTER_FRAME,autoRotationEnter);
				mc.addEventListener(Event.ENTER_FRAME,autoRotationEnter);
			}
			
		}
		private function removeAutoRotation():void{
			for(var i:Number=0;i<_num;i++){
				var mc:MovieClip=orgArr[i] as MovieClip;
				mc.removeEventListener(Event.ENTER_FRAME,rotationEnter);
			}
		}
		private function removeAutoRotationEnter():void{
			for(var i:Number=0;i<_num;i++){
				var mc:MovieClip=orgArr[i] as MovieClip;
				mc.removeEventListener(Event.ENTER_FRAME,autoRotationEnter);
			}
		}
		
		private function autoRotationEnter(e:Event):void{
			var targetMC:MovieClip=e.target as MovieClip;
			targetMC.angle+=_speed;
			targetMC.r=targetMC.angle*180/Math.PI;
			targetMC.x=Math.sin(targetMC.angle)*_R2+_centerX;
			
			isRoing=true;
			//targetMC.y=Math.cos(targetMC.angle)*R1+centerY
			if(_isMouseMove){
				targetMC.y=Math.cos(targetMC.angle)*(conSprite.mouseY/2)-targetMC.x*(_speed/10)*(conSprite.mouseY/2)/2;
			}else{
				targetMC.y=Math.cos(targetMC.angle)*_R1+_centerY;
			}
			
			targetMC.scaleX=targetMC.scaleY=getScale(shortRotation(targetMC.r));
			targetMC.alpha=getAlpha(shortRotation(targetMC.r));
			setDepth();
			
		}
		private function autoReleaseHandler(e:TimerEvent=null){
			_releaseID++;
			if(_releaseID>=_num){
				_releaseID=0;
			}
			rotationHandler(_releaseID);
		}
		private function getDis(value:Number):Number{
			var temp:Number;
			if(value>180){
				temp=360-value;
			}else{
				temp=-value;
			}
			return temp;
		}
		public function get releaseID():int{
			return _releaseID;
		}
		//
		public function addChild(mc:MovieClip):void{
			rollArr.push(mc);
			orgArr.push(mc);
		}
		public function addChilds(mcArr:Array):void{
			rollArr=mcArr.slice();
			orgArr=mcArr.slice();
		}
		public function removeRotation():void{
			removeAutoRotation();
			removeAutoRotationEnter();
		}
		public function recoverState():void{
			
			//autoReleaseHandler()
			_speed=_orgSpeed*_way;
			if(_isMouseMove&&_autoR){
				conSprite.addEventListener(Event.ENTER_FRAME,speedEnter);
			}else if(_autoR){
				autoRotation();
			}else if(_autoRelease){
				autoRelease();
			}
		}
		
	}
}
