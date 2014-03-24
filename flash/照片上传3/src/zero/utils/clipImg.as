/***
clipImg
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月26日 14:36:19
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	public function clipImg(_clip_rect_mc:*, _img:*, _bgColor:uint = 0):BitmapData {
		var _m:Matrix=getM(_img, _clip_rect_mc, false);
		
		var _rect:Rectangle = _clip_rect_mc.getBounds(_clip_rect_mc);
		var _bmd:BitmapData = new BitmapData(_rect.width, _rect.height, false, _bgColor);
		
		//var matrixTemp:Matrix=new Matrix();
		//matrixTemp.a = 1;
		//matrixTemp.b = 0;
		//matrixTemp.c = 0;
		//matrixTemp.d = 1;
		//matrixTemp.tx = _rect.x;
		//matrixTemp.ty = _rect.y;
		//matrixTemp.invert();
		//_m.concat(matrixTemp);
		
		_bmd.draw(_img, _m);
		
		return _bmd;
	}
}