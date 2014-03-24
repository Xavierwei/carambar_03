/***
MultiLoader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月16日 10:53:17
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class MultiLoader{
		
		public static const TEXT:String=URLLoaderDataFormat.TEXT;
		public static const BINARY:String=URLLoaderDataFormat.BINARY;
		public static const BMD:String="bmd";
		public static const SWF:String="swf";
		
		private var loadObjV:Vector.<EventDispatcher>;
		public var itemXMLV:Vector.<XML>;
		
		public var startProgress:Number;
		public var k:Number;
		
		public var srcField:String;
		public var srcFunction:Function;
		public var onLoadProgress:Function;
		public var onLoadOneComplete:Function;
		public var onLoadComplete:Function;
		public var onLoadError:Function;
		
		private var loadId:int;
		public var currLoadingSrc:String;
		
		public function MultiLoader(){
		}
		public function clear():void{
			
			clearLoadObjs();
			
			loadObjV=null;
			
			srcField=null;
			srcFunction=null;
			onLoadProgress=null;
			onLoadOneComplete=null;
			onLoadComplete=null;
			onLoadError=null;
		}
		private function clearLoadObjs():void{
			var target:EventDispatcher;
			for each(var loadObj:EventDispatcher in loadObjV){
				if(loadObj is Loader){
					target=(loadObj as Loader).contentLoaderInfo;
				}else{
					target=loadObj;
				}
				target.removeEventListener(ProgressEvent.PROGRESS,loadOneProgress);
				target.removeEventListener(Event.COMPLETE,loadOneComplete);
				target.removeEventListener(IOErrorEvent.IO_ERROR,loadOneError);
				target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadOneError);
			}
		}
		public function load(data:*,type:String=null):void{
			
			clearLoadObjs();
			
			if(srcField){
			}else{
				srcField="@src";
			}
			
			loadObjV=new Vector.<EventDispatcher>();
			
			itemXMLV=new Vector.<XML>();
			var itemXML:XML;
			
			var nodeList:XMLList;
			if(data is XMLList){
				nodeList=data;
			}else{
				nodeList=new XMLList();
				if(data is XML){
					nodeList[0]=data;
				}else if(data is String){
					nodeList[0]=<node src={data}/>;
				}else{
					throw new Error("不支持的 data："+data);
				}
			}
			for each(var node:XML in nodeList){
				itemXML=<item/>;
				if(srcFunction==null){
					itemXML.@src=node[srcField];
				}else{
					itemXML.@src=srcFunction(node);
				}
				if(type){
					itemXML.@type=type;
				}else{
					switch(itemXML.@src.toString().replace(/^.*(\.\w+)$/i,"$1").toLowerCase()){
						case ".jpg":
						case ".png":
						case ".gif":
							itemXML.@type=BMD;
						break;
						case ".swf":
							itemXML.@type=SWF;
						break;
						default:
							itemXML.@type=TEXT;
						break;
					}
				}
				itemXMLV.push(itemXML);
			}
			
			if(startProgress>0){
			}else{
				startProgress=0;
			}
			if(k>0){
			}else{
				k=1;
			}
			
			loadId=-1;
			loadNext();
		}
		public function stop():void{
			var target:EventDispatcher;
			for each(var loadObj:EventDispatcher in loadObjV){
				if(loadObj is Loader){
					(loadObj as Loader).unloadAndStop();
				}else{
					try{
						(loadObj as URLLoader).close();
					}catch(e:Error){}
				}
			}
			clearLoadObjs();
		}
		private function loadNext():void{
			var type:String;
			
			if(++loadId>=itemXMLV.length){
				if(onLoadComplete==null){
				}else{
					var loadResultArr:Array=new Array();
					loadId=-1;
					for each(var loadObj:EventDispatcher in loadObjV){
						loadId++;
						type=itemXMLV[loadId].@type.toString();
						switch(type){
							case TEXT:
							case BINARY:
								loadResultArr[loadId]=(loadObj as URLLoader).data;
							break;
							case BMD:
								loadResultArr[loadId]=((loadObj as Loader).content as Bitmap).bitmapData;
							break;
							case SWF:
								loadResultArr[loadId]=loadObj as Loader;
							break;
						}
					}
					onLoadComplete(loadResultArr);
				}
				return;
			}
			
			var loader:Loader,urlLoader:URLLoader;
			
			type=itemXMLV[loadId].@type.toString();
			
			var target:EventDispatcher;
			
			switch(type){
				case TEXT:
				case BINARY:
					loadObjV[loadId]=urlLoader=new URLLoader();
					urlLoader.dataFormat=type;
					target=urlLoader;
				break;
				case BMD:
				case SWF:
					loadObjV[loadId]=loader=new Loader();
					target=loader.contentLoaderInfo;
				break;
			}
			
			target.addEventListener(ProgressEvent.PROGRESS,loadOneProgress);
			target.addEventListener(Event.COMPLETE,loadOneComplete);
			target.addEventListener(IOErrorEvent.IO_ERROR,loadOneError);
			target.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadOneError);
			
			currLoadingSrc=itemXMLV[loadId].@src.toString();
			loadObjV[loadId]["load"](new URLRequest(currLoadingSrc));
		}
		private function loadOneProgress(event:ProgressEvent):void{
			if(event.bytesTotal>0){
				_loadOneProgress(event.bytesLoaded/event.bytesTotal);
			}
		}
		private function _loadOneProgress(percent:Number):void{
			if(onLoadProgress==null){
			}else{
				onLoadProgress(startProgress+k*(loadId+percent)/itemXMLV.length);
			}
		}
		private function loadOneComplete(event:Event):void{
			_loadOneProgress(1);
			if(onLoadOneComplete==null){
			}else{
				onLoadOneComplete();
			}
			loadNext();
		}
		private function loadOneError(event:Event):void{
			if(onLoadError==null){
			}else{
				onLoadError();
			}
			loadNext();
		}
		
	}
}