/***
Camera3D 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月25日 19:53:21
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D{
	import flash.display.Sprite;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * 摄像机
	 * 
	 */	
	public class Camera3D extends Obj3D{
		
		internal var scene3D:Scene3D;
		
		/**
		 * 和“屏幕”的距离，越小透视感越强
		 */		
		public var dScreen:Number;
		
		public function Camera3D(_scene3D:Scene3D,_dScreen:Number=1000){
			scene3D=_scene3D;
			dScreen=_dScreen;
		}
		
		override public function clear():void{super.clear();
			scene3D=null;
		}
		
		/**
		 * 输出图像到一个容器里（支持多视口输出哦~）
		 * @param container 容器
		 * 
		 */		
		public function output(container:Sprite):void{
			
			container.graphics.clear();
			var i:int=container.numChildren;
			while(--i>=0){
				container.removeChildAt(i);
			}
			
			var cameraMatrix3D:Matrix3D=matrix3D.clone();
			cameraMatrix3D.invert();
			var renderableObj3DV:Vector.<RenderableObj3D>=new Vector.<RenderableObj3D>();
			var cameraMatrix3DDict:Dictionary=new Dictionary();
			cameraMatrix3DDict[scene3D]=cameraMatrix3D;
			var seed:Vector.<Obj3D>=new <Obj3D>[scene3D];
			while(seed.length){
				var newSeed:Vector.<Obj3D>=new Vector.<Obj3D>();
				for each(var obj3D:Obj3D in seed){
					if(obj3D is Obj3DContainer){
						cameraMatrix3D=cameraMatrix3DDict[obj3D];
						for each(var childObj3D:Obj3D in (obj3D as Obj3DContainer).obj3DV){
							if(childObj3D.visible){
								var childCameraMatrix3D:Matrix3D=childObj3D.matrix3D.clone();
								childCameraMatrix3D.append(cameraMatrix3D);
								cameraMatrix3DDict[childObj3D]=childCameraMatrix3D;
								newSeed.push(childObj3D);
							}
						}
					}else{
						renderableObj3DV.push(obj3D);
					}
				}
				seed=newSeed;
			}
			
			//trace("renderableObj3DV="+renderableObj3DV);
			if(renderableObj3DV.length){
				var center:Vector3D=new Vector3D(0,0,0);//模型空间中描述的中心
				var renderArr:Array=new Array();
				for each(var renderableObj3D:RenderableObj3D in renderableObj3DV){
					
					cameraMatrix3D=cameraMatrix3DDict[renderableObj3D];
					
					var cameraCenter:Vector3D=cameraMatrix3D.transformVector(center);//模型空间中描述的中心转到摄像机空间中描述
					if(cameraCenter.z>0){//在摄像机前面
						var focalLength2:Number=cameraCenter.x*cameraCenter.x+cameraCenter.y*cameraCenter.y+cameraCenter.z*cameraCenter.z;//到摄像机的距离的平方
						var k:Number=dScreen/cameraCenter.z;
						var screenCenter:Array=[cameraCenter.x*k,cameraCenter.y*k];
					}else{
						focalLength2=NaN;
						screenCenter=[NaN,NaN];
					}
					renderArr.push([renderableObj3D,focalLength2,screenCenter]);
					
					var verticesObj3D:VerticesObj3D=renderableObj3D as VerticesObj3D;
					if(verticesObj3D){
						cameraMatrix3D.transformVectors(verticesObj3D.vertexV,verticesObj3D.cameraVertexV);
						//摄像机空间中描述的顶点转换到屏幕上描述
						i=verticesObj3D.cameraVertexV.length;
						var j:int=i/3*2;
						while(i){
							i-=3;
							j-=2;
							var z:Number=verticesObj3D.cameraVertexV[i+2];
							if(z>0){//在摄像机前面
								var x:Number=verticesObj3D.cameraVertexV[i];
								var y:Number=verticesObj3D.cameraVertexV[i+1];
								k=dScreen/z;
								verticesObj3D.screenVertexV[j]=x*k;
								verticesObj3D.screenVertexV[j+1]=y*k;
							}else{
								verticesObj3D.screenVertexV[j]=NaN;
								verticesObj3D.screenVertexV[j+1]=NaN;
							}
						}
					}
					
				}
				
				if(renderArr.length){
					renderArr.sortOn("1",Array.NUMERIC|Array.DESCENDING);//按从远到近的顺序排列
					
					for each(var subRenderArr:Array in renderArr){
						renderableObj3D=subRenderArr[0];
						renderableObj3D.render(container,dScreen,subRenderArr[2],subRenderArr[1]);//按从远到近的顺序渲染所有要渲染的单元
					}
				}
			}
			
		}
		
	}
}

