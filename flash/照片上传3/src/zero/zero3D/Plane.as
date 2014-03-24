/***
Plane
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月24日 09:23:09
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zero3D{
	import flash.display.BitmapData;
	
	/**
	 * 
	 * 平面
	 * 
	 */	
	public class Plane extends Mesh3D{
		
		/**
		 * 
		 * @param wid 宽
		 * @param hei 高
		 * @param segW 横分段
		 * @param segH 竖分段
		 * @param bmd 贴图
		 * @param _rev 是否翻转
		 * @param _useSp 是否使用独立的容器
		 * 
		 */		
		public function Plane(
			wid:Number,
			hei:Number,
			segW:int=4,
			segH:int=4,
			bmd:BitmapData=null,
			_rev:Boolean=false,
			_useSp:Boolean=true
		) {
			
			var vertexV:Vector.<Number>=new Vector.<Number>();
			var uvtV:Vector.<Number>=new Vector.<Number>();
			for(var j:int=0;j<=segH;j++){
				var y:Number=-hei/2+hei*j/segH;
				var v:Number=j/segH;
				for(var i:int=0;i<=segW;i++){
					var x:Number=-wid/2+wid*i/segW;
					var u:Number=i/segW;
					vertexV.push(x,y,0);
					uvtV.push(u,v,0);
				}
			}
			
			var vertexIdV:Vector.<int>=new Vector.<int>();
			for(j=0;j<segH;j++){
				for(i=0;i<segW;i++){
					var id0:int=j*(segW+1)+i;
					var id1:int=id0+(segW+1);
					var id2:int=id1+1;
					var id3:int=id0+1;
					vertexIdV.push(
						id0,id1,id2,
						id2,id3,id0
					);
				}
			}
			
			super(
				vertexV,
				vertexIdV,
				bmd,
				uvtV,
				_rev,
				_useSp
			);
		}
	}
}