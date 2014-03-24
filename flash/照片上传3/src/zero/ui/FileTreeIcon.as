
/***
FileTreeIcon
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月5日 19:53:33
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import mx.core.IFlexDisplayObject;
	
	import zero.*;
	
	public class FileTreeIcon extends Sprite implements IFlexDisplayObject{
		
		public static var iconBmds:Object;
		
		public function FileTreeIcon():void{
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			
			var xml:XML=this.parent["listData"].item;
			var type:String;
			if(xml.children().length()){
				type="dir";
			}else{
				var execResult:Array=/^.*\.(.*?)$/.exec(xml.@name.toString());
				if(execResult){
					type=execResult[1];
				}else{
					type="dir";
				}
			}
			
			if(iconBmds[type]){
			}else{
				type="unknown";
			}
			
			this.graphics.clear();
			var bmd:BitmapData=iconBmds[type];
			var scaleWid:int=40;
			var scaleHei:int=40;
			this.graphics.beginBitmapFill(
				bmd,
				new Matrix(
					scaleWid/bmd.width,
					0,
					0,
					scaleHei/bmd.height,
					(measuredWidth-scaleWid)/2,
					(measuredHeight-scaleHei)/2
				),
				true,
				true
			);
			this.graphics.drawRect(0,0,measuredWidth,measuredHeight);
			this.graphics.endFill();
			
		}
		public function get measuredWidth():Number{
			return 24;
		}
		public function get measuredHeight():Number{
			return 24;
		}
		public function move(x:Number, y:Number):void{
		}
		public function setActualSize(newWidth:Number, newHeight:Number):void{
			
		}
	}
}
		