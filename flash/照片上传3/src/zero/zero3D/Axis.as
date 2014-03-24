/***
Axis
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月24日 13:46:30
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zero3D{
	import flash.display.Graphics;
	import flash.display.Sprite;

	internal class Axis extends VerticesObj3D{
		
		private var sp:Sprite;
		
		public function Axis(len:Number){
			super(new <Number>[
				len,0,0,
				0,len,0,
				0,0,len
			]);
			sp=new Sprite();
		}
		
		override public function clear():void{super.clear();
			sp=null;
		}
		
		override internal function render(
			container:Sprite,
			dScreen:Number,
			screenCenter:Array,
			focalLength2:Number
		):void{
			
			if(
				focalLength2<MAX_NUMBER*MAX_NUMBER
				&&
				screenCenter[0]>-MAX_NUMBER&&screenCenter[0]<MAX_NUMBER
				&&
				screenCenter[1]>-MAX_NUMBER&&screenCenter[1]<MAX_NUMBER
			){
				
				var g:Graphics=sp.graphics;
				g.clear();
				
				if(
					screenVertexV[0]>-MAX_NUMBER&&screenVertexV[0]<MAX_NUMBER
					&&
					screenVertexV[1]>-MAX_NUMBER&&screenVertexV[1]<MAX_NUMBER
				){
					g.lineStyle(1,0xff0000);
					g.moveTo(screenCenter[0],screenCenter[1]);
					g.lineTo(screenVertexV[0],screenVertexV[1]);
				}
				
				if(
					screenVertexV[2]>-MAX_NUMBER&&screenVertexV[2]<MAX_NUMBER
					&&
					screenVertexV[3]>-MAX_NUMBER&&screenVertexV[3]<MAX_NUMBER
				){
					g.lineStyle(1,0x00ff00);
					g.moveTo(screenCenter[0],screenCenter[1]);
					g.lineTo(screenVertexV[2],screenVertexV[3]);
				}
				
				if(
					screenVertexV[4]>-MAX_NUMBER&&screenVertexV[4]<MAX_NUMBER
					&&
					screenVertexV[5]>-MAX_NUMBER&&screenVertexV[5]<MAX_NUMBER
				){
					g.lineStyle(1,0x0000ff);
					g.moveTo(screenCenter[0],screenCenter[1]);
					g.lineTo(screenVertexV[4],screenVertexV[5]);
				}
				
				container.addChild(sp);
				
			}
			
		}
	}
}