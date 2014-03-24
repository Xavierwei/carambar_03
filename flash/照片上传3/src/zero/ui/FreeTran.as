/***
FreeTran 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年11月23日 13:22:02
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	import flash.utils.*;
	
	import zero.utils.getM;
	
	public class FreeTran extends Sprite{
		public static const TYPE_ROTATE:String="rotate";
		public static const TYPE_SKEW:String="skew";
		public static const TYPE_SCALE:String="scale";
		public static const TYPE_DRAG:String="drag";
		
		public var rotateArea:Sprite;
		public var skewArea:Sprite;
		public var dragArea:Sprite;
		private var dragArea_shape:Shape;
		public var scaleArea:Sprite;
		private var userMouse:MovieClip;
		private var currTarget:Sprite;
		
		private var typeDict:Dictionary;
		private var dxDict:Dictionary;
		private var dyDict:Dictionary;
		public var dot_rotateDict:Dictionary;
		public var dot_skewDict:Dictionary;
		public var dot_scaleDict:Dictionary;
		
		private var oldMouseX:Number;
		private var oldMouseY:Number;
		
		private var rotateDotArr:Array;
		private var skewDotArr:Array;
		private var scaleDotArr:Array;
		
		private var __minScaleX:Number=-1;
		private var __minScaleY:Number=-1;
		public function set minScaleX(_minScaleX:Number):void{
			if(_minScaleX>=0){
				__minScaleX=_minScaleX;
			}else{
				throw new Error("不合法的 _minScaleX："+_minScaleX);
			}
		}
		public function set minScaleY(_minScaleY:Number):void{
			if(_minScaleY>=0){
				__minScaleY=_minScaleY;
			}else{
				throw new Error("不合法的 _minScaleY："+_minScaleY);
			}
		}
		
		public function set minScale(_minScale:Number):void{
			if(_minScale>=0){
				minScaleX=_minScale;
				minScaleY=_minScale
			}else{
				throw new Error("不合法的 _minScale："+_minScale);
			}
		}
		
		private var __minWid:Number=-1;
		public function set minWid(_minWid:Number):void{
			if(_minWid>=0){
				__minWid=_minWid;
			}else{
				throw new Error("不合法的 _minWid："+_minWid);
			}
		}
		private var __minHei:Number=-1;
		public function set minHei(_minHei:Number):void{
			if(_minHei>=0){
				__minHei=_minHei;
			}else{
				throw new Error("不合法的 _minHei："+_minHei);
			}
		}
		
		private var __maxScaleX:Number=-1;
		private var __maxScaleY:Number=-1;
		public function set maxScaleX(_maxScaleX:Number):void{
			if(_maxScaleX>=0){
				__maxScaleX=_maxScaleX;
			}else{
				throw new Error("不合法的 _maxScaleX："+_maxScaleX);
			}
		}
		public function set maxScaleY(_maxScaleY:Number):void{
			if(_maxScaleY>=0){
				__maxScaleY=_maxScaleY;
			}else{
				throw new Error("不合法的 _maxScaleY："+_maxScaleY);
			}
		}
		
		public function set maxScale(_maxScale:Number):void{
			if(_maxScale>=0){
				maxScaleX=_maxScale;
				maxScaleY=_maxScale
			}else{
				throw new Error("不合法的 _maxScale："+_maxScale);
			}
		}
		
		private var __maxWid:Number=-1;
		public function set maxWid(_maxWid:Number):void{
			if(_maxWid>=0){
				__maxWid=_maxWid;
			}else{
				throw new Error("不合法的 _maxWid："+_maxWid);
			}
		}
		private var __maxHei:Number=-1;
		public function set maxHei(_maxHei:Number):void{
			if(_maxHei>=0){
				__maxHei=_maxHei;
			}else{
				throw new Error("不合法的 _maxHei："+_maxHei);
			}
		}
		
		/*
		private var __moveBounds:Rectangle=null;
		public function set moveBounds(_moveBounds:Rectangle):void{
			__moveBounds=_moveBounds;
		}
		*/
		public var moveBounds:Rectangle;
		
		private var __useUserMouse:Boolean;
		public function set useUserMouse(_useUserMouse:Boolean):void{
			__useUserMouse=_useUserMouse;
			if(__useUserMouse){
				userMouse.visible=true;
			}else{
				Mouse.show();
				userMouse.visible=false;
			}
		}
		
		private var __realMinWid2:Number=-1;
		private var __realMinHei2:Number=-1;
		private var __realMaxWid2:Number=-1;
		private var __realMaxHei2:Number=-1;
		
		private var currCankaoK:Number;
		
		public var onTran:Function;
		public var onStartTran:Function;
		public var onStopTran:Function;
		
		private var midP:Point;
		
		public function FreeTran(){
			var dragArea_sp:Sprite;
			
			if(this.numChildren){
				rotateArea=this.getChildAt(0) as Sprite;
				skewArea=this.getChildAt(1) as Sprite;
				dragArea=this.getChildAt(2) as Sprite;
				
				dragArea_sp=new Sprite();
				dragArea_shape=dragArea.getChildAt(0) as Shape;
				dragArea_sp.addChild(dragArea_shape);
				dragArea_sp.mouseEnabled=dragArea_sp.mouseChildren=false;
				dragArea.addChild(dragArea_sp);
				
				scaleArea=this.getChildAt(3) as Sprite;
				userMouse=this.getChildAt(4) as MovieClip;
			}else{
				
				rotateArea=new Sprite();
				this.addChild(rotateArea);
				addDot(rotateArea,-50,-50,25,25,0x000000,0);
				addDot(rotateArea,50,-50,25,25,0x000000,0);
				addDot(rotateArea,50,50,25,25,0x000000,0);
				addDot(rotateArea,-50,50,25,25,0x000000,0);
				
				skewArea=new Sprite();
				this.addChild(skewArea);
				addDot(skewArea,0,-50,25,25,0x000000,0);
				addDot(skewArea,50,0,25,25,0x000000,0);
				addDot(skewArea,0,50,25,25,0x000000,0);
				addDot(skewArea,-50,0,25,25,0x000000,0);
				
				dragArea=new Sprite();
				dragArea_sp=new Sprite();
				dragArea_shape=new Shape();
				dragArea_shape.graphics.clear();
				dragArea_shape.graphics.lineStyle(0,0x999999,0.6);
				dragArea_shape.graphics.beginFill(0x000000,0);
				dragArea_shape.graphics.drawRect(0,0,100,100);
				dragArea_shape.graphics.endFill();
				dragArea_sp.addChild(dragArea_shape);
				dragArea_sp.mouseEnabled=dragArea_sp.mouseChildren=false;
				dragArea.addChild(dragArea_sp);
				this.addChild(dragArea);
				
				scaleArea=new Sprite();
				this.addChild(scaleArea);
				addDot(scaleArea,-50,-50,7,7,0x000000,2,0xffffff);
				addDot(scaleArea,50,-50,7,7,0x000000,2,0xffffff);
				addDot(scaleArea,50,50,7,7,0x000000,2,0xffffff);
				addDot(scaleArea,-50,50,7,7,0x000000,2,0xffffff);
				addDot(scaleArea,0,-50,7,7,0x000000,2,0xffffff);
				addDot(scaleArea,50,0,7,7,0x000000,2,0xffffff);
				addDot(scaleArea,0,50,7,7,0x000000,2,0xffffff);
				addDot(scaleArea,-50,0,7,7,0x000000,2,0xffffff);
				
				userMouse=new MovieClip();
				this.addChild(userMouse);
				userMouse.blendMode=BlendMode.INVERT;
			}
			
			useUserMouse=true;
			
			updateUserMouse(null);
			this.visible=false;
			this.addEventListener(Event.ADDED_TO_STAGE,added);
			
			typeDict=new Dictionary();
			dxDict=new Dictionary();
			dyDict=new Dictionary();
			dot_rotateDict=new Dictionary();
			dot_skewDict=new Dictionary();
			dot_scaleDict=new Dictionary();
			
			rotateDotArr=new Array();
			initArea(rotateArea,TYPE_ROTATE,rotateDotArr);
			
			skewDotArr=new Array();
			initArea(skewArea,TYPE_SKEW,skewDotArr);
			
			scaleDotArr=new Array();
			initArea(scaleArea,TYPE_SCALE,scaleDotArr);
			
			initTarget(dragArea,TYPE_DRAG);
		}
		
		private function addDot(
			area:Sprite,
			x:int,y:int,
			wid:int,hei:int,
			fillColor:int,fillAlpha:Number,
			lineColor:int=-1
		):void{
			var dot:Sprite=new Sprite();
			
			area.addChild(dot);
			
			dot.x=x;
			dot.y=y;
			dot.graphics.clear();
			if(lineColor>=0){
				dot.graphics.lineStyle(1,lineColor);
			}
			dot.graphics.beginFill(fillColor,fillAlpha);
			dot.graphics.drawRect(-wid/2,-hei/2,wid,hei);
			dot.graphics.endFill();
		}
		
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			userMouse.mouseEnabled=userMouse.mouseChildren=false;
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			
			clearTarget(dragArea);
			
			clearArea(rotateArea);
			clearArea(scaleArea);
			
			rotateArea=null;
			skewArea=null;
			dragArea=null;
			dragArea_shape=null;
			scaleArea=null;
			userMouse=null;
			currTarget=null;
			
			rotateDotArr=null;
			skewDotArr=null;
			scaleDotArr=null;
			
			onTran=null;
			onStartTran=null;
			onStopTran=null;
			
			midP=null;
			
			Mouse.show();
		}
		
		private var __pic:DisplayObject;
		public function getPic():DisplayObject{
			return __pic;
		}
		public function setPic(_pic:DisplayObject,drag:Boolean=false):void{
			__pic=_pic;
			if(__pic){
				var pic_rect:Rectangle=__pic.getBounds(__pic);
				midP=new Point(pic_rect.x+pic_rect.width/2,pic_rect.y+pic_rect.height/2);
				dragArea_shape.x=pic_rect.x;
				dragArea_shape.y=pic_rect.y;
				dragArea_shape.width=pic_rect.width;
				dragArea_shape.height=pic_rect.height;
				dragArea_shape.parent.width=100;
				dragArea_shape.parent.height=100;
				var dragArea_shape_rect:Rectangle=dragArea_shape.parent.getBounds(dragArea);
				dragArea_shape.parent.x-=dragArea_shape_rect.x;
				dragArea_shape.parent.y-=dragArea_shape_rect.y;
				
				//trace(pic_rect);
				
				if(__minScaleX>=0||__minWid>=0){
					//计算 __realMinWid2，如果 __minScaleX 和 __minWid 同时被设置，取大的那个
					__realMinWid2=-Infinity;
					if(__minScaleX>=0){
						var _minWid:Number=pic_rect.width*__minScaleX;
						if(__realMinWid2<_minWid){
							__realMinWid2=_minWid;
						}
					}
					if(__minWid>=0){
						if(__realMinWid2<__minWid){
							__realMinWid2=__minWid;
						}
					}
					
					__realMinWid2/=2;
				}else{
					__realMinWid2=-1;
				}
				//trace("__realMinWid2="+__realMinWid2);
				
				if(__maxScaleX>=0||__maxWid>=0){
					//计算 __realMaxWid2，如果 __maxScaleX 和 __maxWid 同时被设置，取小的那个
					__realMaxWid2=Infinity;
					if(__maxScaleX>=0){
						var _maxWid:Number=pic_rect.width*__maxScaleX;
						if(__realMaxWid2>_maxWid){
							__realMaxWid2=_maxWid;
						}
					}
					if(__maxWid>=0){
						if(__realMaxWid2>__maxWid){
							__realMaxWid2=__maxWid;
						}
					}
					
					__realMaxWid2/=2;
				}else{
					__realMaxWid2=-1;
				}
				//trace("__realMaxWid2="+__realMaxWid2);
				
				if(__minScaleY>=0||__minHei>=0){
					//计算 __realMinHei2，如果 __minScaleY 和 __minHei 同时被设置，取大的那个
					__realMinHei2=-Infinity;
					if(__minScaleY>=0){
						var _minHei:Number=pic_rect.height*__minScaleY;
						if(__realMinHei2<_minHei){
							__realMinHei2=_minHei;
						}
					}
					if(__minHei>=0){
						if(__realMinHei2<__minHei){
							__realMinHei2=__minHei;
						}
					}
					
					__realMinHei2/=2;
				}else{
					__realMinHei2=-1;
				}
				//trace("__realMinHei2="+__realMinHei2);
				
				if(__maxScaleY>=0||__maxHei>=0){
					//计算 __realMaxHei2，如果 __maxScaleY 和 __maxHei 同时被设置，取小的那个
					__realMaxHei2=Infinity;
					if(__maxScaleY>=0){
						var _maxHei:Number=pic_rect.height*__maxScaleY;
						if(__realMaxHei2>_maxHei){
							__realMaxHei2=_maxHei;
						}
					}
					if(__maxHei>=0){
						if(__realMaxHei2>__maxHei){
							__realMaxHei2=__maxHei;
						}
					}
					
					__realMaxHei2/=2;
				}else{
					__realMaxHei2=-1;
				}
				//trace("__realMaxHei2="+__realMaxHei2);
				
				/*
				this.graphics.clear();
				this.graphics.lineStyle(1,0x0000ff);
				if(__realMaxWid2>=0){
					this.graphics.drawRect(-__realMaxWid2,-__realMaxHei2,__realMaxWid2*2,__realMaxHei2*2);
				}
				if(__realMinWid2>=0){
					this.graphics.drawRect(-__realMinWid2,-__realMinHei2,__realMinWid2*2,__realMinHei2*2);
				}
				*/
				
				__updateByPic();
				
				this.visible=true;
				if(drag){
					currTarget=dragArea;
					updateUserMouse(currTarget);
					oldMouseX=this.parent.mouseX;
					oldMouseY=this.parent.mouseY;
					(onStartTran==null)||onStartTran(__pic,__pic.transform.matrix,TYPE_DRAG);
				}
			}else{
				this.visible=false;
			}
		}
		
		public function set rotateEnabled(_rotateEnabled:Boolean):void{
			rotateArea.visible=_rotateEnabled;
		}
		public function set skewEnabled(_skewEnabled:Boolean):void{
			skewArea.visible=_skewEnabled;
		}
		public function set scaleEnabled(_scaleEnabled:Boolean):void{
			scaleArea.visible=_scaleEnabled;
		}
		public function set scaleSideEnabled(_scaleSideEnabled:Boolean):void{
			dot_scaleDict["dot0-1"].visible=
			dot_scaleDict["dot01"].visible=
			dot_scaleDict["dot-10"].visible=
			dot_scaleDict["dot10"].visible=
			_scaleSideEnabled;
		}
		public function set dragEnabled(_dragEnabled:Boolean):void{
			dragArea.mouseEnabled=_dragEnabled;
			//dragArea.visible=_dragEnabled;
		}
		public var lockScale:Boolean;
		
		private function clearArea(area:Sprite):void{
			var i:int=area.numChildren;
			while(--i>=0){
				clearTarget(area.getChildAt(i) as Sprite);
			}
		}
		private function clearTarget(target:Sprite):void{
			target.removeEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			target.removeEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			target.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
		}
		private function initArea(area:Sprite,type:String,dotArr:Array):void{
			var i:int=area.numChildren;
			while(--i>=0){
				var dot:Sprite=area.getChildAt(i) as Sprite;
				if(dot.x<-1){
					dxDict[dot]=-1;
				}else if(dot.x>1){
					dxDict[dot]=1;
				}else{
					dxDict[dot]=0;
				}
				if(dot.y<-1){
					dyDict[dot]=-1;
				}else if(dot.y>1){
					dyDict[dot]=1;
				}else{
					dyDict[dot]=0;
				}
				
				//trace("dot_"+type+"Dict");
				this["dot_"+type+"Dict"]["dot"+dxDict[dot]+dyDict[dot]]=dot;
				
				initTarget(dot,type);
				
				if(dotArr){
					dotArr[dotArr.length]=dot;
				}
			}
		}
		private function initTarget(target:Sprite,type:String):void{
			target.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			target.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			target.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			typeDict[target]=type;
		}
		private function mouseMove(event:MouseEvent):void{
			if(__pic){
			}else{
				return;
			}
			
			if(currTarget){
				switch(typeDict[currTarget]){
					case TYPE_ROTATE:
						this.rotation+=(Math.atan2(this.parent.mouseY-this.y,this.parent.mouseX-this.x)-Math.atan2(oldMouseY-this.y,oldMouseX-this.x))*(180/Math.PI);
					break;
					case TYPE_SCALE:
						var dot:Sprite;
						var currDx:int=dxDict[currTarget];
						var currDy:int=dyDict[currTarget];
						
						var currX:Number;
						var currY:Number;
						if(currDx){
							currX=this.mouseX*currDx;
						}else{
							currX=0;
						}
						if(currDy){
							currY=this.mouseY*currDy;
						}else{
							currY=0;
						}
						
						if(currDx){
							if(__realMinWid2>=0&&currX<__realMinWid2){
								//如果小于最小宽度
								currX=__realMinWid2;
							}else if(__realMaxWid2>=0&&currX>__realMaxWid2){
								//如果大于最大宽度
								currX=__realMaxWid2;
							}
						}
						if(currDy){
							if(__realMinHei2>=0&&currY<__realMinHei2){
								//如果小于最小高度
								currY=__realMinHei2;
							}
							if(__realMaxHei2>=0&&currY>__realMaxHei2){
								//如果大于最大高度
								currY=__realMaxHei2;
							}
						}
						
						if(lockScale&&currDx&&currDy){
							//等比缩放
							//以绝对值小的为标准
							
							if(currX*currY*currCankaoK<-1){
								currCankaoK*=-1;
							}
							
							if(currCankaoK<0){
								if(currX/currY<currCankaoK){
									currX=currY*currCankaoK;
								}else{
									currY=currX/currCankaoK;
								}
							}else{
								if(currX/currY>currCankaoK){
									currX=currY*currCankaoK;
									if(__realMinWid2>=0&&currX<__realMinWid2){
										//如果小于最小宽度
										currX=__realMinWid2;
										currY=currX/currCankaoK;
									}
								}else{
									currY=currX/currCankaoK;
									if(__realMinHei2>=0&&currY<__realMinHei2){
										//如果小于最小高度
										currY=__realMinHei2;
										currX=currY*currCankaoK;
									}
								}
							}
						}else{
							if(currDx&&currDy){
								currCankaoK=currX/currY;
							}else if(currDx){
								currCankaoK=currX/dot_scaleDict["dot11"].y;
							}else if(currDy){
								currCankaoK=dot_scaleDict["dot11"].x/currY;
							}
							
							//trace("currCankaoK="+currCankaoK);
						}
						
						if(currDx){
							for each(dot in scaleDotArr){
								dot.x=dxDict[dot]*currX;
							}
						}
						if(currDy){
							for each(dot in scaleDotArr){
								dot.y=dyDict[dot]*currY;
							}
						}
						
						updateOtherDotsByScaleDots();
						updateDragAreaByDots();
					break;
					case TYPE_DRAG:
						this.x+=this.parent.mouseX-oldMouseX;
						this.y+=this.parent.mouseY-oldMouseY;
					break;
				}
				if(moveBounds){
					var b:Rectangle=dragArea_shape.getBounds(__pic.parent);
					if(b.left<moveBounds.left){
						this.x+=moveBounds.left-b.left;
					}else if(b.right>moveBounds.right){
						this.x+=moveBounds.right-b.right;
					}
					if(b.top<moveBounds.top){
						this.y+=moveBounds.top-b.top;
					}else if(b.bottom>moveBounds.bottom){
						this.y+=moveBounds.bottom-b.bottom;
					}
				}
				__updatePic();
			}
			
			oldMouseX=this.parent.mouseX;
			oldMouseY=this.parent.mouseY;
			
			userMouse.x=this.mouseX;
			userMouse.y=this.mouseY;
		}
		private function mouseOver(event:MouseEvent):void{
			if(currTarget){
				return;
			}
			updateUserMouse(event.target as Sprite);
		}
		private function mouseOut(event:MouseEvent):void{
			if(currTarget){
				return;
			}
			updateUserMouse(null);
		}
		private function mouseDown(event:MouseEvent):void{
			currTarget=event.target as Sprite;
			switch(typeDict[currTarget]){
				case TYPE_ROTATE:
				case TYPE_SCALE:
				case TYPE_DRAG:
					oldMouseX=this.parent.mouseX;
					oldMouseY=this.parent.mouseY;
					(onStartTran==null)||onStartTran(__pic,__pic.transform.matrix,typeDict[currTarget]);
				break;
			}
		}
		private function mouseUp(event:MouseEvent):void{
			var target:Sprite=event.target as Sprite;
			updateUserMouse(event.target as Sprite);
			if(currTarget){
				(onStopTran==null)||onStopTran(__pic,__pic.transform.matrix,typeDict[currTarget]);
				currTarget=null;
			}
		}
		
		private function updateOtherDotsByScaleDots():void{
			var dot:Sprite;
			var scaleDot:Sprite;
			for each(dot in rotateDotArr){
				scaleDot=dot_scaleDict["dot"+dxDict[dot]+dyDict[dot]];
				dot.x=scaleDot.x;
				dot.y=scaleDot.y;
			}
			for each(dot in skewDotArr){
				scaleDot=dot_scaleDict["dot"+dxDict[dot]+dyDict[dot]];
				dot.x=scaleDot.x;
				dot.y=scaleDot.y;
			}
		}
		private function setMidIn2Dot(dot0:Sprite,dot1:Sprite,dot2:Sprite):void{
			dot0.x=(dot1.x+dot2.x)/2;
			dot0.y=(dot1.y+dot2.y)/2;
		}
		private function updateDragAreaByDots():void{
			var dot0:Sprite=dot_scaleDict["dot-1-1"];
			var dotx:Sprite=dot_scaleDict["dot1-1"];
			var doty:Sprite=dot_scaleDict["dot-11"];
			dragArea.transform.matrix=new Matrix((dotx.x-dot0.x)/100,(dotx.y-dot0.y)/100,(doty.x-dot0.x)/100,(doty.y-dot0.y)/100,dot0.x,dot0.y);
		}
		private function updateDotsByDragArea():void{
			var m:Matrix=dragArea.transform.matrix;
			
			var dot:Sprite;
			for each(dot in scaleDotArr){
				var p:Point=m.transformPoint(new Point(50+50*dxDict[dot],50+50*dyDict[dot]));
				dot.x=p.x;
				dot.y=p.y;
			}
			updateOtherDotsByScaleDots();
		}
		private function updateUserMouse(target:Sprite):void{
			if(target&&typeDict[target]){
				//trace(target,typeDict[target]);
				userMouse.x=this.mouseX;
				userMouse.y=this.mouseY;
				if(__useUserMouse){
					Mouse.hide();
				}
				switch(typeDict[target]){
					case TYPE_DRAG:
						userMouse.rotation=0;
						if(userMouse.totalFrames>1){
							userMouse.gotoAndStop(typeDict[target]);
						}else{
							userMouse.graphics.clear();
							userMouse.graphics.lineStyle(1,0x000000);
							
							userMouse.graphics.moveTo(-10,0);
							userMouse.graphics.lineTo(10,0);
							userMouse.graphics.moveTo(0,-10);
							userMouse.graphics.lineTo(0,10);
							
							userMouse.graphics.beginFill(0x000000);
							userMouse.graphics.moveTo(-6,-4);
							userMouse.graphics.lineTo(-10,0);
							userMouse.graphics.lineTo(-6,4);
							userMouse.graphics.lineTo(-6,-4);
							userMouse.graphics.moveTo(6,-4);
							userMouse.graphics.lineTo(10,0);
							userMouse.graphics.lineTo(6,4);
							userMouse.graphics.lineTo(6,-4);
							userMouse.graphics.moveTo(-4,-6);
							userMouse.graphics.lineTo(0,-10);
							userMouse.graphics.lineTo(4,-6);
							userMouse.graphics.lineTo(-4,-6);
							userMouse.graphics.moveTo(-4,6);
							userMouse.graphics.lineTo(0,10);
							userMouse.graphics.lineTo(4,6);
							userMouse.graphics.lineTo(-4,6);
							userMouse.graphics.endFill();
						}
						return;
					break;
					case TYPE_ROTATE:
						userMouse.rotation=0;
						if(userMouse.totalFrames>1){
							userMouse.gotoAndStop(typeDict[target]);
						}else{
							userMouse.graphics.clear();
							userMouse.graphics.lineStyle(1,0x000000);
							userMouse.graphics.moveTo(0,8);
							userMouse.graphics.curveTo(-8,8,-8,0);
							userMouse.graphics.curveTo(-8,-8,0,-8);
							userMouse.graphics.curveTo(8,-8,8,0);
							userMouse.graphics.beginFill(0x000000);
							userMouse.graphics.moveTo(4,0);
							userMouse.graphics.lineTo(8,4);
							userMouse.graphics.lineTo(12,0);
							userMouse.graphics.lineTo(4,0);
						}
						return;
					break;
					case TYPE_SCALE:
						userMouse.rotation=Math.atan2((currCankaoK<0?-1:1)*dyDict[target],dxDict[target])*(180/Math.PI);
						if(userMouse.totalFrames>1){
							userMouse.gotoAndStop(typeDict[target]);
						}else{
							userMouse.graphics.clear();
							userMouse.graphics.lineStyle(1,0x000000);
							
							userMouse.graphics.moveTo(-10,0);
							userMouse.graphics.lineTo(10,0);
							
							userMouse.graphics.beginFill(0x000000);
							userMouse.graphics.moveTo(-6,-4);
							userMouse.graphics.lineTo(-10,0);
							userMouse.graphics.lineTo(-6,4);
							userMouse.graphics.lineTo(-6,-4);
							userMouse.graphics.moveTo(6,-4);
							userMouse.graphics.lineTo(10,0);
							userMouse.graphics.lineTo(6,4);
							userMouse.graphics.lineTo(6,-4);
							userMouse.graphics.endFill();
						}
						return;
					break;
					//case TYPE_SKEW:
					//	trace("暂不支持");
					//break;
				}
			}
			userMouse.graphics.clear();
			Mouse.show();
			if(userMouse.totalFrames>1){
				userMouse.gotoAndStop(1);
			}
		}
		private function __updateByPic():void{
			updateByPic(__pic);
		}
		private function __updatePic():void{
			updatePic(__pic);
			(onTran==null)||onTran(__pic,__pic.transform.matrix,typeDict[currTarget]);
		}
		
		public function updateByPic(_pic:DisplayObject):void{
			var p:Point=getM(_pic,this.parent,false).transformPoint(midP);
			this.transform.matrix=new Matrix(1,0,0,1,p.x,p.y);//把 this 移至 _pic 中点
			this.rotation=_pic.rotation;//旋转设置为和 _pic 旋转一样
			
			var m:Matrix=dragArea_shape.transform.matrix.clone();
			m.concat(getM(_pic,dragArea.parent,false));
			dragArea.transform.matrix=m;
			
			updateDotsByDragArea();
			
			currCankaoK=(dot_scaleDict["dot-1-1"].x-dot_scaleDict["dot11"].x)/(dot_scaleDict["dot-1-1"].y-dot_scaleDict["dot11"].y);
			//trace("currCankaoK="+currCankaoK);
		}
		public function updatePic(_pic:DisplayObject):void{
			_pic.transform.matrix=getM(dragArea_shape.parent,_pic.parent,false);
		}
	}
}

