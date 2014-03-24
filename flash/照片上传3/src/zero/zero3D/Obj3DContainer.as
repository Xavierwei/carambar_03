/***
Obj3DContainer 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月25日 19:53:07
历次修改:20130922 整理和改进
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D{
	
	/**
	 * 
	 * 3D对象的容器
	 * 
	 */	
	public class Obj3DContainer extends Obj3D{
		
		/**
		 * 所有的子3D对象
		 */		
		internal var obj3DV:Vector.<Obj3D>;
		
		override public function clear():void{super.clear();
			removeAll();
			obj3DV=null;
		}
		
		public function Obj3DContainer(){
			obj3DV=new Vector.<Obj3D>();
		}
		
		/**
		 * 
		 * 添加子3D对象
		 * 
		 */		
		public function addChild(obj3D:Obj3D):void{
			var id:int=obj3DV.indexOf(obj3D);
			if(id>=0){
				throw new Error("重复的 obj3D ："+obj3D);
			}
			obj3DV.fixed=false;
			obj3DV[obj3DV.length]=obj3D;
			obj3DV.fixed=true;
		}
		
		/**
		 * 
		 * 删除子3D对象
		 * 
		 */		
		public function removeChild(obj3D:Obj3D):void{
			var id:int=obj3DV.indexOf(obj3D);
			if(id>=0){
			}else{
				throw new Error("找不到 obj3D ："+obj3D);
			}
			obj3DV.fixed=false;
			obj3DV.splice(id,1);
			obj3DV.fixed=true;
		}
		
		/**
		 * 
		 * 删除所有子3D对象
		 * 
		 */		
		public function removeAll():void{
			obj3DV.fixed=false;
			for each(var obj3D:Obj3D in obj3DV){
				obj3D.clear();
			}
			obj3DV.length=0;
			obj3DV.fixed=true;
		}
	}
}

