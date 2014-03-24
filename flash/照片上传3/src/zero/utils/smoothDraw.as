/***
smoothDraw
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月30日 10:21:21
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import flash.display.Graphics;
	import flash.geom.Point;

	/**
	 * 画平滑曲线
	 * obj 可以是 Graphics，Shape 或 Sprite
	 * bihe 是否闭合
	 * ps 可以是任何带 x，y 属性的对象们，例如 Sprite 或 Point
	 * 用法：smoothDraw(sprite,true,mc1,mc2,mc3,mc4) 或 smoothDraw(sprite,true,[mc1,mc2,mc3,mc4])
	 */	
	public function smoothDraw(obj:*,bihe:Boolean,...ps):void{
		var graphics:Graphics;
		if(obj is Graphics){
			graphics=obj;
		}else{
			graphics=obj.graphics;
		}
		
		var p:*,i:int;
		
		do{
			var hasGroup:Boolean=false;
			var psCopy:Array=new Array();
			for each(p in ps){
				if(p.hasOwnProperty("x")&&p.hasOwnProperty("y")){
					psCopy.push(p);
				}else{
					hasGroup=true;
					for each(var subP:* in p){
						psCopy.push(subP);
					}
				}
			}
			ps=psCopy;
		}while(hasGroup);
		
		if(ps.length<2){
			return;
		}
		
		var dx:Number,dy:Number;
		var p1:*,p2:*;
		
		if(bihe){
		}else{
			p1=ps[0];
			p2=ps[1];
			dx=p1.x-p2.x;
			dy=p1.y-p2.y;
			ps.unshift(new Point(p1.x+dx*0.1,p1.y+dy*0.1));
			p1=ps[ps.length-1];
			p2=ps[ps.length-2];
			dx=p1.x-p2.x;
			dy=p1.y-p2.y;
			ps.push(new Point(p1.x+dx*0.1,p1.y+dy*0.1));
		}
		
		var total:int=ps.length;
		
		//中点
		var ox:Number=0;
		var oy:Number=0;
		for each(p in ps){
			ox+=p.x;
			oy+=p.y;
		}
		ox/=total;
		oy/=total;
		
		var vV:Vector.<Point>=new Vector.<Point>();
		i=-1;
		for each(p in ps){
			i++;
			p1=ps[(i+1)%total];
			p2=ps[(i-1+total)%total];
			vV[i]=new Point(p1.x-p2.x,p1.y-p2.y);
		}
		
		var d:Number;
		if(bihe){
			i=0;
		}else{
			i=1;
		}
		graphics.moveTo(ps[i].x,ps[i].y);
		while(i<total){
			p1=ps[i];
			if(bihe){
			}else{
				if(
					i==0
					||
					i==total-2
					||
					i==total-1
				){
					i++;
					continue;
				}
			}
			
			p2=ps[(i+1)%total];
			var v1:Point=vV[i];
			var v2:Point=vV[(i+1)%total];
			var p0:*=ps[(i-1+total)%total];
			var p3:*=ps[(i+2)%total];
			
			if(
				(p1.x-p0.x)*(p2.y-p1.y)-(p1.y-p0.y)*(p2.x-p1.x)>0
				&&
				(p2.x-p1.x)*(p3.y-p2.y)-(p2.y-p1.y)*(p3.x-p2.x)>0
			){
				//trace("右");
				d=v1.x*v2.y-v1.y*v2.x;
				graphics.curveTo((v1.x*v2.x*(p1.y-p2.y)+v1.x*v2.y*p2.x-v1.y*v2.x*p1.x)/d,(v1.y*v2.y*(p2.x-p1.x)+v1.x*v2.y*p1.y-v1.y*v2.x*p2.y)/d,p2.x,p2.y);
			}else{
				//trace("左");
				dx=p1.x-p2.x;
				dy=p1.y-p2.y;
				d=Math.sqrt(dx*dx+dy*dy)*0.3;
				if(d>0){
					v1.normalize(d);
					v2.normalize(d);
					graphics.curveTo(p1.x+v1.x,p1.y+v1.y,(p1.x+v1.x+p2.x-v2.x)/2,(p1.y+v1.y+p2.y-v2.y)/2);
					graphics.curveTo(p2.x-v2.x,p2.y-v2.y,p2.x,p2.y);
				}
			}
			
			i++;
		}
	}
}