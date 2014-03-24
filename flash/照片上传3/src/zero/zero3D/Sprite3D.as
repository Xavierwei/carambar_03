/***
Sprite3D
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月23日 14:10:46
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zero3D{
	import flash.display.Sprite;
	
	/**
	 * 
	 * 3D场景里的影片剪辑
	 * 
	 */	
	public class Sprite3D extends RenderableObj3D{
		
		/**
		 * 影片剪辑
		 */		
		public var sprite:Sprite;
		
		public function Sprite3D(_sprite:Sprite){
			sprite=_sprite;
		}
		
		override public function clear():void{super.clear();
			sprite=null;
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
				sprite.x=screenCenter[0];
				sprite.y=screenCenter[1];
				sprite.scaleX=sprite.scaleY=dScreen/Math.sqrt(focalLength2);
				container.addChild(sprite);
			}
		}
		
	}
}