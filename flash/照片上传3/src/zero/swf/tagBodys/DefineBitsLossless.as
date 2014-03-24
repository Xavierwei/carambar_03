/***
DefineBitsLossless
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月25日 11:51:43（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineBitsLossless
//Defines a lossless bitmap character that contains RGB bitmap data compressed with ZLIB.
//The data format used by the ZLIB library is described by Request for Comments (RFCs)
//documents 1950 to 1952.
//Two kinds of bitmaps are supported. Colormapped images define a colormap of up to 256
//colors, each represented by a 24-bit RGB value, and then use 8-bit pixel values to index into
//the colormap. Direct images store actual pixel color values using 15 bits (32,768 colors) or 24
//bits (about 17 million colors).
//The minimum file format version for this tag is SWF 2.

//DefineBitsLossless
//Field 					Type 									Comment
//Header 					RECORDHEADER (long) 					Tag type = 20
//CharacterID 				UI16 									ID for this character
//BitmapFormat 				UI8 									Format of compressed data
//																	3 = 8-bit colormapped image
//																	4 = 15-bit RGB image
//																	5 = 24-bit RGB image
//BitmapWidth 				UI16 									Width of bitmap image
//BitmapHeight 				UI16 									Height of bitmap image
//BitmapColorTableSize 		If BitmapFormat = 3, UI8				This value is one less than the actual number of colors in the color table, allowing for up to 256 colors.
//							Otherwise absent
//
//ZlibBitmapData 			If BitmapFormat = 3, COLORMAPDATA		ZLIB compressed bitmap data
//							If BitmapFormat = 4 or 5, BITMAPDATA

package zero.swf.tagBodys{
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import zero.swf.BytesData;
	
	public class DefineBitsLossless{
		
		public var id:int;//UI16
		public var BitmapFormat:int;//UI8
		public var BitmapWidth:int;//UI16
		public var BitmapHeight:int;//UI16
		public var BitmapColorTableSize:int;//UI8
		public var ZlibBitmapData:BytesData;
		
		public function DefineBitsLossless(){
			//id=0;
			//BitmapFormat=0;
			//BitmapWidth=0;
			//BitmapHeight=0;
			BitmapColorTableSize=-1;
			//ZlibBitmapData=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			BitmapFormat=data[offset++];
			
			BitmapWidth=data[offset++]|(data[offset++]<<8);
			
			BitmapHeight=data[offset++]|(data[offset++]<<8);
			
			if(BitmapFormat==3){
				BitmapColorTableSize=data[offset++];
			}else{
				BitmapColorTableSize=-1;
			}
			
			ZlibBitmapData=new BytesData();
			return ZlibBitmapData.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data[2]=BitmapFormat;
			
			data[3]=BitmapWidth;
			data[4]=BitmapWidth>>8;
			
			data[5]=BitmapHeight;
			data[6]=BitmapHeight>>8;
			
			if(BitmapColorTableSize>-1){
				data[7]=BitmapColorTableSize;
			}
			
			data.position=data.length;
			data.writeBytes(ZlibBitmapData.toData(_toDataOptions));
			
			return data;
			
		}
		
		//20120724
		/**
		 * 
		 * 获取图片数据
		 * encoder 可以是 zero.codec.BMPEncoder，zero.codec.PNGEncoder，zero.codec.JPEGEncoder，new mx.graphics.codec.PNGEncoder() 等
		 * 如不传入 encoder，则使用默认的 BitmapData.encode()，但需要 flash player 11.3 及添加编译器参数：-swf-version 16（>=16）
		 * 
		 */
		public function getImgData(encoder:Object=null):ByteArray{
			if(ZlibBitmapData){
				var bmd:BitmapData=decode();
				if(encoder){
					return encoder.encode(bmd);
				}
				if(bmd.hasOwnProperty("encode")){
					return bmd["encode"](bmd.rect,new (getDefinitionByName("flash.display.PNGEncoderOptions"))());
				}
				throw new Error("请传入 encoder，或添加编译器参数：-swf-version 16（>=16）使支持 BitmapData.encode");
			}
			throw new Error("请先调用 initByData() 或 initByXML() 进行初始化");
		}
		
		/**
		 * 
		 * 同步解码为 BitmapData
		 */
		public function decode():BitmapData{
			if(ZlibBitmapData){
				var bmd:BitmapData=new BitmapData(BitmapWidth,BitmapHeight,false);
				var bmpData:ByteArray=ZlibBitmapData.toData(null);
				bmpData.uncompress();
				switch(BitmapFormat){
					case 3:
						//trace(BytesAndStr16.bytes2str16(bmpData,0,bmpData.length));
						//00 00 00  80 00 00  00 80 00  80 80 00 ...
						//ff ff ff ff ff ff ff ff ff ff ff ff ff 00 00 00 
						//ff f6 f6 ef ef ef ef ef ef f6 ff ff ff 00 00 00 
						//ff f6 af 9f 9f 9f 9f 9f a7 ef ff ff ff 00 00 00 
						//ff f6 f6 ef ef ef ef ef f6 f6 ff ff ff 00 00 00 
						//ff ff ff f6 08 08 08 08 08 08 f6 ff ff 00 00 00 
						//ff ff f6 08 08 08 08 f4 bc bc 08 ff ff 00 00 00 
						//ff ff ff f6 08 08 08 08 08 08 f6 ff ff 00 00 00 
						//ff ff ff ff ff ff ff ff ff ff ff ff ff 00 00 00 
						//ff ff f6 09 09 09 09 09 09 09 09 f6 ff 00 00 00 
						//ff ff f6 09 09 09 e4 e4 e4 e4 e4 f6 ff 00 00 00 
						//ff ff ff ff f6 f6 f6 f6 f6 f6 f6 f6 ff 00 00 00
						var pos:int=0;
						var BitmapColorTableArr:Array=new Array();
						for(var BitmapColorId:int=0;BitmapColorId<=BitmapColorTableSize;BitmapColorId++){
							BitmapColorTableArr[BitmapColorId]=(bmpData[pos++]<<16)|(bmpData[pos++]<<8)|bmpData[pos++];
						}
						var bmdBytesId:int=0;
						var bmdBytes:ByteArray=new ByteArray();
						var rest:int=(4-(BitmapWidth%4))%4;
						for(var y:int=0;y<BitmapHeight;y++){
							for(var x:int=0;x<BitmapWidth;x++){
								var color:int=BitmapColorTableArr[bmpData[pos++]];
								bmdBytes[bmdBytesId++]=0xff;
								bmdBytes[bmdBytesId++]=color>>16;//r
								bmdBytes[bmdBytesId++]=color>>8;//g
								bmdBytes[bmdBytesId++]=color;//b
							}
							pos+=rest;//在获取像素时保持在行末是4个字节的整数倍
						}
						bmd.setPixels(bmd.rect,bmdBytes);
					break;
					case 4:
						//trace(BytesAndStr16.bytes2str16(bmpData,0,bmpData.length));
						//7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 00 00 
						//7f ff 7f bd 7f 7b 7f 39 7e f7 7e f7 7e b5 7e b5 7e b5 7f 7b 7f ff 7f ff 7f ff 00 00 
						//7f ff 7f bd 7e 73 7d 8c 7d 8c 7d 8c 7d 8c 7d 8c 7d ce 7e f7 7f ff 7f ff 7f ff 00 00 
						//7f ff 7f bd 7f 7b 7f 39 7f 39 7f 39 7f 39 7f 39 7f 7b 7f bd 7f ff 7f ff 7f ff 00 00 
						//7f ff 7f ff 7f ff 6f fd 67 fb 67 fb 67 fb 67 fb 67 fb 67 fb 6f fd 7f ff 7f ff 00 00 
						//7f ff 7f ff 77 fd 5f fb 47 f7 47 f7 47 f7 3b f7 3b f5 3b f5 57 f9 77 ff 7f ff 00 00 
						//7f ff 7f ff 7f ff 6f fd 67 fb 67 fb 67 fb 67 fb 5f fb 67 fb 6f fd 7f ff 7f ff 00 00 
						//7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 7f ff 00 00 
						//7f ff 7f ff 77 bf 67 3f 5e ff 56 bf 56 bf 56 bf 56 bf 56 bf 5e ff 77 bf 7f ff 00 00 
						//7f ff 7f ff 77 bf 5e ff 4e 7f 4e 7f 46 3f 46 3f 46 3f 46 3f 46 3f 6f 7f 7f ff 00 00 
						//7f ff 7f ff 7f ff 7f ff 77 bf 77 bf 6f 7f 6f 7f 6f 7f 6f 7f 6f 7f 77 bf 7f ff 00 00
						pos=0;
						bmdBytesId=0;
						bmdBytes=new ByteArray();
						for(y=0;y<BitmapHeight;y++){
							for(x=0;x<BitmapWidth;x++){
								var colorData2:int=bmpData[pos++];
								var colorData1:int=bmpData[pos++];
								bmdBytes[bmdBytesId++]=0xff;
								bmdBytes[bmdBytesId++]=Math.round(((colorData2<<25)>>>27)*8.225806451612904);//r
								bmdBytes[bmdBytesId++]=Math.round((((colorData2<<30)>>>27)|(colorData1>>>5))*8.225806451612904);//g
								bmdBytes[bmdBytesId++]=Math.round((colorData1&0x1f)*8.225806451612904);//b
							}
							if(BitmapWidth%2){
								pos+=2;//在获取像素时保持在行末是4个字节的整数倍
							}
						}
						bmd.setPixels(bmd.rect,bmdBytes);
					break;
					case 5:
						//trace(BytesAndStr16.bytes2str16(bmpData,0,bmpData.length));
						//ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
						//ff ff ff ff ff ff ee ee ff ff dd dd ff ff cc cc ff ff bb bb ff ff bb bb ff ff aa aa ff ff aa aa ff ff aa aa ff ff dd dd ff ff ff ff ff ff ff ff ff ff ff ff 
						//ff ff ff ff ff ff ee ee ff ff 99 99 ff ff 66 66 ff ff 66 66 ff ff 66 66 ff ff 66 66 ff ff 66 66 ff ff 77 77 ff ff bb bb ff ff ff ff ff ff ff ff ff ff ff ff 
						//ff ff ff ff ff ff ee ee ff ff dd dd ff ff cc cc ff ff cc cc ff ff cc cc ff ff cc cc ff ff cc cc ff ff dd dd ff ff ee ee ff ff ff ff ff ff ff ff ff ff ff ff 
						//ff ff ff ff ff ff ff ff ff ff ff ff ff dd ff ee ff cc ff dd ff cc ff dd ff cc ff dd ff cc ff dd ff cc ff dd ff cc ff dd ff dd ff ee ff ff ff ff ff ff ff ff 
						//ff ff ff ff ff ff ff ff ff ee ff ee ff bb ff dd ff 88 ff bb ff 88 ff bb ff 88 ff bb ff 77 ff bb ff 77 ff aa ff 77 ff aa ff aa ff cc ff ee ff ff ff ff ff ff 
						//ff ff ff ff ff ff ff ff ff ff ff ff ff dd ff ee ff cc ff dd ff cc ff dd ff cc ff dd ff cc ff dd ff bb ff dd ff cc ff dd ff dd ff ee ff ff ff ff ff ff ff ff 
						//ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
						//ff ff ff ff ff ff ff ff ff ee ee ff ff cc cc ff ff bb bb ff ff aa aa ff ff aa aa ff ff aa aa ff ff aa aa ff ff aa aa ff ff bb bb ff ff ee ee ff ff ff ff ff 
						//ff ff ff ff ff ff ff ff ff ee ee ff ff bb bb ff ff 99 99 ff ff 99 99 ff ff 88 88 ff ff 88 88 ff ff 88 88 ff ff 88 88 ff ff 88 88 ff ff dd dd ff ff ff ff ff 
						//ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ee ee ff ff ee ee ff ff dd dd ff ff dd dd ff ff dd dd ff ff dd dd ff ff dd dd ff ff ee ee ff ff ff ff ff
						bmd.setPixels(bmd.rect,bmpData);
					break;
					default:
						throw new Error("未知 BitmapFormat："+BitmapFormat);
					break;
				}
				return bmd;
			}
			throw new Error("请先调用 initByData() 或 initByXML() 进行初始化");
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineBitsLossless"
					id={id}
					BitmapFormat={BitmapFormat}
					BitmapWidth={BitmapWidth}
					BitmapHeight={BitmapHeight}
				/>;
				
				if(BitmapColorTableSize>-1){
					xml.@BitmapColorTableSize=BitmapColorTableSize;
				}
				
				xml.appendChild(ZlibBitmapData.toXML("ZlibBitmapData",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				BitmapFormat=int(xml.@BitmapFormat.toString());
				
				BitmapWidth=int(xml.@BitmapWidth.toString());
				
				BitmapHeight=int(xml.@BitmapHeight.toString());
				
				var BitmapColorTableSizeXML:XML=xml.@BitmapColorTableSize[0];
				if(BitmapColorTableSizeXML){
					BitmapColorTableSize=int(BitmapColorTableSizeXML.toString());
				}else{
					BitmapColorTableSize=-1;
				}
				
				ZlibBitmapData=new BytesData();
				ZlibBitmapData.initByXML(xml.ZlibBitmapData[0],_initByXMLOptions);
				
			}
		//}//end of CONFIG::USE_XML
	}
}