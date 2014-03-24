/***
Cube
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月18日 16:56:15
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zero3D{
	import flash.display.BitmapData;
	
	/**
	 * 
	 * 正方体
	 * 
	 */	
	public class Cube extends Obj3DContainer{
		
		/**
		 * 
		 * @param d 边长
		 * @param seg 分段
		 * @param bmdOrBmdArr 贴图或贴图数组，如果是BitmapData表示六个面是同一张贴图，如果是数组则按上前右后左下的顺序依次贴图
		 * @param _rev 是否翻转，true为在正方体的内部往外看，false为正常的正方体
		 * @param _useSp 是否使用独立的容器
		 * 
		 */		
		public function Cube(
			d:Number,
			seg:int=4,
			bmdOrBmdArr:*=null,
			_rev:Boolean=false,
			_useSp:Boolean=true
		){
			
			if(bmdOrBmdArr){
				if(bmdOrBmdArr is BitmapData){
					var bmdArr:Array=[bmdOrBmdArr,bmdOrBmdArr,bmdOrBmdArr,bmdOrBmdArr,bmdOrBmdArr,bmdOrBmdArr];
				}else{
					bmdArr=bmdOrBmdArr;
				}
			}else{
				bmdArr=[null,null,null,null,null,null];
			}
			
			if(_rev){
				for(var i:int=0;i<6;i++){
					var plane:Plane=new Plane(d,d,seg,seg,bmdArr[i],false,_useSp);
					this.addChild(plane);
					switch(i){
						case 0:
							//顶
							plane.y=-d/2;
							plane.rotationX=90;
						break;
						case 1:
							//前（其实是后）
							plane.z=d/2;
						break;
						case 2:
							//右
							plane.x=d/2;
							plane.rotationY=90;
						break;
						case 3:
							//后（其实是前）
							plane.z=-d/2;
							plane.rotationY=180;
						break;
						case 4:
							//左
							plane.x=-d/2;
							plane.rotationY=-90;
						break;
						case 5:
							//下
							plane.y=d/2;
							plane.rotationX=-90;
						break;
					}
				}
			}else{
				for(i=0;i<6;i++){
					plane=new Plane(d,d,seg,seg,bmdArr[i],false,_useSp);
					this.addChild(plane);
					switch(i){
						case 0:
							//顶
							plane.y=-d/2;
							plane.rotationX=-90;
						break;
						case 1:
							//前
							plane.z=-d/2;
						break;
						case 2:
							//右
							plane.x=d/2;
							plane.rotationY=-90;
						break;
						case 3:
							//后
							plane.z=d/2;
							plane.rotationY=180;
						break;
						case 4:
							//左
							plane.x=-d/2;
							plane.rotationY=90;
						break;
						case 5:
							//下
							plane.y=d/2;
							plane.rotationX=90;
						break;
					}
				}
			}
			
		}
	}
}