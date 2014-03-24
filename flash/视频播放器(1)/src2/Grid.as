/***
Grid
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年10月30日 16:26:28
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class Grid extends Sprite{
		
		private var bmd:BitmapData;
		
		public function Grid(){
			bmd=new GridBmd();
		}
		public function setSize(wid:int,hei:int):void{
			//var p:Point=this.localToGlobal(new Point());
			//this.x-=p.x;
			//this.y-=p.y;
			this.graphics.clear();
			this.graphics.beginBitmapFill(bmd);
			this.graphics.drawRect(0,0,wid,hei);
			this.graphics.endFill();
			//trace("grid："+this.getBounds(stage));
		}
	}
}