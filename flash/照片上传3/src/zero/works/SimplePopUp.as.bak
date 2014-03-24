/***
SimplePopUp 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月17日 09:47:23
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	public class SimplePopUp extends Sprite{
		
		public static var instance:SimplePopUp;
		
		public static var label_ok:String="确定";
		
		public static function show(msg:String,labels:String=null):SimplePopUp{
			instance.show(msg,labels);
			return instance;
		}
		
		public var bg:Sprite;
		public var txt:TextField;
		
		public var btn0:Btn;
		public var btn1:Btn;
		public var btn2:Btn;
		public var btn3:Btn;
		public var btn4:Btn;
		public var btn5:Btn;
		public var btn6:Btn;
		public var btn7:Btn;
		public var btn8:Btn;
		public var btn9:Btn;
		
		public var callBack:Function;
		
		private var btnDict:Dictionary;
		
		private var bBtn:Rectangle;
		private var bTxt:Rectangle;
		
		public static var autoAdjustTxt:Boolean;//20110622
		
		public function SimplePopUp(){
			if(instance){
				throw new Error("只支持单例");
			}else{
				instance=this;
			}
			this.visible=false;
			
			btnDict=new Dictionary();
			
			var i:int=0;
			bBtn=btn0.getBounds(this);
			while(true){
				var btn:Btn=this["btn"+i];
				if(btn){
					btn.addEventListener(MouseEvent.CLICK,click);
					btn.mouseChildren=false;
					btnDict[btn]=i;
					bBtn=bBtn.union(btn.getBounds(this));
				}else{
					break;
				}
				i++;
			}
			
			bTxt=txt.getBounds(this);
			
			autoAdjustTxt=true;
		}
		
		public function show(msg:String,labels:String=null):void{
			txt.text=msg;
			
			if(autoAdjustTxt){
				txt.x=bTxt.x+(bTxt.width-txt.textWidth)/2;
				txt.y=bTxt.y+(bTxt.height-txt.textHeight)/2;
			}
			
			var labelArr:Array;
			if(labels){
				labelArr=labels.split("|");
			}else{
				labelArr=[label_ok];
			}
			var i:int=0;
			for each(var label:String in labelArr){
				if(this["btn"+i].hasOwnProperty("txt")){
					this["btn"+i]["txt"].text=label;
				}
				i++;
			}
			
			var b:Rectangle;
			switch(i){
				case 1:
					btn0.visible=true;
					btn1.visible=false;
					b=btn0.getBounds(this);
					btn0.x+=bBtn.x+bBtn.width/2-(b.x+b.width/2);
					btn0.y+=bBtn.y+bBtn.height/2-(b.y+b.height/2);
				break;
				case 2:
					btn0.visible=true;
					btn1.visible=true;
					b=btn0.getBounds(this);
					btn0.x+=bBtn.x-b.x;
					btn0.y+=bBtn.y-b.y;
					b=btn1.getBounds(this);
					btn1.x+=bBtn.x+bBtn.width-b.width-b.x;
					btn1.y+=bBtn.y+bBtn.height-b.height-b.y;
				break;
			}
			
			this.visible=true;
		}
		
		private function click(event:MouseEvent):void{
			var callBackResult:Boolean;
			switch(btnDict[event.target]){
				case 0:
					if(btn1.visible){
						if(callBack==null){
						}else{
							callBackResult=callBack(true);
						}
					}else{
						if(callBack==null){
						}else{
							callBackResult=callBack();
						}
					}
				break;
				case 1:
					if(callBack==null){
					}else{
						callBackResult=callBack(false);
					}
				break;
			}
			if(callBackResult){
			}else{
				this.visible=false;
			}
			trace("callBackResult="+callBackResult);
		}
	}
}

