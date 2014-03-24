/***
DoubleFreeTran
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年10月20日 16:27:33
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
	
	import zero.utils.getM;
	
	public class DoubleFreeTran extends Sprite{
		
		private static const d:int=40;
		
		private var rect1:Sprite;
		private var rect2:Sprite;
		
		private var freeTran1:FreeTran;
		private var freeTran2:FreeTran;
		
		private var chankaoM:Matrix;
		
		public function DoubleFreeTran(){
			
			rect2=new Sprite();
			this.addChild(rect2);
			rect2.graphics.clear();
			rect2.graphics.beginFill(0x00ff00,0.05);
			rect2.graphics.drawRect(0,0,100,100);
			rect2.graphics.endFill();
			rect2.mouseEnabled=rect2.mouseChildren=false;
			
			rect1=new Sprite();
			this.addChild(rect1);
			rect1.graphics.clear();
			rect1.graphics.beginFill(0xff0000,0.05);
			rect1.graphics.drawRect(0,0,100,100);
			rect1.graphics.endFill();
			rect1.mouseEnabled=rect1.mouseChildren=false;
			
			freeTran2=new FreeTran();
			this.addChild(freeTran2);
			
			freeTran1=new FreeTran();
			this.addChild(freeTran1);
			
			freeTran1.lockScale=true;
			freeTran2.lockScale=true;
			
			freeTran1.minWid=d;
			freeTran1.minHei=d;
			freeTran2.minWid=d*2;
			freeTran2.minHei=d*2;
			
			freeTran1.onStartTran=startTran1;
			freeTran1.onTran=tran1;
			freeTran1.onStopTran=stopTran1;
			
			freeTran2.onStartTran=startTran2;
			freeTran2.onTran=tran2;
			freeTran2.onStopTran=stopTran2;
			
			freeTran1.transform.colorTransform=new ColorTransform(1,1,1,1,255,0,0,0);
			freeTran2.transform.colorTransform=new ColorTransform(1,1,1,1,0,255,0,0);
			
			this.visible=false;
			
			freeTran2.dot_scaleDict["dot-1-1"].visible=false;
			freeTran2.dot_scaleDict["dot1-1"].visible=false;
			freeTran2.dot_scaleDict["dot-11"].visible=false;
			freeTran2.dot_scaleDict["dot0-1"].visible=false;
			//freeTran2.dot_scaleDict["dot01"].visible=false;
			freeTran2.dot_scaleDict["dot-10"].visible=false;
			//freeTran2.dot_scaleDict["dot10"].visible=false;
			
			freeTran2.dot_rotateDict["dot-1-1"].visible=false;
			freeTran2.dot_rotateDict["dot1-1"].visible=false;
			freeTran2.dot_rotateDict["dot-11"].visible=false;
			
		}
		private var __pic:DisplayObject;
		public function getPic():DisplayObject{
			return __pic;
		}
		public function setPic(_pic:DisplayObject):void{
			__pic=_pic;
			if(__pic){
				this.visible=true;
				freeTran1.setPic(__pic);
				var m:Matrix=freeTran1.dragArea.transform.matrix;
				m.concat(freeTran1.transform.matrix);
				rect1.transform.matrix=m;
				freeTran1.setPic(rect1);
				chankaoM=getM(rect1,__pic,false);
				tran1();
			}else{
				this.visible=false;
			}
		}
		private function startTran1(...args):void{
			freeTran2.mouseEnabled=freeTran2.mouseChildren=false;
		}
		private function tran1(...args):void{
			
			//var r:Number=rect1.rotation*Math.PI/180;
			
			//var c:Number=Math.cos(r);
			//var s:Number=Math.sin(r);
			
			//rect2.x=rect1.x-d*(c-s);
			//rect2.y=rect1.y-d*(s+c);
			
			//rect2.scaleX=(rect1.scaleX*100+d*2)/100;
			//rect2.scaleY=(rect1.scaleY*100+d*2)/100;
			
			//rect2.rotation=rect1.rotation;
			
			//freeTran2.setPic(rect2);
			
			rect2.x=rect1.x;
			rect2.y=rect1.y;
			
			rect2.scaleX=(rect1.scaleX*100+d)/100;
			rect2.scaleY=(rect1.scaleY*100+d)/100;
			
			rect2.rotation=rect1.rotation;
			
			freeTran2.setPic(rect2);
			
			if(__pic){
				var m:Matrix=chankaoM.clone();
				m.invert();
				var m2:Matrix=getM(__pic.parent,rect1,true);
				m2.invert();
				m.concat(m2);
				__pic.transform.matrix=m;
			}
		}
		private function stopTran1(...args):void{
			freeTran2.mouseEnabled=freeTran2.mouseChildren=true;
		}
		private function startTran2(...args):void{
			freeTran1.mouseEnabled=freeTran1.mouseChildren=false;
		}
		private function tran2(...args):void{
			
			//var r:Number=rect2.rotation*Math.PI/180;
			
			//var c:Number=Math.cos(r);
			//var s:Number=Math.sin(r);
			
			//rect1.x=rect2.x+d*(c-s);
			//rect1.y=rect2.y+d*(s+c);
			
			//rect1.scaleX=(rect2.scaleX*100-d*2)/100;
			//rect1.scaleY=(rect2.scaleY*100-d*2)/100;
			
			//rect1.rotation=rect2.rotation;
			
			//freeTran1.setPic(rect1);
			
			rect1.x=rect2.x;
			rect1.y=rect2.y;
			
			rect1.scaleX=(rect2.scaleX*100-d)/100;
			rect1.scaleY=(rect2.scaleY*100-d)/100;
			
			rect1.rotation=rect2.rotation;
			
			freeTran1.setPic(rect1);
			
		}
		private function stopTran2(...args):void{
			freeTran1.mouseEnabled=freeTran1.mouseChildren=true;
			
			if(__pic){
				chankaoM=getM(rect1,__pic,false);
			}
		}
	}
}