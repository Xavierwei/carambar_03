/***
AlphaBmds
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月19日 11:08:16
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
	
	import zero.codec.*;
	
	public class AlphaBmds extends Sprite{
		public function AlphaBmds(){
			//例如云等纯色带 alpha 的图片，可以只用一个通道表示四个通道，起到压缩作用
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void{
			var i:int;
			
			var wid:int,hei:int;
			try{
				wid=this.loaderInfo.width;
				hei=this.loaderInfo.height;
			}catch(e:Error){
				return;
			}
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			var bmd:BitmapData=new BitmapData(wid,hei,true,0x00000000);
			bmd.draw(this);
			var bmdBytes:ByteArray=bmd.getPixels(bmd.rect);
			
			i=bmdBytes.length;
			while((i-=4)>=0){
				bmdBytes[i+1]=
				bmdBytes[i+2]=
				bmdBytes[i+3]=
				bmdBytes[i];
				bmdBytes[i]=0xff;
			}
			bmdBytes.position=0;
			bmd.setPixels(bmd.rect,bmdBytes);
			this.addChild(new Bitmap(bmd));
			var imgData:ByteArray=BMPEncoder.encode(bmd);
			new FileReference().save(imgData,"clouds.bmp");
			
			trace("this.numChildren="+this.numChildren);
			for(i=0;i<this.numChildren;i++){
				trace(this.getChildAt(i).getBounds(this));
			}
		}
	}
}