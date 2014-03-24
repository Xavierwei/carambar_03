/***
DAE 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月14日 15:55:09
历次修改:20130925 整理和改进
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D{
	import flash.geom.Matrix3D;
	import flash.system.System;
	import flash.utils.unescapeMultiByte;
	
	/**
	 * 
	 * DAE
	 * 
	 */	
	public class DAE extends Obj3DContainer{
		
		public static function format(_dae:XML,fileName:String,removeAllExtra:Boolean=true):XML{
			default xml namespace = _dae.namespace();
			formatImagePathToCN(_dae,fileName);
			formatLibrary_effects(_dae);
			delete _dae.asset;
			delete _dae.library_lights;
			var _xmlList:XMLList=_dae.library_visual_scenes.visual_scene.node.(@id == "VisualSceneNode");
			if(_xmlList.length()>0){
				delete _dae.library_visual_scenes.visual_scene.node[_xmlList.childIndex()];
			}
			removeAllNameAs(_dae,"extra",removeAllExtra?null:"effect");
			return _dae
		}
		private static function formatImagePathToCN(_dae:XML,_name:String):void {
			var _path:String;
			var _lth:uint=_dae.library_images.image.length();
			var _type:String;
			var _tempAry:Array;
			_name=_name.split(".")[0];
			for each(var _e:XML in _dae.library_images.image) {
				_path = _e.init_from;
				System.useCodePage=true;
				_path = unescapeMultiByte(_path);
				System.useCodePage = false;
				_path=_path.split("/").pop();
				_tempAry=_path.split(".");
				_type=_tempAry.pop();
				
				//_e.init_from=_tempAry[0]+".jpg";
				_e.init_from=_tempAry[0];
			}
		}
		private static function formatLibrary_effects(_dae:XML):void {
			var _effect:XMLList=_dae.library_effects.effect;
			var _key:String;
			var _has:Boolean;
			var _e:XML;
			var _l:uint = _effect.length ();
			var _index:uint;
			for (var _i:int = _l - 1; _i >= 0; _i--) {
				_e = _effect[_i];
				_has = _e.profile_COMMON.newparam.length() >= 1;
				if (_has) {
					_key = String(_e.profile_COMMON.newparam[0].surface.init_from);
				}
				if (_has && _dae.library_images.image.(@id == _key).length() >= 1) {
					liveChild(_e.profile_COMMON.newparam[0].surface[0], "init_from");
					liveChild(_e.profile_COMMON.newparam[1].sampler2D[0], "source");
					liveChild(_e.profile_COMMON.technique.blinn[0], "diffuse");
				}else {
					delete _effect[_e.childIndex()];
					_key = "#" + String(_e.@id);
					_index = _dae.library_materials.material.(instance_effect.@url == _key).childIndex();
					delete _dae.library_materials.material[_index];
				}
			}
		}
		private static function liveChild(_xml:XML, _name:String):void {
			for each(var _e:XML in _xml.children() ) {
				if (String(_e.localName()) != _name) {
					delete _xml.children()[_e.childIndex()];
				}
			}
		}
		private static function removeAllNameAs(_xml:*,_str:String,_parentName:String=null):void{
			if(String(_xml.localName())==_str){
				if(_xml.parent()&&_xml.parent().localName()!=_parentName){
					delete _xml.parent()[_xml.localName()];
				}
				return;
			}
			for each(var _e:* in _xml.children()){
				removeAllNameAs(_e,_str,_parentName);
			}
		}
		
		public var daeXML:XML;
		private var meshMark:Object;
		
		public function DAE(
			_daeXML:XML,
			bmds:Object=null
		):void{
			
			daeXML=_daeXML;
			
			trace(daeXML);
			
			meshMark=new Object();
			for each(var geometryXML:XML in daeXML.children()){
				var geomMeshV:Vector.<Mesh3D>=new Vector.<Mesh3D>();
				meshMark[geometryXML.name().toString()]=geomMeshV;
				var matrix_str_arr:Array=geometryXML.@matrix.toString().split(",");
				if(matrix_str_arr.length==12){
					var matrix3D:Matrix3D=new Matrix3D(new <Number>[
						Number(matrix_str_arr[0]),Number(matrix_str_arr[1]),Number(matrix_str_arr[2]),0,
						Number(matrix_str_arr[3]),Number(matrix_str_arr[4]),Number(matrix_str_arr[5]),0,
						Number(matrix_str_arr[6]),Number(matrix_str_arr[7]),Number(matrix_str_arr[8]),0,
						Number(matrix_str_arr[9]),Number(matrix_str_arr[10]),Number(matrix_str_arr[11]),1
					]);
				}else{
					matrix3D=new Matrix3D();
				}
				
				
				for each(var meshXML:XML in geometryXML.mesh){
					var vertexVXML:XML=meshXML.vertexV[0];
					var uvVXML:XML=meshXML.uvV[0];
					
					if(vertexVXML){
						var vertexDivisor:int=int(vertexVXML.@divisor.toString());
						if(vertexDivisor>0){
						}else{
							vertexDivisor=1;
						}
						
						var vertexV:Vector.<Number>=new Vector.<Number>();
						var vertexIdV:Vector.<int>=new Vector.<int>();
						
						var i:int=0;
						for each(var str:String in vertexVXML.toString().split(",")){
							vertexV[i++]=int(str)/vertexDivisor;
						}
						i=0;
						for each(str in meshXML.vertexIdV[0].toString().split(",")){
							vertexIdV[i++]=int(str);
						}
					}else{
						throw new Error("顶点列表不能为空");
					}
					
					if(uvVXML){
						var uvDivisor:int=int(uvVXML.@divisor.toString());
						if(uvDivisor>0){
						}else{
							uvDivisor=1;
						}
						
						var uvtV:Vector.<Number>=new Vector.<Number>();
						
						i=0;
						for each(str in uvVXML.toString().split(",")){
							uvtV[i++]=int(str)/uvDivisor;
							if(i%3==2){
								uvtV[i++]=0;
							}
						}
					}else{
						uvtV=null;
					}
					
					var mesh3D:Mesh3D=new Mesh3D(vertexV,vertexIdV,bmds?bmds[meshXML.@materialId.toString()]:null,uvtV);
					mesh3D.matrix3D=matrix3D;
					geomMeshV[geomMeshV.length]=mesh3D;
					this.addChild(mesh3D);
				}
			}
		}
		
		override public function clear():void{super.clear();
			daeXML=null;
			meshMark=null;
		}
		
		/*
		public function setDrawValues(
			lineColor:int,
			lineThickness:int,
			lineAlpha:Number,
			fillColor:int,
			fillAlpha:Number
		):void{
			for each(var mesh3D:Mesh3D in obj3DV){
				mesh3D.lineColor=lineColor;
				mesh3D.lineThickness=lineThickness;
				mesh3D.lineAlpha=lineAlpha;
				
				mesh3D.fillColor=fillColor;
				mesh3D.fillAlpha=fillAlpha;
			}
		}
		public var meshMark:Object;
		public function initByXML(
			daeAdvanceXML:XML,
			bmds:Object=null
		):void{
			meshMark=new Object();
			var geomMeshV:Vector.<Mesh3D>;
			for each(var geometryXML:XML in daeAdvanceXML.children()){
				meshMark[geometryXML.name().toString()]=geomMeshV=new Vector.<Mesh3D>();
				var matrix_str_arr:Array=geometryXML.@matrix.toString().split(",");
				var matrix3D:Matrix3D;
				if(matrix_str_arr.length==12){
					matrix3D=new Matrix3D(new <Number>[
						Number(matrix_str_arr[0]),Number(matrix_str_arr[1]),Number(matrix_str_arr[2]),0,
						Number(matrix_str_arr[3]),Number(matrix_str_arr[4]),Number(matrix_str_arr[5]),0,
						Number(matrix_str_arr[6]),Number(matrix_str_arr[7]),Number(matrix_str_arr[8]),0,
						Number(matrix_str_arr[9]),Number(matrix_str_arr[10]),Number(matrix_str_arr[11]),1
					]);
				}else{
					matrix3D=new Matrix3D();
				}
				
				
				for each(var meshXML:XML in geometryXML.mesh){
					var vertexVXML:XML=meshXML.vertexV[0];
					var uvVXML:XML=meshXML.uvV[0];
					
					var vertexV:Vector.<Number>;
					var vertexIdV:Vector.<int>;
					
					var uvV:Vector.<Number>;
					var uvIdV:Vector.<int>;
					
					var i:int,str:String;
					
					if(vertexVXML){
						var vertexDivisor:int=int(vertexVXML.@divisor.toString());
						if(vertexDivisor>0){
						}else{
							vertexDivisor=1;
						}
						
						vertexV=new Vector.<Number>();
						vertexIdV=new Vector.<int>();
						
						i=0;
						for each(str in vertexVXML.toString().split(",")){
							vertexV[i++]=int(str)/vertexDivisor;
						}
						i=0;
						for each(str in meshXML.vertexIdV[0].toString().split(",")){
							vertexIdV[i++]=int(str);
						}
					}else{
						vertexV=null;
						vertexIdV=null;
						throw new Error("顶点列表不能为空");
					}
					
					if(uvVXML){
						var uvDivisor:int=int(uvVXML.@divisor.toString());
						if(uvDivisor>0){
						}else{
							uvDivisor=1;
						}
						
						uvV=new Vector.<Number>();
						uvIdV=new Vector.<int>();
						
						i=0;
						for each(str in uvVXML.toString().split(",")){
							uvV[i++]=int(str)/uvDivisor;
						}
						i=0;
						for each(str in meshXML.uvIdV[0].toString().split(",")){
							uvIdV[i++]=int(str);
						}
					}else{
						uvV=null;
						uvIdV=null;
					}
						
					var mesh3D:Mesh3D;
					if(bmds){
						mesh3D=new Mesh3D(bmds[meshXML.@materialId.toString()],vertexV,uvV,vertexIdV,uvIdV);
					}else{
						mesh3D=new Mesh3D(null,vertexV,uvV,vertexIdV,uvIdV);
						var lineColorStr:String=meshXML.@lineColor.toString();
						if(lineColorStr){
						}else{
							lineColorStr=geometryXML.@lineColor.toString();
						}
						if(lineColorStr){
							mesh3D.lineColor=int(lineColorStr);
						}else{
							//mesh3D.lineColor=int(Math.random()*0x1000000);
							//mesh3D.lineColor=0xffffff;
						}
					}
					
					mesh3D.matrix3D=matrix3D;
					geomMeshV[geomMeshV.length]=mesh3D;
					addChild(mesh3D);
				}
			}
		}*/
	}
}

