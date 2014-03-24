/***
getPointTarget
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月29日 10:51:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * @param _container 容器
	 * @param _point 点
	 * @param _size 菱形大小
	 * @param maxAlpha alpha阈值(0~1)
	 */	
	
	public function getPointTarget(_container:DisplayObjectContainer, _point:Point, _size:int = 1,maxAlpha:Number=0):DisplayObject{
		var i:int=_container.numChildren;
		var alpha:int=int(maxAlpha*0xff);
		var bmd:BitmapData=new BitmapData(_size*2-1,_size*2-1,true,0x00000000);
		while(--i>=0){
			bmd.fillRect(bmd.rect,0x00000000);
			var child:DisplayObject=_container.getChildAt(i);
			var m:Matrix=child.transform.matrix;
			m.tx-=_point.x-_size+2;
			m.ty-=_point.y-_size+2;
			bmd.draw(child,m);
			var y:int=bmd.height;
			var ok:Boolean=true;
			loop:while(--y>=0){
				var x:int=y+1>_size?(y+1)-_size:_size-(y+1);
				var xMax:int=bmd.width-1-x;
				while(x<=xMax){
					if((bmd.getPixel32(x,y)>>>24)>alpha){
					}else{
						ok=false;
						break loop;
					}
					x++;
				}
			}
			if(ok){
				return child;
			}
		}
		return null;
	}
}