/***
Grid
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月09日 16:37:58
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class Grid extends Sprite{
		
		public static var bmd:BitmapData;
		
		private static var gridV:Vector.<Grid>=new Vector.<Grid>();
		
		public function Grid(){
			var i:int=gridV.length;
			while(--i>=0){
				gridV[i].clear();
				gridV.pop();
			}
			if(bmd){
				gridV.push(this);
				this.addEventListener(Event.ADDED_TO_STAGE,added);
			}
		}
		public function clear():void{
			this.graphics.clear();
		}
		private function added(...args):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.addEventListener(Event.RESIZE,resize);
			resize();
		}
		private function removed(...args):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.removeEventListener(Event.RESIZE,resize);
		}
		private function resize(...args):void{
			var p:Point=this.localToGlobal(new Point());
			this.x-=p.x;
			this.y-=p.y;
			this.graphics.clear();
			this.graphics.beginBitmapFill(bmd);
			this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			this.graphics.endFill();
			//trace(this.getBounds(stage));
		}
	}
}