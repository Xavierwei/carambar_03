/***
RenderableObj3D
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月23日 16:57:55
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zero3D{
	import flash.display.Sprite;
	
	/**
	 * 
	 * 可渲染的3D对象
	 * 
	 */	
	public class RenderableObj3D extends Obj3D{
		public function RenderableObj3D(){
		}
		
		/**
		 *渲染 
		 * 
		 */		
		internal function render(
			container:Sprite,
			dScreen:Number,
			screenCenter:Array,
			focalLength2:Number
		):void{}
		
	}
}