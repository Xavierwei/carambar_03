/***
BMPEncoder 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2009年2月7日 16:25:01
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package zero.codec{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;

	public class BMPEncoder{
		
		public static const A8R8G8B8:String="A8R8G8B8";
		public static const X8R8G8B8:String="X8R8G8B8";
		
		public static const R8G8B8:String="R8G8B8";
		
		public static const A1R5G5B5:String="A1R5G5B5";
		public static const X1R5G5B5:String="X1R5G5B5";
		public static const A4R4G4B4:String="A4R4G4B4";
		public static const X4R4G4B4:String="X4R4G4B4";
		public static const R5G6B5:String="R5G6B5";
		
		public static const BIT8:String="BIT8";
		public static const BIT8RLE:String="BIT8RLE";
		
		public static const BIT4:String="BIT4";
		public static const BIT4RLE:String="BIT4RLE";
		
		public static const BIT1:String="BIT1";
		
		public static function encode(
			bmd:BitmapData,
			biBitCountOrMode:*=24,
			isRev:Boolean=false
		):ByteArray{
			var biWidth:int=bmd.width;
			var biHeight:int=bmd.height;
			var bmpData:ByteArray=new ByteArray();
			
			//BMP文件头
			//typedef struct tagBITMAPFILEHEADER {
			//	WORD	bfType;			// 位图文件的类型，必须为BM
			//	DWORD	bfSize;			// 位图文件的大小，以字节为单位
			//	WORD	bfReserved1;	// 位图文件保留字，必须为0
			//	WORD	bfReserved2;	// 位图文件保留字，必须为0
			//	DWORD	bfOffBits;		// 位图数据的起始位置，以相对于位图文件头的偏移量表示，以字节为单位
			//} BITMAPFILEHEADER, *PBITMAPFILEHEADER;
			//
			//|.BM.|....大小...|..0..|..0..|
			//42 4d b6 70 06 00 00 00 00 00
			
			//bfType="BM"
			bmpData[0]=0x42;
			bmpData[1]=0x4d;
			
			//bfSize
			//bmpData[2]=0;
			//bmpData[3]=0;
			//bmpData[4]=0;
			//bmpData[5]=0;
			
			//bfReserved1
			bmpData[6]=0;
			bmpData[7]=0;
			//bfReserved2
			bmpData[8]=0;
			bmpData[9]=0;
			
			//bfOffBits
			//bmpData[10]=0;
			//bmpData[11]=0;
			//bmpData[12]=0;
			//bmpData[13]=0;
			
			
			//位图信息头
			//typedef struct tagBITMAPINFOHEADER{
			//	DWORD	biSize; //本结构所占用字节数
			//	LONG	biWidth; //位图的宽度
			//	LONG	biHeight; //位图的高度
			//	WORD	biPlanes; //永远为1 ,由于没有用过所以 没做研究 附msdn解释 Specifies the number of planes for the target device. This value must be set to 1. 
			//	WORD	biBitCount;//位图的位数  分为1 4 8 16 24 32 本文没对1 4 进行研究
			//	DWORD	biCompression; //本意为压缩类型，但是却另外有作用，稍候解释
			//	DWORD	biSizeImage; //表示位图数据区域的大小以字节为单位
			//	LONG	biXPelsPerMeter;//位图水平分辨率，每米像素数
			//	LONG	biYPelsPerMeter;//位图垂直分辨率，每米像素数
			//	DWORD	biClrUsed;//ColorsUsed 位图实际使用的颜色表中的颜色数
			//	DWORD	biClrImportant;//ColorsImportant 位图显示过程中重要的颜色数
			//} BITMAPINFOHEADER, *PBITMAPINFOHEADER;
			
			//biSize
			//bmpData[14]=0;
			//bmpData[15]=0;
			//bmpData[16]=0;
			//bmpData[17]=0;
			
			//biWidth
			bmpData[18]=biWidth;
			bmpData[19]=biWidth>>8;
			bmpData[20]=biWidth>>16;//因为BitmapData最大只能到2880,所以这个其实总是0
			bmpData[21]=biWidth>>24;//因为BitmapData最大只能到2880,所以这个其实总是0
			
			//biHeight
			var uBiHeight:int=isRev?-biHeight:biHeight;
			bmpData[22]=uBiHeight;
			bmpData[23]=uBiHeight>>8;
			bmpData[24]=uBiHeight>>16;
			bmpData[25]=uBiHeight>>24;
			
			//biPlanes
			bmpData[26]=1;
			bmpData[27]=0;
			
			//biBitCount
			//bmpData[28]=0;
			//bmpData[29]=0;
			
			//biCompression
			//bmpData[30]=0;
			//bmpData[31]=0;
			//bmpData[32]=0;
			//bmpData[33]=0;
			
			//biSizeImage
			//bmpData[34]=0;
			//bmpData[35]=0;
			//bmpData[36]=0;
			//bmpData[37]=0;
			
			//biXPelsPerMeter
			bmpData[38]=0x12;
			bmpData[39]=0x0b;
			bmpData[40]=0;
			bmpData[41]=0;
			
			//biYPelsPerMeter
			bmpData[42]=0x12;
			bmpData[43]=0x0b;
			bmpData[44]=0;
			bmpData[45]=0;
			
			//biClrUsed
			bmpData[46]=0;
			bmpData[47]=0;
			bmpData[48]=0;
			bmpData[49]=0;
			
			//biClrImportant
			bmpData[50]=0;
			bmpData[51]=0;
			bmpData[52]=0;
			bmpData[53]=0;
			
			var pos:int,bfOffBits:int;
			var rest:int;
			var x:int,y:int;
			
			var bmdBytes:ByteArray;
			if(isRev){
				bmdBytes=bmd.getPixels(bmd.rect);
			}else{
				var bmdCopy:BitmapData=bmd.clone();
				bmdCopy.draw(bmd,new Matrix(1,0,0,-1,0,biHeight));
				bmdBytes=bmdCopy.getPixels(bmd.rect);
				bmdCopy.dispose();
				bmdCopy=null;
			}
			
			//trace("biBitCountOrMode="+biBitCountOrMode);
			
			var colorData:int;
			var bmdBytesId:int=0;
			switch(biBitCountOrMode){
				case 32:
				case A8R8G8B8:
					
					//bfOffBits
					bfOffBits=54;
					bmpData[10]=54;
					bmpData[11]=0;
					bmpData[12]=0;
					bmpData[13]=0;
					
					//biSize
					bmpData[14]=40;
					bmpData[15]=0;
					bmpData[16]=0;
					bmpData[17]=0;
					
					//biBitCount
					bmpData[28]=32;
					bmpData[29]=0;
					
					//设置像素值
					pos=bfOffBits;
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							bmpData[pos++]=bmdBytes[bmdBytesId+3];//b
							bmpData[pos++]=bmdBytes[bmdBytesId+2];//g
							bmpData[pos++]=bmdBytes[bmdBytesId+1];//r
							bmpData[pos++]=0x00;
							bmdBytesId+=4;
						}
					}
				break;
				case X8R8G8B8:
					
					//bfOffBits
					bfOffBits=70;
					bmpData[10]=70;
					bmpData[11]=0;
					bmpData[12]=0;
					bmpData[13]=0;
					
					//biSize
					bmpData[14]=56;
					bmpData[15]=0;
					bmpData[16]=0;
					bmpData[17]=0;
					
					//biBitCount
					bmpData[28]=32;
					bmpData[29]=0;
					
					//biCompression
					bmpData[30]=3;
					bmpData[31]=0;
					bmpData[32]=0;
					bmpData[33]=0;
					
					//mask1
					bmpData[54]=0x00;
					bmpData[55]=0x00;
					bmpData[56]=0x00;
					bmpData[57]=0xff;
					//mask2
					bmpData[58]=0x00;
					bmpData[59]=0x00;
					bmpData[60]=0xff;
					bmpData[61]=0x00;
					//mask3
					bmpData[62]=0x00;
					bmpData[63]=0xff;
					bmpData[64]=0x00;
					bmpData[65]=0x00;
					
					//不知道是啥
					bmpData[66]=0x00;
					bmpData[67]=0x00;
					bmpData[68]=0x00;
					bmpData[69]=0x00;
					
					//设置像素值
					pos=bfOffBits;
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							bmpData[pos++]=0x00;
							bmpData[pos++]=bmdBytes[bmdBytesId+3];//b
							bmpData[pos++]=bmdBytes[bmdBytesId+2];//g
							bmpData[pos++]=bmdBytes[bmdBytesId+1];//r
							bmdBytesId+=4;
						}
					}
				break;
				case 24:
				case R8G8B8:
					
					//bfOffBits
					bfOffBits=54;
					bmpData[10]=54;
					bmpData[11]=0;
					bmpData[12]=0;
					bmpData[13]=0;
					
					//biSize
					bmpData[14]=40;
					bmpData[15]=0;
					bmpData[16]=0;
					bmpData[17]=0;
					
					//biBitCount
					bmpData[28]=24;
					bmpData[29]=0;
					
					//设置像素值
					pos=bfOffBits;
					rest=(4-((biWidth*3)%4))%4;//在设置像素时保持在行末是4个字节的整数倍
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							bmpData[pos++]=bmdBytes[bmdBytesId+3];//b
							bmpData[pos++]=bmdBytes[bmdBytesId+2];//g
							bmpData[pos++]=bmdBytes[bmdBytesId+1];//r
							bmdBytesId+=4;
						}
						pos+=rest;
					}
				break;
				case 16:
				case A1R5G5B5:
					
					//bfOffBits
					bfOffBits=70;
					bmpData[10]=70;
					bmpData[11]=0;
					bmpData[12]=0;
					bmpData[13]=0;
					
					//biSize
					bmpData[14]=56;
					bmpData[15]=0;
					bmpData[16]=0;
					bmpData[17]=0;
					
					//biBitCount
					bmpData[28]=16;
					bmpData[29]=0;
					
					//biCompression
					bmpData[30]=3;
					bmpData[31]=0;
					bmpData[32]=0;
					bmpData[33]=0;
					
					//mask1
					bmpData[54]=0x00;
					bmpData[55]=0x7c;
					bmpData[56]=0x00;
					bmpData[57]=0x00;
					//mask2
					bmpData[58]=0xe0;
					bmpData[59]=0x03;
					bmpData[60]=0x00;
					bmpData[61]=0x00;
					//mask3
					bmpData[62]=0x1f;
					bmpData[63]=0x00;
					bmpData[64]=0x00;
					bmpData[65]=0x00;
					
					//不知道是啥
					bmpData[66]=0x00;
					bmpData[67]=0x80;
					bmpData[68]=0x00;
					bmpData[69]=0x00;
					
					//设置像素值
					//0x00~0x1f ==> 0x00~0xff
					//8.225806451612904==0xff/0x1f
					pos=bfOffBits;
					rest=(4-((biWidth*2)%4))%4;//在设置像素时保持在行末是4个字节的整数倍
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							bmdBytesId++;
							colorData=
								(Math.round(bmdBytes[bmdBytesId++]/8.225806451612904)<<10)//r
								|
								((Math.round(bmdBytes[bmdBytesId++]/8.225806451612904))<<5)//g
								|
								Math.round(bmdBytes[bmdBytesId++]/8.225806451612904)//b
							;
							bmpData[pos++]=colorData;
							bmpData[pos++]=colorData>>8;
						}
						pos+=rest;
					}
				break;
				case X1R5G5B5:
					
					if(isRev){
						//bfOffBits
						bfOffBits=70;
						bmpData[10]=70;
						bmpData[11]=0;
						bmpData[12]=0;
						bmpData[13]=0;
						
						//biSize
						bmpData[14]=56;
						bmpData[15]=0;
						bmpData[16]=0;
						bmpData[17]=0;
						
						//biBitCount
						bmpData[28]=16;
						bmpData[29]=0;
						
						//biCompression
						bmpData[30]=3;
						bmpData[31]=0;
						bmpData[32]=0;
						bmpData[33]=0;
						
						//mask1
						bmpData[54]=0x00;
						bmpData[55]=0x7c;
						bmpData[56]=0x00;
						bmpData[57]=0x00;
						//mask2
						bmpData[58]=0xe0;
						bmpData[59]=0x03;
						bmpData[60]=0x00;
						bmpData[61]=0x00;
						//mask3
						bmpData[62]=0x1f;
						bmpData[63]=0x00;
						bmpData[64]=0x00;
						bmpData[65]=0x00;
						
						//不知道是啥
						bmpData[66]=0x00;
						bmpData[67]=0x80;
						bmpData[68]=0x00;
						bmpData[69]=0x00;
					}else{
						//bfOffBits
						bfOffBits=54;
						bmpData[10]=54;
						bmpData[11]=0;
						bmpData[12]=0;
						bmpData[13]=0;
						
						//biSize
						bmpData[14]=40;
						bmpData[15]=0;
						bmpData[16]=0;
						bmpData[17]=0;
						
						//biBitCount
						bmpData[28]=16;
						bmpData[29]=0;
					}
					
					//设置像素值
					//0x00~0x1f ==> 0x00~0xff
					//8.225806451612904==0xff/0x1f
					pos=bfOffBits;
					rest=(4-((biWidth*2)%4))%4;//在设置像素时保持在行末是4个字节的整数倍
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							bmdBytesId++;
							colorData=
								(Math.round(bmdBytes[bmdBytesId++]/8.225806451612904)<<10)//r
								|
								((Math.round(bmdBytes[bmdBytesId++]/8.225806451612904))<<5)//g
								|
								Math.round(bmdBytes[bmdBytesId++]/8.225806451612904)//b
							;
							bmpData[pos++]=colorData;
							bmpData[pos++]=colorData>>8;
						}
						pos+=rest;
					}
				break;
				case A4R4G4B4:
					//bfOffBits
					bfOffBits=70;
					bmpData[10]=70;
					bmpData[11]=0;
					bmpData[12]=0;
					bmpData[13]=0;
					
					//biSize
					bmpData[14]=56;
					bmpData[15]=0;
					bmpData[16]=0;
					bmpData[17]=0;
					
					//biBitCount
					bmpData[28]=16;
					bmpData[29]=0;
					
					//biCompression
					bmpData[30]=3;
					bmpData[31]=0;
					bmpData[32]=0;
					bmpData[33]=0;
					
					//mask1
					bmpData[54]=0x00;
					bmpData[55]=0x0f;
					bmpData[56]=0x00;
					bmpData[57]=0x00;
					//mask2
					bmpData[58]=0xf0;
					bmpData[59]=0x00;
					bmpData[60]=0x00;
					bmpData[61]=0x00;
					//mask3
					bmpData[62]=0x0f;
					bmpData[63]=0x00;
					bmpData[64]=0x00;
					bmpData[65]=0x00;
					
					//不知道是啥
					bmpData[66]=0x00;
					bmpData[67]=0xf0;
					bmpData[68]=0x00;
					bmpData[69]=0x00;
					
					//设置像素值
					//0x00~0x0f ==> 0x00~0xff
					//17==0xff/0x0f
					pos=bfOffBits;
					rest=(4-((biWidth*2)%4))%4;//在设置像素时保持在行末是4个字节的整数倍
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							bmpData[pos++]=
								Math.round(bmdBytes[bmdBytesId+3]/17)//b
								|
								(Math.round(bmdBytes[bmdBytesId+2]/17)<<4)//g
							;
							bmpData[pos++]=Math.round(bmdBytes[bmdBytesId+1]/17);//r
							bmdBytesId+=4;
						}
						pos+=rest;
					}
				break;
				case X4R4G4B4:
					//bfOffBits
					bfOffBits=70;
					bmpData[10]=70;
					bmpData[11]=0;
					bmpData[12]=0;
					bmpData[13]=0;
					
					//biSize
					bmpData[14]=56;
					bmpData[15]=0;
					bmpData[16]=0;
					bmpData[17]=0;
					
					//biBitCount
					bmpData[28]=16;
					bmpData[29]=0;
					
					//biCompression
					bmpData[30]=3;
					bmpData[31]=0;
					bmpData[32]=0;
					bmpData[33]=0;
					
					//mask1
					bmpData[54]=0x00;
					bmpData[55]=0x0f;
					bmpData[56]=0x00;
					bmpData[57]=0x00;
					//mask2
					bmpData[58]=0xf0;
					bmpData[59]=0x00;
					bmpData[60]=0x00;
					bmpData[61]=0x00;
					//mask3
					bmpData[62]=0x0f;
					bmpData[63]=0x00;
					bmpData[64]=0x00;
					bmpData[65]=0x00;
					
					//不知道是啥
					bmpData[66]=0x00;
					bmpData[67]=0x00;
					bmpData[68]=0x00;
					bmpData[69]=0x00;
					
					//设置像素值
					//0x00~0x0f ==> 0x00~0xff
					//17==0xff/0x0f
					pos=bfOffBits;
					rest=(4-((biWidth*2)%4))%4;//在设置像素时保持在行末是4个字节的整数倍
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							bmpData[pos++]=
								Math.round(bmdBytes[bmdBytesId+3]/17)//b
								|
								(Math.round(bmdBytes[bmdBytesId+2]/17)<<4)//g
							;
							bmpData[pos++]=Math.round(bmdBytes[bmdBytesId+1]/17);//r
							bmdBytesId+=4;
						}
						pos+=rest;
					}
				break;
				case R5G6B5:
					//bfOffBits
					bfOffBits=70;
					bmpData[10]=70;
					bmpData[11]=0;
					bmpData[12]=0;
					bmpData[13]=0;
					
					//biSize
					bmpData[14]=56;
					bmpData[15]=0;
					bmpData[16]=0;
					bmpData[17]=0;
					
					//biBitCount
					bmpData[28]=16;
					bmpData[29]=0;
					
					//biCompression
					bmpData[30]=3;
					bmpData[31]=0;
					bmpData[32]=0;
					bmpData[33]=0;
					
					//mask1
					bmpData[54]=0x00;
					bmpData[55]=0xf8;
					bmpData[56]=0x00;
					bmpData[57]=0x00;
					//mask2
					bmpData[58]=0xe0;
					bmpData[59]=0x07;
					bmpData[60]=0x00;
					bmpData[61]=0x00;
					//mask3
					bmpData[62]=0x1f;
					bmpData[63]=0x00;
					bmpData[64]=0x00;
					bmpData[65]=0x00;
					
					//不知道是啥
					bmpData[66]=0x00;
					bmpData[67]=0x00;
					bmpData[68]=0x00;
					bmpData[69]=0x00;
					
					//设置像素值
					//0x00~0x1f ==> 0x00~0xff
					//8.225806451612904==0xff/0x1f
					//4.0476190476190474====0xff/0x3f
					pos=bfOffBits;
					rest=(4-((biWidth*2)%4))%4;//在设置像素时保持在行末是4个字节的整数倍
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							bmdBytesId++;
							colorData=
								(Math.round(bmdBytes[bmdBytesId++]/8.225806451612904)<<11)//r
								|
								((Math.round(bmdBytes[bmdBytesId++]/4.0476190476190474))<<5)//g
								|
								Math.round(bmdBytes[bmdBytesId++]/8.225806451612904)//b
							;
							bmpData[pos++]=colorData;
							bmpData[pos++]=colorData>>8;
						}
						pos+=rest;
					}
				break;
				case 8:
				case BIT8:
				case BIT8RLE:
					throw new Error("暂不支持对8位位图的编码");
				break;
				case 4:
				case BIT4:
				case BIT4RLE:
					throw new Error("暂不支持对4位位图的编码");
				break;
				case 1:
				case BIT1:
					throw new Error("暂不支持对1位位图的编码");
				break;
			}
			
			bmdBytesId=4-(pos%4);
			while(--bmdBytesId>=0){
				bmpData[pos++]=0;
			}
			
			var bfSize:int=bmpData.length;
			bmpData[2]=bfSize;
			bmpData[3]=bfSize>>8;
			bmpData[4]=bfSize>>16;
			bmpData[5]=bfSize>>24;
			
			var biSizeImage:int=bfSize-bfOffBits;
			bmpData[34]=biSizeImage;
			bmpData[35]=biSizeImage>>8;
			bmpData[36]=biSizeImage>>16;
			bmpData[37]=biSizeImage>>24;
			
			return bmpData;
		}
		public static function getWidth(bmpData:ByteArray):int{
			return bmpData[18]|(bmpData[19]<<8)|(bmpData[20]<<16)|(bmpData[21]<<24);
		}
		public static function getHeight(bmpData:ByteArray):int{
			return bmpData[22]|(bmpData[23]<<8)|(bmpData[24]<<16)|(bmpData[25]<<24);
		}
		public static function decode(bmpData:ByteArray,clipX:int=0,clipY:int=0,clipWidth:int=0,clipHeight:int=0):BitmapData{
			
			//BMP文件头
			//typedef struct tagBITMAPFILEHEADER {
			//	WORD	bfType;			// 位图文件的类型，必须为BM
			//	DWORD	bfSize;			// 位图文件的大小，以字节为单位
			//	WORD	bfReserved1;	// 位图文件保留字，必须为0
			//	WORD	bfReserved2;	// 位图文件保留字，必须为0
			//	DWORD	bfOffBits;		// 位图数据的起始位置，以相对于位图文件头的偏移量表示，以字节为单位
			//} BITMAPFILEHEADER, *PBITMAPFILEHEADER;
			//
			//|.BM.|....大小...|..0..|..0..|
			//42 4d b6 70 06 00 00 00 00 00
			
			if(
				bmpData[0]==0x42
				&&
				bmpData[1]==0x4d
			){
				//0x42,0x4d----66,77----BM
			}else{
				throw new Error("不是有效的位图文件");
			}
			
			//位图信息头
			//typedef struct tagBITMAPINFOHEADER{
			//	DWORD	biSize; //本结构所占用字节数
			//	LONG	biWidth; //位图的宽度
			//	LONG	biHeight; //位图的高度
			//	WORD	biPlanes; //永远为1 ,由于没有用过所以 没做研究 附msdn解释 Specifies the number of planes for the target device. This value must be set to 1. 
			//	WORD	biBitCount;//位图的位数  分为1 4 8 16 24 32 本文没对1 4 进行研究
			//	DWORD	biCompression; //本意为压缩类型，但是却另外有作用，稍候解释
			//	DWORD	biSizeImage; //表示位图数据区域的大小以字节为单位
			//	LONG	biXPelsPerMeter;//位图水平分辨率，每米像素数
			//	LONG	biYPelsPerMeter;//位图垂直分辨率，每米像素数
			//	DWORD	biClrUsed;//ColorsUsed 位图实际使用的颜色表中的颜色数
			//	DWORD	biClrImportant;//ColorsImportant 位图显示过程中重要的颜色数
			//} BITMAPINFOHEADER, *PBITMAPINFOHEADER;
			
			var bfOffBits:int=bmpData[10]|(bmpData[11]<<8)|(bmpData[12]<<16)|(bmpData[13]<<24);
			//var biSize:int=bmpData[14]|(bmpData[15]<<8)|(bmpData[16]<<16)|(bmpData[17]<<24);
			var biWidth:int=bmpData[18]|(bmpData[19]<<8)|(bmpData[20]<<16)|(bmpData[21]<<24);
			var biHeight:int=bmpData[22]|(bmpData[23]<<8)|(bmpData[24]<<16)|(bmpData[25]<<24);
			//var biPlanes:int=bmpData[26]|(bmpData[27]<<8);
			var biBitCount:int=bmpData[28]|(bmpData[29]<<8);
			var biCompression:int=bmpData[30]|(bmpData[31]<<8)|(bmpData[32]<<16)|(bmpData[33]<<24);
			//var biSizeImage:int=bmpData[34]|(bmpData[35]<<8)|(bmpData[36]<<16)|(bmpData[37]<<24);
			//var biXPelsPerMeter:int=bmpData[38]|(bmpData[39]<<8)|(bmpData[40]<<16)|(bmpData[41]<<24);
			//var biYPelsPerMeter:int=bmpData[42]|(bmpData[43]<<8)|(bmpData[44]<<16)|(bmpData[45]<<24);
			//var biClrUsed:int=bmpData[46]|(bmpData[47]<<8)|(bmpData[48]<<16)|(bmpData[49]<<24);
			//var biClrImportant:int=bmpData[50]|(bmpData[51]<<8)|(bmpData[52]<<16)|(bmpData[53]<<24);
			
			var isRev:Boolean;
			if(biHeight<0){
				isRev=true;
				biHeight=-biHeight;
			}else{
				isRev=false;
			}
			
			if(clipX>=0&&clipY>=0&&clipWidth>0&&clipHeight>0){
				if(clipX+clipWidth>biWidth){
					throw new Error("clipX="+clipX+"，clipWidth="+clipWidth+"，biWidth="+biWidth+"，clipX+clipWidth 超出 biWidth");
				}
				if(clipY+clipHeight>biHeight){
					throw new Error("clipY="+clipY+"，clipHeight="+clipHeight+"，biHeight="+biHeight+"，clipY+clipHeight 超出 biHeight");
				}
			}
			
			//颜色表
			//typedef struct tagRGBQUAD {
			//	BYTE	rgbBlue;// 蓝色的亮度(值范围为0-255)
			//	BYTE	rgbGreen; // 绿色的亮度(值范围为0-255)
			//	BYTE	rgbRed; // 红色的亮度(值范围为0-255)
			//	BYTE	rgbReserved;// 保留，必须为0
			//} RGBQUAD;
			//颜色表中RGBQUAD结构数据的个数有biBitCount来确定:
			//当biBitCount=1,4,8时，分别有2,16,256个表项;
			
			//trace("======================================================================");
			//trace(biWidth+"x"+biHeight+"_"+biBitCount+"位"+(isRev?"_翻转":""));
			//trace("biCompression="+biCompression);
			
			//trace("bfOffBits="+bfOffBits);
			var pos:int;
			var rest:int;
			var x:int,y:int;
			
			var rArr:Array,gArr:Array,bArr:Array,colorIndex:int,byte:int,i:int;
			
			var bmdBytes:ByteArray=new ByteArray();
			
			var bmdBytesId:int=0;
			switch(biBitCount){
				case 32:
					
					pos=bfOffBits;
					
					if(clipX>=0&&clipY>=0&&clipWidth>0&&clipHeight>0){
						if(isRev){
							pos+=clipY*(biWidth*4)+clipX*4;
						}else{
							pos+=(biHeight-(clipY+clipHeight))*(biWidth*4)+clipX*4;
						}
						rest=(biWidth-clipWidth)*4;
						biWidth=clipWidth;
						biHeight=clipHeight;
					}else{
						rest=0;
					}
					
					if(biCompression){
						//X8R8G8B8
						//获取像素值
						for(y=0;y<biHeight;y++){
							for(x=0;x<biWidth;x++){
								pos++;
								bmdBytes[bmdBytesId]=0xff;
								bmdBytes[bmdBytesId+3]=bmpData[pos++];//b
								bmdBytes[bmdBytesId+2]=bmpData[pos++];//g
								bmdBytes[bmdBytesId+1]=bmpData[pos++];//r
								bmdBytesId+=4;
							}
							pos+=rest;
						}
					}else{
						//A8R8G8B8
						//获取像素值
						for(y=0;y<biHeight;y++){
							for(x=0;x<biWidth;x++){
								bmdBytes[bmdBytesId+3]=bmpData[pos++];//b
								bmdBytes[bmdBytesId+2]=bmpData[pos++];//g
								bmdBytes[bmdBytesId+1]=bmpData[pos++];//r
								pos++;
								bmdBytes[bmdBytesId]=0xff;
								bmdBytesId+=4;
							}
							pos+=rest;
						}
					}
				break;
				case 24:
					//R8G8B8
					
					pos=bfOffBits;
					rest=(4-((biWidth*3)%4))%4;//在获取像素时保持在行末是4个字节的整数倍
					
					if(clipX>=0&&clipY>=0&&clipWidth>0&&clipHeight>0){
						if(isRev){
							pos+=clipY*(biWidth*3+rest)+clipX*3;
						}else{
							pos+=(biHeight-(clipY+clipHeight))*(biWidth*3+rest)+clipX*3;
						}
						rest+=(biWidth-clipWidth)*3;
						biWidth=clipWidth;
						biHeight=clipHeight;
					}
					
					//获取像素值
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							bmdBytes[bmdBytesId+3]=bmpData[pos++];//b
							bmdBytes[bmdBytesId+2]=bmpData[pos++];//g
							bmdBytes[bmdBytesId+1]=bmpData[pos++];//r
							bmdBytes[bmdBytesId]=0xff;
							bmdBytesId+=4;
						}
						pos+=rest;
					}
				break;
				case 16:
					var mask1:int;
					if(biCompression){
						//在位图数据区域前存在一个RGB掩码的描述 是3个DWORD值
						mask1=bmpData[54]|(bmpData[55]<<8)|(bmpData[56]<<16)|(bmpData[57]<<24);
						//mask2=bmpData[58]|(bmpData[59]<<8)|(bmpData[60]<<16)|(bmpData[61]<<24);
						//mask3=bmpData[62]|(bmpData[63]<<8)|(bmpData[64]<<16)|(bmpData[65]<<24);
					}else{
						//16_x1r5g5b5,16_x1r5g5b5_rev,貌似就是没有压缩的555格式...
						mask1=0x7c00;
					}
					
					//trace(mask1.toString(16),mask1.toString(2));
					//trace(mask2.toString(16),mask2.toString(2));
					//trace(mask3.toString(16),mask3.toString(2));
					
					pos=bfOffBits;
					rest=(4-((biWidth*2)%4))%4;//在获取像素时保持在行末是4个字节的整数倍
					
					if(clipX>=0&&clipY>=0&&clipWidth>0&&clipHeight>0){
						if(isRev){
							pos+=clipY*(biWidth*2+rest)+clipX*2;
						}else{
							pos+=(biHeight-(clipY+clipHeight))*(biWidth*2+rest)+clipX*2;
						}
						rest+=(biWidth-clipWidth)*2;
						biWidth=clipWidth;
						biHeight=clipHeight;
					}
					
					var colorData1:int;
					var colorData2:int;
					switch(mask1){
						case 0xf800:
							//R5G6B5
							//获取像素值
							//0x00~0x1f ==> 0x00~0xff
							//8.225806451612904==0xff/0x1f
							//4.0476190476190474====0xff/0x3f
							for(y=0;y<biHeight;y++){
								for(x=0;x<biWidth;x++){
									colorData1=bmpData[pos++];
									colorData2=bmpData[pos++];
									bmdBytes[bmdBytesId++]=0xff;
									bmdBytes[bmdBytesId++]=Math.round(((colorData2<<24)>>>27)*8.225806451612904);//r
									bmdBytes[bmdBytesId++]=Math.round((((colorData2<<29)>>>26)|(colorData1>>>5))*4.0476190476190474);//g
									bmdBytes[bmdBytesId++]=Math.round((colorData1&0x1f)*8.225806451612904);//b
								}
								pos+=rest;
							}
						break;
						case 0xf00:
							//A4R4G4B4
							//X4R4G4B4
							//获取像素值
							//0x00~0x0f ==> 0x00~0xff
							//17==0xff/0x0f
							for(y=0;y<biHeight;y++){
								for(x=0;x<biWidth;x++){
									colorData1=bmpData[pos++];
									colorData2=bmpData[pos++];
									bmdBytes[bmdBytesId++]=0xff;
									bmdBytes[bmdBytesId++]=(colorData2&0x0f)*17;//r
									bmdBytes[bmdBytesId++]=(colorData1>>>4)*17;//g
									bmdBytes[bmdBytesId++]=(colorData1&0x0f)*17;//b
								}
								pos+=rest;
							}
						break;
						default:
							//A1R5G5B5
							//X1R5G5B5
							//获取像素值
							//0x00~0x1f ==> 0x00~0xff
							//8.225806451612904==0xff/0x1f
							for(y=0;y<biHeight;y++){
								for(x=0;x<biWidth;x++){
									colorData1=bmpData[pos++];
									colorData2=bmpData[pos++];
									bmdBytes[bmdBytesId++]=0xff;
									bmdBytes[bmdBytesId++]=Math.round(((colorData2<<25)>>>27)*8.225806451612904);//r
									bmdBytes[bmdBytesId++]=Math.round((((colorData2<<30)>>>27)|(colorData1>>>5))*8.225806451612904);//g
									bmdBytes[bmdBytesId++]=Math.round((colorData1&0x1f)*8.225806451612904);//b
								}
								pos+=rest;
							}
						break;
					}
				break;
				case 8:
					if(biCompression){
						//BIT8RLE
						throw new Error("暂不支持8位压缩位图的解码 ^_^");
						//http://www.vckbase.com/article/bitmap/3.htm
						//关于位图行程编码格式压缩
						//作者:TingYa 
						//
						//---Window中的位图支持行程编码压缩方式，通常位图的象素使用4比特或者8比特来表示，即BITMAPINFOHEADER结构中的biCompression的BI_RLE8和BI_RLE4
						//1．8位位图的压缩
						//---在这种情况下BITMAPINFOHEADER结构中的biCompression设置为BI_RLE8,.使用256色位图行程编码格式将位图进行压缩。这种压缩方式包括绝对方式和编码方式。 
						//
						//编码方式
						//---在此方式下每两个字节组成一个信息单元。第一个字节给出其后面相连的象素的个数。第二个字节给出这些象素使用的颜色索引表中的索引。例如：信息单元03 04，03表示其后的象素个数是3个，04表示这些象素使用的是颜色索引表中的第五项的值。压缩数据展开后就是04 04 04 .同理04 05 可以展开为05 05 05 05. 信息单元的第一个字节也可以是00，这种情况下信息单元并不表示数据单元，而是表示一些特殊的含义。这些含义通常由信息单元的第二个字节的值来描述。这些值在0x00到0x02之间。
						//具体含义如下： 
						//第二个字节的值 
						//00 线结束 
						//01 位图结束 
						//02 象素位置增量。表示紧跟在这个字节后面的信息单元里的两个字节中所包含的无符号值指定了下个象素相对于当前象素的水平和垂直偏移量。例如：00 02 06 08表示的含义是下一个象素的位值是从当前位置向右移动5个象素，向下移动8个象素。（不是字节） 
						//
						//绝对方式 
						//
						//---绝对方式的标志是第一个字节是0，第二个字节是0x03到0xff之间的值。第二个 字节的值表示跟随其后面的象素的字节数目。每个字节都包含一个象素的颜色索引。 每个行程编码都必须补齐到字的边界。 
						//
						//2． 4位位图压缩
						//---这是BITMAPINFOHEADER的biCompression设置为BI_RLE4，使用16位行程编码格式进行位图压缩。压缩方式也包括编码方式和绝对方式。 
						//编码方式： 
						//---4位压缩的编码方式跟8位的编码的压缩方式没有什么区别。每个信息单元也是由 两个字节表示，第一个字节表示其后面所跟随的象素的个数。第二个字节表示象素在 颜色索引表中的索引。这个字节又分为上下两个部分。第一个象素用上半部分指定的 颜色表中的颜色画出。第二个象素用下半部分的颜色画出。第三个象素用下一个字节 的上半部分画出。依次类推。 其余的跟8位位图压缩差不多。
					}else{
						//BIT8
						
						//获取调色板
						pos=54;
						rArr=new Array();
						gArr=new Array();
						bArr=new Array();
						for(colorIndex=0;colorIndex<256;colorIndex++){
							bArr[colorIndex]=bmpData[pos++];
							gArr[colorIndex]=bmpData[pos++];
							rArr[colorIndex]=bmpData[pos++];
							pos++;
						}
						
						//获取像素值
						pos=bfOffBits;
						rest=(4-(biWidth%4))%4;//在获取像素时保持在行末是4个字节的整数倍
						
						if(clipX>=0&&clipY>=0&&clipWidth>0&&clipHeight>0){
							if(isRev){
								pos+=clipY*(biWidth+rest)+clipX;
							}else{
								pos+=(biHeight-(clipY+clipHeight))*(biWidth+rest)+clipX;
							}
							rest+=(biWidth-clipWidth);
							biWidth=clipWidth;
							biHeight=clipHeight;
						}
						
						for(y=0;y<biHeight;y++){
							for(x=0;x<biWidth;x++){
								colorIndex=bmpData[pos++];
								bmdBytes[bmdBytesId++]=0xff;
								bmdBytes[bmdBytesId++]=rArr[colorIndex];
								bmdBytes[bmdBytesId++]=gArr[colorIndex];
								bmdBytes[bmdBytesId++]=bArr[colorIndex];
							}
							pos+=rest;
						}
					}
				break;
				case 4:
					if(biCompression){
						//BIT4RLE
						throw new Error("暂不支持4位压缩位图的解码 ^_^");
					}else{
						//BIT4
						
						//获取调色板
						pos=54;
						rArr=new Array();
						gArr=new Array();
						bArr=new Array();
						for(colorIndex=0;colorIndex<16;colorIndex++){
							bArr[colorIndex]=bmpData[pos++];
							gArr[colorIndex]=bmpData[pos++];
							rArr[colorIndex]=bmpData[pos++];
							pos++;
						}
						
						//获取像素值
						pos=bfOffBits;
						rest=(4-(Math.ceil(biWidth/2)%4))%4;//在获取像素时保持在行末是4个字节的整数倍
						
						if(clipX>=0&&clipY>=0&&clipWidth>0&&clipHeight>0){
							throw new Error("暂不支持4位位图的 clipX，clipY，clipWidth，clipHeight 解码 ^_^");
						}
						
						x=0;
						y=0;
						loop_bit4:while(true){
							byte=bmpData[pos++];
							i=2;
							while(--i>=0){
								colorIndex=(byte>>>(4*i))&0x0f;
								bmdBytes[bmdBytesId++]=0xff;
								bmdBytes[bmdBytesId++]=rArr[colorIndex];
								bmdBytes[bmdBytesId++]=gArr[colorIndex];
								bmdBytes[bmdBytesId++]=bArr[colorIndex];
								if(++x>=biWidth){
									if(++y>=biHeight){
										break loop_bit4;
									}
									x=0;
									pos+=rest;
									break;
								}
							}
						}
					}
				break;
				case 1:
					//BIT1
					
					//获取调色板
					pos=54;
					rArr=new Array();
					gArr=new Array();
					bArr=new Array();
					for(colorIndex=0;colorIndex<2;colorIndex++){
						bArr[colorIndex]=bmpData[pos++];
						gArr[colorIndex]=bmpData[pos++];
						rArr[colorIndex]=bmpData[pos++];
						pos++;
					}
					
					//获取像素值
					pos=bfOffBits;
					rest=(4-(Math.ceil(biWidth/8)%4))%4;//在获取像素时保持在行末是4个字节的整数倍
					
					if(clipX>=0&&clipY>=0&&clipWidth>0&&clipHeight>0){
						throw new Error("暂不支持1位位图的 clipX，clipY，clipWidth，clipHeight 解码 ^_^");
					}
					
					x=0;
					y=0;
					loop_bit1:while(true){
						byte=bmpData[pos++];
						i=8;
						while(--i>=0){
							colorIndex=(byte>>>i)&0x01;
							bmdBytes[bmdBytesId++]=0xff;
							bmdBytes[bmdBytesId++]=rArr[colorIndex];
							bmdBytes[bmdBytesId++]=gArr[colorIndex];
							bmdBytes[bmdBytesId++]=bArr[colorIndex];
							if(++x>=biWidth){
								if(++y>=biHeight){
									break loop_bit1;
								}
								x=0;
								pos+=rest;
								break;
							}
						}
					}
				break;
				default:
					throw new Error("不是有效的位图文件");
				break;
			}
			
			var bmd:BitmapData=new BitmapData(biWidth,biHeight,false,0x000000);
			bmd.setPixels(bmd.rect,bmdBytes);
			if(isRev){
			}else{
				var bmdCopy:BitmapData=bmd.clone();
				bmd.draw(bmdCopy,new Matrix(1,0,0,-1,0,biHeight));
				bmdCopy.dispose();
				bmdCopy=null;
			}
			
			return bmd;
		}
	}
}