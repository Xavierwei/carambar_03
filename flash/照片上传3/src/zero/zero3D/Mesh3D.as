/***
Mesh3D
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年09月23日 10:10:14
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.zero3D{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.TriangleCulling;

	/**
	 * 
	 * 面片
	 * 
	 */	
	public class Mesh3D extends VerticesObj3D{
		
		private var sp:Sprite;
		
		private var vertexIdV:Vector.<int>;
		public var bmd:BitmapData;
		internal var uvtV:Vector.<Number>;
		
		private var rev:Boolean;
		
		public function Mesh3D(
			_vertexV:Vector.<Number>,
			_vertexIdV:Vector.<int>,
			_bmd:BitmapData=null,
			_uvtV:Vector.<Number>=null,
			_rev:Boolean=false,
			_useSp:Boolean=true
		){
			
			super(_vertexV);
			
			if(_useSp){
				sp=new Sprite();
			}
			
			vertexIdV=_vertexIdV;
			vertexIdV.fixed=true;
			
			bmd=_bmd;
			
			uvtV=_uvtV;
			uvtV.fixed=true;
			
			rev=_rev;
			
		}
		
		override public function clear():void{super.clear();
			
			if(sp){
				sp=null;
			}
			
			vertexIdV=null;
			bmd=null;
			uvtV=null;
			
		}
		
		override internal function render(
			container:Sprite,
			dScreen:Number,
			screenCenter:Array,
			focalLength2:Number
		):void{
			
			var render_vertexIdV:Vector.<int>=new Vector.<int>();
			
			var mark:Array=new Array();
			var i:int=screenVertexV.length;
			while(i){
				i-=2;
				if(
					screenVertexV[i]>-MAX_NUMBER&&screenVertexV[i]<MAX_NUMBER
					&&
					screenVertexV[i+1]>-MAX_NUMBER&&screenVertexV[i+1]<MAX_NUMBER
				){
					mark[i/2]=true;
					
					//计算t
					//参考：通过三角形获得 3D 效果（http://help.adobe.com/zh_CN/as3/dev/WS84753F1C-5ABE-40b1-A2E4-07D7349976C4zephyr_serranozephyr.html）
					var j:int=i/2*3;
					uvtV[j+2]=dScreen/cameraVertexV[j+2];
				}
			}
			
			i=vertexIdV.length;
			while(i){
				i-=3;
				if(
					mark[vertexIdV[i]]
					&&
					mark[vertexIdV[i+1]]
					&&
					mark[vertexIdV[i+2]]
				){
					render_vertexIdV.push(vertexIdV[i],vertexIdV[i+1],vertexIdV[i+2]);
				}
			}
			
			if(render_vertexIdV.length){
				if(sp){
					var g:Graphics=sp.graphics;
					g.clear();
				}else{
					g=container.graphics;
				}
				if(bmd){
					//g.lineStyle(1,0xffff00);//测试
					g.beginBitmapFill(bmd,null,false,true);//设置贴图
				}else{
					g.lineStyle(1,0xff0000);//设置线条
				}
				g.drawTriangles(screenVertexV,render_vertexIdV,uvtV,rev?TriangleCulling.NEGATIVE:TriangleCulling.POSITIVE);
				if(bmd){
					g.endFill();//清除贴图设置
				}else{
					g.lineStyle();//清除线条设置
				}
				if(sp){
					container.addChild(sp);
				}
			}
			
		}
		
	}
}