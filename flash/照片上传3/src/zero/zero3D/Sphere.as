/***
Sphere
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月23日 22:38:06
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zero3D{
	import flash.display.BitmapData;
	
	/**
	 * 
	 * 球体
	 * 
	 */	
	public class Sphere extends Mesh3D{
		
		/**
		 * 
		 * @param r 半径
		 * @param seg 分段
		 * @param bmd 贴图
		 * @param _rev 是否翻转，true为在球体的内部往外看（如：全景图），false为正常的球体（如：地球仪）
		 * @param _useSp 是否使用独立的容器
		 * 
		 */		
		public function Sphere(
			r:Number,
			seg:int=12,
			bmd:BitmapData=null,
			_rev:Boolean=false,
			_useSp:Boolean=true
		) {
			
			var vertexV:Vector.<Number>=new Vector.<Number>();
			var uvtV:Vector.<Number>=new Vector.<Number>();
			var vertexIdV:Vector.<int>=new Vector.<int>();
			
			var i:int,j:int;
			for(i=0;i<=seg;i++){
				var v:Number=i/seg;
				var radH:Number=Math.PI*v;
				var y:Number=-r*Math.cos(radH);
				var rw:Number=r*Math.sin(radH);//纬圆半径
				for(j=0;j<=seg;j++){
					var u:Number=j/seg;
					var radW:Number=Math.PI*2*u;
					var z:Number=-rw*Math.cos(radW);
					var x:Number=rw*Math.sin(radW);
					vertexV.push(x,y,z);
					uvtV.push(u,v,0);
				}
			}
			for(i=0;i<seg;i++){
				for(j=0;j<seg;j++){
					var id0:int=(seg+1)*i+j;
					var id1:int=(seg+1)*i+(1+j)%(seg+1);
					var id2:int=(seg+1)*(i+1)+(1+j)%(seg+1);
					var id3:int=(seg+1)*(i+1)+j;
					if(i==0){
					}else{
						vertexIdV.push(id1,id0,id3);
					}
					if(i==seg-1){
					}else{
						vertexIdV.push(id3,id2,id1);
					}
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