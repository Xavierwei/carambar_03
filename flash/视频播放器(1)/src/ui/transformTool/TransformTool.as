/**
*
* 6dn Transform Tool

*----------------------------------------------------------------
* @notice 6dn Transform Tool 变形工具类
* @author 6dn
* @fp9.0  as3.0
* @v2.0
* @date 2009-7-15
*
* AUTHOR ******************************************************************************
* 
* authorName : 黎新苑 - www.6dn.cn
* QQ :160379558(6dnの星)
* MSN :xdngo@hotmail.com
* email :6dn@6dn.cn  xdngo@163.com
* webpage :   http://www.6dn.cn
* blog :    http://blog.6dn.cn
* 
* LICENSE ******************************************************************************
* 
* ① 此类为携带版变形工具类，所有用到的类都集成在一起~，所以阅读起来可能会不太方便。
* ② 基本上实现对选中DisplayObject进行缩放，旋转，变形,可轻松添加和移除控制；
* ③构造方法:
		TansformTool(container:DisplayObjectContainer) //创建TansformTool

	公共方法:

		-Init():void                          //初始化并添加侦听
		-Clear():void                         //移除TansformTool并移除侦听

		-AddControl(displayobject:DisplayObject):void       //添加控制
		-RemoveControl(displayobject:DisplayObject):void    //移除控制

		-SetType(object:Object, type:String):void  //设置TansformTool的类型

			// object:Object 中可设置：
				//o_graphics:String("rect" | "circle" | "bmp"); 中心点图形
				//graphics:String("rect" | "circle" | "bmp"); 边块图形
				//o_bitmapdata:BitmapData 中心点填充位图,o_graphics设为"bmp"才生效
				//bitmapdata:BitmapData 边块填充位图,graphics设为"bmp"才生效
				//color:uint  颜色值
				//border:uint  线条粗细
				//size:uint  边块大小
				//type:String("default") 使用默认设置

			//type:String ("activate" | "select") 指定激活状态或选择状态

		-SetStyle(displayobject:DisplayObject, object:Object):void  //设置DisplayObject的控制方式

			//displayobject:DisplayObject 要控制的显示对象

			// object:Object 中可设置:
				//enMoveX:Boolean 是否可以沿X轴拖动
				//enMoveY:Boolean 是否可以沿Y轴拖动
				//enSclaeX:Boolean 是否可以沿X轴拉伸
				//enSclaeY:Boolean 是否可以沿Y轴拉伸
				//enSkewX:Boolean 是否可以沿X轴斜切
				//enSkewY:Boolean 是否可以沿Y轴斜切
				//enScale:Boolean  是否可以拉伸
				//eqScale:Boolean  是否限制等比
				//enRotation:Boolean  是否可以旋转
				//enSetMidPoint:Boolean  是否设置中心点

		-SetInfo(displayobject:DisplayObject, parameter:Object):Boolean   //设置DisplayObject的属性
		    
			//displayobject:DisplayObject 要控制的显示对象

			//parameter:Object 中可设置
				//x  设置x值:Number=数值 设置还原初始:String="revert"
				//y  设置y值:Number=数值 设置还原初始:String="revert"
				//scalex  设置scalex值:Number=数值 设置还原初始:String="revert"
				//sclaey  设置sclaey值:Number=数值 设置还原初始:String="revert"
				//skewx  设置skewx值:Number=数值 设置还原初始:String="revert"
				//skewy  设置skewy值:Number=数值 设置还原初始:String="revert"
				//rotation 设置rotation值:Number=数值 设置还原初始:String="revert"

		-GetInfo(displayobject:DisplayObject):Object     //获取DisplayObject的属性值
		
		-Undo():Boolean   //撤消
		-Redo():Boolean   //重做
		-ClearRecorde():void //删除操作记录

	公共属性:
		-area:Rectangle  //TansformTool作用区域（默认为舞台区域)(读写)
		-selectedItem:DisplayObject  //当前选择的显示对象(读写)

	用法示例 usage：
	var _transform:TransformTool = new TransformTool(root as DisplayObjectContainer);
	_transform.AddControl(mc);
	_transform.SetStyle(mc, {enMoveX:false, enScaleY:false, enSkewX:false, enSkewY:false});
	_transform.SetType({o_graphics:"bmp", graphics:"rect", color:0x339900, size:2},"activate");
	_transform.SetType({o_graphics:"circle", graphics:"rect", color:0x0, size:1},"select");
	_transform.Init();

* Please, keep this header and the list of all authors
* 
*/

package ui.transformTool
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;

	import flash.events.Event;	
	import flash.events.MouseEvent;
	import flash.events.IEventDispatcher;
		
	public class TransformTool 
	{
		private var matrixClass:MatrixClass;
		private var mathClass:MathClass;
		private var stateClass:StateClass;
		private var containTest:ContainPointClass;
		private var shapeArrow:ArrowShapeClass;
		private var shapeBounds:ShapeClass ;
	
		private var objectInfoList:Array;
		private var recordeList:Array;
		
		private var selectIndex:int;	
		private var recordIndex:int;	
		private var toolContainer:DisplayObjectContainer;
		private var typeActivate:Object;
		private var typeSelect:Object;
		private var rectArea:Rectangle;
		//-------------------------------------------------
		private static var mousePoint:Point = new Point();
		public var onSelectChange:Function;
		public var onChanging:Function;
		
		public function TransformTool(_container:DisplayObjectContainer = null) 
		{	
			if (!_container)
			{
				throw Error("please set containner first!");
				return;
			}
			toolContainer = _container
			matrixClass = new MatrixClass();
			mathClass = new MathClass();
			stateClass = new StateClass();
			shapeArrow = new ArrowShapeClass();
			shapeBounds = new ShapeClass();
			containTest = new ContainPointClass();
			
			objectInfoList = new Array();
			recordeList = new Array();
			selectIndex = -1;
			recordIndex = 0;
			
			typeActivate = { o_graphics:"cicle", graphics:"rect", o_bitmapdata: null, bitmapdata: null, color:0x0 };
			typeSelect = { o_graphics:"cicle",  graphics:"rect", o_bitmapdata:null,  bitmapdata: null, color:0xFF9900 };
			
		}
		public function Init(_stageMouse:Boolean = false):void
		{
			toolContainer.addChild(shapeBounds);
			toolContainer.addChild(shapeArrow);
			if (_stageMouse) {
				toolContainer.stage.addEventListener( MouseEvent.MOUSE_MOVE, EventHadler);
			}else {
				toolContainer.addEventListener( MouseEvent.MOUSE_MOVE, EventHadler);
				toolContainer.addEventListener(MouseEvent.ROLL_OUT, EventHadler);
			}
			toolContainer.addEventListener( MouseEvent.MOUSE_DOWN, EventHadler);
			toolContainer.stage.addEventListener( MouseEvent.MOUSE_UP, EventHadler);
		}
		public function Clear():void
		{
			shapeArrow.Clear();
			shapeBounds.Clear();
			
			toolContainer.removeChild(shapeArrow);
			toolContainer.removeChild(shapeBounds);
			
			toolContainer.stage.removeEventListener( MouseEvent.MOUSE_MOVE, EventHadler);
			toolContainer.removeEventListener( MouseEvent.MOUSE_DOWN, EventHadler);
			toolContainer.stage.removeEventListener( MouseEvent.MOUSE_UP, EventHadler);
		}
		
		public function AddControl(_disObject:DisplayObject,_isCenterMid:Boolean=true):void
		{
			var _objInfo:Object = findObjectInfo(_disObject);
			if (_objInfo) {
				return;
			}
			var _internalPoint:Point = new Point(0, 0);
			if (_isCenterMid) {
				_internalPoint.x = _disObject.width * 0.5 / _disObject.scaleX;
				_internalPoint.y = _disObject.height * 0.5 / _disObject.scaleY;
			}
			var _externalPoint:Point = (_disObject.parent).globalToLocal(_disObject.localToGlobal(_internalPoint));
			var _matrixObj:Object = matrixClass.GetMatrix(_disObject, _internalPoint);
			
			if (_disObject is DisplayObjectContainer) {
				(_disObject as DisplayObjectContainer).mouseChildren=false;
			}
			var _style :Object= {
				enMoveX:true,
				enMoveY:true,
				enScaleX:true,
				enScaleY:true,
				enSkewX:true,
				enSkewY:true,
				enScale:true,
				eaScale:false,
				enRotation:true,
				enSetMidPoint:true
			};
			objectInfoList.push(
				{
					obj        : _disObject, 
					state      : stateClass.normal,
					areanum    : -1,
					mousePoint0 : new Point(0,0),
					mousePoint1 : new Point(0,0),
					internalPoint  : _internalPoint,
					externalPoint  : _externalPoint,
					initMatrix : _matrixObj,
					matrix     : _matrixObj,
					style      : _style
				}
			);
		}
		
		public function RemoveControl(_disObject:DisplayObject):void 
		{
			var _index:int=FindIndex(_disObject);
			if (_index != -1) 
			{
				objectInfoList.splice(_index,1);
			}
		}
		
		public function Undo():Boolean
		{
			if (recordIndex < 0 || recordeList.length<1 ) {
				recordIndex = 0;
				return false;
			}else {
				doFun();
				recordIndex = recordIndex > 0? recordIndex - 1:0;
			}
			return true;
		}
		public function Redo():Boolean
		{
			recordIndex = recordIndex < ( recordeList.length - 1)? recordIndex + 1:( recordeList.length - 1);
			if (recordIndex > recordeList.length -1 || recordeList.length<1 ) {
				recordIndex = recordeList.length -1;
				return false;
			}else{
				doFun();
			}
			return true;
		}
		private function doFun():void {
			var _disObject:DisplayObject = recordeList[recordIndex].disObject;
			var _matrix:Object = recordeList[recordIndex].matrix_old;
			var $_tx:Number = _matrix.tx;
			var $_ty:Number = _matrix.ty;
			var $_scalex:Number = _matrix.scalex;
			var $_scaley:Number = _matrix.scaley;
			var $_skewx:Number = _matrix.skewx;
			var $_skewy:Number = _matrix.skewy;
			
			var _objInfo:Object = findObjectInfo(_disObject);
			GraphicsClear();
			_objInfo.state = stateClass.select;
			_objInfo.matrix = _matrix;
			selectedItem = _disObject;
			GraphicsDraw(_matrix);
			
			matrixClass.SetMatrix(_disObject, $_tx, $_ty, $_scalex, $_scaley, $_skewx, $_skewy);
		}
		public function ClearRecorde():void
		{
			recordeList = [];
		}
		
		public function SetInfo(_disObject:DisplayObject,$parameter:Object=null):Boolean
		{
			var _objInfo:Object = findObjectInfo(_disObject);
			if (!_objInfo) {
				return false;
			}
			var _matrix:Object = _objInfo.matrix;
			var $_o_matrix:Object = _objInfo.initMatrix;
			
			if (!$parameter) {
				$parameter = { };
			}
			var $_tx:* = $parameter.x || "revert";
			var $_ty:* = $parameter.y || "revert";
			var $_scalex:* = $parameter.scalex || "revert";
			var $_scaley:* = $parameter.scaley || "revert";
			var $_skewx:* = $parameter.skewx || "revert";
			var $_skewy:* = $parameter.skewy || "revert";
			var $_rotation:* = $parameter.rotation || "revert";
			
			($_tx == "revert") ? (_matrix.tx = $_o_matrix.tx) : ($_tx != null) ? (_matrix.tx = Number($_tx)) : null ;
			($_ty == "revert") ? (_matrix.ty = $_o_matrix.ty) : ($_ty != null) ? (_matrix.ty = Number($_ty)) : null ;
			($_scalex == "revert") ? (_matrix.scalex = $_o_matrix.scalex) : ($_scalex != null) ? (_matrix.scalex = Number($_scalex)) : null ;
			($_scaley == "revert") ? (_matrix.scaley = $_o_matrix.scaley) : ($_scaley != null) ? (_matrix.scaley = Number($_scaley)) : null ;
			if ($_rotation != null) 
			{
				if ($_rotation == "revert") {
					_matrix.skewx = $_o_matrix.skewx;
					_matrix.skewy = $_o_matrix.skewy;
				}else {
					_matrix.skewx = Number($_rotation);
					_matrix.skewy = Number($_rotation);
				}
			}
			($_skewx == "revert") ? (_matrix.skewx = $_o_matrix.skewx) : ($_skewx != null) ? (_matrix.skewx = Number($_skewx)) : null ;
			($_skewy == "revert") ? (_matrix.skewy = $_o_matrix.skewy) : ($_skewy != null) ? (_matrix.skewy = Number($_skewy)) : null ;
			
			matrixClass.SetMatrix(_disObject, _matrix.tx, _matrix.ty, _matrix.scalex, _matrix.scaley, _matrix.skewx, _matrix.skewy);
			_objInfo.matrix = matrixClass.GetMatrix(_disObject, _objInfo.internalPoint);
			
			return true;
		}
		public function GetInfo(_disObject:DisplayObject):Object
		{
			var _objInfo:Object = findObjectInfo(_disObject);
			if (!_objInfo) {
				return null;
			}
			var _matrix:Object = _objInfo.matrix;
			var $_re_object:Object = {
				x: _matrix.tx,
				y: _matrix.ty,
				scalex: _matrix.scalex,
				scaley: _matrix.scaley,
				skewx: _matrix.skewx,
				skewy: _matrix.skewy,
				rotation: _matrix.skewx
			}
			return $_re_object;
		}
		public function resetInfo(_disObject:DisplayObject):void {
			_disObject.transform.matrix = new Matrix();
		}
		public function SetType($type:Object, $state:String = "activate"):void
		{
			var $_o_graphics :* = $type.o_graphics;
			var $_graphics:* = $type.graphics;
			var $_o_bitmapdata:* = $type.o_bitmapdata;
			var $_bitmapdata :* = $type.bitmapdata;
			var $_color :* = $type.color;
			var $_border :* = $type.border;
			var $_size :* = $type.size;
			var $_type :String = $type.type;
			
			var $typeActivate:Object = { o_graphics:"cicle", graphics:"rect", o_bitmapdata: null, bitmapdata: null, color:0x0, border:1};
			var $typeSelect:Object  = { o_graphics:"cicle",  graphics:"rect", o_bitmapdata:null,  bitmapdata: null, color:0xFF9900, border:1};
			
			var $_obj:Object = $state == "select" ? typeSelect : typeActivate;
			if ($_type == "default")
			{
				$_obj = $state == "select" ? $typeSelect : $typeActivate;
			}
			($_o_graphics != null) && ($_obj.o_graphics = String($_o_graphics));
			($_graphics != null) && ($_obj.graphics = String($_graphics));
			($_o_bitmapdata != null) && ($_obj.o_bitmapdata = BitmapData($_o_bitmapdata));
			($_bitmapdata != null) && ($_obj.bitmapdata = BitmapData($_bitmapdata));
			($_color != null) && ($_obj.color = uint($_color));
			($_border != null) && ($_obj.border = uint($_border));
			($_size != null) && ($_obj.size = uint($_size));
			
		}
		public function SetStyle(_disObject:DisplayObject, $style:Object):void
		{
			var _objInfo:Object = findObjectInfo(_disObject);
			if (!_objInfo) {
				return;
			}
			var $_EnMoveX :* = $style.enMoveX;
			var $_EnMoveY :* = $style.enMoveY;
			var $_EnScaleX:* = $style.enScaleX;
			var $_EnScaleY:* = $style.enScaleY;
			var $_EnSkewX :* = $style.enSkewX;
			var $_EnSkewY :* = $style.enSkewY;
			var $_EnScale :* = $style.enScale;
			var $_EqScale :* = $style.eqScale;
			var $_EnRotation:* = $style.enRotation;
			var $_EnSetMidPoint:* = $style.enSetMidPoint;
			
			($_EnMoveX != null) && (_objInfo.style.enMoveX = Boolean($_EnMoveX));
			($_EnMoveY != null) && (_objInfo.style.enMoveY = Boolean($_EnMoveY));
			($_EnScaleX != null) && (_objInfo.style.enScaleX = Boolean($_EnScaleX));
			($_EnScaleY != null) && (_objInfo.style.enScaleY = Boolean($_EnScaleY));
			($_EnSkewX != null) && (_objInfo.style.enSkewX = Boolean($_EnSkewX));
			($_EnSkewY != null) && (_objInfo.style.enSkewY = Boolean($_EnSkewY));
			($_EnScale != null) && (_objInfo.style.enScale = Boolean($_EnScale));
			($_EqScale != null) && (_objInfo.style.eqScale = Boolean($_EqScale));
			($_EnRotation != null) && (_objInfo.style.enRotation = Boolean($_EnRotation));
			($_EnSetMidPoint != null) && (_objInfo.style.enSetMidPoint = Boolean($_EnSetMidPoint));
		}
		private var __selectedItem:DisplayObject;
		public function set selectedItem(_disObject:DisplayObject):void
		{
			GraphicsClear();
			if (!_disObject) {
				__selectedItem = null;
				ArrowClear();
			}else {
				var _objInfo:Object = findObjectInfo(_disObject);
				if (!_objInfo) {
					AddControl(_disObject);
					_objInfo = findObjectInfo(_disObject);
				}
				if (__selectedItem) {
					findObjectInfo(__selectedItem).state = stateClass.normal;
				}
				__selectedItem = _disObject;
				__selectedItem.parent.addChild(__selectedItem);
				shapeBounds.parent.addChild(shapeBounds);
				shapeArrow.parent.addChild(shapeArrow);
				_objInfo.state = stateClass.select;
				GraphicsDraw(_objInfo.matrix);
			}
			if (onSelectChange!=null) {
				onSelectChange(__selectedItem);
			}
		}
		public function get selectedItem():DisplayObject
		{
			return __selectedItem;
		}
		public function set area($rectangle:Rectangle):void
		{
			rectArea = $rectangle;
		}
		
		public function get area():Rectangle
		{
			return rectArea;
		}
		
		private function EventHadler(_evt:MouseEvent):void 
		{
			_evt.updateAfterEvent();
			var _disObject:DisplayObject = _evt.target as DisplayObject;
			var _objInfo:Object;
			
			mousePoint.x = toolContainer.mouseX;
			mousePoint.y = toolContainer.mouseY;
			var _isInRectArea:Boolean = rectArea?rectArea.containsPoint(mousePoint):true;
			
			var _matrix:Object;
			var _areaNum:int;
			switch(_evt.type) {
				case "mouseDown":
					if (!_isInRectArea) {
						return;
					}
					if (selectedItem) {
						_objInfo = findObjectInfo(selectedItem);
						if (_objInfo.state==stateClass.area) {
							_objInfo.mousePoint0 = new Point(toolContainer.mouseX, toolContainer.mouseY);
							_objInfo.externalPoint = selectedItem.parent.globalToLocal(selectedItem.localToGlobal(_objInfo.internalPoint));
							_objInfo.state = stateClass.change;
							return;
						}
					}
					_objInfo = findObjectInfo(_disObject);
					if (_objInfo) {
						selectedItem = _disObject;
						_objInfo.mousePoint0 = new Point(toolContainer.mouseX, toolContainer.mouseY);
						_objInfo.matrix.array[4] = _disObject.parent.globalToLocal(_disObject.localToGlobal(_objInfo.internalPoint));
						_objInfo.externalPoint = _disObject.parent.globalToLocal(_disObject.localToGlobal(_objInfo.internalPoint));
						_objInfo.state = stateClass.drag;
						GraphicsClear();
						GraphicsDraw(_objInfo.matrix);
					}else {
						selectedItem = null;
						GraphicsClear();
					}
					break;
				case "mouseUp":
					if (!selectedItem) {
						return;
					}
					_objInfo = findObjectInfo(selectedItem);
					if (_objInfo.state == stateClass.change) {
						(recordIndex != recordeList.length - 1) && (recordeList.splice(recordIndex+1,recordeList.length));
						recordeList.push( {
							disObject: selectedItem,
							matrix_old: _objInfo.matrix,
							matrix_new: matrixClass.GetMatrix(selectedItem,_objInfo.internalPoint)
						});
						recordIndex = recordeList.length - 1;
						
						_objInfo.state = stateClass.select;
						_objInfo.matrix = matrixClass.GetMatrix(selectedItem, _objInfo.internalPoint);
						toolContainer.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
					}else if (_objInfo.state == stateClass.drag) {
						ArrowClear();
						
						(recordIndex != recordeList.length - 1) && (recordeList.splice(recordIndex + 1, recordeList.length));
						recordeList.push({
							disObject: selectedItem,
							matrix_old: _objInfo.matrix,
							matrix_new: matrixClass.GetMatrix(selectedItem,_objInfo.internalPoint)
						});
						recordIndex = recordeList.length - 1;
						
						_objInfo.state = stateClass.select;
						_objInfo.matrix = matrixClass.GetMatrix(selectedItem,_objInfo.internalPoint);
						_objInfo.externalPoint = selectedItem.parent.globalToLocal(selectedItem.localToGlobal(_objInfo.internalPoint));
					}
					break;
				case "rollOut":
				case "mouseMove":
					/*var _parent:*=event.target;
					while(_parent){
						if(_parent==this){
							return true;
						}
						_parent=_parent.parent;
					}
					return false;
					trace(_evt.target+"_____"+_evt.currentTarget);*/
					if (!_isInRectArea) {
						ArrowClear();
						return;
					}
					var passRoll:Boolean;
					_objInfo = findObjectInfo(selectedItem);
					if (_objInfo) {
						var _stateClass:String;
						_matrix = _objInfo.matrix;
						_stateClass = _objInfo.state;
						_areaNum = GetAreaNum(_objInfo);
						if (_stateClass == stateClass.change) {
							passRoll = true;
							GraphicsClear();
							_areaNum  = _objInfo.areanum;
							ArrowMove();
							SetChange(_objInfo, _areaNum);
							_matrix = matrixClass.GetMatrix(selectedItem, _objInfo.internalPoint);
							GraphicsDraw(_matrix);
							if (onChanging!=null) {
								onChanging();
							}
						}else if (_stateClass == stateClass.drag) {
							passRoll = true;
							GraphicsClear();
							SetMove(_objInfo);
							ArrowShow(shapeArrow.Bmp_move);
							ArrowMove();
							_matrix    = matrixClass.GetMatrix(selectedItem,_objInfo.internalPoint);
							GraphicsDraw(_matrix);
							if (onChanging!=null) {
								onChanging();
							}
						}else if (_areaNum != -1) {
							passRoll = true;
							GraphicsClear();
							_objInfo.areanum = _areaNum;
							_objInfo.state = stateClass.area;
							var $_tmp_bmp:BitmapData = GetArrowBmp(_matrix, _areaNum);
							var $_isOrigin:Boolean = _areaNum == 4 ? true : false;
							if ($_tmp_bmp != null) {
								ArrowShow($_tmp_bmp,$_isOrigin);
								ArrowMove();
							}
							GraphicsDraw(_matrix);
						}else {
							_objInfo.state = stateClass.select;
							//GraphicsClear();
							ArrowClear();
						}
					}
					if (passRoll) {
						return;
					}
					_objInfo = findObjectInfo(_disObject);
					if (_objInfo && _disObject != selectedItem) {
						GraphicsClear();
						DrawSelectGraphics(_objInfo.matrix);
						if (selectedItem) {
							GraphicsDraw(_matrix);
						}
					}
					break;
			}
		}
		//-----------------------------------------------------------------------
		private function SetMove(_objInfo:Object):void
		{
			var _disObject:DisplayObject = _objInfo.obj;
			var $_mousePoint0:Point = _objInfo.mousePoint0;
			var $_mousePoint1:Point = new Point(toolContainer.mouseX, toolContainer.mouseY);
			var _matrix:Object =  _objInfo.matrix;
			
			var $_EnMoveX:Boolean = _objInfo.style.enMoveX;
			var $_EnMoveY:Boolean = _objInfo.style.enMoveY;
			
			($_EnMoveX) && (_disObject.x = _matrix.tx + $_mousePoint1.x -$_mousePoint0.x);
			($_EnMoveY) && (_disObject.y = _matrix.ty + $_mousePoint1.y -$_mousePoint0.y);
		}
		private function SetMidPoint(_objInfo:Object):void 
		{	
			var _disObject:DisplayObject = _objInfo.obj;
			_objInfo.externalPoint.x = toolContainer.mouseX;
			_objInfo.externalPoint.y = toolContainer.mouseY;
			_objInfo.internalPoint = (_disObject).globalToLocal((_disObject.parent).localToGlobal(_objInfo.externalPoint));
		}
		private function SetChange(_objInfo:Object, $area_num:int):void 
		{
			//   ------------------
			//   [0] 11 [3] 11 [6]
			//    9			   10
			//   [1]    [4]    [7]
			//    9            10
			//   [2] 12 [5] 12 [8] [13]
			//   ------------------
			var $_type:String;
			if ($area_num == 4) 
			{
				$_type = "setMidPoint" ;
				SetMidPoint(_objInfo);
				return;
			}else if ($area_num == 0 || $area_num == 8 || $area_num == 2 || $area_num == 6) 
			{
				$_type = "scale";
			} else if ($area_num == 1 || $area_num == 7 ) 
			{
				$_type = "xscale";
			} else if ($area_num == 3 || $area_num == 5 )
			{
				$_type = "yscale";
			} else if ($area_num == 9 || $area_num == 10) 
			{
				$_type = "yskew";
			} else if ($area_num == 11 || $area_num == 12) 
			{
				$_type = "xskew";
			} else if ($area_num == 13) 
			{
				$_type = "rotation";
			} else{
				return;
			}
			var _disObject:DisplayObject = _objInfo.obj;
			
			var _matrix:Object = _objInfo.matrix;
			//var $_matrix_new:Object = matrixClass.GetMatrix(_disObject,_objInfo.internalPoint);
			var $_array:Array = _matrix.array;
			var _internalPoint:Point = _objInfo.internalPoint;
			var _externalPoint:Point = _objInfo.externalPoint;
			
			var $_EqScale:Boolean = _objInfo.style.eqScale;
			var $_EnScaleX:Boolean = _objInfo.style.enScaleX;
			var $_EnScaleY:Boolean = _objInfo.style.enScaleY;
			
			var $_mousePoint0:Point = _objInfo.mousePoint0;
			var $_mousePoint1:Point = new Point(toolContainer.mouseX, toolContainer.mouseY);
			_objInfo.mousePoint1 =  $_mousePoint1;
			
			var $_minW:int = 10 ;
			var $_minH:int = 10 ;
			var $_minSkew:int = 10 ;
			var $_objW:int ;
			var $_objH:int ;
			var $_skew_gap:Number ;
			
			var $_tx:Number = _matrix.tx;
			var $_ty:Number = _matrix.ty;
			var $_scalex:Number = _matrix.scalex;
			var $_scaley:Number = _matrix.scaley;
			var $_skewx:Number = _matrix.skewx;
			var $_skewy:Number = _matrix.skewy;
			var $_angle0:Number;
			var $_angle1:Number;
			var $_tmp_obj:Object;
			
			
			switch ($_type) {
				case "xscale" :
					if($_EnScaleX){	
						$_scalex = GetNewScaleX(_objInfo, $area_num);
						($_EqScale) && ($_scaley = $_scalex);
					}
					break;
					
				case "yscale" :
					if($_EnScaleY){	
						$_scaley = GetNewScaleY(_objInfo, $area_num);
						($_EqScale) && ($_scalex = $_scaley);
					}
					break;
					
				case "scale" :
					if($_EnScaleX){	
						$_scalex = GetNewScaleX(_objInfo, $area_num);
						($_EqScale) && ($_scaley = $_scalex);
					}
					if($_EnScaleY){	
						$_scaley = GetNewScaleY(_objInfo, $area_num);
						($_EqScale) && ($_scalex = $_scaley);
					}
					//$_scaley = $_scalex;
					break;
					
				case "rotation" :
					$_angle0 = mathClass.GetAngle($_mousePoint0, _externalPoint);
					$_angle1 = mathClass.GetAngle($_mousePoint1, _externalPoint);
					$_skewx  = $_skewx + $_angle1 - $_angle0;
					$_skewy  = $_skewy + $_angle1 - $_angle0;
					break;
				case "xskew" :
					$_tmp_obj = GetNewSkewY(_objInfo, $area_num);
					$_skewx  = $_tmp_obj.skewx;
					$_scaley = $_tmp_obj.scaley;
					($_EqScale)&& ($_scaley = $_scalex);
					break;
				case "yskew" :
					$_tmp_obj = GetNewSkewX(_objInfo, $area_num);
					$_skewy  = $_tmp_obj.skewy;
					$_scalex = $_tmp_obj.scalex;
					($_EqScale)&& ($_scalex = $_scaley);
					break;
				default :
					break;
			}
			$_objW = _matrix.w * $_scalex;
			$_objH = _matrix.h * $_scaley;
			$_skew_gap = Math.abs($_skewx - $_skewy)%180;
			
			if(($_objW < $_minW && $_objW > -$_minW) || ($_objH < $_minH && $_objH > -$_minH) || ($_skew_gap< 90+$_minSkew && $_skew_gap> 90-$_minSkew))
			{
				return;
			}
				
			matrixClass.SetMatrix(_disObject, $_tx, $_ty, $_scalex, $_scaley, $_skewx, $_skewy);
			matrixClass.SetMidPoint(_disObject, _internalPoint, _externalPoint);
			
		}
		//-----------------------------------------------------------------------
		private function GetNewSkewX(_objInfo:Object, $area_num:int):Object
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_num:int = $area_num == 9 ? 1 : 7; 
			var _matrix:Object = _objInfo.matrix;
			var $_array:Array = _matrix.array;
			var $_skewx:Number = _matrix.skewx;
			var $_skewy:Number = _matrix.skewy;
			var $_scalex:Number = _matrix.scalex;
		
			var $_midPoint:Point = $_array[4];
			var $_areaPoint:Point= $_array[$_num];
			var $_mousePoint0:Point = _objInfo.mousePoint0;	
			var $_mousePoint1:Point = _objInfo.mousePoint1;	

			var $_mp0:Point = mathClass.GetCrossPoint( $_mousePoint0, $_skewy, $_midPoint, $_skewx + 90);
			var $_mp1:Point = mathClass.GetCrossPoint( $_mousePoint0, $_skewy, $_areaPoint, $_skewx + 90);
			var $_mp2:Point = mathClass.GetCrossPoint( $_mousePoint1, $_skewy, $_midPoint, $_skewx + 90);
			var $_mp3:Point = mathClass.GetCrossPoint( $_mousePoint1, $_skewy, $_areaPoint, $_skewx + 90);
			
			var $_angle:Number ;
			var $_angle0:Number = mathClass.GetAngle($_mp3, $_mp0);
			var $_angle1:Number = mathClass.GetAngle($_mp0, $_mp3);
			
			var $_tmp_point0:Point = mathClass.GetCrossPoint( $_midPoint, $_skewy, $_array[1], $_skewx + 90);
			var $_tmp_point1:Point = mathClass.GetCrossPoint( $_midPoint, $_skewy, $_array[7], $_skewx + 90);
			
			var $_s0:Number = mathClass.GetPos( $_array[1], $_array[7]);
			var $_s1:Number = mathClass.GetPos( $_midPoint, $_tmp_point0);
			var $_s2:Number = mathClass.GetPos( $_midPoint, $_tmp_point1);
			
			var $_isLeft :Boolean = $_s2 > $_s0 && $_s2 > $_s1 ;
			var $_isRight :Boolean = $_s1 > $_s0 && $_s1 > $_s2 ;
			
			if ($area_num == 9)
			{
				$_angle = $_angle0;
				($_isLeft) && ($_angle = $_angle1);
			}else if ($area_num == 10)
			{
				$_angle = $_angle1;
				($_isRight) && ($_angle = $_angle0);
			}
			
			if (int($_mp0.x-$_mp1.x)!=0 || int($_mp0.y-$_mp1.y)!=0)
			{
				$_skewy  = $_angle;
				$_mp0 = mathClass.GetCrossPoint( $_midPoint, $_skewy, $_array[0], $_skewx + 90);
				$_mp1 = mathClass.GetCrossPoint( $_midPoint, $_skewy, $_array[8], $_skewx + 90);
				$_scalex = mathClass.GetPos($_mp0, $_mp1) / _matrix.w;
			}
			
			return {skewy:$_skewy, scalex:$_scalex};
		}
		private function GetNewSkewY(_objInfo:Object, $area_num:int):Object
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_num:int = $area_num == 11 ? 3 : 5; 
			var _matrix:Object = _objInfo.matrix;
			var $_array:Array = _matrix.array;
			var $_skewx:Number = _matrix.skewx;
			var $_skewy:Number = _matrix.skewy;
			var $_scaley:Number = _matrix.scaley;
			
			var $_midPoint:Point = $_array[4];
			var $_areaPoint:Point= $_array[$_num];
			var $_mousePoint0:Point = _objInfo.mousePoint0;	
			var $_mousePoint1:Point = _objInfo.mousePoint1;	

			var $_mp0:Point = mathClass.GetCrossPoint( $_mousePoint0, $_skewx + 90, $_midPoint, $_skewy);
			var $_mp1:Point = mathClass.GetCrossPoint( $_mousePoint0, $_skewx + 90, $_areaPoint, $_skewy);
			var $_mp2:Point = mathClass.GetCrossPoint( $_mousePoint1, $_skewx + 90, $_midPoint, $_skewy);
			var $_mp3:Point = mathClass.GetCrossPoint( $_mousePoint1, $_skewx + 90, $_areaPoint, $_skewy);
			
			var $_angle:Number ;
			var $_angle0:Number = mathClass.GetAngle($_mp3, $_mp0);
			var $_angle1:Number = mathClass.GetAngle($_mp0, $_mp3);
			
			var $_tmp_point0:Point = mathClass.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[3], $_skewy);
			var $_tmp_point1:Point = mathClass.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[5], $_skewy);
			
			var $_s0:Number = mathClass.GetPos( $_array[3], $_array[5]);
			var $_s1:Number = mathClass.GetPos( $_midPoint, $_tmp_point0);
			var $_s2:Number = mathClass.GetPos( $_midPoint, $_tmp_point1);
			
			var $_isUp :Boolean = $_s2 > $_s0 && $_s2 > $_s1 ;
			var $_isDown :Boolean = $_s1 > $_s0 && $_s1 > $_s2 ;
			
			if ($area_num == 11)
			{
				$_angle = $_angle0;
				($_isUp) && ($_angle = $_angle1);
			}else if ($area_num == 12)
			{
				$_angle = $_angle1;
				($_isDown) && ($_angle = $_angle0);
			}
			
			if (int($_mp0.x-$_mp1.x)!=0 || int($_mp0.y-$_mp1.y)!=0)
			{
				$_skewx  = $_angle-90;
				$_mp0 = mathClass.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[0], $_skewy);
				$_mp1 = mathClass.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[8], $_skewy);
				
				$_scaley =  mathClass.GetPos($_mp0, $_mp1) / _matrix.h;
				
			}
			return { skewx:$_skewx, scaley:$_scaley };
		}
		
		private function GetNewScaleX(_objInfo:Object, $area_num:int):Number
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var _matrix:Object = _objInfo.matrix;
			var $_array:Array = _matrix.array;
			var $_skewx:Number = _matrix.skewx;
			var $_skewy:Number = _matrix.skewy;
			
			var $_midPoint:Point = $_array[4];
			var $_mousePoint1:Point = _objInfo.mousePoint1;
			var $_areaPoint:Point= $_array[$area_num];
			
			var $_mp0:Point = mathClass.GetCrossPoint( $_midPoint, $_skewy, $_areaPoint, $_skewx + 90);
			var $_mp1:Point = mathClass.GetCrossPoint( $_midPoint, $_skewy, $_mousePoint1, $_skewx + 90);
			
			var $_s0:Number = mathClass.GetPos( $_midPoint, $_mp0);
			var $_s1:Number = mathClass.GetPos( $_midPoint, $_mp1);
			var $_s3:Number = mathClass.GetPos( $_mp0, $_mp1);
			var $_vetor:int = ($_s3 > $_s1)&&($_s3 > $_s0) ? -1 :1;
			
			var $_scalex:Number = _matrix.scalex;
			($_s0 > 1 || $_s0 < -1) && ( $_scalex  = $_scalex *($_s1/$_s0) * $_vetor);	
			return $_scalex;
		}
		
		private function GetNewScaleY(_objInfo:Object, $area_num:int):Number
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var _matrix:Object = _objInfo.matrix;
			var $_array:Array = _matrix.array;
			var $_skewx:Number = _matrix.skewx;
			var $_skewy:Number = _matrix.skewy;
			
			var $_midPoint:Point = $_array[4];
			var $_mousePoint1:Point = _objInfo.mousePoint1;
			var $_areaPoint:Point= $_array[$area_num];
			
			var $_mp0:Point = mathClass.GetCrossPoint( $_midPoint, $_skewx + 90, $_areaPoint, $_skewy);
			var $_mp1:Point = mathClass.GetCrossPoint( $_midPoint, $_skewx + 90, $_mousePoint1, $_skewy);
			
			var $_s0:Number = mathClass.GetPos( $_midPoint, $_mp0);
			var $_s1:Number = mathClass.GetPos( $_midPoint, $_mp1);
			var $_s3:Number = mathClass.GetPos( $_mp0, $_mp1);
			var $_vetor:int = ($_s3 > $_s1)&&($_s3 > $_s0) ? -1 :1;
			
			var $_scaley:Number = _matrix.scaley;
			($_s0 > 1 || $_s0 < -1) && ($_scaley  = $_scaley *($_s1 / $_s0 ) * $_vetor) ;
			return $_scaley;
		}
		
		private function GetAreaNum(_objInfo:Object):int
		{
			//   $areanum--------------
			//   [0] 11 [3] 11 [6]
			//    9			   10
			//   [1]    [4]    [7]
			//    9            10
			//   [2] 12 [5] 12 [8] [13]
			//   ----------------------
			var _matrix:Object = _objInfo.matrix;
			var $_arr:Array = _matrix.array;
			var $_testPoint:Point = new Point(toolContainer.mouseX, toolContainer.mouseY);
			var $_areaPoint:Point ;
			var $_isTrue:Boolean ;
			var $_obj_size0:uint = _matrix.w * _matrix.scalex * 0.25;
			var $_obj_size1:uint = _matrix.h * _matrix.scaley * 0.25;
			var $_block_size0:uint = 10;
			var $_block_size1:uint = 10;
			var $_block_size2:uint = 8;
			var $_block_size3:uint = 8;
			var $_block_size4:uint = 15;
			
			var $_EnScaleX:Boolean = _objInfo.style.enScaleX;
			var $_EnScaleY:Boolean = _objInfo.style.enScaleY;
			var $_EnSkewX:Boolean = _objInfo.style.enSkewX;
			var $_EnSkewY:Boolean = _objInfo.style.enSkewY;
			var $_EnScale:Boolean = _objInfo.style.enScale;
			var $_EnRotation:Boolean = _objInfo.style.enRotation;
			var $_EnSetMidPoint:Boolean = _objInfo.style.enSetMidPoint;
			
			var $_inexistence:int = -1;

			($_obj_size0 < 10) && ($_block_size0 = $_obj_size0);
			($_obj_size1 < 10) && ($_block_size1 = $_obj_size1);
			($_obj_size0 < 8) && ($_block_size2 = $_obj_size0);
			($_obj_size1 < 8) && ($_block_size3 = $_obj_size1);
			
			var $_p_arr0:Array = new Array(
				new Point($_arr[0].x - $_block_size0, $_arr[0].y),
				new Point($_arr[0].x + $_block_size0, $_arr[0].y),
				new Point($_arr[2].x - $_block_size0, $_arr[2].y),
				new Point($_arr[2].x + $_block_size0, $_arr[2].y)
			);
			
			var $_p_arr1:Array = new Array(
				new Point($_arr[6].x - $_block_size0, $_arr[6].y),
				new Point($_arr[6].x + $_block_size0, $_arr[6].y),
				new Point($_arr[8].x - $_block_size0, $_arr[8].y),
				new Point($_arr[8].x + $_block_size0, $_arr[8].y)
			);
			
			var $_p_arr2:Array = new Array(
				new Point($_arr[0].x , $_arr[0].y - $_block_size1),
				new Point($_arr[0].x , $_arr[0].y + $_block_size1),
				new Point($_arr[6].x , $_arr[6].y - $_block_size1),
				new Point($_arr[6].x , $_arr[6].y + $_block_size1)
			);
			
			var $_p_arr3:Array = new Array(
				new Point($_arr[2].x , $_arr[2].y - $_block_size1),
				new Point($_arr[2].x , $_arr[2].y + $_block_size1),
				new Point($_arr[8].x , $_arr[8].y - $_block_size1),
				new Point($_arr[8].x , $_arr[8].y + $_block_size1)
			);
			
			var $_p_bounds:Array = new Array($_arr[0],$_arr[6],$_arr[2],$_arr[8]);
			
			var $_len:int = $_arr.length;
			while ($_len--)
			{
				$_areaPoint = $_arr[$_len];
				$_isTrue = containTest.IsInRect($_testPoint, $_areaPoint, $_block_size2, $_block_size3);
				if ($_isTrue)
				{
					if (($_len == 1 || $_len == 7) && (!$_EnScaleX)) {
						return $_inexistence;
					}else if (($_len == 3 || $_len == 5) && (!$_EnScaleY)) {
						return $_inexistence;
					}else if (($_len == 0 || $_len == 6 || $_len == 2 || $_len == 8 ) && (!$_EnScale)) {
						return $_inexistence;
					}else if (($_len == 4 ) && (!$_EnSetMidPoint)) {
						return $_inexistence;
					}else{
						return $_len;
					}
				}
			}
			//----------------
			if (containTest.IsInBouds($_testPoint, $_p_arr0)) 
			{
				if ($_EnSkewY){
					return 9
				}else {
					return $_inexistence;
				}
			} else if (containTest.IsInBouds($_testPoint, $_p_arr1)) 
			{
				if ($_EnSkewY) {
					return 10;
				}else {
					return $_inexistence;
				}
			} else if (containTest.IsInBouds($_testPoint, $_p_arr2)) 
			{
				if ($_EnSkewX) {
					return 11;
				}else {
					return $_inexistence;
				}
			} else if (containTest.IsInBouds($_testPoint, $_p_arr3)) 
			{
				if ($_EnSkewX) {
					return 12 ;
				}else {
					return $_inexistence;
				}
			} else if (containTest.IsInBouds($_testPoint, $_p_bounds)) 
			{
				return $_inexistence;
			}
			//----------------
			var $_isTrue0:Boolean = containTest.IsInRect($_testPoint, $_arr[0], $_block_size4, $_block_size4);
			var $_isTrue1:Boolean = containTest.IsInRect($_testPoint, $_arr[2], $_block_size4, $_block_size4);
			var $_isTrue2:Boolean = containTest.IsInRect($_testPoint, $_arr[6], $_block_size4, $_block_size4);
			var $_isTrue3:Boolean = containTest.IsInRect($_testPoint, $_arr[8], $_block_size4, $_block_size4);
			if ($_isTrue0 || $_isTrue1 || $_isTrue2 || $_isTrue3)
			{
				if ($_EnRotation) {
					return 13;
				}else {
					return $_inexistence;
				}
			}
			
			return $_inexistence;
		}
		
		private function GetArrowBmp($matrix:Object, $areanum:int):BitmapData
		{
			//   $areanum--------------
			//   [0] 11 [3] 11 [6]
			//    9			   10
			//   [1]    [4]    [7]
			//    9            10
			//   [2] 12 [5] 12 [8] [13]
			//   ----------------------
			
			var $_skewx:Number = $matrix.skewx;
			var $_skewy:Number = $matrix.skewy;
			var $_angle:Number;
			var $_bmp:BitmapData;
			
			if ($areanum == 4 ) 
			{
				$_bmp = shapeArrow.Bmp_cursor;
			}else if ( $areanum == 0 || $areanum == 8 )
			{
				$_angle = GetNearAngle(($_skewx + $_skewy )* 0.5 + 45 );
				($_angle!=-1) && ($_bmp = shapeArrow["Bmp_resize"+ $_angle]);
			}else if ($areanum == 2 || $areanum == 6 ) 
			{
				$_angle = GetNearAngle(($_skewx + $_skewy )* 0.5 + 135);
				($_angle!=-1) && ($_bmp = shapeArrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 1 || $areanum == 7 ) 
			{
				$_angle = GetNearAngle($_skewy);
				($_angle!=-1) && ($_bmp = shapeArrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 3 || $areanum == 5 ) 
			{
				$_angle = GetNearAngle($_skewx+270);
				($_angle!=-1) && ($_bmp = shapeArrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 9 || $areanum == 10 ) 
			{
				$_angle = GetNearAngle($_skewx+270);
				($_angle!=-1) && ($_bmp = shapeArrow["Bmp_skew" + $_angle]);
			}else if ($areanum == 11 || $areanum == 12 ) 
			{
				$_angle = GetNearAngle($_skewy);
				($_angle!=-1) && ($_bmp = shapeArrow["Bmp_skew" + $_angle]);
			}else if ($areanum == 13 ) 
			{
				$_bmp = shapeArrow.Bmp_rotation;
			}
			
			return $_bmp;
			
		}
		
		private function GetNearAngle($angle:Number):Number
		{
			var $_arr:Array = new Array(0, 45, 90, 135, 180);
			var $_len:int = $_arr.length;
			var $_min:Number = Number.POSITIVE_INFINITY;
			var $_gap:Number;
			var $_re_num:Number = -1;
			
			$angle = $angle % 360;
			($angle < 0) && ($angle = 360 + $angle);
			($angle > 180) && ($angle =  $angle-180);
			
			while ($_len--)
			{
				$_gap = $angle-$_arr[$_len];
				($_gap < 0) && ($_gap = -$_gap);
				if ($_min > $_gap)
				{
					$_min = $_gap;
					$_re_num = $_arr[$_len];
				}
			}
			($_re_num == 180) && ($_re_num = 0);
			return $_re_num;
			
		}
		//----------------------------------------------------------------------------
		private function ArrowMove():void
		{
			shapeArrow.x = toolContainer.mouseX;
			shapeArrow.y = toolContainer.mouseY;
		}
		private function ArrowShow($bmp:BitmapData, $isOrigin:Boolean = false):void
		{
			//var $_bmp:BitmapData = _arr_bmp[$index];
			shapeArrow.Show($bmp,$isOrigin);
			Mouse.hide();
		}
		public function ArrowClear():void
		{
			shapeArrow.Clear();
			Mouse.show();
		}
		//----------------------------------------------------------------------------
			
		private function FindIndex(_disObject:DisplayObject):int 
		{
			var $_len:int=objectInfoList.length;
			while ($_len--) {
				var $_object:Object=objectInfoList[$_len];
				if ($_object.obj == _disObject) {
					return $_len;
				}
			}
			return -1;
		}
		private function findObjectInfo(_object:DisplayObject):Object {
			for each(var _objectInfo:Object in objectInfoList) {
				if (_objectInfo.obj == _object) {
					return _objectInfo;
				}
			}
			return null;
		}
		//----------------------------------------------------------------------
		
		public function GraphicsClear():void
		{
			shapeBounds.Clear();
		}
		
		private function GraphicsDraw($matrix:Object):void
		{
			//var $_block_size:Number = 3;
			var $_arr:Array = $matrix.array;
			var $_len:int = $_arr.length;
			
			var $_color:uint = typeActivate.color == null? 0x0 : typeActivate.color;
			var $_border:uint = typeActivate.border == null? 1 : typeActivate.border;
			var $_block_size:uint = typeActivate.size == null? 3 : typeActivate.size;
			var $_graphics:String = typeActivate.graphics;
			var $_bitmapdata:BitmapData = typeActivate.bitmapdata == null ? shapeArrow.Bmp_6dn : typeActivate.bitmapdata;
			var $_o_graphics:String = typeActivate.o_graphics;
			var $_o_bitmapdata:BitmapData = typeActivate.o_bitmapdata == null ? shapeArrow.Bmp_6dn : typeActivate.o_bitmapdata;
			
			var $_tmp_arr:Array = new Array($_arr[0], $_arr[2], $_arr[8], $_arr[6]);
			
			shapeBounds.CreateLine($_tmp_arr,$_border,$_color);
			
			while ($_len--)
			{
				
				if ($_len != 4)
				{
					switch($_graphics)
					{
						case "rect":
							shapeBounds.CreateRect($_arr[$_len].x-$_block_size, $_arr[$_len].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
							break;
						case "circle":
							shapeBounds.CreateCircle($_arr[$_len].x, $_arr[$_len].y, $_block_size, $_color, $_border, 0xffffff);
							break;
						case "bmp":
							shapeBounds.FillBitmap($_bitmapdata, false, $_arr[$_len].x, $_arr[$_len].y);
							break;
						default:
							shapeBounds.CreateRect($_arr[$_len].x - $_block_size, $_arr[$_len].y - $_block_size, $_block_size * 2, $_block_size * 2, $_color);
							break;
					}
				}
			}
			
			switch($_o_graphics)
			{
				case "rect":
					shapeBounds.CreateRect($_arr[4].x-$_block_size, $_arr[4].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
					break;
				case "circle":
					shapeBounds.CreateCircle($_arr[4].x, $_arr[4].y, $_block_size, 0xffffff, $_border, $_color);
					break;
				case "bmp":
					shapeBounds.FillBitmap($_o_bitmapdata, false, $_arr[4].x, $_arr[4].y);
					break;
				default:
					shapeBounds.CreateCircle($_arr[4].x, $_arr[4].y, $_block_size, 0xffffff, $_border, $_color);
					break;
			}
			
		}
		
		private function DrawSelectGraphics($matrix:Object):void
		{
			var $_arr:Array = $matrix.array;
			var $_len:int = $_arr.length;
			//var $_block_size:Number = 3;
			
			var $_color:uint = typeSelect.color == null? 0xFF9900 : typeSelect.color;
			var $_border:uint = typeSelect.border == null? 1 : typeSelect.border;
			var $_block_size:uint = typeSelect.size == null? 3 : typeSelect.size;
			var $_graphics:String = typeSelect.graphics;
			var $_bitmapdata:BitmapData = typeSelect.bitmapdata == null ? shapeArrow.Bmp_6dn : typeSelect.bitmapdata;
			var $_o_graphics:String = typeSelect.o_graphics;
			var $_o_bitmapdata:BitmapData = typeSelect.o_bitmapdata == null ? shapeArrow.Bmp_6dn : typeSelect.o_bitmapdata;
			
			var $_tmp_arr:Array = new Array($_arr[0], $_arr[2], $_arr[8], $_arr[6]);
			
			shapeBounds.CreateLine($_tmp_arr,$_border,$_color);
			
			while ($_len--)
			{
				
				if ($_len != 4)
				{
					//shapeBounds.CreateRect($_arr[$_len].x-$_block_size, $_arr[$_len].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
					switch($_graphics)
					{
						case "rect":
							shapeBounds.CreateRect($_arr[$_len].x-$_block_size, $_arr[$_len].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
							break;
						case "circle":
							shapeBounds.CreateCircle($_arr[$_len].x, $_arr[$_len].y, $_block_size, $_color, $_border, 0xffffff);
							break;
						case "bmp":
							shapeBounds.FillBitmap($_bitmapdata, false, $_arr[$_len].x, $_arr[$_len].y);
							break;
						default:
							shapeBounds.CreateRect($_arr[$_len].x - $_block_size, $_arr[$_len].y - $_block_size, $_block_size * 2, $_block_size * 2, $_color);
							break;
					}
				}
			}
			
			switch($_o_graphics)
			{
				case "rect":
					shapeBounds.CreateRect($_arr[4].x-$_block_size, $_arr[4].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
					break;
				case "circle":
					shapeBounds.CreateCircle($_arr[4].x, $_arr[4].y, $_block_size, 0xffffff, $_border, $_color);
					break;
				case "bmp":
					shapeBounds.FillBitmap($_o_bitmapdata, false, $_arr[4].x, $_arr[4].y);
					break;
				default:
					shapeBounds.CreateCircle($_arr[4].x, $_arr[4].y, $_block_size, 0xffffff, $_border, $_color);
					break;
			}
		}
		
	}
}