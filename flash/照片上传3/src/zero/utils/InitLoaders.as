/***
InitLoaders
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年4月21日 18:55:58
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class InitLoaders{
		
		/**
		 * 
		 * 1个参数 getURLLoader(loadComplete)
		 * 2个参数 getURLLoader(loadComplete,loadError)
		 * 3个参数 getURLLoader(loadProgress,loadComplete,loadError)
		 * 
		 */		
		public static function getURLLoader(...args):URLLoader{
			var urlLoader:URLLoader=new URLLoader();
			initURLLoader.apply(InitLoaders,[urlLoader].concat(args));
			return urlLoader;
		}
		
		/**
		 * 
		 * 2个参数 initURLLoader(urlLoader,loadComplete)
		 * 3个参数 initURLLoader(urlLoader,loadComplete,loadError)
		 * 4个参数 initURLLoader(urlLoader,loadProgress,loadComplete,loadError)
		 * 
		 */	
		public static function initURLLoader(urlLoader:URLLoader,...args):void{
			var loadProgress:Function,loadComplete:Function,loadError:Function;
			switch(args.length){
				case 1:
					loadProgress=null;
					loadComplete=args[0];
					loadError=null;
				break;
				case 2:
					loadProgress=null;
					loadComplete=args[0];
					loadError=args[1];
				break;
				case 3:
					loadProgress=args[0];
					loadComplete=args[1];
					loadError=args[2];
				break;
			}
			if(loadProgress==null){
			}else{
				addListener(urlLoader,ProgressEvent.PROGRESS,loadProgress);
			}
			if(loadComplete==null){
			}else{
				addListener(urlLoader,Event.COMPLETE,loadComplete);
			}
			if(loadError==null){
			}else{
				addListener(urlLoader,SecurityErrorEvent.SECURITY_ERROR,loadError);
				addListener(urlLoader,IOErrorEvent.IO_ERROR,loadError);
			}
		}
		
		/**
		 * 
		 * 1个参数 getLoader(loadComplete)
		 * 2个参数 getLoader(loadComplete,loadError)
		 * 3个参数 getLoader(loadProgress,loadComplete,loadError)
		 * 
		 */	
		public static function getLoader(...args):Loader{
			var loader:Loader=new Loader();
			initLoader.apply(InitLoaders,[loader].concat(args));
			return loader;
		}
		
		/**
		 * 
		 * 2个参数 initLoader(loader,loadComplete)
		 * 3个参数 initLoader(loader,loadComplete,loadError)
		 * 4个参数 initLoader(loader,loadProgress,loadComplete,loadError)
		 * 
		 */	
		public static function initLoader(loader:Loader,...args):void{
			var loadProgress:Function,loadComplete:Function,loadError:Function;
			switch(args.length){
				case 1:
					loadProgress=null;
					loadComplete=args[0];
					loadError=null;
				break;
				case 2:
					loadProgress=null;
					loadComplete=args[0];
					loadError=args[1];
				break;
				case 3:
					loadProgress=args[0];
					loadComplete=args[1];
					loadError=args[2];
				break;
			}
			if(loadProgress==null){
			}else{
				addListener(loader.contentLoaderInfo,ProgressEvent.PROGRESS,loadProgress);
			}
			if(loadComplete==null){
			}else{
				addListener(loader.contentLoaderInfo,Event.COMPLETE,loadComplete);
			}
			if(loadError==null){
			}else{
				addListener(loader.contentLoaderInfo,SecurityErrorEvent.SECURITY_ERROR,loadError);
				addListener(loader.contentLoaderInfo,IOErrorEvent.IO_ERROR,loadError);
			}
		}
		
		public static function clear(_loader:*,unload:Boolean=true):void{
			if(_loader is URLLoader){
				var urlLoader:URLLoader=_loader;
				if(unload){
					try{
						urlLoader.close();
					}catch(e:Error){}
				}
				removeListeners(urlLoader);
			}else if(_loader is Loader){
				var loader:Loader=_loader;
				if(unload){
					try{
						loader.close();
					}catch(e:Error){}
					try{
						loader.unload();
					}catch(e:Error){}
					try{
						loader.unloadAndStop();
					}catch(e:Error){}
				}
				removeListeners(loader.contentLoaderInfo);
			}
		}
		
		private static var dict:Dictionary=new Dictionary();
		private static function addListener(eventDispatcher:EventDispatcher,type:String,listener:Function):void{
			if(type){
				if(listener==null){
				}else{
					if(dict[eventDispatcher]){
					}else{
						dict[eventDispatcher]=new Object();
					}
					if(dict[eventDispatcher][type]){
					}else{
						dict[eventDispatcher][type]=new Dictionary();
					}
					if(dict[eventDispatcher][type][listener]){
					}else{
						dict[eventDispatcher][type][listener]=true;
					}
					eventDispatcher.addEventListener(type,listener);
				}
			}
		}
		private static function removeListener(eventDispatcher:EventDispatcher,type:String,listener:Function):void{
			if(type){
				if(listener==null){
				}else{
					//if(
					//	dict[eventDispatcher]
					//	&&
					//	dict[eventDispatcher][type]
					//	&&
					//	dict[eventDispatcher][type][listener]
					//){
						delete dict[eventDispatcher][type][listener];
						if(getMarkNum(dict[eventDispatcher][type])){
						}else{
							delete dict[eventDispatcher][type];
						}
						if(getMarkNum(dict[eventDispatcher])){
						}else{
							delete dict[eventDispatcher];
						}
					//}
					eventDispatcher.removeEventListener(type,listener);
				}
			}
		}
		private static function removeListeners(eventDispatcher:EventDispatcher):void{
			var typeArr:Array=new Array();
			for(var type:String in dict[eventDispatcher]){
				typeArr.push(type);
			}
			for each(type in typeArr){
				var listenerArr:Array=new Array();
				for(var listener:* in dict[eventDispatcher][type]){
					listenerArr.push(listener);
				}
				for each(listener in listenerArr){
					removeListener(eventDispatcher,type,listener);
				}
			}
			
			//遍历所有可能的 type 以检查是否有未清理的事件
			for each(var metadataXML:XML in describeType(eventDispatcher).metadata){
				//<metadata name="Event">
				//	<arg key="name" value="progress"/>
				//	<arg key="type" value="flash.events.ProgressEvent"/>
				//</metadata>
				for each(var argXML:XML in metadataXML.arg){
					if(argXML.@name.toString()=="name"){
						//trace("type="+argXML.@value.toString());
						if(eventDispatcher.hasEventListener(argXML.@value.toString())){
							trace("未清理的事件，type="+argXML.@value.toString());
						}
						break;
					}
				}
			}
		}
		private static function getMarkNum(obj:Object):int{
			var num:int=0;
			for(var name:String in obj){
				num++;
			}
			//trace("num="+num);
			return num;
		}
		public static function checkDict():void{
			trace("checkDict----------------------------------------");
			for(var eventDispatcher:* in dict){
				trace("eventDispatcher="+eventDispatcher);
				for(var type:String in dict[eventDispatcher]){
					trace(" type="+'"'+type+'"');
					for(var listener:* in dict[eventDispatcher][type]){
						trace("  listener="+listener);
					}
				}
			}
			trace("----------------------------------------checkDict");
		}
	}
}