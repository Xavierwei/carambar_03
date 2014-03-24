/***
Fla
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年07月26日 22:56:16
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.fla{
	import flash.filesystem.File;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	import zero.FileTypes;
	import zero.codec.MyCRC32;
	import zero.zip.Zip;
	import zero.zip.ZipFile;

	public class Fla{
		
		private static const DOMDocumentChildNameV:Vector.<String>=new Vector.<String>();
		public static const DOMDocumentChildName_FOLDERS:String="folders";
		DOMDocumentChildNameV.push(DOMDocumentChildName_FOLDERS);
		public static const DOMDocumentChildName_MEDIA:String="media";
		DOMDocumentChildNameV.push(DOMDocumentChildName_MEDIA);
		public static const DOMDocumentChildName_SYMBOLS:String="symbols";
		DOMDocumentChildNameV.push(DOMDocumentChildName_SYMBOLS);
		public static const DOMDocumentChildName_TIMELINES:String="timelines";
		DOMDocumentChildNameV.push(DOMDocumentChildName_TIMELINES);
		public static const DOMDocumentChildName_PRINTERSETTINGS:String="PrinterSettings";
		DOMDocumentChildNameV.push(DOMDocumentChildName_PRINTERSETTINGS);
		public static const DOMDocumentChildName_PUBLISHHISTORY:String="publishHistory";
		DOMDocumentChildNameV.push(DOMDocumentChildName_PUBLISHHISTORY);
		DOMDocumentChildNameV.fixed=true;
		
		public var zip:Zip;
		
		public var DOMDocumentXML:XML;
		public var PublishSettingsXML:XML;
		
		private var xmls:Object;//由于 xml 有命名空间使用起来很不方便，故使用此法
		
		public function Fla(){
		}
		
		public function clear():void{
			if(zip){
				zip.clear();
				zip=null;
			}
			xmls=null;
			DOMDocumentXML=null;
			PublishSettingsXML=null;
		}
		
		public function decode(flaData:ByteArray,_decodeOtions:Object=null):void{
			
			clear();
			
			zip=new Zip();
			zip.decode(flaData,"utf-8");
			
			xmls=new Object();
			
			DOMDocumentXML=getXML("DOMDocument.xml",5);
			PublishSettingsXML=new XML(zip.getFileByName("PublishSettings.xml").getText());
		}
		
		private function getXML(fileName:String,prettyIndent:int):XML{
			if(xmls[fileName]){
			}else{
				var str:String=zip.getFileByName(fileName).getText();
				var matchArr:Array=str.match(/(?:\s+xmlns(?:\:\w+)?\="[^"]+")+/);
				if(matchArr){
					var nsStrs:String=matchArr[0];
					str=str.replace(nsStrs,"");
				}else{
					nsStrs="";
				}
				xmls[fileName]={xml:new XML(str),nsStrs:nsStrs,prettyIndent:prettyIndent};
			}
			return xmls[fileName].xml;
		}
		public function encode(_encodeOtions:Object=null):ByteArray{
			
			var childArr:Array=new Array();
			for each(var child:XML in DOMDocumentXML.children()){
				var childOrder:int=DOMDocumentChildNameV.indexOf(child.name().toString());
				if(childOrder>-1){
					childArr[childOrder]=child;
				}else{
					throw "暂不支持的 DOMDocumentChildName："+child.name().toString();
				}
			}
			delete DOMDocumentXML.*;
			for(childOrder=0;childOrder<childArr.length;childOrder++){
				child=childArr[childOrder];
				if(child){
					DOMDocumentXML.appendChild(child);
				}
			}
			
			//写 xml
			var old_prettyIndent:int=XML.prettyIndent;
			
			for(var fileName:String in xmls){
				//trace("fileName="+fileName);
				var xmlObj:Object=xmls[fileName];
				XML.prettyIndent=xmlObj.prettyIndent;
				zip.getFileByName(fileName).setText(xmlObj.xml.toXMLString().replace(/^(<\w+)/,"$1"+xmlObj.nsStrs));
			}
			
			XML.prettyIndent=2;
			zip.getFileByName("PublishSettings.xml").setText('<flash_profiles>\n'+PublishSettingsXML.children().toXMLString()+'\n</flash_profiles>');
			
			XML.prettyIndent=old_prettyIndent;
			//
			
			return zip.encode();
			
		}
		
		public function get name():String{
			
			//可能会有多个 xfl，取修改时间最晚的
			for each(var file:ZipFile in zip.fileV){
				if(/^.*\.xfl$/i.test(file.name)){
					if(xflFile){
						if(xflFile.date.time<file.date.time){
							xflFile=file;
						}
					}else{
						var xflFile:ZipFile=file;
					}
				}
			}
			
			return xflFile.name.replace(/^(.*)\.xfl$/i,"$1");
		}
		public function set name(_name:String):void{
			
			var oldName:String=name;
			
			//可能会有多个 xfl，取修改时间最晚的
			for each(var file:ZipFile in zip.fileV){
				if(/^.*\.xfl$/i.test(file.name)){
					if(xflFile){
						if(xflFile.date.time<file.date.time){
							xflFile=file;
						}
					}else{
						var xflFile:ZipFile=file;
					}
				}
			}
			xflFile.name=_name+".xfl";
			
			var PublishFormatPropertiesXML:XML=PublishSettingsXML.flash_profile[0].PublishFormatProperties[0];
			
			if(PublishFormatPropertiesXML.flashFileName[0].toString()==oldName+".swf"){
				PublishFormatPropertiesXML.flashFileName=_name+".swf";
			}
			if(PublishFormatPropertiesXML.projectorWinFileName[0].toString()==oldName+".exe"){
				PublishFormatPropertiesXML.projectorWinFileName=_name+".exe";
			}
			if(PublishFormatPropertiesXML.projectorMacFileName[0].toString()==oldName+".app"){
				PublishFormatPropertiesXML.projectorMacFileName=_name+".app";
			}
			if(PublishFormatPropertiesXML.htmlFileName[0].toString()==oldName+".html"){
				PublishFormatPropertiesXML.htmlFileName=_name+".html";
			}
			if(PublishFormatPropertiesXML.gifFileName[0].toString()==oldName+".gif"){
				PublishFormatPropertiesXML.gifFileName=_name+".gif";
			}
			if(PublishFormatPropertiesXML.jpegFileName[0].toString()==oldName+".jpg"){
				PublishFormatPropertiesXML.jpegFileName=_name+".jpg";
			}
			if(PublishFormatPropertiesXML.pngFileName[0].toString()==oldName+".png"){
				PublishFormatPropertiesXML.pngFileName=_name+".png";
			}
			if(PublishFormatPropertiesXML.qtFileName[0].toString()==oldName+".mov"){
				PublishFormatPropertiesXML.qtFileName=_name+".mov";
			}
			if(PublishFormatPropertiesXML.rnwkFileName[0].toString()==oldName+".smil"){
				PublishFormatPropertiesXML.rnwkFileName=_name+".smil";
			}
			if(PublishFormatPropertiesXML.swcFileName[0].toString()==oldName+".swc"){
				PublishFormatPropertiesXML.swcFileName=_name+".swc";
			}
			
			var PublishHtmlPropertiesXML:XML=PublishSettingsXML.flash_profile[0].PublishHtmlProperties[0];
			
			if(PublishHtmlPropertiesXML.ContentFilename[0].toString()==oldName+"_content.html"){
				PublishHtmlPropertiesXML.ContentFilename=_name+"_content.html";
			}
			if(PublishHtmlPropertiesXML.AlternateFilename[0].toString()==oldName+"_alternate.html"){
				PublishHtmlPropertiesXML.AlternateFilename=_name+"_alternate.html";
			}
			
		}
		
		public function get exportSWFPath():String{
			var PublishFormatPropertiesXML:XML=PublishSettingsXML.flash_profile[0].PublishFormatProperties[0];
			return PublishFormatPropertiesXML.flashFileName[0].toString();
		}
		public function set exportSWFPath(_exportSWFPath:String):void{
			var PublishFormatPropertiesXML:XML=PublishSettingsXML.flash_profile[0].PublishFormatProperties[0];
			PublishFormatPropertiesXML.defaultNames=0;
			PublishFormatPropertiesXML.flashDefaultName=0;
			PublishFormatPropertiesXML.flashFileName=_exportSWFPath;
		}
		
		/**
		 * 
		 * "None","Deflate","LZMA"
		 * 
		 */
		public function get CompressionType():String{
			var PublishFlashPropertiesXML:XML=PublishSettingsXML.flash_profile[0].PublishFlashProperties[0];
			if(PublishFlashPropertiesXML.CompressMovie[0].toString()=="1"){
				if(PublishFlashPropertiesXML.CompressionType[0].toString()=="1"){
					return "LZMA";
				}
				return "Deflate";
			}
			return "None";
		}
		public function set CompressionType(_CompressionType:String):void{
			var PublishFlashPropertiesXML:XML=PublishSettingsXML.flash_profile[0].PublishFlashProperties[0];
			if(_CompressionType=="None"){
				PublishFlashPropertiesXML.CompressMovie="0";
			}else{
				PublishFlashPropertiesXML.CompressMovie="1";
				if(_CompressionType=="LZMA"){
					PublishFlashPropertiesXML.CompressionType="1";
				}else{
					PublishFlashPropertiesXML.CompressionType="0";
				}
			}
		}
		
		public function get width():int{
			if(DOMDocumentXML.@width.toString()){
			}else{
				DOMDocumentXML.@width=550;
			}
			return int(DOMDocumentXML.@width.toString());
		}
		public function set width(_width:int):void{
			DOMDocumentXML.@width=_width;
		}
		
		public function get height():int{
			if(DOMDocumentXML.@height.toString()){
			}else{
				DOMDocumentXML.@height=400;
			}
			return int(DOMDocumentXML.@height.toString());
		}
		public function set height(_height:int):void{
			DOMDocumentXML.@height=_height;
		}
		
		public function get frameRate():int{
			if(DOMDocumentXML.@frameRate.toString()){
			}else{
				DOMDocumentXML.@frameRate=24;
			}
			return int(DOMDocumentXML.@frameRate.toString());
		}
		public function set frameRate(_frameRate:int):void{
			DOMDocumentXML.@frameRate=_frameRate;
		}
		
		public function get backgroundColor():int{
			if(DOMDocumentXML.@backgroundColor.toString()){
			}else{
				DOMDocumentXML.@backgroundColor="#ffffff";
			}
			return int("0x"+DOMDocumentXML.@backgroundColor.toString().subsrt(1));
		}
		public function set backgroundColor(_backgroundColor:int):void{
			DOMDocumentXML.@backgroundColor="#"+(0x1000000+_backgroundColor).toString(16).substr(1);
		}
		
		public function getDOMDocumentChild(name:String):XML{
			var child:XML=DOMDocumentXML[name][0];
			if(child){
			}else{
				DOMDocumentXML.appendChild(child=<{name}/>);
			}
			return child;
		}
		public function getTimelineXML(sceneName:String):XML{
			for each(var DOMTimelineXML:XML in getDOMDocumentChild(DOMDocumentChildName_TIMELINES).DOMTimeline){
				if(DOMTimelineXML.@name.toString()==sceneName){
					return DOMTimelineXML;
				}
			}
			trace("找不到 DOMTimelineXML，sceneName="+sceneName);
			return null;
		}
		public function getMainTimelineLayerXML(sceneName:String,layerName:String):XML{
			var DOMTimelineXML:XML=getTimelineXML(sceneName);
			if(DOMTimelineXML){
				for each(var DOMLayerXML:XML in DOMTimelineXML.layers[0].DOMLayer){
					if(DOMLayerXML.@name.toString()==layerName){
						return DOMLayerXML;
					}
				}
				trace("找不到 DOMLayerXML，layerName="+layerName);
			}
			return null;
		}
		public function getItemLayerXML(namePath:String,layerName:String):XML{
			var itemFile:ZipFile=zip.getFileByName("LIBRARY/"+namePath+".xml");
			if(itemFile){
				for each(var DOMLayerXML:XML in getXML("LIBRARY/"+namePath+".xml",2).timeline[0].DOMTimeline[0].layers[0].DOMLayer){
					if(DOMLayerXML.@name.toString()==layerName){
						return DOMLayerXML;
					}
				}
				trace("找不到 DOMLayerXML，layerName="+layerName);
			}else{
				trace("找不到 item："+namePath);
			}
			return null;
		}
		
		public function addBitmapItem(
			imgData:ByteArray,
			namePath:String,
			fileURL:String,
			width:int,
			height:int
		):void{
			
			removeItem(namePath);
			
			fileURL=fileURL.replace(/\\/g,"/");
			
			var mediaXML:XML=getDOMDocumentChild(DOMDocumentChildName_MEDIA);
			
			var time:Number=new Date().time;
			var sourceLastImported:int=int(time/1000);
			var itemID:String=int(time/1000).toString(16)+"-"+(0x100000000+(time%1000)).toString(16).substr(1);//未考虑重复的 itemID
			//trace("itemID="+itemID);
			
			var itemXML:XML=<DOMBitmapItem
				name={namePath}
				itemID={itemID}
				sourceExternalFilepath={fileURL.replace("file:///","")}
				sourceLastImported={sourceLastImported}
				externalFileCRC32={MyCRC32.crc32(imgData)}
				externalFileSize={imgData.length}
				useImportedJPEGData="false"
				compressionType="lossless"
				originalCompressionType="lossless"
				quality="50"
				href={namePath}
				frameRight={width*20}
				frameBottom={height*20}
				isJPEG="true"
			/>;
			var type:String=FileTypes.getType(imgData,fileURL.replace(/^.*\/([^\/]+)$/,"$1"));
			switch(type){
				case FileTypes.JPG:
					delete itemXML.@useImportedJPEGData;
					delete itemXML.@compressionType;
					delete itemXML.@originalCompressionType;
				break;
				case FileTypes.PNG:
				case FileTypes.GIF:
					delete itemXML.@isJPEG;
				break;
				case FileTypes.BMP:
					delete itemXML.@isJPEG;
					throw "addBitmapItem() 暂不支持："+type+"（可能报错：读取文件时出现问题，一个或多个文件没有导入。无法将场景载入内存。 您的文件可能已损坏。）";
				break;
				default:
					throw "addBitmapItem() 不支持："+type;
				break;
			}
			mediaXML.appendChild(itemXML);
			//trace(mediaXML);
			zip.add(imgData,"LIBRARY/"+namePath);
		}
		public function removeItem(namePath:String):Boolean{
			var mediaXML:XML=getDOMDocumentChild(DOMDocumentChildName_MEDIA);
			var i:int=-1;
			for each(var itemXML:XML in mediaXML.children()){
				i++;
				if(itemXML.@name.toString()==namePath){
					delete mediaXML.children()[i];
					return true;
				}
			}
			return false;
		}
		
		public function addElement(DOMLayerXML:XML,frameId:int,namePathOrElementXML:*,matrix:Matrix=null):void{
			if(DOMLayerXML){
				for each(var DOMFrameXML:XML in DOMLayerXML.frames[0].DOMFrame){
					if(int(DOMFrameXML.@index.toString())==frameId){
						
						if(namePathOrElementXML is XML){
							var elementXML:XML=namePathOrElementXML;
						}else{
							var namePath:String=namePathOrElementXML;
							
							//根据 namePath 搜索库里对应的元件，目前只搜索 media 中的内容
							var mediaXML:XML=getDOMDocumentChild(DOMDocumentChildName_MEDIA);
							for each(var itemXML:XML in mediaXML.children()){
								if(itemXML.@name.toString()==namePath){
									switch(itemXML.name().toString()){
										case "DOMBitmapItem":
											var nodeName:String="DOMBitmapInstance";
										break;
									}
									break;
								}
							}
							//
							
							if(nodeName){
								elementXML=<{nodeName} libraryItemName={namePath}/>;
							}else{
								throw "nodeName="+nodeName;
							}
						}
						
						DOMFrameXML.elements[0].appendChild(elementXML);
						
						if(matrix){
							var matrixXML:XML=elementXML.matrix[0];
							if(matrixXML){
							}else{
								elementXML.appendChild(matrixXML=<matrix/>);
							}
							var MatrixXML:XML=matrixXML.Matrix[0];
							if(MatrixXML){
							}else{
								matrixXML.appendChild(MatrixXML=<Matrix/>);
							}
							MatrixXML.@a=matrix.a;
							MatrixXML.@b=matrix.b;
							MatrixXML.@c=matrix.c;
							MatrixXML.@d=matrix.d;
							MatrixXML.@tx=matrix.tx;
							MatrixXML.@ty=matrix.ty;
						}
						
						//trace("elementXML="+elementXML.toXMLString());
						
						return;
					}
				}
				trace("找不到 DOMFrameXML，frameId="+frameId);
			}else{
				trace("DOMLayerXML="+DOMLayerXML);
			}
		}
		
		public function removeBins():void{
			var i:int=zip.fileV.length;
			while(--i>=0){
				if(zip.fileV[i].name.indexOf("bin/")==0){
					zip.fileV.splice(i,1);
				}
			}
		}
		public function removePublishHistory():void{
			DOMDocumentXML.publishHistory=<publishHistory/>;
		}
		
		public function getSrcArr():Array{
			return PublishSettingsXML.flash_profile[0].PublishFlashProperties[0].AS3PackagePaths[0].toString().split(";");
		}
		
	}
}