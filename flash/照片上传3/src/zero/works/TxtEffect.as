/***
TxtEffect
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月4日 18:35:55
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class TxtEffect extends MovieClip{
		
		public var num1:Sprite;
		public var num2:Sprite;
		public var bg:Sprite;
		
		private var bgWid:int;
		private var bgHei:int;
		
		private var size:int;
		private var color:int;
		private var bold:Boolean;
		
		public function TxtEffect(){
			this.stop();
			this.addFrameScript(this.totalFrames-1,update);
			
			if(bgWid>0){
				bg.width=bgWid;
			}
			if(bgHei>0){
				bg.height=bgHei;
			}
			
			if(num1.numChildren&&num2.numChildren){
				(num1.getChildAt(0) as TextField).text="0";
				(num2.getChildAt(0) as TextField).text="0";
			}//else{
			//	initTxts(new TextField(),new TextField());
			//}
		}
		
		public function initTxts(txt1:TextField,txt2:TextField):void{
			var i:int;
			
			i=num1.numChildren;
			while(--i>=0){
				num1.removeChildAt(i);
			}
			num1.addChild(txt1);
			
			i=num2.numChildren;
			while(--i>=0){
				num2.removeChildAt(i);
			}
			num2.addChild(txt2);
			
			setTxt(txt1,"0");
			setTxt(txt2,"0");
		}
		
		private function setTxt(txt:TextField,htmlText:String):void{
			if(size>0){
				htmlText='<font size="'+size+'" color="#'+(0x1000000+color).toString(16).substr(1)+'">'+htmlText+'</font>';
			}
			if(bold){
				htmlText="<b>"+htmlText+"</b>";
			}
			txt.htmlText=htmlText;
			
			txt.autoSize=TextFieldAutoSize.RIGHT;
			//txt.x=-txt.width/2;
			//txt.y=-txt.height/2;
		}
		
		private var __value:int=-1;
		public function get value():int{
			return __value;
		}
		public function set value(_value:int):void{
			if(__value==_value){
				return;
			}
			__value=_value;
			if(num2.numChildren){
				this.gotoAndPlay(2);
				setTxt(num2.getChildAt(0) as TextField,__value.toString());
			}
		}
		private function update():void{
			this.gotoAndStop(1);
			setTxt(num1.getChildAt(0) as TextField,(num2.getChildAt(0) as TextField).text);
		}
	}
}
		