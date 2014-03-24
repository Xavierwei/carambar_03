package zero.ui{
	import akdcl.display.UIDisplay;
	import akdcl.events.MediaEvent;
	import akdcl.layout.Display;
	import akdcl.layout.Group;
	import akdcl.media.PlayState;
	import akdcl.media.PlayerSkin;
	import akdcl.media.providers.MediaProvider;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import zero.utils.stopAll;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class AutoFitMediaSkin extends PlayerSkin {
		private static const GLOW_HIGH:Object = {alpha: 1, blurX: 4, blurY: 4, strength: 2};
		private static const GLOW_LOW:Object = {alpha: 1, blurX: 2, blurY: 2, strength: 1};

		private static const PLAY_SHOW:Object = {autoAlpha: 1, scaleX: 1, scaleY: 1};
		private static const PLAY_HIDE:Object = {autoAlpha: 0, scaleX: 0, scaleY: 0};

		private static function glowHith(_clip:*):void {
			TweenMax.to(_clip, 1, {glowFilter: GLOW_HIGH, ease: Elastic.easeOut});
		}

		private static function glowLow(_clip:*):void {
			TweenMax.to(_clip, 0.5, {glowFilter: GLOW_LOW});
		}

		private static function setColor(_clip:*, _color:uint = 0):void {
			TweenMax.to(_clip, 0, {tint: _color});
		}

		public var glowColor:uint = 0xff0000;

		public var barBottom:*;

		private var layoutXML:XML;

		private var group:Group;

		override protected function init():void {
			super.init();
			
			stopAll(this);
			
			displayContainer = new UIDisplay(50, 50, -1);
			displayContainer.addEventListener(MouseEvent.CLICK, onDisplayClickHandler);
			addChildAt(displayContainer, 0);

			GLOW_HIGH.color = glowColor;
			GLOW_LOW.color = glowColor;

			barBottom.alpha = 0.5;

			setColor(barPlayProgress.bar, glowColor);

			glowLow(btnPlay);
			glowLow(btnStop);
			glowLow(btnPlayPause);
			glowLow(btnPrev);
			glowLow(btnNext);
			glowLow(btnVolume);
			glowLow(barVolume);
			glowLow(barPlayProgress);
			glowLow(txtPlayProgress);

			addEventListener(MouseEvent.MOUSE_OVER, onMouseOverAndOutHandler);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOverAndOutHandler);

			layoutXML =
				<Group>
					<Display id="content"/>
					<Group alignY="1">
						<Display id="barBottom" height="16"/>
						<HGroup height="16">
							<Display id="btnPlayPause" width="16"/>
							<Display id="btnStop" width="16"/>
							<Display id="btnPrev" width="16"/>
							<Display id="btnNext" width="16"/>
							<Display id="barPlayProgress"/>
							<Display id="txtPlayProgress" width="70"/>
							<Display id="btnVolume" width="16"/>
							<Display id="barVolume" width="50"/>
						</HGroup>
					</Group>
					<Group alignX="0.5" alignY="0.5">
						<Display id="btnPlay" width="40" height="40"/>
					</Group>
					<Display id="float"/>
					<Display id="frame"/>
				</Group>;

			group = Group.createGroup(layoutXML) as Group;
			group.forEachChild(setGroupChild);

			//stage.addEventListener(Event.RESIZE, onStageResizeHandler);
		}
		
		private function onDisplayClickHandler(_e:MouseEvent):void 
		{
			playOrPause();
		}

		override protected function onRemoveHandler():void {
			super.onRemoveHandler();
		}
		
		override protected function onStateChangeHandler(_evt:MediaEvent):void 
		{
			super.onStateChangeHandler(_evt);
			if (player.isPlaying) {
				TweenMax.to(btnPlay, 0.3, { autoAlpha:0 } );
			}else {
				TweenMax.to(btnPlay, 0.3, { autoAlpha:1 } );
			}
		}

		private function onMouseOverAndOutHandler(_e:MouseEvent):void {
			switch (_e.target){
				case btnPlay:
				case btnPlayPause:
				case btnStop:
				case btnPrev:
				case btnNext:
				case btnVolume:
				case barVolume:
				case barPlayProgress:
					if (_e.type == MouseEvent.MOUSE_OUT){
						glowLow(_e.target);
					} else {
						glowHith(_e.target);
					}
					break;
			}
		}

		//
		private function setGroupChild(_display:Display):void {
			var _id:String = _display.userData.xml.@id;
			switch (_id){
				case "barBottom":
					_display.setContent(barBottom);
					break;
				case "btnPlayPause":
					_display.setContent(btnPlayPause);
					break;
				case "btnStop":
					_display.setContent(btnStop);
					break;
				case "btnPrev":
					_display.setContent(btnPrev);
					break;
				case "btnNext":
					_display.setContent(btnNext);
					break;
				case "txtPlayProgress":
					_display.setContent(txtPlayProgress);
					_display.addEventListener(Event.SCROLL, onBarPlayChangeHandler1);
					break;
				case "btnVolume":
					_display.setContent(btnVolume);
					break;
				case "barVolume":
					_display.setContent(barVolume);
					break;
				case "btnPlay":
					_display.setContent(btnPlay);
					break;
				case "barPlayProgress":
					_display.addEventListener(Event.RESIZE, onBarPlayChangeHandler);
					_display.addEventListener(Event.SCROLL, onBarPlayChangeHandler);
					break;
				case "content":
					_display.setContent(displayContainer.proxy);
					break;
			}
		}

		private function onBarPlayChangeHandler1(_e:Event):void {
			var _display:Display = _e.target as Display;
		}

		private function onBarPlayChangeHandler(_e:Event):void {
			var _display:Display = _e.target as Display;
			barPlayProgress.height = _display.height;
			barPlayProgress.length = _display.width - 12;
			barPlayProgress.x = _display.x + 6;
			barPlayProgress.y = _display.y;
			if (group.width > 300){
				if (!txtPlayProgress.visible){
					txtPlayProgress.visible = true;
				}
			} else {
				if (txtPlayProgress.visible){
					txtPlayProgress.visible = false;
				}
				barPlayProgress.length += 70;
			}
		}
		
		public function setSize(_w:uint, _h:uint):void {
			if(bufferProgressClip){
				bufferProgressClip.x=_w/2;
				bufferProgressClip.y=_h/2;
			}
			group.setSize(_w, _h);
		}

		/*private function onStageResizeHandler(e:Event):void {
			group.setSize(stage.stageWidth, stage.stageHeight);
		}*/
	}
}