/***
TypeWriter
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年11月13日 17:32:05
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class TypeWriter extends Sprite{
		
		private var fadeId:int;
		private var text:String;
		public var txt:TextField;
		
		private var rrggbb1:String;
		private var rrggbb2:String;
		private var rrggbb3:String;
		
		private var typeComplete:Function;
		
		public function TypeWriter(){
			txt.autoSize=TextFieldAutoSize.LEFT;
			var r:int=(txt.textColor>>16)&0xff;
			var g:int=(txt.textColor>>8)&0xff;
			var b:int=txt.textColor&0xff;
			for(var i:int=1;i<=3;i++){
				var rr:String=Math.round(r*i/4).toString(16);
				if(rr.length<2){
					rr="0"+rr;
				}
				var gg:String=Math.round(g*i/4).toString(16);
				if(gg.length<2){
					gg="0"+gg;
				}
				var bb:String=Math.round(b*i/4).toString(16);
				if(bb.length<2){
					bb="0"+bb;
				}
				this["rrggbb"+i]=rr+gg+bb;
			}
		}
		public function clear():void{
			txt.text="";
			stop();
		}
		public function stop():void{
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
		}
		public function setText(_text:String,_typeComplete:Function=null):void{
			text=_text;
			typeComplete=_typeComplete;
			fadeId=-1;
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void{
			if((++fadeId)-3>=text.length){
				this.removeEventListener(Event.ENTER_FRAME,enterFrame);
				if(typeComplete==null){
				}else{
					typeComplete();
				}
				return;
			}
			var output:String="";
			if(fadeId>=3){
				output+=text.substr(0,fadeId-2);
			}
			if(fadeId>=2&&fadeId-2<text.length){
				output+='<font color="#'+rrggbb3+'">'+text.charAt(fadeId-2)+'</font>';
			}
			if(fadeId>=1&&fadeId-1<text.length){
				output+='<font color="#'+rrggbb2+'">'+text.charAt(fadeId-1)+'</font>';
			}
			if(fadeId<text.length){
				output+='<font color="#'+rrggbb1+'">'+text.charAt(fadeId)+'</font>';
			}
			txt.htmlText=output;
		}
	}
}