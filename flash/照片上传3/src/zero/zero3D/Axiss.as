/***
Axiss 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月25日 21:00:23
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * 
	 * 用红绿蓝三色绘制的坐标轴,主要用来显示坐标系的状态
	 * 
	 */	
	public class Axiss extends Obj3DContainer{
		
		public function Axiss(len:Number){
			
			var axis:Axis=new Axis(len);
			this.addChild(axis);
			
			for(var i:int=0;i<3;i++){
				var txt:TextField=new TextField();
				txt.autoSize=TextFieldAutoSize.LEFT;
				var sp:Sprite=new Sprite();
				var sprite3D:Sprite3D=new Sprite3D(sp);
				this.addChild(sprite3D);
				switch(i){
					case 0:
						txt.textColor=0xff0000;
						txt.text="x";
						sprite3D.x=len+10;
					break;
					case 1:
						txt.textColor=0x00ff00;
						txt.text="y";
						sprite3D.y=len+10;
					break;
					case 2:
						txt.textColor=0x0000ff;
						txt.text="z";
						sprite3D.z=len+10;
					break;
				}
				
				sp.addChild(txt);
				txt.x=-txt.width/2;
				txt.y=-txt.height/2;
			}
			
		}
	}
}