/***
VerticesObj3D 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月26日 15:14:16
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D{
	import flash.geom.Vector3D;
	
	/**
	 * 
	 * 由若干个顶点组成的3d物体
	 * 
	 */	
	public class VerticesObj3D extends RenderableObj3D{
		
		/**
		 *模型空间中描述的顶点列表 
		 */		
		internal var vertexV:Vector.<Number>;
		
		/**
		 *摄像机空间中描述的顶点列表 
		 */
		internal var cameraVertexV:Vector.<Number>;
		
		/**
		 *屏幕上描述的顶点列表,每两个作为一个顶点,分别是 x,y;
		 */		
		internal var screenVertexV:Vector.<Number>;
		
		public function VerticesObj3D(_vertexV:Vector.<Number>){
			vertexV=_vertexV;
			vertexV.fixed=true;
			cameraVertexV=new Vector.<Number>(vertexV.length);
			cameraVertexV.fixed=true;
			screenVertexV=new Vector.<Number>(vertexV.length*2/3);
			screenVertexV.fixed=true;
		}
		
		override public function clear():void{super.clear();
			vertexV=null;
			cameraVertexV=null;
			screenVertexV=null;
		}
		
	}
}

