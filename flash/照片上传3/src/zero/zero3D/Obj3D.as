/***
Obj3D 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月25日 19:52:32
历次修改:20130922 整理和改进
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	import zero.zero3D.Camera3D;
	
	/**
	 * 
	 * 3D对象的基类，坐标系x轴指向右方，y轴指向下方，z轴指向屏幕背面
	 * 
	 */	
	public class Obj3D{
		
		/**
		 * 最大数值，防止数值太大导致绘图困难，还用于比较是否NaN
		 */		
		internal static const MAX_NUMBER:Number=10000;
		
		/**
		 *点或向量(Vector3D)转到父系统(parent)的转换矩阵 
		 */		
		internal var matrix3D:Matrix3D;
		
		/**
		 *是否渲染 
		 */		
		public var visible:Boolean=true;
		
		private var __x:Number;
		private var __y:Number;
		private var __z:Number;
		
		private var __scaleX:Number;
		private var __scaleY:Number;
		private var __scaleZ:Number;
		
		private var __rotationX:Number;
		private var __rotationY:Number;
		private var __rotationZ:Number;
		
		private var __outterRotationX:Number;
		private var __outterRotationY:Number;
		private var __outterRotationZ:Number;
		
		public function Obj3D(){
			matrix3D=new Matrix3D();
			__x=__y=__z=0;
			__scaleX=__scaleY=__scaleZ=1;
			__rotationX=__rotationY=__rotationZ=0;
			__outterRotationX=__outterRotationY=__outterRotationZ=0;
		}
		
		/** 
		 *清除以便垃圾回收
		 */		
		public function clear():void{
			matrix3D=null;
		}
		
		public function get x():Number{
			return __x;
		}
		public function set x(_x:Number):void{
			__x=_x;
			updateMatrix3D();
		}
		
		public function get y():Number{
			return __y;
		}
		public function set y(_y:Number):void{
			__y=_y;
			updateMatrix3D();
		}
		
		public function get z():Number{
			return __z;
		}
		public function set z(_z:Number):void{
			__z=_z;
			updateMatrix3D();
		}
		
		public function get scaleX():Number{
			return __scaleX;
		}
		public function set scaleX(_scaleX:Number):void{
			__scaleX=_scaleX;
			updateMatrix3D();
		}
		
		public function get scaleY():Number{
			return __scaleY;
		}
		public function set scaleY(_scaleY:Number):void{
			__scaleY=_scaleY;
			updateMatrix3D();
		}
		
		public function get scaleZ():Number{
			return __scaleZ;
		}
		public function set scaleZ(_scaleZ:Number):void{
			__scaleZ=_scaleZ;
			updateMatrix3D();
		}
		
		public function get rotationX():Number{
			return __rotationX;
		}
		public function set rotationX(_rotationX:Number):void{
			__rotationX=_rotationX;
			updateMatrix3D();
		}
		
		public function get rotationY():Number{
			return __rotationY;
		}
		public function set rotationY(_rotationY:Number):void{
			__rotationY=_rotationY;
			updateMatrix3D();
		}
		
		public function get rotationZ():Number{
			return __rotationZ;
		}
		public function set rotationZ(_rotationZ:Number):void{
			__rotationZ=_rotationZ;
			updateMatrix3D();
		}
		
		private function updateMatrix3D():void{
			
			if(__scaleX==1&&__scaleY==1&&__scaleZ==1){//不缩放
				if(
					__rotationX==0
					&&
					__rotationY==0
					&&
					__rotationZ==0
				){//不旋转
					matrix3D.rawData=new <Number>[
						1,0,0,0,
						0,1,0,0,
						0,0,1,0,
						__x,__y,__z,1
					];
					return;
				}
			}
			
			if(__scaleX==1&&__scaleY==1&&__scaleZ==1){
				matrix3D.identity();
			}else{
				//缩放
				matrix3D.rawData=new <Number>[
					__scaleX,0,0,0,
					0,__scaleY,0,0,
					0,0,__scaleZ,0,
					0,0,0,1
				];
			}
			
			if(__rotationX==0){
			}else{
				//旋转x
				var rad:Number=__rotationX/180*Math.PI;
				var _c:Number=Math.cos(rad);
				var _s:Number=Math.sin(rad);
				if(__scaleX==1&&__scaleY==1&&__scaleZ==1){
					matrix3D.rawData=new <Number>[
						1,0,0,0,
						0,_c,_s,0,
						0,-_s,_c,0,
						0,0,0,1
					];
				}else{
					matrix3D.append(new Matrix3D(new <Number>[
						1,0,0,0,
						0,_c,_s,0,
						0,-_s,_c,0,
						0,0,0,1
					]));
				}
			}
			
			if(__rotationY==0){
			}else{
				//旋转y
				rad=__rotationY/180*Math.PI;
				_c=Math.cos(rad);
				_s=Math.sin(rad);
				if(
					__scaleX==1&&__scaleY==1&&__scaleZ==1
					&&
					__rotationX==0
				){
					matrix3D.rawData=new <Number>[
						_c,0,-_s,0,
						0,1,0,0,
						_s,0,_c,0,
						0,0,0,1
					];
				}else{
					matrix3D.append(new Matrix3D(new <Number>[
						_c,0,-_s,0,
						0,1,0,0,
						_s,0,_c,0,
						0,0,0,1
					]));
				}
			}
			
			if(__rotationZ==0){
				//位移
				if(
					__scaleX==1&&__scaleY==1&&__scaleZ==1
					&&
					__rotationX==0
					&&
					__rotationY==0
				){
					matrix3D.rawData=new <Number>[
						1,0,0,0,
						0,1,0,0,
						0,0,1,0,
						__x,__y,__z,1
					];
				}else{
					matrix3D.append(new Matrix3D(new <Number>[
						1,0,0,0,
						0,1,0,0,
						0,0,1,0,
						__x,__y,__z,1
					]));
				}
			}else{
				//旋转z和位移
				rad=__rotationZ/180*Math.PI;
				_c=Math.cos(rad);
				_s=Math.sin(rad);
				if(
					__scaleX==1&&__scaleY==1&&__scaleZ==1
					&&
					__rotationX==0
					&&
					__rotationY==0
				){
					matrix3D.rawData=new <Number>[
						_c,_s,0,0,
						-_s,_c,0,0,
						0,0,1,0,
						__x,__y,__z,1
					];
				}else{
					matrix3D.append(new Matrix3D(new <Number>[
						_c,_s,0,0,
						-_s,_c,0,0,
						0,0,1,0,
						__x,__y,__z,1
					]));
				}
			}
			
		}
		
		/**
		 * 相对于父级x轴的旋转度
		 */
		public function get outterRotationX():Number{
			return __outterRotationX;
		}
		public function set outterRotationX(_outterRotationX:Number):void{
			
			__outterRotationX=_outterRotationX;
			
			//xy等属性从此无效
			__x=__y=__z=NaN;
			__scaleX=__scaleY=__scaleZ=NaN;
			__rotationX=__rotationY=__rotationZ=NaN;
			
			matrix3D.identity();
			matrix3D.appendRotation(__outterRotationZ,Vector3D.Z_AXIS);
			matrix3D.appendRotation(__outterRotationY,Vector3D.Y_AXIS);
			matrix3D.appendRotation(__outterRotationX,Vector3D.X_AXIS);
			
		}
		
		/**
		 * 相对于父级Y轴的旋转度
		 */
		public function get outterRotationY():Number{
			return __outterRotationY;
		}
		public function set outterRotationY(_outterRotationY:Number):void{
			
			__outterRotationY=_outterRotationY;
			
			//xy等属性从此无效
			__x=__y=__z=NaN;
			__scaleX=__scaleY=__scaleZ=NaN;
			__rotationX=__rotationY=__rotationZ=NaN;
			
			matrix3D.identity();
			matrix3D.appendRotation(__outterRotationZ,Vector3D.Z_AXIS);
			matrix3D.appendRotation(__outterRotationY,Vector3D.Y_AXIS);
			matrix3D.appendRotation(__outterRotationX,Vector3D.X_AXIS);
			
		}
		
		/**
		 * 相对于父级Z轴的旋转度
		 */
		public function get outterRotationZ():Number{
			return __outterRotationZ;
		}
		public function set outterRotationZ(_outterRotationZ:Number):void{
			
			__outterRotationZ=_outterRotationZ;
			
			//xy等属性从此无效
			__x=__y=__z=NaN;
			__scaleX=__scaleY=__scaleZ=NaN;
			__rotationX=__rotationY=__rotationZ=NaN;
			
			matrix3D.identity();
			matrix3D.appendRotation(__outterRotationZ,Vector3D.Z_AXIS);
			matrix3D.appendRotation(__outterRotationY,Vector3D.Y_AXIS);
			matrix3D.appendRotation(__outterRotationX,Vector3D.X_AXIS);
			
		}
		
		/** 
		 * 绕父级的axis轴旋转degrees角度
		 */		
		public function appendRotation(degrees:Number,axis:Vector3D):void{
			
			//xy等属性从此无效
			__x=__y=__z=NaN;
			__scaleX=__scaleY=__scaleZ=NaN;
			__rotationX=__rotationY=__rotationZ=NaN;
			
			matrix3D.appendRotation(degrees,axis);
			
		}
		
		/*
		//输出顶点列表以便查看	
		internal static function checkVertexV(vertexV:Vector.<Number>):void{
			trace("-----------------------------------");
			for(var i:int=0;i<vertexV.length;i+=3){
				trace(normalizeNum(vertexV[i])+"\t"+normalizeNum(vertexV[i+1])+"\t"+normalizeNum(vertexV[i+2]));
			}
			trace("-----------------------------------");
		}
		//输出 matrix3D 以便查看	
		internal static function checkMatrix3D(matrix3D:Matrix3D):void{
			var rawData:Vector.<Number>=matrix3D.rawData;
			trace(
				"-----------------------------------\n"+
				normalizeNum(rawData[0])+"\t"+normalizeNum(rawData[1])+"\t"+normalizeNum(rawData[2])+"\t"+normalizeNum(rawData[3])+"\n"+
				normalizeNum(rawData[4])+"\t"+normalizeNum(rawData[5])+"\t"+normalizeNum(rawData[6])+"\t"+normalizeNum(rawData[7])+"\n"+
				normalizeNum(rawData[8])+"\t"+normalizeNum(rawData[9])+"\t"+normalizeNum(rawData[10])+"\t"+normalizeNum(rawData[11])+"\n"+
				normalizeNum(rawData[12])+"\t"+normalizeNum(rawData[13])+"\t"+normalizeNum(rawData[14])+"\t"+normalizeNum(rawData[15])+"\n"+
				"-----------------------------------\n"
			);
		}
		private static function normalizeNum(num:Number):String{
			var num:Number=Math.round(num*1000)/1000;
			var str:String=num.toString();
			if(str.indexOf(".")>0){
				return str;
			}
			return str+=".000";
		}*/
	}
}

