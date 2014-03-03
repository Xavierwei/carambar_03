/***
ImgLoader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年11月14日 14:26:13
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	
	import com.greensock.TweenMax;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.FileTypes;
	import zero.codec.BMPEncoder;
	import zero.codec.PNGEncoder;
	import zero.utils.playAll;
	import zero.utils.stopAll;
	
	public class ImgLoader extends Sprite{
		
		public var xml:XML;
		
		public var loader:Loader;
		private var dataLoader:URLLoader;
		
		private var connection:NetConnection;
		private var stream:NetStream;
		private var flvData:ByteArray;
		public var video:Video;
		protected var video_is_showing:Boolean;
		
		private var align:String;
		private var dataType:String;
		
		public var container:Sprite;
		public var bottomContainer:Sprite;
		public var boundsMask:Sprite;//20130512
		public var bg:Sprite;
		public var progressClip:Sprite;
		
		public var autoPlay:Boolean;
		public var repeat:Boolean;
		
		public var onLoadComplete:Function;
		public var onLoadError:Function;
		public var onLoadProgress:Function;
		public var onFadeComplete:Function;
		public var onPlayComplete:Function;
		
		public function ImgLoader():void{
			
			autoPlay=true;
			repeat=false;
			
			if(progressClip){
				stopAll(progressClip);
				progressClip.visible=false;
			}
		}
		public function clear():void{
			xml=null;
			
			if(stream){
				try{
					stream.close();
				}catch(e:Error){}
			}
			stopLoader();
			
			dataLoader=null;
			if(loader){
				try{
					loader.unloadAndStop();
				}catch(e:Error){
					loader.unload();
				}
				loader=null;
			}
			if(container){
				stopAll(container);
				container=null;
			}
			if(bottomContainer){
				bottomContainer=null;
			}
			if(progressClip){
				stopAll(progressClip);
				progressClip=null;
			}
			connection=null;
			stream=null;
			flvData=null;
			if(video){
				video.attachNetStream(null);
				video=null;
			}
			
			onLoadComplete=null;
			onLoadError=null;
			onLoadProgress=null;
			onFadeComplete=null;
			onPlayComplete=null;
		}
		public function stopLoader():void{
			if(dataLoader){
				try{
					dataLoader.close();
				}catch(e:Error){}
				dataLoader.removeEventListener(ProgressEvent.PROGRESS,loadProgress);
				dataLoader.removeEventListener(Event.COMPLETE,loadDataComplete);
				dataLoader.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
				dataLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadError);
			}
			if(loader){
				try{
					loader.close();
				}catch(e:Error){}
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loadProgress);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadImgComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
				loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadError);
				stopAll(loader);
			}
			
			var movie:MovieClip=getMovie();
			if(movie){
				movie.addFrameScript(movie.totalFrames-1,null);
				movie.stop();
			}
			
			video_is_showing=false;
			this.removeEventListener(Event.ENTER_FRAME,loadVideoProgress);
			
			if(connection){
				try{
					connection.close();
				}catch(e:Error){
					//trace("e="+e);
				}
			}
			if(stream){
				stream.pause();
				stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			}
			if(video&&video.parent==container){
				container.removeChild(video);
			}
		}
		
		/**
		 * 
		 * load(imgData)
		 * load(<img src="test.jpg" align="bottom center"/>)
		 * load(Bmd0)
		 * load("Bmd0")
		 * load(<img src="Bmd0" align="bottom center"/>)
		 * 
		 */		
		public function load(data:*,_dataType:String=null,_wid:int=0,_hei:int=0):void{
			
			var i:int;
			
			if(bottomContainer){
				i=bottomContainer.numChildren;
				while(--i>=0){
					bottomContainer.removeChildAt(i);
				}
			}
			
			if(loader&&bottomContainer){
			}else{
				if(stream){
					try{
						stream.close();
					}catch(e:Error){}
				}
			}
			stopLoader();
			
			if(bottomContainer){
				if(loader){
					bottomContainer.addChild(loader);
				}
				if(video){
					bottomContainer.addChild(video);
				}
			}
			loader=null;
			dataLoader=null;
			connection=null;
			stream=null;
			flvData=null;
			if(video){
				video.attachNetStream(null);
				video=null;
			}
			
			if(container){
				i=container.numChildren;
				while(--i>=0){
					container.removeChildAt(i);
				}
			}
			
			if(data){
			}else{
				return;
			}
			
			if(data is ByteArray||data is BitmapData||data is Class){
				xml=<img/>;
			}else if(data is XML){
				xml=data;
				if(xml.@src.toString()){
				}else{
					return;
				}
			}else if(data is String){
				xml=<img src={data}/>;
			}else{
				throw new Error("load 未知数据："+data);
			}
			
			if(_wid>0){
				xml.@width=_wid;
			}
			if(_hei>0){
				xml.@height=_hei;
			}
			
			if(container){
			}else{
				container=new Sprite();
				this.addChildAt(container,0);
			}
			
			align=xml.@align.toString();
			if(align){
			}else{
				if(bg){
					var b:Rectangle=bg.getBounds(this);
					var dx:Number=Math.round(container.x-b.x);
					var dy:Number=Math.round(container.y-b.y);
					//var d0:Number=0-dx;
					var d1:Number=b.width-dx;
					var d2:Number=b.width/2-dx;
					if(dx*dx<d1*d1&&dx*dx<d2*d2){
						align="left";
					}else if(d1*d1<dx*dx&&d1*d1<d2*d2){
						align="right";
					}else{
						align="center";
					}
					//d0=0-dy;
					d1=b.height-dy;
					d2=b.height/2-dy;
					if(dy*dy<d1*d1&&dy*dy<d2*d2){
						align+=" top";
					}else if(d1*d1<dy*dy&&d1*d1<d2*d2){
						align+=" bottom";
					}else{
						align+=" middle";
					}
				}else{
					align="top left";
				}
			}
			
			i=this.numChildren;
			while(--i>=0){
				var child:DisplayObject=this.getChildAt(i);
				if(child.hasOwnProperty("mouseEnabled")){
					child["mouseEnabled"]=false;
				}
				if(child.hasOwnProperty("mouseChildren")){
					child["mouseChildren"]=false;
				}
			}
			container.mouseChildren=true;
			
			dataType=_dataType;
			
			if(data is Class){
				data=new data();
			}
			
			if(data is ByteArray){
				loadData(data);
				return;
			}
			if(data is BitmapData){
				loadBmd(data);
				return;
			}
			
			var BmdClass:Class;
			try{
				BmdClass=getDefinitionByName(xml.@src.toString()) as Class;
			}catch(e:Error){
				BmdClass=null;
			}
			if(BmdClass){
				data=new BmdClass();
				if(data is ByteArray){
					loadData(data);
					return;
				}
				if(data is BitmapData){
					loadBmd(data);
					return;
				}
				throw new Error("load 未知数据："+BmdClass+(xml?"，"+xml.toXMLString():""));
			}
			
			loadSrc(xml.@src.toString(),dataType);
		}
		private function loadSrc(src:String,_dataType:String):void{
			if(_dataType){
				dataType=_dataType;
			}else{
				dataType=src.split(".").pop().toLowerCase();
			}
			switch(dataType){
				case FileTypes.JPG:
				case FileTypes.PNG:
				case FileTypes.GIF:
				case FileTypes.SWF:
					if(loader){
					}else{
						loader=new Loader();
						loader.visible=false;
						container.addChild(loader);
					}
					loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,loadProgress);
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadImgComplete);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadError);
					loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadError);
					loader.load(new URLRequest(src),new LoaderContext(true));
				break;
				case FileTypes.FLV:
				case FileTypes.F4V:
				case FileTypes.MP4:
					connection=new NetConnection();
					connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
					connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
					connection.connect(null);
					this.addEventListener(Event.ENTER_FRAME,loadVideoProgress);
				break;
				default:
					if(dataLoader){
					}else{
						dataLoader=new URLLoader();
					}
					dataLoader.addEventListener(ProgressEvent.PROGRESS,loadProgress);
					dataLoader.addEventListener(Event.COMPLETE,loadDataComplete);
					dataLoader.addEventListener(IOErrorEvent.IO_ERROR,loadError);
					dataLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadError);
					dataLoader.dataFormat=URLLoaderDataFormat.BINARY;
					dataLoader.load(new URLRequest(src));
				break;
			}
			if(progressClip){
				playAll(progressClip);
				if(progressClip is MovieClip){
					if((progressClip as MovieClip).totalFrames>1){
						(progressClip as MovieClip).gotoAndStop(1);
					}
				}
				if(progressClip.hasOwnProperty("txt")){
					progressClip["txt"].text="0 %";
				}
				progressClip.visible=true;
			}
		}
		private function loadData(data:ByteArray):void{
			dataType=FileTypes.getType(data);
			switch(dataType){
				case FileTypes.JPG:
				case FileTypes.PNG:
				case FileTypes.GIF:
				case FileTypes.SWF:
					if(loader){
					}else{
						loader=new Loader();
						loader.visible=false;
						container.addChild(loader);
					}
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadImgComplete);
					loader.loadBytes(data);
				break;
				case FileTypes.BMP:
					loadBmd(BMPEncoder.decode(data));
				break;
				case FileTypes.FLV:
				case FileTypes.F4V:
				case FileTypes.MP4:
					flvData=data;
					connection=new NetConnection();
					connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
					connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
					connection.connect(null);
				break;
				default:
					if(dataLoader){//防止循环加载
					}else if(xml){
						if(xml.@src.toString()){
							loadSrc(xml.@src.toString(),dataType);
							return;
						}
					}
					throw new Error("loadData 未知数据"+(xml?"，"+xml.toXMLString():""));
				break;
			}
		}
		private function loadBmd(bmd:BitmapData):void{
			loadData(PNGEncoder.encode(bmd));
		}
		private function loadProgress(event:ProgressEvent):void{
			if(event.bytesTotal>0){
				_loadProgress(event.bytesLoaded/event.bytesTotal);
			}
		}
		private function loadDataComplete(...args):void{
			loadData(dataLoader.data);
		}
		private function loadImgComplete(...args):void{
			if(xml.@smoothing.toString()=="true"){
				if(loader.content is Bitmap){
					(loader.content as Bitmap).smoothing=true;
				}
			}
			var wid:int=-1;
			var hei:int=-1;
			if(boundsMask){
				if(loader.contentLoaderInfo.width/loader.contentLoaderInfo.height>boundsMask.width/boundsMask.height){
					hei=boundsMask.height;
					wid=loader.contentLoaderInfo.width/loader.contentLoaderInfo.height*hei;
				}else{
					wid=boundsMask.width;
					hei=loader.contentLoaderInfo.height/loader.contentLoaderInfo.width*wid;
				}
			}else{
				if(xml.@width.toString()){
					wid=int(xml.@width.toString());
				}
				if(xml.@height.toString()){
					hei=int(xml.@height.toString());
				}
			}
			if(wid>-1){
				if(loader.content is Bitmap){
					loader.width=wid;
				}else{
					loader.scaleX=wid/loader.contentLoaderInfo.width;
				}
			}else{
				wid=loader.contentLoaderInfo.width;
			}
			if(hei>-1){
				if(loader.content is Bitmap){
					loader.height=hei;
				}else{
					loader.scaleY=hei/loader.contentLoaderInfo.height;
				}
			}else{
				hei=loader.contentLoaderInfo.height;
			}
			showContent(loader,wid,hei);
			_loadComplete();
			var movie:MovieClip=getMovie();
			if(movie){
				movie.addFrameScript(movie.totalFrames-1,playComplete);
				if(autoPlay){
				}else{
					movie.stop();
				}
			}else{
				playComplete();
			}
		}
		private function getMovie():MovieClip{
			var movie:MovieClip;
			try{
				movie=loader.content as MovieClip;
			}catch(e:Error){
				movie=null;
			}
			if(movie&&movie.totalFrames>1){
				return movie;
			}
			return null;
		}
		private function loadError(event:Event):void{
			//Error #2044: 未处理的 IOErrorEvent:。 text=Error #2124: 加载的文件为未知类型。
			//Error #2044: 未处理的 IOErrorEvent:。 text=Error #2036: 加载未完成。
			if(
				event
				&&
				event is IOErrorEvent
				&&
				(event as IOErrorEvent).errorID==2036
				||
				dataType=="unknown"
			){
				_loadError();
				return;
			}
			loadSrc(xml.@src.toString(),"unknown");
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			//trace("event.info.code="+event.info.code);
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					connectStream();
				break;
				case "NetStream.Buffer.Flush":
				case "NetStream.Buffer.Full":
					if(video_is_showing){
					}else{
						if(autoPlay){
						}else{
							stream.pause();
						}
						video_is_showing=true;
						
						if(bg){
							video.width=bg.width;
							video.height=bg.height;
						}else{
							video.width=video.videoWidth;
							video.height=video.videoHeight;
						}
						//trace("xml="+xml.toXMLString());
						if(xml.@width.toString()){
							video.width=int(xml.@width.toString());
						}
						if(xml.@height.toString()){
							video.height=int(xml.@height.toString());
						}
						
						this.removeEventListener(Event.ENTER_FRAME,loadVideoProgress);
						showContent(video,video.width,video.height);
						_loadComplete();
					}
				break;
				case "NetStream.Play.StreamNotFound":
					_loadError();
				break;
				case "NetStream.Buffer.Empty"://- - //20120817
					if(flvData){
						playComplete();
					}
				break;
				case "NetStream.Play.Stop":
					if(flvData){
					}else{
						playComplete();
					}
				break;
			}
		}
		
		private function connectStream():void {
			stream=new NetStream(connection);
			if(__vol>-1){
				setVolume(__vol);
			}
			stream.client={onMetaData:function(...args):void{}};//用于解决：ReferenceError: Error #1069: 在 flash.net.NetStream 上找不到属性 onMetaData，且没有默认值。
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			video=new Video();
			video.attachNetStream(stream);
			video.visible=false;
			stream.bufferTime=xml.@bufferTime.toString()?int(xml.@bufferTime.toString()):10;
			if(flvData){
				//trace("flvData.length="+flvData.length);
				stream.play(null);
				stream.appendBytes(flvData);
			}else{
				stream.play(xml.@src.toString());
			}
			container.addChild(video);
		}
		private function loadVideoProgress(...args):void{
			if(stream&&stream.bufferTime>0){
				var percent:Number=stream.bufferLength/stream.bufferTime;
				if(percent>0){
					if(percent>1){
						percent=1;
					}
				}else{
					percent=0;
				}
				_loadProgress(percent);
			}
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			// ignore AsyncErrorEvent events.
		}
		
		private function showContent(content:DisplayObject,contentWid:int,contentHei:int):void{
			if(align.indexOf("left")>-1){
				//
			}else if(align.indexOf("right")>-1){
				content.x=-contentWid;
			}else{
				content.x=-int(contentWid/2);
			}
			if(align.indexOf("top")>-1){
				//
			}else if(align.indexOf("bottom")>-1){
				content.y=-contentHei;
			}else{
				content.y=-int(contentHei/2);
			}
			content.visible=true;
			content.alpha=0;
			TweenMax.to(content,12,{alpha:1,onComplete:onFadeComplete,useFrames:true});
		}
		private function _loadProgress(percent:Number):void{
			if(progressClip){
				if(progressClip is MovieClip){
					if((progressClip as MovieClip).totalFrames>1){
						(progressClip as MovieClip).gotoAndStop(int(percent*((progressClip as MovieClip).totalFrames-1))+1);
					}
				}
				if(progressClip.hasOwnProperty("txt")){
					progressClip["txt"].text=int(percent*100)+" %";
				}
			}
			if(onLoadProgress==null){
			}else{
				onLoadProgress(percent);
			}
		}
		private function _loadComplete():void{
			if(progressClip){
				stopAll(progressClip);
				progressClip.visible=false;
			}
			if(onLoadComplete==null){
			}else{
				onLoadComplete();
			}
		}
		private function _loadError():void{
			if(progressClip){
				stopAll(progressClip);
				progressClip.visible=false;
			}
			trace(this+" 加载失败"+(xml?"，"+xml.toXMLString():""));
			if(onLoadError==null){
			}else{
				onLoadError();
			}
		}
		
		public function pause():void{
			if(stream){
				stream.pause();
			}
			var movie:MovieClip=getMovie();
			if(movie){
				movie.stop();
			}
		}
		public function resume(pos:int=-1):void{
			if(stream){
				if(pos>-1){
					stream.seek(pos);
				}
				stream.resume();
			}
			var movie:MovieClip=getMovie();
			if(movie){
				movie.play();
			}
		}
		
		private function playComplete():void{
			
			if(stream){
				if(repeat){
					stream.play(xml.@src.toString());
				}//else{
				//	stream.pause();
				//}
			}
			
			var movie:MovieClip=getMovie();
			if(movie){
				if(repeat){
					//
				}else{
					movie.stop();
				}
			}
			
			if(onPlayComplete==null){
			}else{
				onPlayComplete();
			}
			
		}
		
		private var __vol:Number;
		public function setVolume(_vol:Number):void{
			__vol=_vol;
			if(stream){
				var soundTransform:SoundTransform=stream.soundTransform;
				soundTransform.volume=__vol;
				stream.soundTransform=soundTransform;
			}
		}
	}
}