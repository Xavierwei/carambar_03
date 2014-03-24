/***
DefineBits
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月24日 13:33:50（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//This tag defines a bitmap character with JPEG compression. It contains only the JPEG
//compressed image data (from the Frame Header onward). A separate JPEGTables tag contains
//the JPEG encoding data used to encode this image (the Tables/Misc segment).
//NOTE
//Only one JPEGTables tag is allowed in a SWF file, and thus all bitmaps defined with
//DefineBits must share common encoding tables.
//The data in this tag begins with the JPEG SOI marker 0xFF, 0xD8 and ends with the EOI
//marker 0xFF, 0xD9. Before version 8 of the SWF file format, SWF files could contain an
//erroneous header of 0xFF, 0xD9, 0xFF, 0xD8 before the JPEG SOI marker.
//The minimum file format version for this tag is SWF 1.
//
//DefineBits
//Field 			Type 					Comment
//Header 			RECORDHEADER (long) 	Tag type = 6
//CharacterID 		UI16 					ID for this character
//JPEGData 			UI8[image data size] 	JPEG compressed image

package zero.swf.tagBodys{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import zero.swf.BytesData;
	
	public class DefineBits{
		
		public var id:int;//UI16
		public var JPEGData:BytesData;
		
		public function DefineBits(){
			//id=0;
			//JPEGData=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			JPEGData=new BytesData();
			return JPEGData.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data.position=2;
			data.writeBytes(JPEGData.toData(_toDataOptions));
			
			return data;
			
		}
		
		//20120724
		/**
		* 
		* 获取图片数据
		* 
		*/
		public function getImgData(jpegTablesData:ByteArray):ByteArray{
			if(JPEGData){
				var imgData:ByteArray=new ByteArray();
				imgData.writeBytes(jpegTablesData);
				imgData.writeBytes(JPEGData.toData(null));
				var offset:int=0;
				var endOffset:int=imgData.length;
				var jpgData:ByteArray=new ByteArray();
				jpgData[0]=0xff;
				jpgData[1]=0xd8;
				jpgData.position=2;
				while(offset<endOffset){
					var blockStartOffset:int=offset;
					if(imgData[offset]==0xff){
						while(imgData[++offset]==0xff){}
						switch(imgData[offset++]){
							case 0xd8:
								//图像开始SOI(Start of Image)标记
							break;
							case 0xd9:
								//图像结束EOI(End of Image)
							break;
							case 0xda:
								//扫描开始SOS(Start of Scan)
								jpgData.writeBytes(imgData,blockStartOffset);
								return jpgData;
							break;
							default:
								var blockSize:int=(imgData[offset++]<<8)|imgData[offset++];
								offset+=blockSize-2;
								jpgData.writeBytes(imgData,blockStartOffset,offset-blockStartOffset);
							break;
						}
					}else{
						trace("imgData[offset]="+imgData[offset]);
						return imgData;//可能是 PNG 或 GIF
					}
				}
				throw new Error("找不到扫描开始标记ffda");
			}
			throw new Error("请先调用 initByData() 或 initByXML() 进行初始化");
		}
		
		public function getJPGWH(jpegTablesData:ByteArray):Array{
			if(JPEGData){
				var imgData:ByteArray=new ByteArray();
				imgData.writeBytes(jpegTablesData);
				imgData.writeBytes(JPEGData.toData(null));
				var offset:int=0;
				var endOffset:int=imgData.length;
				while(offset<endOffset){
					var blockStartOffset:int=offset;
					if(imgData[offset]==0xff){
						while(imgData[++offset]==0xff){}
						switch(imgData[offset++]){
							case 0xd8:
								//图像开始SOI(Start of Image)标记
							break;
							case 0xd9:
								//图像结束EOI(End of Image)
							break;
							case 0xc0:
								return [
									(imgData[offset+3]<<8)|imgData[offset+4],
									(imgData[offset+5]<<8)|imgData[offset+6]
								];
							break;
							case 0xda:
								//扫描开始SOS(Start of Scan)
								throw new Error("找不到标记ffc0");
							break;
							default:
								var blockSize:int=(imgData[offset++]<<8)|imgData[offset++];
								offset+=blockSize-2;
							break;
						}
					}else{
						trace("imgData[offset]="+imgData[offset]);
						throw new Error("不是 JPEG");
					}
				}
				throw new Error("找不到扫描开始标记ffda");
			}
			throw new Error("请先调用 initByData() 或 initByXML() 进行初始化");
		}
		
		/**
		 * 
		 * 同步解码为 BitmapData
		 * decoder 可以是 http://code.google.com/p/as3-jpeg-decoder/downloads/detail?name=jpeg-decoder.zip&can=2&q= 里的 JPEGDecoder
		 * 使用方法：
		 *  var jpegDecoder:Object={decode:function(imgData:ByteArray):BitmapData{
		 *		return new JPEGDecoder().parseAsBitmapData(imgData);//未考虑 imgData 可能是 PNG 或 GIF 的情况
		 *	}};
		 *  defineBitsJPEG2.decode(jpegDecoder);
		 * 
		 */
		public function decode(decoder:Object,jpegTablesData:ByteArray):BitmapData{
			if(JPEGData){
				return decoder.decode(getImgData(jpegTablesData));
			}
			throw new Error("请先调用 initByData() 或 initByXML() 进行初始化");
		}
		
		private var loader:Loader;
		private var onDecodeComplete:Function;
		/**
		 * 
		 * 异步解码为 BitmapData
		 */
		public function decodeAsync(jpegTablesData:ByteArray,_onDecodeComplete:Function):void{
			if(JPEGData){
				onDecodeComplete=_onDecodeComplete;
				
				var swfData:ByteArray=new ByteArray();
				
				swfData[0]=0x46;
				swfData[1]=0x57;
				swfData[2]=0x53;
				
				swfData[3]=0x09;
				
				swfData[8]=0x30;
				swfData[9]=0x0a;
				swfData[10]=0x00;
				swfData[11]=0xa0;
				
				swfData[12]=0x00;
				swfData[13]=0x01;
				
				swfData[14]=0x01;
				swfData[15]=0x00;
				
				//<FileAttributes class="zero.swf.tagBodys.FileAttributes" UseGPU="false" UseDirectBlit="false" HasMetadata="false" ActionScript3="true" suppressCrossDomainCaching="false" swfRelativeUrls="false" UseNetwork="false"/>
				swfData[16]=0x44;
				swfData[17]=0x11;
				swfData[18]=0x08;
				swfData[19]=0x00;
				swfData[20]=0x00;
				swfData[21]=0x00;
				
				//<SetBackgroundColor class="zero.swf.tagBodys.SetBackgroundColor" BackgroundColor="0x000000"/>
				swfData[22]=0x43;
				swfData[23]=0x02;
				swfData[24]=0x00;
				swfData[25]=0x00;
				swfData[26]=0x00;
				
				//JPEGTables
				swfData[27]=0x3f;
				swfData[28]=0x02;
				var jpegTablesDataSize:int=jpegTablesData.length;
				swfData[29]=jpegTablesDataSize;
				swfData[30]=jpegTablesDataSize>>8;
				swfData[31]=jpegTablesDataSize>>16;
				swfData[32]=jpegTablesDataSize>>24;
				swfData.position=33;
				swfData.writeBytes(jpegTablesData);
				
				//DefineBits
				swfData[swfData.length]=0xbf;
				swfData[swfData.length]=0x01;
				var thisData:ByteArray=this.toData(null);
				var thisDataSize:int=thisData.length;
				swfData[swfData.length]=thisDataSize;
				swfData[swfData.length]=thisDataSize>>8;
				swfData[swfData.length]=thisDataSize>>16;
				swfData[swfData.length]=thisDataSize>>24;
				swfData.position=swfData.length;
				swfData.writeBytes(thisData);
				
				//<PlaceObject3 class="zero.swf.tagBodys.PlaceObject3" PlaceFlagMove="false" PlaceFlagHasImage="true" Depth="1" CharacterId="1"/>
				swfData[swfData.length]=0x86;
				swfData[swfData.length]=0x11;
				swfData[swfData.length]=0x02;
				swfData[swfData.length]=0x10;
				swfData[swfData.length]=0x01;
				swfData[swfData.length]=0x00;
				swfData[swfData.length]=id;
				swfData[swfData.length]=id>>8;
				
				//<ShowFrame frame="1"/>
				swfData[swfData.length]=0x40;
				swfData[swfData.length]=0x00;
				
				//<End/>
				swfData[swfData.length]=0x00;
				swfData[swfData.length]=0x00;
				
				var swfDataSize:int=swfData.length;
				swfData[4]=swfDataSize;
				swfData[5]=swfDataSize>>8;
				swfData[6]=swfDataSize>>16;
				swfData[7]=swfDataSize>>24;
				
				loader=new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,decodeComplete);
				var loaderContext:LoaderContext=new LoaderContext();
				if(loaderContext.hasOwnProperty("allowCodeImport")){
					loaderContext["allowCodeImport"]=true;
					loader.loadBytes(swfData,loaderContext);
				}else{
					loader.loadBytes(swfData);
				}
			}else{
				throw new Error("请先调用 initByData() 或 initByXML() 进行初始化");
			}
		}
		private function decodeComplete(...args):void{
			var bmd:BitmapData=((loader.content as Sprite).getChildAt(0) as Bitmap).bitmapData;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,decodeComplete);
			loader.unloadAndStop();
			loader=null;
			if(onDecodeComplete==null){
			}else{
				var _onDecodeComplete:Function=onDecodeComplete;
				onDecodeComplete=null;
				_onDecodeComplete(bmd);
			}
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineBits"
					id={id}
				/>;
				
				xml.appendChild(JPEGData.toXML("JPEGData",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				JPEGData=new BytesData();
				JPEGData.initByXML(xml.JPEGData[0],_initByXMLOptions);
				
			}
		//}//end of CONFIG::USE_XML
	}
}