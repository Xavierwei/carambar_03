package akdcl.key{
	import flash.events.EventDispatcher;
	
	import akdcl.events.KeyEvent;
	
	public class CrossKey extends EventDispatcher{
		static private var nameList:Array=new Array			
		//
		protected var _keyManager:KeyManager
		protected var _keyGroupName:String
		protected var _keyGroupID:uint
		protected var _key_up:Key
		protected var _key_down:Key
		protected var _key_left:Key
		protected var _key_right:Key	
		//		
		public function CrossKey(keyManager:KeyManager,up:Key,down:Key,left:Key,right:Key):void{			
			this._keyManager=keyManager
			//
			this._key_up=up
			this._key_down=down
			this._key_left=left
			this._key_right=right
			//
			this._key_up.keyName="up"
			this._key_down.keyName="down"
			this._key_left.keyName="left"
			this._key_right.keyName="right"
			//
			//
			this._keyGroupName=this._keyManager.getNewGroupName()
			this._keyGroupID=this._keyManager.getGroupID(this._keyGroupName)
			this._key_left.combined=this._key_right.combined=this._key_up.combined=this._key_down.combined=true
			this._key_left.groupName=this._key_right.groupName=this._key_up.groupName=this._key_down.groupName=this._keyGroupName
			this._key_left.groupID=this._key_right.groupID=this._key_up.groupID=this._key_down.groupID=this._keyGroupID
			this._key_left.disable=this._key_right.disable=this._key_up.disable=this._key_down.disable=true
			//
			this._keyManager.addKey(this._key_up)
			this._keyManager.addKey(this._key_down)
			this._keyManager.addKey(this._key_left)
			this._keyManager.addKey(this._key_right)
			//=new KeyManager(this._stage,this._precision,this._key_up,this._key_down,this._key_left,this._key_right)
			this._keyManager.addEventListener(KeyEvent.KEY_UP,onKeyUp)
			this._keyManager.addEventListener(KeyEvent.KEY_DOWN,onKeyDown)
			this._keyManager.addEventListener(KeyEvent.KEY_HOLD,onKeyHold)
			//
			
		}
		public function start():void{
			this._key_left.disable=this._key_right.disable=this._key_up.disable=this._key_down.disable=false
			this.dispatchEvent(new KeyEvent(KeyEvent.GROUP_START))
		}
		public function stop():void{
			this._key_left.disable=this._key_right.disable=this._key_up.disable=this._key_down.disable=true
			this.dispatchEvent(new KeyEvent(KeyEvent.CROSS_STOP))
		}
		public function upBinding(up:Function=null,
								   down:Function=null,
								   left:Function=null,
								   right:Function=null,
								   left_up:Function=null,
								   right_up:Function=null,
								   left_down:Function=null,
								   right_down:Function=null):void{								   	
			up&&this.addEventListener(KeyEvent.onCrossUp_UP,up)
			down&&this.addEventListener(KeyEvent.onCrossUp_DOWN,down)
			left&&this.addEventListener(KeyEvent.onCrossUp_LEFT,left)
			right&&this.addEventListener(KeyEvent.onCrossUp_RIGHT,right)
			left_up&&this.addEventListener(KeyEvent.onCrossUp_LEFTUP,left_up)
			right_up&&this.addEventListener(KeyEvent.onCrossUp_RIGHTUP,right_up)
			left_down&&this.addEventListener(KeyEvent.onCrossUp_LEFTDOWN,left_down)
			right_down&&this.addEventListener(KeyEvent.onCrossUp_RIGHTDOWN,right_down)
			//none&&this.addEventListener(KeyEvent.onCrossUp_NONE,none)
			
		}
		public function downBinding(up:Function=null,
								   down:Function=null,
								   left:Function=null,
								   right:Function=null,
								   left_up:Function=null,
								   right_up:Function=null,
								   left_down:Function=null,
								   right_down:Function=null):void{
			up&&this.addEventListener(KeyEvent.onCrossDown_UP,up)
			down&&this.addEventListener(KeyEvent.onCrossDown_DOWN,down)
			left&&this.addEventListener(KeyEvent.onCrossDown_LEFT,left)
			right&&this.addEventListener(KeyEvent.onCrossDown_RIGHT,right)
			left_up&&this.addEventListener(KeyEvent.onCrossDown_LEFTUP,left_up)
			right_up&&this.addEventListener(KeyEvent.onCrossDown_RIGHTUP,right_up)
			left_down&&this.addEventListener(KeyEvent.onCrossDown_LEFTDOWN,left_down)
			right_down&&this.addEventListener(KeyEvent.onCrossDown_RIGHTDOWN,right_down)			
		}
		public function holdBinding(up:Function=null,
								   down:Function=null,
								   left:Function=null,
								   right:Function=null,
								   left_up:Function=null,
								   right_up:Function=null,
								   left_down:Function=null,
								   right_down:Function=null):void{
			up&&this.addEventListener(KeyEvent.onCrossHold_UP,up)
			down&&this.addEventListener(KeyEvent.onCrossHold_DOWN,down)
			left&&this.addEventListener(KeyEvent.onCrossHold_LEFT,left)
			right&&this.addEventListener(KeyEvent.onCrossHold_RIGHT,right)
			left_up&&this.addEventListener(KeyEvent.onCrossHold_LEFTUP,left_up)
			right_up&&this.addEventListener(KeyEvent.onCrossHold_RIGHTUP,right_up)
			left_down&&this.addEventListener(KeyEvent.onCrossHold_LEFTDOWN,left_down)
			right_down&&this.addEventListener(KeyEvent.onCrossHold_RIGHTDOWN,right_down)
		}
		protected function onKeyUp(e:KeyEvent):void{
			if(e.groupID==this._keyGroupID){					
				switch(e.keyCode){
					case 1:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_UP,true,false,e.keyCode,this._key_up.keyName,e.groupName,e.groupID,0,1))
						//this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_UP,true,false,e.keyCode))
					break
					case 2:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_DOWN,true,false,e.keyCode,this._key_down.keyName,e.groupName,e.groupID,0,1))
					break
					case 4:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_LEFT,true,false,e.keyCode,this._key_left.keyName,e.groupName,e.groupID,0,1))
					break
					case 8:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_RIGHT,true,false,e.keyCode,this._key_right.keyName,e.groupName,e.groupID,0,1))
					break
					case 5:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_LEFTUP,true,false,e.keyCode,"leftup",e.groupName,e.groupID,0,1))
					break
					case 9:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_RIGHTUP,true,false,e.keyCode,"rightup",e.groupName,e.groupID,0,1))
					break
					case 6:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_LEFTDOWN,true,false,e.keyCode,"leftdown",e.groupName,e.groupID,0,1))
					break
					case 10:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_RIGHTDOWN,true,false,e.keyCode,"rightdown",e.groupName,e.groupID,0,1))
					break
					case 0:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_NONE,true,false,e.keyCode,"none",e.groupName,e.groupID,0,1))
					break
					case 12:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_LEFTRIGHT,true,false,e.keyCode,"leftright",e.groupName,e.groupID,0,1))
					break
					case 3:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossUp_UPDOWN,true,false,e.keyCode,"updown",e.groupName,e.groupID,0,1))
					break
					default:
						//trace(e.keyCode)
					break
				}
			}
		}
		protected function onKeyDown(e:KeyEvent):void{
			//trace(e.groupID,e.keyCode)			
			if(e.groupID==this._keyGroupID){	
				switch(e.keyCode){
					case 1:					
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_UP,true,false,e.keyCode,this._key_up.keyName,e.groupName,e.groupID,1))
					break
					case 2:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_DOWN,true,false,e.keyCode,this._key_down.keyName,e.groupName,e.groupID,1))
					break
					case 4:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_LEFT,true,false,e.keyCode,this._key_left.keyName,e.groupName,e.groupID,1))
					break
					case 8:				
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_RIGHT,true,false,e.keyCode,this._key_right.keyName,e.groupName,e.groupID,1))
					break
					case 5:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_LEFTUP,true,false,e.keyCode,"leftup",e.groupName,e.groupID,1))
					break
					case 9:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_RIGHTUP,true,false,e.keyCode,"rightup",e.groupName,e.groupID,1))
					break
					case 6:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_LEFTDOWN,true,false,e.keyCode,"leftdown",e.groupName,e.groupID,1))
					break
					case 10:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_RIGHTDOWN,true,false,e.keyCode,"rightdown",e.groupName,e.groupID,1))
					break
					case 0:
						//this.dispatchEvent(KeyEvent
					break
					case 12:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_LEFTRIGHT,true,false,e.keyCode,"leftright",e.groupName,e.groupID,1))
					break
					case 3:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossDown_UPDOWN,true,false,e.keyCode,"updown",e.groupName,e.groupID,1))
					break
					default:
						//trace(e.keyCode)
					break
				}
			}			
		}
		protected function onKeyHold(e:KeyEvent):void{		
				//trace(e.groupID,e.keyCode)				
			if(e.groupID==this._keyGroupID){
				switch(e.keyCode){
					case 1:					
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_UP,true,false,e.keyCode,this._key_up.keyName,e.groupName,e.groupID,e.holdTime))
					break
					case 2:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_DOWN,true,false,e.keyCode,this._key_down.keyName,e.groupName,e.groupID,e.holdTime))
					break
					case 4:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_LEFT,true,false,e.keyCode,this._key_left.keyName,e.groupName,e.groupID,e.holdTime))
					break
					case 8:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_RIGHT,true,false,e.keyCode,this._key_right.keyName,e.groupName,e.groupID,e.holdTime))
					break
					case 5:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_LEFTUP,true,false,e.keyCode,"leftup",e.groupName,e.groupID,e.holdTime))
					break
					case 9:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_RIGHTUP,true,false,e.keyCode,"rightup",e.groupName,e.groupID,e.holdTime))
					break
					case 6:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_LEFTDOWN,true,false,e.keyCode,"leftdown",e.groupName,e.groupID,e.holdTime))
					break
					case 10:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_RIGHTDOWN,true,false,e.keyCode,"rightdown",e.groupName,e.groupID,e.holdTime))
					break
					case 0:
						//this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_NONE)
					break
					case 12:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_LEFTRIGHT,true,false,e.keyCode,"leftright",e.groupName,e.groupID,e.holdTime))
					break
					case 3:
						this.dispatchEvent(new KeyEvent(KeyEvent.onCrossHold_UPDOWN,true,false,e.keyCode,"updown",e.groupName,e.groupID,e.holdTime))
					break
					default:
						//trace(e.keyCode)
					break
				}
			}
		}
	}//end CrossKey

}