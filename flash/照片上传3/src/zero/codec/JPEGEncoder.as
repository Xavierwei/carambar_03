////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

//改进 ZЁЯ¤ 2011年10月31日

package zero.codec{
	
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	
	/**
	 *  The JPEGEncoder class converts raw bitmap images into encoded
	 *  images using Joint Photographic Experts Group (JPEG) compression.
	 *
	 *  For information about the JPEG algorithm, see the document
	 *  http://www.opennet.ru/docs/formats/jpeg.txt by Cristi Cuturicu.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public class JPEGEncoder{
		public static const contentType:String = "image/jpeg";
		
		private static const std_dc_luminance_nrcodes:Vector.<int> = new <int>[ 0, 0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 ];
		private static const std_dc_luminance_values:Vector.<int> =  new <int>[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ];
		private static const std_dc_chrominance_nrcodes:Vector.<int> =  new <int>[ 0, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0 ];
		private static const std_dc_chrominance_values:Vector.<int> =  new <int>[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ];
		private static const std_ac_luminance_nrcodes:Vector.<int> =  new <int>[ 0, 0, 2, 1, 3, 3, 2, 4, 3, 5, 5, 4, 4, 0, 0, 1, 0x7D ];
		private static const std_ac_luminance_values:Vector.<int> = new <int>[
			0x01, 0x02, 0x03, 0x00, 0x04, 0x11, 0x05, 0x12,
			0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61, 0x07,
			0x22, 0x71, 0x14, 0x32, 0x81, 0x91, 0xA1, 0x08,
			0x23, 0x42, 0xB1, 0xC1, 0x15, 0x52, 0xD1, 0xF0,
			0x24, 0x33, 0x62, 0x72, 0x82, 0x09, 0x0A, 0x16,
			0x17, 0x18, 0x19, 0x1A, 0x25, 0x26, 0x27, 0x28,
			0x29, 0x2A, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
			0x3A, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
			0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59,
			0x5A, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69,
			0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79,
			0x7A, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89,
			0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98,
			0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
			0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6,
			0xB7, 0xB8, 0xB9, 0xBA, 0xC2, 0xC3, 0xC4, 0xC5,
			0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xD2, 0xD3, 0xD4,
			0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xE1, 0xE2,
			0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA,
			0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8,
			0xF9, 0xFA
		];
		private static const std_ac_chrominance_nrcodes:Vector.<int> = new <int>[ 0, 0, 2, 1, 2, 4, 4, 3, 4, 7, 5, 4, 4, 0, 1, 2, 0x77 ];
		private static const std_ac_chrominance_values:Vector.<int> = new <int>[
			0x00, 0x01, 0x02, 0x03, 0x11, 0x04, 0x05, 0x21,
			0x31, 0x06, 0x12, 0x41, 0x51, 0x07, 0x61, 0x71,
			0x13, 0x22, 0x32, 0x81, 0x08, 0x14, 0x42, 0x91,
			0xA1, 0xB1, 0xC1, 0x09, 0x23, 0x33, 0x52, 0xF0,
			0x15, 0x62, 0x72, 0xD1, 0x0A, 0x16, 0x24, 0x34,
			0xE1, 0x25, 0xF1, 0x17, 0x18, 0x19, 0x1A, 0x26,
			0x27, 0x28, 0x29, 0x2A, 0x35, 0x36, 0x37, 0x38,
			0x39, 0x3A, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
			0x49, 0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
			0x59, 0x5A, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
			0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
			0x79, 0x7A, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
			0x88, 0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96,
			0x97, 0x98, 0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5,
			0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4,
			0xB5, 0xB6, 0xB7, 0xB8, 0xB9, 0xBA, 0xC2, 0xC3,
			0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xD2,
			0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA,
			0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9,
			0xEA, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8,
			0xF9, 0xFA
		];
		
		private static var jpegEncoderV:Vector.<JPEGEncoder>=new Vector.<JPEGEncoder>(101);
		public static function encode(bitmapData:BitmapData,quality:int=80):ByteArray{
			if (quality <= 0){
				quality = 1;
			}else if (quality > 100){
				quality = 100;
			}
			
			if(jpegEncoderV[quality]){
			}else{
				jpegEncoderV[quality]=new JPEGEncoder(quality);
			}
			return jpegEncoderV[quality].encode(bitmapData);
		}
		
		/**
		 *  Constructor.
		 *
		 *  @param quality A value between 0.0 and 100.0. 
		 *  The smaller the <code>quality</code> value, 
		 *  the smaller the file size of the resultant image. 
		 *  The value does not affect the encoding speed.
		 *. Note that even though this value is a number between 0.0 and 100.0, 
		 *  it does not represent a percentage. 
		 *  The default value is 50.0.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		
		private var YDC_HT:Vector.<int>;
		private var UVDC_HT:Vector.<int>;
		private var YAC_HT:Vector.<int>;
		private var UVAC_HT:Vector.<int>;
		private var category:Vector.<int>;
		private var bitcode:Vector.<int>;
		
		private var byteout_head:ByteArray;
		
		private var YTable_0:int;
		private var YTable_1:int;
		private var YTable_2:int;
		private var YTable_3:int;
		private var YTable_4:int;
		private var YTable_5:int;
		private var YTable_6:int;
		private var YTable_7:int;
		private var YTable_8:int;
		private var YTable_9:int;
		private var YTable_10:int;
		private var YTable_11:int;
		private var YTable_12:int;
		private var YTable_13:int;
		private var YTable_14:int;
		private var YTable_15:int;
		private var YTable_16:int;
		private var YTable_17:int;
		private var YTable_18:int;
		private var YTable_19:int;
		private var YTable_20:int;
		private var YTable_21:int;
		private var YTable_22:int;
		private var YTable_23:int;
		private var YTable_24:int;
		private var YTable_25:int;
		private var YTable_26:int;
		private var YTable_27:int;
		private var YTable_28:int;
		private var YTable_29:int;
		private var YTable_30:int;
		private var YTable_31:int;
		private var YTable_32:int;
		private var YTable_33:int;
		private var YTable_34:int;
		private var YTable_35:int;
		private var YTable_36:int;
		private var YTable_37:int;
		private var YTable_38:int;
		private var YTable_39:int;
		private var YTable_40:int;
		private var YTable_41:int;
		private var YTable_42:int;
		private var YTable_43:int;
		private var YTable_44:int;
		private var YTable_45:int;
		private var YTable_46:int;
		private var YTable_47:int;
		private var YTable_48:int;
		private var YTable_49:int;
		private var YTable_50:int;
		private var YTable_51:int;
		private var YTable_52:int;
		private var YTable_53:int;
		private var YTable_54:int;
		private var YTable_55:int;
		private var YTable_56:int;
		private var YTable_57:int;
		private var YTable_58:int;
		private var YTable_59:int;
		private var YTable_60:int;
		private var YTable_61:int;
		private var YTable_62:int;
		private var YTable_63:int;
		
		private var UVTable_0:int;
		private var UVTable_1:int;
		private var UVTable_2:int;
		private var UVTable_3:int;
		private var UVTable_4:int;
		private var UVTable_5:int;
		private var UVTable_6:int;
		private var UVTable_7:int;
		private var UVTable_8:int;
		private var UVTable_9:int;
		private var UVTable_10:int;
		private var UVTable_11:int;
		private var UVTable_12:int;
		private var UVTable_13:int;
		private var UVTable_14:int;
		private var UVTable_15:int;
		private var UVTable_16:int;
		private var UVTable_17:int;
		private var UVTable_18:int;
		private var UVTable_19:int;
		private var UVTable_20:int;
		private var UVTable_21:int;
		private var UVTable_22:int;
		private var UVTable_23:int;
		private var UVTable_24:int;
		private var UVTable_25:int;
		private var UVTable_26:int;
		private var UVTable_27:int;
		private var UVTable_28:int;
		private var UVTable_29:int;
		private var UVTable_30:int;
		private var UVTable_31:int;
		private var UVTable_32:int;
		private var UVTable_33:int;
		private var UVTable_34:int;
		private var UVTable_35:int;
		private var UVTable_36:int;
		private var UVTable_37:int;
		private var UVTable_38:int;
		private var UVTable_39:int;
		private var UVTable_40:int;
		private var UVTable_41:int;
		private var UVTable_42:int;
		private var UVTable_43:int;
		private var UVTable_44:int;
		private var UVTable_45:int;
		private var UVTable_46:int;
		private var UVTable_47:int;
		private var UVTable_48:int;
		private var UVTable_49:int;
		private var UVTable_50:int;
		private var UVTable_51:int;
		private var UVTable_52:int;
		private var UVTable_53:int;
		private var UVTable_54:int;
		private var UVTable_55:int;
		private var UVTable_56:int;
		private var UVTable_57:int;
		private var UVTable_58:int;
		private var UVTable_59:int;
		private var UVTable_60:int;
		private var UVTable_61:int;
		private var UVTable_62:int;
		private var UVTable_63:int;
		
		private var fdtbl_Y_0:Number;
		private var fdtbl_Y_1:Number;
		private var fdtbl_Y_2:Number;
		private var fdtbl_Y_3:Number;
		private var fdtbl_Y_4:Number;
		private var fdtbl_Y_5:Number;
		private var fdtbl_Y_6:Number;
		private var fdtbl_Y_7:Number;
		private var fdtbl_Y_8:Number;
		private var fdtbl_Y_9:Number;
		private var fdtbl_Y_10:Number;
		private var fdtbl_Y_11:Number;
		private var fdtbl_Y_12:Number;
		private var fdtbl_Y_13:Number;
		private var fdtbl_Y_14:Number;
		private var fdtbl_Y_15:Number;
		private var fdtbl_Y_16:Number;
		private var fdtbl_Y_17:Number;
		private var fdtbl_Y_18:Number;
		private var fdtbl_Y_19:Number;
		private var fdtbl_Y_20:Number;
		private var fdtbl_Y_21:Number;
		private var fdtbl_Y_22:Number;
		private var fdtbl_Y_23:Number;
		private var fdtbl_Y_24:Number;
		private var fdtbl_Y_25:Number;
		private var fdtbl_Y_26:Number;
		private var fdtbl_Y_27:Number;
		private var fdtbl_Y_28:Number;
		private var fdtbl_Y_29:Number;
		private var fdtbl_Y_30:Number;
		private var fdtbl_Y_31:Number;
		private var fdtbl_Y_32:Number;
		private var fdtbl_Y_33:Number;
		private var fdtbl_Y_34:Number;
		private var fdtbl_Y_35:Number;
		private var fdtbl_Y_36:Number;
		private var fdtbl_Y_37:Number;
		private var fdtbl_Y_38:Number;
		private var fdtbl_Y_39:Number;
		private var fdtbl_Y_40:Number;
		private var fdtbl_Y_41:Number;
		private var fdtbl_Y_42:Number;
		private var fdtbl_Y_43:Number;
		private var fdtbl_Y_44:Number;
		private var fdtbl_Y_45:Number;
		private var fdtbl_Y_46:Number;
		private var fdtbl_Y_47:Number;
		private var fdtbl_Y_48:Number;
		private var fdtbl_Y_49:Number;
		private var fdtbl_Y_50:Number;
		private var fdtbl_Y_51:Number;
		private var fdtbl_Y_52:Number;
		private var fdtbl_Y_53:Number;
		private var fdtbl_Y_54:Number;
		private var fdtbl_Y_55:Number;
		private var fdtbl_Y_56:Number;
		private var fdtbl_Y_57:Number;
		private var fdtbl_Y_58:Number;
		private var fdtbl_Y_59:Number;
		private var fdtbl_Y_60:Number;
		private var fdtbl_Y_61:Number;
		private var fdtbl_Y_62:Number;
		private var fdtbl_Y_63:Number;
		
		private var fdtbl_UV_0:Number;
		private var fdtbl_UV_1:Number;
		private var fdtbl_UV_2:Number;
		private var fdtbl_UV_3:Number;
		private var fdtbl_UV_4:Number;
		private var fdtbl_UV_5:Number;
		private var fdtbl_UV_6:Number;
		private var fdtbl_UV_7:Number;
		private var fdtbl_UV_8:Number;
		private var fdtbl_UV_9:Number;
		private var fdtbl_UV_10:Number;
		private var fdtbl_UV_11:Number;
		private var fdtbl_UV_12:Number;
		private var fdtbl_UV_13:Number;
		private var fdtbl_UV_14:Number;
		private var fdtbl_UV_15:Number;
		private var fdtbl_UV_16:Number;
		private var fdtbl_UV_17:Number;
		private var fdtbl_UV_18:Number;
		private var fdtbl_UV_19:Number;
		private var fdtbl_UV_20:Number;
		private var fdtbl_UV_21:Number;
		private var fdtbl_UV_22:Number;
		private var fdtbl_UV_23:Number;
		private var fdtbl_UV_24:Number;
		private var fdtbl_UV_25:Number;
		private var fdtbl_UV_26:Number;
		private var fdtbl_UV_27:Number;
		private var fdtbl_UV_28:Number;
		private var fdtbl_UV_29:Number;
		private var fdtbl_UV_30:Number;
		private var fdtbl_UV_31:Number;
		private var fdtbl_UV_32:Number;
		private var fdtbl_UV_33:Number;
		private var fdtbl_UV_34:Number;
		private var fdtbl_UV_35:Number;
		private var fdtbl_UV_36:Number;
		private var fdtbl_UV_37:Number;
		private var fdtbl_UV_38:Number;
		private var fdtbl_UV_39:Number;
		private var fdtbl_UV_40:Number;
		private var fdtbl_UV_41:Number;
		private var fdtbl_UV_42:Number;
		private var fdtbl_UV_43:Number;
		private var fdtbl_UV_44:Number;
		private var fdtbl_UV_45:Number;
		private var fdtbl_UV_46:Number;
		private var fdtbl_UV_47:Number;
		private var fdtbl_UV_48:Number;
		private var fdtbl_UV_49:Number;
		private var fdtbl_UV_50:Number;
		private var fdtbl_UV_51:Number;
		private var fdtbl_UV_52:Number;
		private var fdtbl_UV_53:Number;
		private var fdtbl_UV_54:Number;
		private var fdtbl_UV_55:Number;
		private var fdtbl_UV_56:Number;
		private var fdtbl_UV_57:Number;
		private var fdtbl_UV_58:Number;
		private var fdtbl_UV_59:Number;
		private var fdtbl_UV_60:Number;
		private var fdtbl_UV_61:Number;
		private var fdtbl_UV_62:Number;
		private var fdtbl_UV_63:Number;
		
		public function JPEGEncoder(quality:int){
			var sf:int;
			if (quality < 50){
				sf = int(5000 / quality);
			}else{
				sf = int(200 - quality * 2);
			}
			
			// Create tables
			initHuffmanTbl();
			initCategoryNumber();
			initQuantTables(sf);
			
			byteout_head=new ByteArray();
			
			// Add JPEG headers
			byteout_head[0]=0xFF;
			byteout_head[1]=0xD8;// SOI
			
			//writeAPP0
			byteout_head[2]=0xFF;
			byteout_head[3]=0xE0;	// marker
			byteout_head[4]=0;
			byteout_head[5]=16;	// length
			byteout_head[6]=0x4A;	// J
			byteout_head[7]=0x46;	// F
			byteout_head[8]=0x49;	// I
			byteout_head[9]=0x46;	// F
			byteout_head[10]=0;		// = "JFIF",'\0'
			byteout_head[11]=1;		// versionhi
			byteout_head[12]=1;		// versionlo
			byteout_head[13]=0;		// xyunits
			byteout_head[14]=0;
			byteout_head[15]=1;		// xdensity
			byteout_head[16]=0;
			byteout_head[17]=1;		// ydensity
			byteout_head[18]=0;		// thumbnwidth
			byteout_head[19]=0;		// thumbnheight
			
			//writeDQT
			byteout_head[20]=0xFF;
			byteout_head[21]=0xDB;	// marker
			byteout_head[22]=0;
			byteout_head[23]=132;     // length
			byteout_head[24]=0;
			
			byteout_head[25]=YTable_0;
			byteout_head[26]=YTable_1;
			byteout_head[27]=YTable_2;
			byteout_head[28]=YTable_3;
			byteout_head[29]=YTable_4;
			byteout_head[30]=YTable_5;
			byteout_head[31]=YTable_6;
			byteout_head[32]=YTable_7;
			byteout_head[33]=YTable_8;
			byteout_head[34]=YTable_9;
			byteout_head[35]=YTable_10;
			byteout_head[36]=YTable_11;
			byteout_head[37]=YTable_12;
			byteout_head[38]=YTable_13;
			byteout_head[39]=YTable_14;
			byteout_head[40]=YTable_15;
			byteout_head[41]=YTable_16;
			byteout_head[42]=YTable_17;
			byteout_head[43]=YTable_18;
			byteout_head[44]=YTable_19;
			byteout_head[45]=YTable_20;
			byteout_head[46]=YTable_21;
			byteout_head[47]=YTable_22;
			byteout_head[48]=YTable_23;
			byteout_head[49]=YTable_24;
			byteout_head[50]=YTable_25;
			byteout_head[51]=YTable_26;
			byteout_head[52]=YTable_27;
			byteout_head[53]=YTable_28;
			byteout_head[54]=YTable_29;
			byteout_head[55]=YTable_30;
			byteout_head[56]=YTable_31;
			byteout_head[57]=YTable_32;
			byteout_head[58]=YTable_33;
			byteout_head[59]=YTable_34;
			byteout_head[60]=YTable_35;
			byteout_head[61]=YTable_36;
			byteout_head[62]=YTable_37;
			byteout_head[63]=YTable_38;
			byteout_head[64]=YTable_39;
			byteout_head[65]=YTable_40;
			byteout_head[66]=YTable_41;
			byteout_head[67]=YTable_42;
			byteout_head[68]=YTable_43;
			byteout_head[69]=YTable_44;
			byteout_head[70]=YTable_45;
			byteout_head[71]=YTable_46;
			byteout_head[72]=YTable_47;
			byteout_head[73]=YTable_48;
			byteout_head[74]=YTable_49;
			byteout_head[75]=YTable_50;
			byteout_head[76]=YTable_51;
			byteout_head[77]=YTable_52;
			byteout_head[78]=YTable_53;
			byteout_head[79]=YTable_54;
			byteout_head[80]=YTable_55;
			byteout_head[81]=YTable_56;
			byteout_head[82]=YTable_57;
			byteout_head[83]=YTable_58;
			byteout_head[84]=YTable_59;
			byteout_head[85]=YTable_60;
			byteout_head[86]=YTable_61;
			byteout_head[87]=YTable_62;
			byteout_head[88]=YTable_63;
			
			byteout_head[89]=1;
			
			byteout_head[90]=UVTable_0;
			byteout_head[91]=UVTable_1;
			byteout_head[92]=UVTable_2;
			byteout_head[93]=UVTable_3;
			byteout_head[94]=UVTable_4;
			byteout_head[95]=UVTable_5;
			byteout_head[96]=UVTable_6;
			byteout_head[97]=UVTable_7;
			byteout_head[98]=UVTable_8;
			byteout_head[99]=UVTable_9;
			byteout_head[100]=UVTable_10;
			byteout_head[101]=UVTable_11;
			byteout_head[102]=UVTable_12;
			byteout_head[103]=UVTable_13;
			byteout_head[104]=UVTable_14;
			byteout_head[105]=UVTable_15;
			byteout_head[106]=UVTable_16;
			byteout_head[107]=UVTable_17;
			byteout_head[108]=UVTable_18;
			byteout_head[109]=UVTable_19;
			byteout_head[110]=UVTable_20;
			byteout_head[111]=UVTable_21;
			byteout_head[112]=UVTable_22;
			byteout_head[113]=UVTable_23;
			byteout_head[114]=UVTable_24;
			byteout_head[115]=UVTable_25;
			byteout_head[116]=UVTable_26;
			byteout_head[117]=UVTable_27;
			byteout_head[118]=UVTable_28;
			byteout_head[119]=UVTable_29;
			byteout_head[120]=UVTable_30;
			byteout_head[121]=UVTable_31;
			byteout_head[122]=UVTable_32;
			byteout_head[123]=UVTable_33;
			byteout_head[124]=UVTable_34;
			byteout_head[125]=UVTable_35;
			byteout_head[126]=UVTable_36;
			byteout_head[127]=UVTable_37;
			byteout_head[128]=UVTable_38;
			byteout_head[129]=UVTable_39;
			byteout_head[130]=UVTable_40;
			byteout_head[131]=UVTable_41;
			byteout_head[132]=UVTable_42;
			byteout_head[133]=UVTable_43;
			byteout_head[134]=UVTable_44;
			byteout_head[135]=UVTable_45;
			byteout_head[136]=UVTable_46;
			byteout_head[137]=UVTable_47;
			byteout_head[138]=UVTable_48;
			byteout_head[139]=UVTable_49;
			byteout_head[140]=UVTable_50;
			byteout_head[141]=UVTable_51;
			byteout_head[142]=UVTable_52;
			byteout_head[143]=UVTable_53;
			byteout_head[144]=UVTable_54;
			byteout_head[145]=UVTable_55;
			byteout_head[146]=UVTable_56;
			byteout_head[147]=UVTable_57;
			byteout_head[148]=UVTable_58;
			byteout_head[149]=UVTable_59;
			byteout_head[150]=UVTable_60;
			byteout_head[151]=UVTable_61;
			byteout_head[152]=UVTable_62;
			byteout_head[153]=UVTable_63;
			
			//writeSOF0
			byteout_head[154]=0xFF;
			byteout_head[155]=0xC0;	// marker
			byteout_head[156]=0;
			byteout_head[157]=17;		// length, truecolor YUV JPG
			byteout_head[158]=8;		// precision
			//byteout_head[159]=height>>8;
			//byteout_head[160]=height;
			//byteout_head[161]=width>>8;
			//byteout_head[162]=width;
			byteout_head[163]=3;		// nrofcomponents
			byteout_head[164]=1;		// IdY
			byteout_head[165]=0x11;	// HVY
			byteout_head[166]=0;		// QTY
			byteout_head[167]=2;		// IdU
			byteout_head[168]=0x11;	// HVU
			byteout_head[169]=1;		// QTU
			byteout_head[170]=3;		// IdV
			byteout_head[171]=0x11;	// HVV
			byteout_head[172]=1;		// QTV
			
			//writeDHT
			byteout_head[173]=0xFF;
			byteout_head[174]=0xC4; // marker
			byteout_head[175]=0x01;
			byteout_head[176]=0xA2; // length
			
			byteout_head[177]=0; // HTYDCinfo
			
			byteout_head[178]=std_dc_luminance_nrcodes[1];
			byteout_head[179]=std_dc_luminance_nrcodes[2];
			byteout_head[180]=std_dc_luminance_nrcodes[3];
			byteout_head[181]=std_dc_luminance_nrcodes[4];
			byteout_head[182]=std_dc_luminance_nrcodes[5];
			byteout_head[183]=std_dc_luminance_nrcodes[6];
			byteout_head[184]=std_dc_luminance_nrcodes[7];
			byteout_head[185]=std_dc_luminance_nrcodes[8];
			byteout_head[186]=std_dc_luminance_nrcodes[9];
			byteout_head[187]=std_dc_luminance_nrcodes[10];
			byteout_head[188]=std_dc_luminance_nrcodes[11];
			byteout_head[189]=std_dc_luminance_nrcodes[12];
			byteout_head[190]=std_dc_luminance_nrcodes[13];
			byteout_head[191]=std_dc_luminance_nrcodes[14];
			byteout_head[192]=std_dc_luminance_nrcodes[15];
			byteout_head[193]=std_dc_luminance_nrcodes[16];
			
			byteout_head[194]=std_dc_luminance_values[0];
			byteout_head[195]=std_dc_luminance_values[1];
			byteout_head[196]=std_dc_luminance_values[2];
			byteout_head[197]=std_dc_luminance_values[3];
			byteout_head[198]=std_dc_luminance_values[4];
			byteout_head[199]=std_dc_luminance_values[5];
			byteout_head[200]=std_dc_luminance_values[6];
			byteout_head[201]=std_dc_luminance_values[7];
			byteout_head[202]=std_dc_luminance_values[8];
			byteout_head[203]=std_dc_luminance_values[9];
			byteout_head[204]=std_dc_luminance_values[10];
			byteout_head[205]=std_dc_luminance_values[11];
			
			byteout_head[206]=0x10; // HTYACinfo
			
			byteout_head[207]=std_ac_luminance_nrcodes[1];
			byteout_head[208]=std_ac_luminance_nrcodes[2];
			byteout_head[209]=std_ac_luminance_nrcodes[3];
			byteout_head[210]=std_ac_luminance_nrcodes[4];
			byteout_head[211]=std_ac_luminance_nrcodes[5];
			byteout_head[212]=std_ac_luminance_nrcodes[6];
			byteout_head[213]=std_ac_luminance_nrcodes[7];
			byteout_head[214]=std_ac_luminance_nrcodes[8];
			byteout_head[215]=std_ac_luminance_nrcodes[9];
			byteout_head[216]=std_ac_luminance_nrcodes[10];
			byteout_head[217]=std_ac_luminance_nrcodes[11];
			byteout_head[218]=std_ac_luminance_nrcodes[12];
			byteout_head[219]=std_ac_luminance_nrcodes[13];
			byteout_head[220]=std_ac_luminance_nrcodes[14];
			byteout_head[221]=std_ac_luminance_nrcodes[15];
			byteout_head[222]=std_ac_luminance_nrcodes[16];
			
			byteout_head[223]=std_ac_luminance_values[0];
			byteout_head[224]=std_ac_luminance_values[1];
			byteout_head[225]=std_ac_luminance_values[2];
			byteout_head[226]=std_ac_luminance_values[3];
			byteout_head[227]=std_ac_luminance_values[4];
			byteout_head[228]=std_ac_luminance_values[5];
			byteout_head[229]=std_ac_luminance_values[6];
			byteout_head[230]=std_ac_luminance_values[7];
			byteout_head[231]=std_ac_luminance_values[8];
			byteout_head[232]=std_ac_luminance_values[9];
			byteout_head[233]=std_ac_luminance_values[10];
			byteout_head[234]=std_ac_luminance_values[11];
			byteout_head[235]=std_ac_luminance_values[12];
			byteout_head[236]=std_ac_luminance_values[13];
			byteout_head[237]=std_ac_luminance_values[14];
			byteout_head[238]=std_ac_luminance_values[15];
			byteout_head[239]=std_ac_luminance_values[16];
			byteout_head[240]=std_ac_luminance_values[17];
			byteout_head[241]=std_ac_luminance_values[18];
			byteout_head[242]=std_ac_luminance_values[19];
			byteout_head[243]=std_ac_luminance_values[20];
			byteout_head[244]=std_ac_luminance_values[21];
			byteout_head[245]=std_ac_luminance_values[22];
			byteout_head[246]=std_ac_luminance_values[23];
			byteout_head[247]=std_ac_luminance_values[24];
			byteout_head[248]=std_ac_luminance_values[25];
			byteout_head[249]=std_ac_luminance_values[26];
			byteout_head[250]=std_ac_luminance_values[27];
			byteout_head[251]=std_ac_luminance_values[28];
			byteout_head[252]=std_ac_luminance_values[29];
			byteout_head[253]=std_ac_luminance_values[30];
			byteout_head[254]=std_ac_luminance_values[31];
			byteout_head[255]=std_ac_luminance_values[32];
			byteout_head[256]=std_ac_luminance_values[33];
			byteout_head[257]=std_ac_luminance_values[34];
			byteout_head[258]=std_ac_luminance_values[35];
			byteout_head[259]=std_ac_luminance_values[36];
			byteout_head[260]=std_ac_luminance_values[37];
			byteout_head[261]=std_ac_luminance_values[38];
			byteout_head[262]=std_ac_luminance_values[39];
			byteout_head[263]=std_ac_luminance_values[40];
			byteout_head[264]=std_ac_luminance_values[41];
			byteout_head[265]=std_ac_luminance_values[42];
			byteout_head[266]=std_ac_luminance_values[43];
			byteout_head[267]=std_ac_luminance_values[44];
			byteout_head[268]=std_ac_luminance_values[45];
			byteout_head[269]=std_ac_luminance_values[46];
			byteout_head[270]=std_ac_luminance_values[47];
			byteout_head[271]=std_ac_luminance_values[48];
			byteout_head[272]=std_ac_luminance_values[49];
			byteout_head[273]=std_ac_luminance_values[50];
			byteout_head[274]=std_ac_luminance_values[51];
			byteout_head[275]=std_ac_luminance_values[52];
			byteout_head[276]=std_ac_luminance_values[53];
			byteout_head[277]=std_ac_luminance_values[54];
			byteout_head[278]=std_ac_luminance_values[55];
			byteout_head[279]=std_ac_luminance_values[56];
			byteout_head[280]=std_ac_luminance_values[57];
			byteout_head[281]=std_ac_luminance_values[58];
			byteout_head[282]=std_ac_luminance_values[59];
			byteout_head[283]=std_ac_luminance_values[60];
			byteout_head[284]=std_ac_luminance_values[61];
			byteout_head[285]=std_ac_luminance_values[62];
			byteout_head[286]=std_ac_luminance_values[63];
			byteout_head[287]=std_ac_luminance_values[64];
			byteout_head[288]=std_ac_luminance_values[65];
			byteout_head[289]=std_ac_luminance_values[66];
			byteout_head[290]=std_ac_luminance_values[67];
			byteout_head[291]=std_ac_luminance_values[68];
			byteout_head[292]=std_ac_luminance_values[69];
			byteout_head[293]=std_ac_luminance_values[70];
			byteout_head[294]=std_ac_luminance_values[71];
			byteout_head[295]=std_ac_luminance_values[72];
			byteout_head[296]=std_ac_luminance_values[73];
			byteout_head[297]=std_ac_luminance_values[74];
			byteout_head[298]=std_ac_luminance_values[75];
			byteout_head[299]=std_ac_luminance_values[76];
			byteout_head[300]=std_ac_luminance_values[77];
			byteout_head[301]=std_ac_luminance_values[78];
			byteout_head[302]=std_ac_luminance_values[79];
			byteout_head[303]=std_ac_luminance_values[80];
			byteout_head[304]=std_ac_luminance_values[81];
			byteout_head[305]=std_ac_luminance_values[82];
			byteout_head[306]=std_ac_luminance_values[83];
			byteout_head[307]=std_ac_luminance_values[84];
			byteout_head[308]=std_ac_luminance_values[85];
			byteout_head[309]=std_ac_luminance_values[86];
			byteout_head[310]=std_ac_luminance_values[87];
			byteout_head[311]=std_ac_luminance_values[88];
			byteout_head[312]=std_ac_luminance_values[89];
			byteout_head[313]=std_ac_luminance_values[90];
			byteout_head[314]=std_ac_luminance_values[91];
			byteout_head[315]=std_ac_luminance_values[92];
			byteout_head[316]=std_ac_luminance_values[93];
			byteout_head[317]=std_ac_luminance_values[94];
			byteout_head[318]=std_ac_luminance_values[95];
			byteout_head[319]=std_ac_luminance_values[96];
			byteout_head[320]=std_ac_luminance_values[97];
			byteout_head[321]=std_ac_luminance_values[98];
			byteout_head[322]=std_ac_luminance_values[99];
			byteout_head[323]=std_ac_luminance_values[100];
			byteout_head[324]=std_ac_luminance_values[101];
			byteout_head[325]=std_ac_luminance_values[102];
			byteout_head[326]=std_ac_luminance_values[103];
			byteout_head[327]=std_ac_luminance_values[104];
			byteout_head[328]=std_ac_luminance_values[105];
			byteout_head[329]=std_ac_luminance_values[106];
			byteout_head[330]=std_ac_luminance_values[107];
			byteout_head[331]=std_ac_luminance_values[108];
			byteout_head[332]=std_ac_luminance_values[109];
			byteout_head[333]=std_ac_luminance_values[110];
			byteout_head[334]=std_ac_luminance_values[111];
			byteout_head[335]=std_ac_luminance_values[112];
			byteout_head[336]=std_ac_luminance_values[113];
			byteout_head[337]=std_ac_luminance_values[114];
			byteout_head[338]=std_ac_luminance_values[115];
			byteout_head[339]=std_ac_luminance_values[116];
			byteout_head[340]=std_ac_luminance_values[117];
			byteout_head[341]=std_ac_luminance_values[118];
			byteout_head[342]=std_ac_luminance_values[119];
			byteout_head[343]=std_ac_luminance_values[120];
			byteout_head[344]=std_ac_luminance_values[121];
			byteout_head[345]=std_ac_luminance_values[122];
			byteout_head[346]=std_ac_luminance_values[123];
			byteout_head[347]=std_ac_luminance_values[124];
			byteout_head[348]=std_ac_luminance_values[125];
			byteout_head[349]=std_ac_luminance_values[126];
			byteout_head[350]=std_ac_luminance_values[127];
			byteout_head[351]=std_ac_luminance_values[128];
			byteout_head[352]=std_ac_luminance_values[129];
			byteout_head[353]=std_ac_luminance_values[130];
			byteout_head[354]=std_ac_luminance_values[131];
			byteout_head[355]=std_ac_luminance_values[132];
			byteout_head[356]=std_ac_luminance_values[133];
			byteout_head[357]=std_ac_luminance_values[134];
			byteout_head[358]=std_ac_luminance_values[135];
			byteout_head[359]=std_ac_luminance_values[136];
			byteout_head[360]=std_ac_luminance_values[137];
			byteout_head[361]=std_ac_luminance_values[138];
			byteout_head[362]=std_ac_luminance_values[139];
			byteout_head[363]=std_ac_luminance_values[140];
			byteout_head[364]=std_ac_luminance_values[141];
			byteout_head[365]=std_ac_luminance_values[142];
			byteout_head[366]=std_ac_luminance_values[143];
			byteout_head[367]=std_ac_luminance_values[144];
			byteout_head[368]=std_ac_luminance_values[145];
			byteout_head[369]=std_ac_luminance_values[146];
			byteout_head[370]=std_ac_luminance_values[147];
			byteout_head[371]=std_ac_luminance_values[148];
			byteout_head[372]=std_ac_luminance_values[149];
			byteout_head[373]=std_ac_luminance_values[150];
			byteout_head[374]=std_ac_luminance_values[151];
			byteout_head[375]=std_ac_luminance_values[152];
			byteout_head[376]=std_ac_luminance_values[153];
			byteout_head[377]=std_ac_luminance_values[154];
			byteout_head[378]=std_ac_luminance_values[155];
			byteout_head[379]=std_ac_luminance_values[156];
			byteout_head[380]=std_ac_luminance_values[157];
			byteout_head[381]=std_ac_luminance_values[158];
			byteout_head[382]=std_ac_luminance_values[159];
			byteout_head[383]=std_ac_luminance_values[160];
			byteout_head[384]=std_ac_luminance_values[161];
			
			byteout_head[385]=1; // HTUDCinfo
			
			byteout_head[386]=std_dc_chrominance_nrcodes[1];
			byteout_head[387]=std_dc_chrominance_nrcodes[2];
			byteout_head[388]=std_dc_chrominance_nrcodes[3];
			byteout_head[389]=std_dc_chrominance_nrcodes[4];
			byteout_head[390]=std_dc_chrominance_nrcodes[5];
			byteout_head[391]=std_dc_chrominance_nrcodes[6];
			byteout_head[392]=std_dc_chrominance_nrcodes[7];
			byteout_head[393]=std_dc_chrominance_nrcodes[8];
			byteout_head[394]=std_dc_chrominance_nrcodes[9];
			byteout_head[395]=std_dc_chrominance_nrcodes[10];
			byteout_head[396]=std_dc_chrominance_nrcodes[11];
			byteout_head[397]=std_dc_chrominance_nrcodes[12];
			byteout_head[398]=std_dc_chrominance_nrcodes[13];
			byteout_head[399]=std_dc_chrominance_nrcodes[14];
			byteout_head[400]=std_dc_chrominance_nrcodes[15];
			byteout_head[401]=std_dc_chrominance_nrcodes[16];
			
			byteout_head[402]=std_dc_chrominance_values[0];
			byteout_head[403]=std_dc_chrominance_values[1];
			byteout_head[404]=std_dc_chrominance_values[2];
			byteout_head[405]=std_dc_chrominance_values[3];
			byteout_head[406]=std_dc_chrominance_values[4];
			byteout_head[407]=std_dc_chrominance_values[5];
			byteout_head[408]=std_dc_chrominance_values[6];
			byteout_head[409]=std_dc_chrominance_values[7];
			byteout_head[410]=std_dc_chrominance_values[8];
			byteout_head[411]=std_dc_chrominance_values[9];
			byteout_head[412]=std_dc_chrominance_values[10];
			byteout_head[413]=std_dc_chrominance_values[11];
			
			byteout_head[414]=0x11; // HTUACinfo
			
			byteout_head[415]=std_ac_chrominance_nrcodes[1];
			byteout_head[416]=std_ac_chrominance_nrcodes[2];
			byteout_head[417]=std_ac_chrominance_nrcodes[3];
			byteout_head[418]=std_ac_chrominance_nrcodes[4];
			byteout_head[419]=std_ac_chrominance_nrcodes[5];
			byteout_head[420]=std_ac_chrominance_nrcodes[6];
			byteout_head[421]=std_ac_chrominance_nrcodes[7];
			byteout_head[422]=std_ac_chrominance_nrcodes[8];
			byteout_head[423]=std_ac_chrominance_nrcodes[9];
			byteout_head[424]=std_ac_chrominance_nrcodes[10];
			byteout_head[425]=std_ac_chrominance_nrcodes[11];
			byteout_head[426]=std_ac_chrominance_nrcodes[12];
			byteout_head[427]=std_ac_chrominance_nrcodes[13];
			byteout_head[428]=std_ac_chrominance_nrcodes[14];
			byteout_head[429]=std_ac_chrominance_nrcodes[15];
			byteout_head[430]=std_ac_chrominance_nrcodes[16];
			
			byteout_head[431]=std_ac_chrominance_values[0];
			byteout_head[432]=std_ac_chrominance_values[1];
			byteout_head[433]=std_ac_chrominance_values[2];
			byteout_head[434]=std_ac_chrominance_values[3];
			byteout_head[435]=std_ac_chrominance_values[4];
			byteout_head[436]=std_ac_chrominance_values[5];
			byteout_head[437]=std_ac_chrominance_values[6];
			byteout_head[438]=std_ac_chrominance_values[7];
			byteout_head[439]=std_ac_chrominance_values[8];
			byteout_head[440]=std_ac_chrominance_values[9];
			byteout_head[441]=std_ac_chrominance_values[10];
			byteout_head[442]=std_ac_chrominance_values[11];
			byteout_head[443]=std_ac_chrominance_values[12];
			byteout_head[444]=std_ac_chrominance_values[13];
			byteout_head[445]=std_ac_chrominance_values[14];
			byteout_head[446]=std_ac_chrominance_values[15];
			byteout_head[447]=std_ac_chrominance_values[16];
			byteout_head[448]=std_ac_chrominance_values[17];
			byteout_head[449]=std_ac_chrominance_values[18];
			byteout_head[450]=std_ac_chrominance_values[19];
			byteout_head[451]=std_ac_chrominance_values[20];
			byteout_head[452]=std_ac_chrominance_values[21];
			byteout_head[453]=std_ac_chrominance_values[22];
			byteout_head[454]=std_ac_chrominance_values[23];
			byteout_head[455]=std_ac_chrominance_values[24];
			byteout_head[456]=std_ac_chrominance_values[25];
			byteout_head[457]=std_ac_chrominance_values[26];
			byteout_head[458]=std_ac_chrominance_values[27];
			byteout_head[459]=std_ac_chrominance_values[28];
			byteout_head[460]=std_ac_chrominance_values[29];
			byteout_head[461]=std_ac_chrominance_values[30];
			byteout_head[462]=std_ac_chrominance_values[31];
			byteout_head[463]=std_ac_chrominance_values[32];
			byteout_head[464]=std_ac_chrominance_values[33];
			byteout_head[465]=std_ac_chrominance_values[34];
			byteout_head[466]=std_ac_chrominance_values[35];
			byteout_head[467]=std_ac_chrominance_values[36];
			byteout_head[468]=std_ac_chrominance_values[37];
			byteout_head[469]=std_ac_chrominance_values[38];
			byteout_head[470]=std_ac_chrominance_values[39];
			byteout_head[471]=std_ac_chrominance_values[40];
			byteout_head[472]=std_ac_chrominance_values[41];
			byteout_head[473]=std_ac_chrominance_values[42];
			byteout_head[474]=std_ac_chrominance_values[43];
			byteout_head[475]=std_ac_chrominance_values[44];
			byteout_head[476]=std_ac_chrominance_values[45];
			byteout_head[477]=std_ac_chrominance_values[46];
			byteout_head[478]=std_ac_chrominance_values[47];
			byteout_head[479]=std_ac_chrominance_values[48];
			byteout_head[480]=std_ac_chrominance_values[49];
			byteout_head[481]=std_ac_chrominance_values[50];
			byteout_head[482]=std_ac_chrominance_values[51];
			byteout_head[483]=std_ac_chrominance_values[52];
			byteout_head[484]=std_ac_chrominance_values[53];
			byteout_head[485]=std_ac_chrominance_values[54];
			byteout_head[486]=std_ac_chrominance_values[55];
			byteout_head[487]=std_ac_chrominance_values[56];
			byteout_head[488]=std_ac_chrominance_values[57];
			byteout_head[489]=std_ac_chrominance_values[58];
			byteout_head[490]=std_ac_chrominance_values[59];
			byteout_head[491]=std_ac_chrominance_values[60];
			byteout_head[492]=std_ac_chrominance_values[61];
			byteout_head[493]=std_ac_chrominance_values[62];
			byteout_head[494]=std_ac_chrominance_values[63];
			byteout_head[495]=std_ac_chrominance_values[64];
			byteout_head[496]=std_ac_chrominance_values[65];
			byteout_head[497]=std_ac_chrominance_values[66];
			byteout_head[498]=std_ac_chrominance_values[67];
			byteout_head[499]=std_ac_chrominance_values[68];
			byteout_head[500]=std_ac_chrominance_values[69];
			byteout_head[501]=std_ac_chrominance_values[70];
			byteout_head[502]=std_ac_chrominance_values[71];
			byteout_head[503]=std_ac_chrominance_values[72];
			byteout_head[504]=std_ac_chrominance_values[73];
			byteout_head[505]=std_ac_chrominance_values[74];
			byteout_head[506]=std_ac_chrominance_values[75];
			byteout_head[507]=std_ac_chrominance_values[76];
			byteout_head[508]=std_ac_chrominance_values[77];
			byteout_head[509]=std_ac_chrominance_values[78];
			byteout_head[510]=std_ac_chrominance_values[79];
			byteout_head[511]=std_ac_chrominance_values[80];
			byteout_head[512]=std_ac_chrominance_values[81];
			byteout_head[513]=std_ac_chrominance_values[82];
			byteout_head[514]=std_ac_chrominance_values[83];
			byteout_head[515]=std_ac_chrominance_values[84];
			byteout_head[516]=std_ac_chrominance_values[85];
			byteout_head[517]=std_ac_chrominance_values[86];
			byteout_head[518]=std_ac_chrominance_values[87];
			byteout_head[519]=std_ac_chrominance_values[88];
			byteout_head[520]=std_ac_chrominance_values[89];
			byteout_head[521]=std_ac_chrominance_values[90];
			byteout_head[522]=std_ac_chrominance_values[91];
			byteout_head[523]=std_ac_chrominance_values[92];
			byteout_head[524]=std_ac_chrominance_values[93];
			byteout_head[525]=std_ac_chrominance_values[94];
			byteout_head[526]=std_ac_chrominance_values[95];
			byteout_head[527]=std_ac_chrominance_values[96];
			byteout_head[528]=std_ac_chrominance_values[97];
			byteout_head[529]=std_ac_chrominance_values[98];
			byteout_head[530]=std_ac_chrominance_values[99];
			byteout_head[531]=std_ac_chrominance_values[100];
			byteout_head[532]=std_ac_chrominance_values[101];
			byteout_head[533]=std_ac_chrominance_values[102];
			byteout_head[534]=std_ac_chrominance_values[103];
			byteout_head[535]=std_ac_chrominance_values[104];
			byteout_head[536]=std_ac_chrominance_values[105];
			byteout_head[537]=std_ac_chrominance_values[106];
			byteout_head[538]=std_ac_chrominance_values[107];
			byteout_head[539]=std_ac_chrominance_values[108];
			byteout_head[540]=std_ac_chrominance_values[109];
			byteout_head[541]=std_ac_chrominance_values[110];
			byteout_head[542]=std_ac_chrominance_values[111];
			byteout_head[543]=std_ac_chrominance_values[112];
			byteout_head[544]=std_ac_chrominance_values[113];
			byteout_head[545]=std_ac_chrominance_values[114];
			byteout_head[546]=std_ac_chrominance_values[115];
			byteout_head[547]=std_ac_chrominance_values[116];
			byteout_head[548]=std_ac_chrominance_values[117];
			byteout_head[549]=std_ac_chrominance_values[118];
			byteout_head[550]=std_ac_chrominance_values[119];
			byteout_head[551]=std_ac_chrominance_values[120];
			byteout_head[552]=std_ac_chrominance_values[121];
			byteout_head[553]=std_ac_chrominance_values[122];
			byteout_head[554]=std_ac_chrominance_values[123];
			byteout_head[555]=std_ac_chrominance_values[124];
			byteout_head[556]=std_ac_chrominance_values[125];
			byteout_head[557]=std_ac_chrominance_values[126];
			byteout_head[558]=std_ac_chrominance_values[127];
			byteout_head[559]=std_ac_chrominance_values[128];
			byteout_head[560]=std_ac_chrominance_values[129];
			byteout_head[561]=std_ac_chrominance_values[130];
			byteout_head[562]=std_ac_chrominance_values[131];
			byteout_head[563]=std_ac_chrominance_values[132];
			byteout_head[564]=std_ac_chrominance_values[133];
			byteout_head[565]=std_ac_chrominance_values[134];
			byteout_head[566]=std_ac_chrominance_values[135];
			byteout_head[567]=std_ac_chrominance_values[136];
			byteout_head[568]=std_ac_chrominance_values[137];
			byteout_head[569]=std_ac_chrominance_values[138];
			byteout_head[570]=std_ac_chrominance_values[139];
			byteout_head[571]=std_ac_chrominance_values[140];
			byteout_head[572]=std_ac_chrominance_values[141];
			byteout_head[573]=std_ac_chrominance_values[142];
			byteout_head[574]=std_ac_chrominance_values[143];
			byteout_head[575]=std_ac_chrominance_values[144];
			byteout_head[576]=std_ac_chrominance_values[145];
			byteout_head[577]=std_ac_chrominance_values[146];
			byteout_head[578]=std_ac_chrominance_values[147];
			byteout_head[579]=std_ac_chrominance_values[148];
			byteout_head[580]=std_ac_chrominance_values[149];
			byteout_head[581]=std_ac_chrominance_values[150];
			byteout_head[582]=std_ac_chrominance_values[151];
			byteout_head[583]=std_ac_chrominance_values[152];
			byteout_head[584]=std_ac_chrominance_values[153];
			byteout_head[585]=std_ac_chrominance_values[154];
			byteout_head[586]=std_ac_chrominance_values[155];
			byteout_head[587]=std_ac_chrominance_values[156];
			byteout_head[588]=std_ac_chrominance_values[157];
			byteout_head[589]=std_ac_chrominance_values[158];
			byteout_head[590]=std_ac_chrominance_values[159];
			byteout_head[591]=std_ac_chrominance_values[160];
			byteout_head[592]=std_ac_chrominance_values[161];
			
			//writeSOS
			byteout_head[593]=0xFF;
			byteout_head[594]=0xDA;	// marker
			byteout_head[595]=0;
			byteout_head[596]=12;		// length
			byteout_head[597]=3;		// nrofcomponents
			byteout_head[598]=1;		// IdY
			byteout_head[599]=0;		// HTY
			byteout_head[600]=2;		// IdU
			byteout_head[601]=0x11;	// HTU
			byteout_head[602]=3;		// IdV
			byteout_head[603]=0x11;	// HTV
			byteout_head[604]=0;		// Ss
			byteout_head[605]=0x3f;	// Se
			byteout_head[606]=0;		// Bf
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Converts the pixels of BitmapData object
		 *  to a JPEG-encoded ByteArray object.
		 *
		 *  @param bitmapData The input BitmapData object.
		 *
		 *  @return Returns a ByteArray object containing JPEG-encoded image data.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function encode(bitmapData:BitmapData):ByteArray{
			return internalEncode(
				bitmapData,
				bitmapData.width,
				bitmapData.height
			);
		}
		
		/**
		 *  Converts a ByteArray object containing raw pixels
		 *  in 32-bit ARGB (Alpha, Red, Green, Blue) format
		 *  to a new JPEG-encoded ByteArray object. 
		 *  The original ByteArray is left unchanged.
		 *  Transparency is not supported; however you still must represent
		 *  each pixel as four bytes in ARGB format.
		 *
		 *  @param byteArray The input ByteArray object containing raw pixels.
		 *  This ByteArray should contain
		 *  <code>4 * width * height</code> bytes.
		 *  Each pixel is represented by 4 bytes, in the order ARGB.
		 *  The first four bytes represent the top-left pixel of the image.
		 *  The next four bytes represent the pixel to its right, etc.
		 *  Each row follows the previous one without any padding.
		 *
		 *  @param width The width of the input image, in pixels.
		 *
		 *  @param height The height of the input image, in pixels.
		 *
		 *  @param transparent If <code>false</code>,
		 *  alpha channel information is ignored.
		 *
		 *  @return Returns a ByteArray object containing JPEG-encoded image data. 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function encodeByteArray(
			byteArray:ByteArray,
			width:int,
			height:int
		):ByteArray{
			return internalEncode(
				byteArray,
				width,
				height
			);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods: Initialization
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 *  Initializes the Huffman tables YDC_HT, UVDC_HT, YAC_HT, and UVAC_HT.
		 */
		private function initHuffmanTbl():void
		{
			YDC_HT = computeHuffmanTbl(std_dc_luminance_nrcodes,
				std_dc_luminance_values);
			
			UVDC_HT = computeHuffmanTbl(std_dc_chrominance_nrcodes,
				std_dc_chrominance_values);
			
			YAC_HT = computeHuffmanTbl(std_ac_luminance_nrcodes,
				std_ac_luminance_values);
			
			UVAC_HT = computeHuffmanTbl(std_ac_chrominance_nrcodes,
				std_ac_chrominance_values);
			
		}
		
		/**
		 *  @private
		 */
		private function computeHuffmanTbl(nrcodes:Vector.<int>, std_table:Vector.<int>):Vector.<int>
		{
			var codevalue:int = 0;
			var pos_in_table:int = 0;
			
			var HT:Vector.<int> = new Vector.<int>((std_table[std_table.length-1]+1)*2);
			HT.fixed=true;
			
			var bitStringId:int;
			for (var k:int = 1; k <= 16; k++)
			{
				for (var j:int = 1; j <= nrcodes[k]; j++)
				{
					bitStringId=std_table[pos_in_table]*2;
					HT[bitStringId] = codevalue;
					HT[bitStringId+1] = k;
					
					pos_in_table++;
					codevalue++;
				}
				
				codevalue *= 2;
			}
			
			return HT;
		}
		
		/**
		 *  @private
		 *  Initializes the category and bitcode arrays.
		 */
		private function initCategoryNumber():void
		{
			var nr:int;
			
			var nrlower:int = 1;
			var nrupper:int = 2;
			
			category=new Vector.<int>(65535);
			category.fixed=true;
			bitcode=new Vector.<int>(65535*2);
			bitcode.fixed=true;
			
			var bitStringId:int;
			
			for (var cat:int = 1; cat <= 15; cat++)
			{
				// Positive numbers
				for (nr = nrlower; nr < nrupper; nr++)
				{
					bitStringId=32767 + nr;
					
					category[bitStringId] = cat;
					
					bitStringId*=2;
					bitcode[bitStringId]=nr;
					bitcode[bitStringId+1]=cat;
				}
				
				// Negative numbers
				for (nr = -(nrupper - 1); nr <= -nrlower; nr++)
				{
					bitStringId=32767 + nr;
					
					category[bitStringId] = cat;
					
					bitStringId*=2;
					bitcode[bitStringId]=nrupper - 1 + nr;
					bitcode[bitStringId+1]=cat;
				}
				
				nrlower <<= 1;
				nrupper <<= 1;
			}
		}
		
		/**
		 *  @private
		 *  Initializes YTable, UVTable, fdtbl_Y, and fdtbl_UV.
		 */
		private function initQuantTables(sf:int):void
		{
			//var i:int = 0;
			//var t:int;
			
			//for (i = 0; i < 64; i++){
			//	t = Math.floor((YQT[i] * sf + 50)/100);
			//	if (t < 1){
			//		t = 1;
			//	}else if (t > 255){
			//		t = 255;
			//	}
			//	this["YTable_"+ZigZag[i]] = t;
			//}
			
			YTable_0 = Math.floor(0.16 * sf + 0.5);if (YTable_0 < 1){YTable_0 = 1;}else if (YTable_0 > 255){YTable_0 = 255;}
			YTable_1 = Math.floor(0.11 * sf + 0.5);if (YTable_1 < 1){YTable_1 = 1;}else if (YTable_1 > 255){YTable_1 = 255;}
			YTable_5 = Math.floor(0.1 * sf + 0.5);if (YTable_5 < 1){YTable_5 = 1;}else if (YTable_5 > 255){YTable_5 = 255;}
			YTable_6 = Math.floor(0.16 * sf + 0.5);if (YTable_6 < 1){YTable_6 = 1;}else if (YTable_6 > 255){YTable_6 = 255;}
			YTable_14 = Math.floor(0.24 * sf + 0.5);if (YTable_14 < 1){YTable_14 = 1;}else if (YTable_14 > 255){YTable_14 = 255;}
			YTable_15 = Math.floor(0.4 * sf + 0.5);if (YTable_15 < 1){YTable_15 = 1;}else if (YTable_15 > 255){YTable_15 = 255;}
			YTable_27 = Math.floor(0.51 * sf + 0.5);if (YTable_27 < 1){YTable_27 = 1;}else if (YTable_27 > 255){YTable_27 = 255;}
			YTable_28 = Math.floor(0.61 * sf + 0.5);if (YTable_28 < 1){YTable_28 = 1;}else if (YTable_28 > 255){YTable_28 = 255;}
			YTable_2 = Math.floor(0.12 * sf + 0.5);if (YTable_2 < 1){YTable_2 = 1;}else if (YTable_2 > 255){YTable_2 = 255;}
			YTable_4 = Math.floor(0.12 * sf + 0.5);if (YTable_4 < 1){YTable_4 = 1;}else if (YTable_4 > 255){YTable_4 = 255;}
			YTable_7 = Math.floor(0.14 * sf + 0.5);if (YTable_7 < 1){YTable_7 = 1;}else if (YTable_7 > 255){YTable_7 = 255;}
			YTable_13 = Math.floor(0.19 * sf + 0.5);if (YTable_13 < 1){YTable_13 = 1;}else if (YTable_13 > 255){YTable_13 = 255;}
			YTable_16 = Math.floor(0.26 * sf + 0.5);if (YTable_16 < 1){YTable_16 = 1;}else if (YTable_16 > 255){YTable_16 = 255;}
			YTable_26 = Math.floor(0.58 * sf + 0.5);if (YTable_26 < 1){YTable_26 = 1;}else if (YTable_26 > 255){YTable_26 = 255;}
			YTable_29 = Math.floor(0.6 * sf + 0.5);if (YTable_29 < 1){YTable_29 = 1;}else if (YTable_29 > 255){YTable_29 = 255;}
			YTable_42 = Math.floor(0.55 * sf + 0.5);if (YTable_42 < 1){YTable_42 = 1;}else if (YTable_42 > 255){YTable_42 = 255;}
			YTable_3 = Math.floor(0.14 * sf + 0.5);if (YTable_3 < 1){YTable_3 = 1;}else if (YTable_3 > 255){YTable_3 = 255;}
			YTable_8 = Math.floor(0.13 * sf + 0.5);if (YTable_8 < 1){YTable_8 = 1;}else if (YTable_8 > 255){YTable_8 = 255;}
			YTable_12 = Math.floor(0.16 * sf + 0.5);if (YTable_12 < 1){YTable_12 = 1;}else if (YTable_12 > 255){YTable_12 = 255;}
			YTable_17 = Math.floor(0.24 * sf + 0.5);if (YTable_17 < 1){YTable_17 = 1;}else if (YTable_17 > 255){YTable_17 = 255;}
			YTable_25 = Math.floor(0.4 * sf + 0.5);if (YTable_25 < 1){YTable_25 = 1;}else if (YTable_25 > 255){YTable_25 = 255;}
			YTable_30 = Math.floor(0.57 * sf + 0.5);if (YTable_30 < 1){YTable_30 = 1;}else if (YTable_30 > 255){YTable_30 = 255;}
			YTable_41 = Math.floor(0.69 * sf + 0.5);if (YTable_41 < 1){YTable_41 = 1;}else if (YTable_41 > 255){YTable_41 = 255;}
			YTable_43 = Math.floor(0.56 * sf + 0.5);if (YTable_43 < 1){YTable_43 = 1;}else if (YTable_43 > 255){YTable_43 = 255;}
			YTable_9 = Math.floor(0.14 * sf + 0.5);if (YTable_9 < 1){YTable_9 = 1;}else if (YTable_9 > 255){YTable_9 = 255;}
			YTable_11 = Math.floor(0.17 * sf + 0.5);if (YTable_11 < 1){YTable_11 = 1;}else if (YTable_11 > 255){YTable_11 = 255;}
			YTable_18 = Math.floor(0.22 * sf + 0.5);if (YTable_18 < 1){YTable_18 = 1;}else if (YTable_18 > 255){YTable_18 = 255;}
			YTable_24 = Math.floor(0.29 * sf + 0.5);if (YTable_24 < 1){YTable_24 = 1;}else if (YTable_24 > 255){YTable_24 = 255;}
			YTable_31 = Math.floor(0.51 * sf + 0.5);if (YTable_31 < 1){YTable_31 = 1;}else if (YTable_31 > 255){YTable_31 = 255;}
			YTable_40 = Math.floor(0.87 * sf + 0.5);if (YTable_40 < 1){YTable_40 = 1;}else if (YTable_40 > 255){YTable_40 = 255;}
			YTable_44 = Math.floor(0.8 * sf + 0.5);if (YTable_44 < 1){YTable_44 = 1;}else if (YTable_44 > 255){YTable_44 = 255;}
			YTable_53 = Math.floor(0.62 * sf + 0.5);if (YTable_53 < 1){YTable_53 = 1;}else if (YTable_53 > 255){YTable_53 = 255;}
			YTable_10 = Math.floor(0.18 * sf + 0.5);if (YTable_10 < 1){YTable_10 = 1;}else if (YTable_10 > 255){YTable_10 = 255;}
			YTable_19 = Math.floor(0.22 * sf + 0.5);if (YTable_19 < 1){YTable_19 = 1;}else if (YTable_19 > 255){YTable_19 = 255;}
			YTable_23 = Math.floor(0.37 * sf + 0.5);if (YTable_23 < 1){YTable_23 = 1;}else if (YTable_23 > 255){YTable_23 = 255;}
			YTable_32 = Math.floor(0.56 * sf + 0.5);if (YTable_32 < 1){YTable_32 = 1;}else if (YTable_32 > 255){YTable_32 = 255;}
			YTable_39 = Math.floor(0.68 * sf + 0.5);if (YTable_39 < 1){YTable_39 = 1;}else if (YTable_39 > 255){YTable_39 = 255;}
			YTable_45 = Math.floor(1.09 * sf + 0.5);if (YTable_45 < 1){YTable_45 = 1;}else if (YTable_45 > 255){YTable_45 = 255;}
			YTable_52 = Math.floor(1.03 * sf + 0.5);if (YTable_52 < 1){YTable_52 = 1;}else if (YTable_52 > 255){YTable_52 = 255;}
			YTable_54 = Math.floor(0.77 * sf + 0.5);if (YTable_54 < 1){YTable_54 = 1;}else if (YTable_54 > 255){YTable_54 = 255;}
			YTable_20 = Math.floor(0.24 * sf + 0.5);if (YTable_20 < 1){YTable_20 = 1;}else if (YTable_20 > 255){YTable_20 = 255;}
			YTable_22 = Math.floor(0.35 * sf + 0.5);if (YTable_22 < 1){YTable_22 = 1;}else if (YTable_22 > 255){YTable_22 = 255;}
			YTable_33 = Math.floor(0.55 * sf + 0.5);if (YTable_33 < 1){YTable_33 = 1;}else if (YTable_33 > 255){YTable_33 = 255;}
			YTable_38 = Math.floor(0.64 * sf + 0.5);if (YTable_38 < 1){YTable_38 = 1;}else if (YTable_38 > 255){YTable_38 = 255;}
			YTable_46 = Math.floor(0.81 * sf + 0.5);if (YTable_46 < 1){YTable_46 = 1;}else if (YTable_46 > 255){YTable_46 = 255;}
			YTable_51 = Math.floor(1.04 * sf + 0.5);if (YTable_51 < 1){YTable_51 = 1;}else if (YTable_51 > 255){YTable_51 = 255;}
			YTable_55 = Math.floor(1.13 * sf + 0.5);if (YTable_55 < 1){YTable_55 = 1;}else if (YTable_55 > 255){YTable_55 = 255;}
			YTable_60 = Math.floor(0.92 * sf + 0.5);if (YTable_60 < 1){YTable_60 = 1;}else if (YTable_60 > 255){YTable_60 = 255;}
			YTable_21 = Math.floor(0.49 * sf + 0.5);if (YTable_21 < 1){YTable_21 = 1;}else if (YTable_21 > 255){YTable_21 = 255;}
			YTable_34 = Math.floor(0.64 * sf + 0.5);if (YTable_34 < 1){YTable_34 = 1;}else if (YTable_34 > 255){YTable_34 = 255;}
			YTable_37 = Math.floor(0.78 * sf + 0.5);if (YTable_37 < 1){YTable_37 = 1;}else if (YTable_37 > 255){YTable_37 = 255;}
			YTable_47 = Math.floor(0.87 * sf + 0.5);if (YTable_47 < 1){YTable_47 = 1;}else if (YTable_47 > 255){YTable_47 = 255;}
			YTable_50 = Math.floor(1.03 * sf + 0.5);if (YTable_50 < 1){YTable_50 = 1;}else if (YTable_50 > 255){YTable_50 = 255;}
			YTable_56 = Math.floor(1.21 * sf + 0.5);if (YTable_56 < 1){YTable_56 = 1;}else if (YTable_56 > 255){YTable_56 = 255;}
			YTable_59 = Math.floor(1.2 * sf + 0.5);if (YTable_59 < 1){YTable_59 = 1;}else if (YTable_59 > 255){YTable_59 = 255;}
			YTable_61 = Math.floor(1.01 * sf + 0.5);if (YTable_61 < 1){YTable_61 = 1;}else if (YTable_61 > 255){YTable_61 = 255;}
			YTable_35 = Math.floor(0.72 * sf + 0.5);if (YTable_35 < 1){YTable_35 = 1;}else if (YTable_35 > 255){YTable_35 = 255;}
			YTable_36 = Math.floor(0.92 * sf + 0.5);if (YTable_36 < 1){YTable_36 = 1;}else if (YTable_36 > 255){YTable_36 = 255;}
			YTable_48 = Math.floor(0.95 * sf + 0.5);if (YTable_48 < 1){YTable_48 = 1;}else if (YTable_48 > 255){YTable_48 = 255;}
			YTable_49 = Math.floor(0.98 * sf + 0.5);if (YTable_49 < 1){YTable_49 = 1;}else if (YTable_49 > 255){YTable_49 = 255;}
			YTable_57 = Math.floor(1.12 * sf + 0.5);if (YTable_57 < 1){YTable_57 = 1;}else if (YTable_57 > 255){YTable_57 = 255;}
			YTable_58 = Math.floor(1 * sf + 0.5);if (YTable_58 < 1){YTable_58 = 1;}else if (YTable_58 > 255){YTable_58 = 255;}
			YTable_62 = Math.floor(1.03 * sf + 0.5);if (YTable_62 < 1){YTable_62 = 1;}else if (YTable_62 > 255){YTable_62 = 255;}
			YTable_63 = Math.floor(0.99 * sf + 0.5);if (YTable_63 < 1){YTable_63 = 1;}else if (YTable_63 > 255){YTable_63 = 255;}
			
			//for (i = 0; i < 64; i++){
			//	t = Math.floor((UVQT[i] * sf + 50) / 100);
			//	if (t < 1){
			//		t = 1;
			//	}else if (t > 255){
			//		t = 255;
			//	}
			//	this["UVTable_"+ZigZag[i]] = t;
			//}
			
			UVTable_0 = Math.floor(0.17 * sf + 0.5);if (UVTable_0 < 1){UVTable_0 = 1;}else if (UVTable_0 > 255){UVTable_0 = 255;}
			UVTable_1 = Math.floor(0.18 * sf + 0.5);if (UVTable_1 < 1){UVTable_1 = 1;}else if (UVTable_1 > 255){UVTable_1 = 255;}
			UVTable_5 = Math.floor(0.24 * sf + 0.5);if (UVTable_5 < 1){UVTable_5 = 1;}else if (UVTable_5 > 255){UVTable_5 = 255;}
			UVTable_6 = Math.floor(0.47 * sf + 0.5);if (UVTable_6 < 1){UVTable_6 = 1;}else if (UVTable_6 > 255){UVTable_6 = 255;}
			UVTable_14 = Math.floor(0.99 * sf + 0.5);if (UVTable_14 < 1){UVTable_14 = 1;}else if (UVTable_14 > 255){UVTable_14 = 255;}
			UVTable_15 = Math.floor(0.99 * sf + 0.5);if (UVTable_15 < 1){UVTable_15 = 1;}else if (UVTable_15 > 255){UVTable_15 = 255;}
			UVTable_27 = Math.floor(0.99 * sf + 0.5);if (UVTable_27 < 1){UVTable_27 = 1;}else if (UVTable_27 > 255){UVTable_27 = 255;}
			UVTable_28 = Math.floor(0.99 * sf + 0.5);if (UVTable_28 < 1){UVTable_28 = 1;}else if (UVTable_28 > 255){UVTable_28 = 255;}
			UVTable_2 = Math.floor(0.18 * sf + 0.5);if (UVTable_2 < 1){UVTable_2 = 1;}else if (UVTable_2 > 255){UVTable_2 = 255;}
			UVTable_4 = Math.floor(0.21 * sf + 0.5);if (UVTable_4 < 1){UVTable_4 = 1;}else if (UVTable_4 > 255){UVTable_4 = 255;}
			UVTable_7 = Math.floor(0.26 * sf + 0.5);if (UVTable_7 < 1){UVTable_7 = 1;}else if (UVTable_7 > 255){UVTable_7 = 255;}
			UVTable_13 = Math.floor(0.66 * sf + 0.5);if (UVTable_13 < 1){UVTable_13 = 1;}else if (UVTable_13 > 255){UVTable_13 = 255;}
			UVTable_16 = Math.floor(0.99 * sf + 0.5);if (UVTable_16 < 1){UVTable_16 = 1;}else if (UVTable_16 > 255){UVTable_16 = 255;}
			UVTable_26 = Math.floor(0.99 * sf + 0.5);if (UVTable_26 < 1){UVTable_26 = 1;}else if (UVTable_26 > 255){UVTable_26 = 255;}
			UVTable_29 = Math.floor(0.99 * sf + 0.5);if (UVTable_29 < 1){UVTable_29 = 1;}else if (UVTable_29 > 255){UVTable_29 = 255;}
			UVTable_42 = Math.floor(0.99 * sf + 0.5);if (UVTable_42 < 1){UVTable_42 = 1;}else if (UVTable_42 > 255){UVTable_42 = 255;}
			UVTable_3 = Math.floor(0.24 * sf + 0.5);if (UVTable_3 < 1){UVTable_3 = 1;}else if (UVTable_3 > 255){UVTable_3 = 255;}
			UVTable_8 = Math.floor(0.26 * sf + 0.5);if (UVTable_8 < 1){UVTable_8 = 1;}else if (UVTable_8 > 255){UVTable_8 = 255;}
			UVTable_12 = Math.floor(0.56 * sf + 0.5);if (UVTable_12 < 1){UVTable_12 = 1;}else if (UVTable_12 > 255){UVTable_12 = 255;}
			UVTable_17 = Math.floor(0.99 * sf + 0.5);if (UVTable_17 < 1){UVTable_17 = 1;}else if (UVTable_17 > 255){UVTable_17 = 255;}
			UVTable_25 = Math.floor(0.99 * sf + 0.5);if (UVTable_25 < 1){UVTable_25 = 1;}else if (UVTable_25 > 255){UVTable_25 = 255;}
			UVTable_30 = Math.floor(0.99 * sf + 0.5);if (UVTable_30 < 1){UVTable_30 = 1;}else if (UVTable_30 > 255){UVTable_30 = 255;}
			UVTable_41 = Math.floor(0.99 * sf + 0.5);if (UVTable_41 < 1){UVTable_41 = 1;}else if (UVTable_41 > 255){UVTable_41 = 255;}
			UVTable_43 = Math.floor(0.99 * sf + 0.5);if (UVTable_43 < 1){UVTable_43 = 1;}else if (UVTable_43 > 255){UVTable_43 = 255;}
			UVTable_9 = Math.floor(0.47 * sf + 0.5);if (UVTable_9 < 1){UVTable_9 = 1;}else if (UVTable_9 > 255){UVTable_9 = 255;}
			UVTable_11 = Math.floor(0.66 * sf + 0.5);if (UVTable_11 < 1){UVTable_11 = 1;}else if (UVTable_11 > 255){UVTable_11 = 255;}
			UVTable_18 = Math.floor(0.99 * sf + 0.5);if (UVTable_18 < 1){UVTable_18 = 1;}else if (UVTable_18 > 255){UVTable_18 = 255;}
			UVTable_24 = Math.floor(0.99 * sf + 0.5);if (UVTable_24 < 1){UVTable_24 = 1;}else if (UVTable_24 > 255){UVTable_24 = 255;}
			UVTable_31 = Math.floor(0.99 * sf + 0.5);if (UVTable_31 < 1){UVTable_31 = 1;}else if (UVTable_31 > 255){UVTable_31 = 255;}
			UVTable_40 = Math.floor(0.99 * sf + 0.5);if (UVTable_40 < 1){UVTable_40 = 1;}else if (UVTable_40 > 255){UVTable_40 = 255;}
			UVTable_44 = Math.floor(0.99 * sf + 0.5);if (UVTable_44 < 1){UVTable_44 = 1;}else if (UVTable_44 > 255){UVTable_44 = 255;}
			UVTable_53 = Math.floor(0.99 * sf + 0.5);if (UVTable_53 < 1){UVTable_53 = 1;}else if (UVTable_53 > 255){UVTable_53 = 255;}
			UVTable_10 = Math.floor(0.99 * sf + 0.5);if (UVTable_10 < 1){UVTable_10 = 1;}else if (UVTable_10 > 255){UVTable_10 = 255;}
			UVTable_19 = Math.floor(0.99 * sf + 0.5);if (UVTable_19 < 1){UVTable_19 = 1;}else if (UVTable_19 > 255){UVTable_19 = 255;}
			UVTable_23 = Math.floor(0.99 * sf + 0.5);if (UVTable_23 < 1){UVTable_23 = 1;}else if (UVTable_23 > 255){UVTable_23 = 255;}
			UVTable_32 = Math.floor(0.99 * sf + 0.5);if (UVTable_32 < 1){UVTable_32 = 1;}else if (UVTable_32 > 255){UVTable_32 = 255;}
			UVTable_39 = Math.floor(0.99 * sf + 0.5);if (UVTable_39 < 1){UVTable_39 = 1;}else if (UVTable_39 > 255){UVTable_39 = 255;}
			UVTable_45 = Math.floor(0.99 * sf + 0.5);if (UVTable_45 < 1){UVTable_45 = 1;}else if (UVTable_45 > 255){UVTable_45 = 255;}
			UVTable_52 = Math.floor(0.99 * sf + 0.5);if (UVTable_52 < 1){UVTable_52 = 1;}else if (UVTable_52 > 255){UVTable_52 = 255;}
			UVTable_54 = Math.floor(0.99 * sf + 0.5);if (UVTable_54 < 1){UVTable_54 = 1;}else if (UVTable_54 > 255){UVTable_54 = 255;}
			UVTable_20 = Math.floor(0.99 * sf + 0.5);if (UVTable_20 < 1){UVTable_20 = 1;}else if (UVTable_20 > 255){UVTable_20 = 255;}
			UVTable_22 = Math.floor(0.99 * sf + 0.5);if (UVTable_22 < 1){UVTable_22 = 1;}else if (UVTable_22 > 255){UVTable_22 = 255;}
			UVTable_33 = Math.floor(0.99 * sf + 0.5);if (UVTable_33 < 1){UVTable_33 = 1;}else if (UVTable_33 > 255){UVTable_33 = 255;}
			UVTable_38 = Math.floor(0.99 * sf + 0.5);if (UVTable_38 < 1){UVTable_38 = 1;}else if (UVTable_38 > 255){UVTable_38 = 255;}
			UVTable_46 = Math.floor(0.99 * sf + 0.5);if (UVTable_46 < 1){UVTable_46 = 1;}else if (UVTable_46 > 255){UVTable_46 = 255;}
			UVTable_51 = Math.floor(0.99 * sf + 0.5);if (UVTable_51 < 1){UVTable_51 = 1;}else if (UVTable_51 > 255){UVTable_51 = 255;}
			UVTable_55 = Math.floor(0.99 * sf + 0.5);if (UVTable_55 < 1){UVTable_55 = 1;}else if (UVTable_55 > 255){UVTable_55 = 255;}
			UVTable_60 = Math.floor(0.99 * sf + 0.5);if (UVTable_60 < 1){UVTable_60 = 1;}else if (UVTable_60 > 255){UVTable_60 = 255;}
			UVTable_21 = Math.floor(0.99 * sf + 0.5);if (UVTable_21 < 1){UVTable_21 = 1;}else if (UVTable_21 > 255){UVTable_21 = 255;}
			UVTable_34 = Math.floor(0.99 * sf + 0.5);if (UVTable_34 < 1){UVTable_34 = 1;}else if (UVTable_34 > 255){UVTable_34 = 255;}
			UVTable_37 = Math.floor(0.99 * sf + 0.5);if (UVTable_37 < 1){UVTable_37 = 1;}else if (UVTable_37 > 255){UVTable_37 = 255;}
			UVTable_47 = Math.floor(0.99 * sf + 0.5);if (UVTable_47 < 1){UVTable_47 = 1;}else if (UVTable_47 > 255){UVTable_47 = 255;}
			UVTable_50 = Math.floor(0.99 * sf + 0.5);if (UVTable_50 < 1){UVTable_50 = 1;}else if (UVTable_50 > 255){UVTable_50 = 255;}
			UVTable_56 = Math.floor(0.99 * sf + 0.5);if (UVTable_56 < 1){UVTable_56 = 1;}else if (UVTable_56 > 255){UVTable_56 = 255;}
			UVTable_59 = Math.floor(0.99 * sf + 0.5);if (UVTable_59 < 1){UVTable_59 = 1;}else if (UVTable_59 > 255){UVTable_59 = 255;}
			UVTable_61 = Math.floor(0.99 * sf + 0.5);if (UVTable_61 < 1){UVTable_61 = 1;}else if (UVTable_61 > 255){UVTable_61 = 255;}
			UVTable_35 = Math.floor(0.99 * sf + 0.5);if (UVTable_35 < 1){UVTable_35 = 1;}else if (UVTable_35 > 255){UVTable_35 = 255;}
			UVTable_36 = Math.floor(0.99 * sf + 0.5);if (UVTable_36 < 1){UVTable_36 = 1;}else if (UVTable_36 > 255){UVTable_36 = 255;}
			UVTable_48 = Math.floor(0.99 * sf + 0.5);if (UVTable_48 < 1){UVTable_48 = 1;}else if (UVTable_48 > 255){UVTable_48 = 255;}
			UVTable_49 = Math.floor(0.99 * sf + 0.5);if (UVTable_49 < 1){UVTable_49 = 1;}else if (UVTable_49 > 255){UVTable_49 = 255;}
			UVTable_57 = Math.floor(0.99 * sf + 0.5);if (UVTable_57 < 1){UVTable_57 = 1;}else if (UVTable_57 > 255){UVTable_57 = 255;}
			UVTable_58 = Math.floor(0.99 * sf + 0.5);if (UVTable_58 < 1){UVTable_58 = 1;}else if (UVTable_58 > 255){UVTable_58 = 255;}
			UVTable_62 = Math.floor(0.99 * sf + 0.5);if (UVTable_62 < 1){UVTable_62 = 1;}else if (UVTable_62 > 255){UVTable_62 = 255;}
			UVTable_63 = Math.floor(0.99 * sf + 0.5);if (UVTable_63 < 1){UVTable_63 = 1;}else if (UVTable_63 > 255){UVTable_63 = 255;}
			
			//for (var row:int = 0; row < 8; row++)
			//{
			//	for (var col:int = 0; col < 8; col++)
			//	{
			//		fdtbl_Y[i] =
			//			(1.0 / (this["YTable_"+ZigZag[i]] * aasf[row] * aasf[col] * 8.0));
			//		
			//		fdtbl_UV[i] =
			//			(1.0 / (this["UVTable_"+ZigZag[i]] * aasf[row] * aasf[col] * 8.0));
			//		
			//		i++;
			//	}
			//}
			fdtbl_Y_0 = 0.125 / YTable_0;
			fdtbl_UV_0 = 0.125 / UVTable_0;
			fdtbl_Y_1 = 0.09011997777179934 / YTable_1;
			fdtbl_UV_1 = 0.09011997777179934 / UVTable_1;
			fdtbl_Y_2 = 0.09567085808222033 / YTable_5;
			fdtbl_UV_2 = 0.09567085808222033 / UVTable_5;
			fdtbl_Y_3 = 0.10630376188381872 / YTable_6;
			fdtbl_UV_3 = 0.10630376188381872 / UVTable_6;
			fdtbl_Y_4 = 0.125 / YTable_14;
			fdtbl_UV_4 = 0.125 / UVTable_14;
			fdtbl_Y_5 = 0.15909482264998828 / YTable_15;
			fdtbl_UV_5 = 0.15909482264998828 / UVTable_15;
			fdtbl_Y_6 = 0.23096988319021516 / YTable_27;
			fdtbl_UV_6 = 0.23096988319021516 / UVTable_27;
			fdtbl_Y_7 = 0.4530637236410742 / YTable_28;
			fdtbl_UV_7 = 0.4530637236410742 / UVTable_28;
			fdtbl_Y_8 = 0.09011997777179934 / YTable_2;
			fdtbl_UV_8 = 0.09011997777179934 / UVTable_2;
			fdtbl_Y_9 = 0.06497288314871685 / YTable_4;
			fdtbl_UV_9 = 0.06497288314871685 / UVTable_4;
			fdtbl_Y_10 = 0.06897484483022932 / YTable_7;
			fdtbl_UV_10 = 0.06897484483022932 / UVTable_7;
			fdtbl_Y_11 = 0.07664074126422714 / YTable_13;
			fdtbl_UV_11 = 0.07664074126422714 / UVTable_13;
			fdtbl_Y_12 = 0.09011997777179934 / YTable_16;
			fdtbl_UV_12 = 0.09011997777179934 / UVTable_16;
			fdtbl_Y_13 = 0.11470097504660243 / YTable_26;
			fdtbl_UV_13 = 0.11470097504660243 / UVTable_26;
			fdtbl_Y_14 = 0.16652000591245825 / YTable_29;
			fdtbl_UV_14 = 0.16652000591245825 / UVTable_29;
			fdtbl_Y_15 = 0.32664074162993795 / YTable_42;
			fdtbl_UV_15 = 0.32664074162993795 / UVTable_42;
			fdtbl_Y_16 = 0.09567085808222033 / YTable_3;
			fdtbl_UV_16 = 0.09567085808222033 / UVTable_3;
			fdtbl_Y_17 = 0.06897484483022932 / YTable_8;
			fdtbl_UV_17 = 0.06897484483022932 / UVTable_8;
			fdtbl_Y_18 = 0.07322330468950675 / YTable_12;
			fdtbl_UV_18 = 0.07322330468950675 / UVTable_12;
			fdtbl_Y_19 = 0.08136137693434371 / YTable_17;
			fdtbl_UV_19 = 0.08136137693434371 / UVTable_17;
			fdtbl_Y_20 = 0.09567085808222033 / YTable_25;
			fdtbl_UV_20 = 0.09567085808222033 / UVTable_25;
			fdtbl_Y_21 = 0.12176590559490434 / YTable_30;
			fdtbl_UV_21 = 0.12176590559490434 / UVTable_30;
			fdtbl_Y_22 = 0.17677669532766466 / YTable_41;
			fdtbl_UV_22 = 0.17677669532766466 / UVTable_41;
			fdtbl_Y_23 = 0.34675996165334005 / YTable_43;
			fdtbl_UV_23 = 0.34675996165334005 / UVTable_43;
			fdtbl_Y_24 = 0.10630376188381872 / YTable_9;
			fdtbl_UV_24 = 0.10630376188381872 / UVTable_9;
			fdtbl_Y_25 = 0.07664074126422714 / YTable_11;
			fdtbl_UV_25 = 0.07664074126422714 / UVTable_11;
			fdtbl_Y_26 = 0.08136137693434371 / YTable_18;
			fdtbl_UV_26 = 0.08136137693434371 / UVTable_18;
			fdtbl_Y_27 = 0.09040391832521304 / YTable_24;
			fdtbl_UV_27 = 0.09040391832521304 / UVTable_24;
			fdtbl_Y_28 = 0.10630376188381872 / YTable_31;
			fdtbl_UV_28 = 0.10630376188381872 / UVTable_31;
			fdtbl_Y_29 = 0.1352990251514618 / YTable_40;
			fdtbl_UV_29 = 0.1352990251514618 / UVTable_40;
			fdtbl_Y_30 = 0.19642373971988847 / YTable_44;
			fdtbl_UV_30 = 0.19642373971988847 / UVTable_44;
			fdtbl_Y_31 = 0.385299025569096 / YTable_53;
			fdtbl_UV_31 = 0.385299025569096 / UVTable_53;
			fdtbl_Y_32 = 0.125 / YTable_10;
			fdtbl_UV_32 = 0.125 / UVTable_10;
			fdtbl_Y_33 = 0.09011997777179934 / YTable_19;
			fdtbl_UV_33 = 0.09011997777179934 / UVTable_19;
			fdtbl_Y_34 = 0.09567085808222033 / YTable_23;
			fdtbl_UV_34 = 0.09567085808222033 / UVTable_23;
			fdtbl_Y_35 = 0.10630376188381872 / YTable_32;
			fdtbl_UV_35 = 0.10630376188381872 / UVTable_32;
			fdtbl_Y_36 = 0.125 / YTable_39;
			fdtbl_UV_36 = 0.125 / UVTable_39;
			fdtbl_Y_37 = 0.15909482264998828 / YTable_45;
			fdtbl_UV_37 = 0.15909482264998828 / UVTable_45;
			fdtbl_Y_38 = 0.23096988319021516 / YTable_52;
			fdtbl_UV_38 = 0.23096988319021516 / UVTable_52;
			fdtbl_Y_39 = 0.4530637236410742 / YTable_54;
			fdtbl_UV_39 = 0.4530637236410742 / UVTable_54;
			fdtbl_Y_40 = 0.15909482264998828 / YTable_20;
			fdtbl_UV_40 = 0.15909482264998828 / UVTable_20;
			fdtbl_Y_41 = 0.11470097504660243 / YTable_22;
			fdtbl_UV_41 = 0.11470097504660243 / UVTable_22;
			fdtbl_Y_42 = 0.12176590559490434 / YTable_33;
			fdtbl_UV_42 = 0.12176590559490434 / UVTable_33;
			fdtbl_Y_43 = 0.1352990251514618 / YTable_38;
			fdtbl_UV_43 = 0.1352990251514618 / UVTable_38;
			fdtbl_Y_44 = 0.15909482264998828 / YTable_46;
			fdtbl_UV_44 = 0.15909482264998828 / UVTable_46;
			fdtbl_Y_45 = 0.20248930075224983 / YTable_51;
			fdtbl_UV_45 = 0.20248930075224983 / UVTable_51;
			fdtbl_Y_46 = 0.29396890082908633 / YTable_55;
			fdtbl_UV_46 = 0.29396890082908633 / UVTable_55;
			fdtbl_Y_47 = 0.5766407420945601 / YTable_60;
			fdtbl_UV_47 = 0.5766407420945601 / UVTable_60;
			fdtbl_Y_48 = 0.23096988319021516 / YTable_21;
			fdtbl_UV_48 = 0.23096988319021516 / UVTable_21;
			fdtbl_Y_49 = 0.16652000591245825 / YTable_34;
			fdtbl_UV_49 = 0.16652000591245825 / UVTable_34;
			fdtbl_Y_50 = 0.17677669532766466 / YTable_37;
			fdtbl_UV_50 = 0.17677669532766466 / UVTable_37;
			fdtbl_Y_51 = 0.19642373971988847 / YTable_47;
			fdtbl_UV_51 = 0.19642373971988847 / UVTable_47;
			fdtbl_Y_52 = 0.23096988319021516 / YTable_50;
			fdtbl_UV_52 = 0.23096988319021516 / UVTable_50;
			fdtbl_Y_53 = 0.29396890082908633 / YTable_56;
			fdtbl_UV_53 = 0.29396890082908633 / UVTable_56;
			fdtbl_Y_54 = 0.42677669552721315 / YTable_59;
			fdtbl_UV_54 = 0.42677669552721315 / UVTable_59;
			fdtbl_Y_55 = 0.8371526026168227 / YTable_61;
			fdtbl_UV_55 = 0.8371526026168227 / UVTable_61;
			fdtbl_Y_56 = 0.4530637236410742 / YTable_35;
			fdtbl_UV_56 = 0.4530637236410742 / UVTable_35;
			fdtbl_Y_57 = 0.32664074162993795 / YTable_36;
			fdtbl_UV_57 = 0.32664074162993795 / UVTable_36;
			fdtbl_Y_58 = 0.34675996165334005 / YTable_48;
			fdtbl_UV_58 = 0.34675996165334005 / UVTable_48;
			fdtbl_Y_59 = 0.385299025569096 / YTable_49;
			fdtbl_UV_59 = 0.385299025569096 / UVTable_49;
			fdtbl_Y_60 = 0.4530637236410742 / YTable_57;
			fdtbl_UV_60 = 0.4530637236410742 / UVTable_57;
			fdtbl_Y_61 = 0.5766407420945601 / YTable_58;
			fdtbl_UV_61 = 0.5766407420945601 / UVTable_58;
			fdtbl_Y_62 = 0.8371526026168227 / YTable_62;
			fdtbl_UV_62 = 0.8371526026168227 / UVTable_62;
			fdtbl_Y_63 = 1.6421339014361256 / YTable_63;
			fdtbl_UV_63 = 1.6421339014361256 / UVTable_63;
		}
		
		private static function normalizeBytes(bytes:ByteArray,width:int,height:int):ByteArray{
			
			var normalizeBytes:ByteArray,i:int,lastLineBytes:ByteArray;
			
			if(width%8){
			}else{
				if(height%8){
				}else{
					return bytes;
				}
				
				normalizeBytes=new ByteArray();
				normalizeBytes.writeBytes(bytes);
				
				lastLineBytes=new ByteArray();
				lastLineBytes.writeBytes(bytes,bytes.length-width*4,width*4);
				
				i=8-(height%8);
				while(i--){
					normalizeBytes.writeBytes(lastLineBytes);
				}
				
				return normalizeBytes;
			}
			
			normalizeBytes=new ByteArray();
			var mod:int=8-(width%8);
			for(var y:int=0;y<height;y++){
				normalizeBytes.writeBytes(bytes,y*width*4,width*4);
				
				bytes.position=(y*width+width-1)*4
				var lastColor:int=bytes.readInt();
				
				i=mod;
				while(i--){
					normalizeBytes.writeInt(lastColor);
				}
			}
			
			if(height%8){
				var normalizeWidth:int=Math.ceil(width/8)*8;
				lastLineBytes=new ByteArray();
				lastLineBytes.writeBytes(normalizeBytes,normalizeBytes.length-normalizeWidth*4,normalizeWidth*4);
				
				i=8-(height%8);
				while(i--){
					normalizeBytes.writeBytes(lastLineBytes);
				}
			}
			
			return normalizeBytes;
		}
		
		private static function breakToBytes88(sourceByteArray:ByteArray,normalizeWidth:int,normalizeHeight:int):Vector.<ByteArray>{
			var bytes88V:Vector.<ByteArray>=new Vector.<ByteArray>();
			var bmd:BitmapData=new BitmapData(normalizeWidth,normalizeHeight,false,0xffffff);
			sourceByteArray.position=0;
			bmd.setPixels(bmd.rect,sourceByteArray);
			var i:int=0;
			var rect:Rectangle=new Rectangle(0,0,8,8);
			for(var y:int=0;y<normalizeHeight;y+=8){
				rect.y=y;
				for(var x:int=0;x<normalizeWidth;x+=8){
					rect.x=x;
					bytes88V[i++]=bmd.getPixels(rect);
				}
			}
			bytes88V.fixed=true;
			return bytes88V;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods: Core processing
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		private function internalEncode(
			source:Object,
			width:int,
			height:int,
			transparent:Boolean = true
		):ByteArray{
			//var t:int;
			
			//t=getTimer();
			//trace("width="+width+",height="+height);
			// The source is either a BitmapData or a ByteArray.
			var sourceByteArray:ByteArray;
			if(source is BitmapData){
				sourceByteArray = (source as BitmapData).getPixels((source as BitmapData).rect);
			}else{
				sourceByteArray = source as ByteArray;
			}
			
			//trace("把 "+source+" 转换成 sourceByteArray 耗时："+(getTimer()-t)+" 毫秒");
			
			//t=getTimer();
			sourceByteArray=normalizeBytes(sourceByteArray,width,height);
			//trace("normalizeBytes 耗时："+(getTimer()-t)+" 毫秒");
			
			var normalizeWidth:int=Math.ceil(width/8)*8;
			var normalizeHeight:int=Math.ceil(height/8)*8;
			
			/*
			//检查 normalizeBytes 后的 BitmapData
			var bmd:BitmapData=new BitmapData(normalizeWidth,normalizeHeight,false,0xffffff);
			sourceByteArray.position=0;
			trace("normalizeWidth="+normalizeWidth);
			trace("normalizeHeight="+normalizeHeight);
			trace("sourceByteArray.length="+sourceByteArray.length);
			trace("sourceByteArray.length/normalizeWidth/4="+sourceByteArray.length/normalizeWidth/4);
			bmd.setPixels(bmd.rect,sourceByteArray);
			width=bmd.width;
			height=bmd.height;
			sourceByteArray = bmd.getPixels(bmd.rect);
			*/
			
			//t=getTimer();
			var bytes88V:Vector.<ByteArray>=breakToBytes88(sourceByteArray,normalizeWidth,normalizeHeight);
			//trace("breakToBytes88 耗时："+(getTimer()-t)+" 毫秒");
			
			// Initialize bit writer
			var byteout:ByteArray = new ByteArray();
			
			byteout.writeBytes(byteout_head);
			byteout[159]=height>>8;
			byteout[160]=height;
			byteout[161]=width>>8;
			byteout[162]=width;
			
			var offset:int=607;
			
			var bGroupValue:int=0;
			var bGroupBitsOffset:int=32;
			
			var DCY:Number = 0;
			var DCU:Number = 0;
			var DCV:Number = 0;
			
			var bitStringId:int;
			
			var tmp0:Number;
			var tmp1:Number;
			var tmp2:Number;
			var tmp3:Number;
			var tmp4:Number;
			var tmp5:Number;
			var tmp6:Number;
			var tmp7:Number;
			var tmp10:Number;
			var tmp11:Number;
			var tmp12:Number;
			var tmp13:Number;
			
			var z1:Number;
			var z2:Number;
			var z3:Number;
			var z4:Number;
			var z5:Number;
			var z11:Number;
			var z13:Number;
			
			var Diff:int;
			var end0pos:int;
			var startpos:int;
			var nrzeroes:int;
			var nrmarker:int;
			
			var DU:Vector.<Number>=new Vector.<Number>(64);
			DU.fixed=true;
			
			var i:int;
			
			for each(var bytes88:ByteArray in bytes88V){
				var YUVDU_0:Number =  0.299 * bytes88[1] + 0.587 * bytes88[2] + 0.114 * bytes88[3] - 128;
				var YUVDU_64:Number = -0.16874 * bytes88[1] - 0.33126 * bytes88[2] + 0.5 * bytes88[3];
				var YUVDU_128:Number =  0.5 * bytes88[1] - 0.41869 * bytes88[2] - 0.08131 * bytes88[3];
				var YUVDU_1:Number =  0.299 * bytes88[5] + 0.587 * bytes88[6] + 0.114 * bytes88[7] - 128;
				var YUVDU_65:Number = -0.16874 * bytes88[5] - 0.33126 * bytes88[6] + 0.5 * bytes88[7];
				var YUVDU_129:Number =  0.5 * bytes88[5] - 0.41869 * bytes88[6] - 0.08131 * bytes88[7];
				var YUVDU_2:Number =  0.299 * bytes88[9] + 0.587 * bytes88[10] + 0.114 * bytes88[11] - 128;
				var YUVDU_66:Number = -0.16874 * bytes88[9] - 0.33126 * bytes88[10] + 0.5 * bytes88[11];
				var YUVDU_130:Number =  0.5 * bytes88[9] - 0.41869 * bytes88[10] - 0.08131 * bytes88[11];
				var YUVDU_3:Number =  0.299 * bytes88[13] + 0.587 * bytes88[14] + 0.114 * bytes88[15] - 128;
				var YUVDU_67:Number = -0.16874 * bytes88[13] - 0.33126 * bytes88[14] + 0.5 * bytes88[15];
				var YUVDU_131:Number =  0.5 * bytes88[13] - 0.41869 * bytes88[14] - 0.08131 * bytes88[15];
				var YUVDU_4:Number =  0.299 * bytes88[17] + 0.587 * bytes88[18] + 0.114 * bytes88[19] - 128;
				var YUVDU_68:Number = -0.16874 * bytes88[17] - 0.33126 * bytes88[18] + 0.5 * bytes88[19];
				var YUVDU_132:Number =  0.5 * bytes88[17] - 0.41869 * bytes88[18] - 0.08131 * bytes88[19];
				var YUVDU_5:Number =  0.299 * bytes88[21] + 0.587 * bytes88[22] + 0.114 * bytes88[23] - 128;
				var YUVDU_69:Number = -0.16874 * bytes88[21] - 0.33126 * bytes88[22] + 0.5 * bytes88[23];
				var YUVDU_133:Number =  0.5 * bytes88[21] - 0.41869 * bytes88[22] - 0.08131 * bytes88[23];
				var YUVDU_6:Number =  0.299 * bytes88[25] + 0.587 * bytes88[26] + 0.114 * bytes88[27] - 128;
				var YUVDU_70:Number = -0.16874 * bytes88[25] - 0.33126 * bytes88[26] + 0.5 * bytes88[27];
				var YUVDU_134:Number =  0.5 * bytes88[25] - 0.41869 * bytes88[26] - 0.08131 * bytes88[27];
				var YUVDU_7:Number =  0.299 * bytes88[29] + 0.587 * bytes88[30] + 0.114 * bytes88[31] - 128;
				var YUVDU_71:Number = -0.16874 * bytes88[29] - 0.33126 * bytes88[30] + 0.5 * bytes88[31];
				var YUVDU_135:Number =  0.5 * bytes88[29] - 0.41869 * bytes88[30] - 0.08131 * bytes88[31];
				var YUVDU_8:Number =  0.299 * bytes88[33] + 0.587 * bytes88[34] + 0.114 * bytes88[35] - 128;
				var YUVDU_72:Number = -0.16874 * bytes88[33] - 0.33126 * bytes88[34] + 0.5 * bytes88[35];
				var YUVDU_136:Number =  0.5 * bytes88[33] - 0.41869 * bytes88[34] - 0.08131 * bytes88[35];
				var YUVDU_9:Number =  0.299 * bytes88[37] + 0.587 * bytes88[38] + 0.114 * bytes88[39] - 128;
				var YUVDU_73:Number = -0.16874 * bytes88[37] - 0.33126 * bytes88[38] + 0.5 * bytes88[39];
				var YUVDU_137:Number =  0.5 * bytes88[37] - 0.41869 * bytes88[38] - 0.08131 * bytes88[39];
				var YUVDU_10:Number =  0.299 * bytes88[41] + 0.587 * bytes88[42] + 0.114 * bytes88[43] - 128;
				var YUVDU_74:Number = -0.16874 * bytes88[41] - 0.33126 * bytes88[42] + 0.5 * bytes88[43];
				var YUVDU_138:Number =  0.5 * bytes88[41] - 0.41869 * bytes88[42] - 0.08131 * bytes88[43];
				var YUVDU_11:Number =  0.299 * bytes88[45] + 0.587 * bytes88[46] + 0.114 * bytes88[47] - 128;
				var YUVDU_75:Number = -0.16874 * bytes88[45] - 0.33126 * bytes88[46] + 0.5 * bytes88[47];
				var YUVDU_139:Number =  0.5 * bytes88[45] - 0.41869 * bytes88[46] - 0.08131 * bytes88[47];
				var YUVDU_12:Number =  0.299 * bytes88[49] + 0.587 * bytes88[50] + 0.114 * bytes88[51] - 128;
				var YUVDU_76:Number = -0.16874 * bytes88[49] - 0.33126 * bytes88[50] + 0.5 * bytes88[51];
				var YUVDU_140:Number =  0.5 * bytes88[49] - 0.41869 * bytes88[50] - 0.08131 * bytes88[51];
				var YUVDU_13:Number =  0.299 * bytes88[53] + 0.587 * bytes88[54] + 0.114 * bytes88[55] - 128;
				var YUVDU_77:Number = -0.16874 * bytes88[53] - 0.33126 * bytes88[54] + 0.5 * bytes88[55];
				var YUVDU_141:Number =  0.5 * bytes88[53] - 0.41869 * bytes88[54] - 0.08131 * bytes88[55];
				var YUVDU_14:Number =  0.299 * bytes88[57] + 0.587 * bytes88[58] + 0.114 * bytes88[59] - 128;
				var YUVDU_78:Number = -0.16874 * bytes88[57] - 0.33126 * bytes88[58] + 0.5 * bytes88[59];
				var YUVDU_142:Number =  0.5 * bytes88[57] - 0.41869 * bytes88[58] - 0.08131 * bytes88[59];
				var YUVDU_15:Number =  0.299 * bytes88[61] + 0.587 * bytes88[62] + 0.114 * bytes88[63] - 128;
				var YUVDU_79:Number = -0.16874 * bytes88[61] - 0.33126 * bytes88[62] + 0.5 * bytes88[63];
				var YUVDU_143:Number =  0.5 * bytes88[61] - 0.41869 * bytes88[62] - 0.08131 * bytes88[63];
				var YUVDU_16:Number =  0.299 * bytes88[65] + 0.587 * bytes88[66] + 0.114 * bytes88[67] - 128;
				var YUVDU_80:Number = -0.16874 * bytes88[65] - 0.33126 * bytes88[66] + 0.5 * bytes88[67];
				var YUVDU_144:Number =  0.5 * bytes88[65] - 0.41869 * bytes88[66] - 0.08131 * bytes88[67];
				var YUVDU_17:Number =  0.299 * bytes88[69] + 0.587 * bytes88[70] + 0.114 * bytes88[71] - 128;
				var YUVDU_81:Number = -0.16874 * bytes88[69] - 0.33126 * bytes88[70] + 0.5 * bytes88[71];
				var YUVDU_145:Number =  0.5 * bytes88[69] - 0.41869 * bytes88[70] - 0.08131 * bytes88[71];
				var YUVDU_18:Number =  0.299 * bytes88[73] + 0.587 * bytes88[74] + 0.114 * bytes88[75] - 128;
				var YUVDU_82:Number = -0.16874 * bytes88[73] - 0.33126 * bytes88[74] + 0.5 * bytes88[75];
				var YUVDU_146:Number =  0.5 * bytes88[73] - 0.41869 * bytes88[74] - 0.08131 * bytes88[75];
				var YUVDU_19:Number =  0.299 * bytes88[77] + 0.587 * bytes88[78] + 0.114 * bytes88[79] - 128;
				var YUVDU_83:Number = -0.16874 * bytes88[77] - 0.33126 * bytes88[78] + 0.5 * bytes88[79];
				var YUVDU_147:Number =  0.5 * bytes88[77] - 0.41869 * bytes88[78] - 0.08131 * bytes88[79];
				var YUVDU_20:Number =  0.299 * bytes88[81] + 0.587 * bytes88[82] + 0.114 * bytes88[83] - 128;
				var YUVDU_84:Number = -0.16874 * bytes88[81] - 0.33126 * bytes88[82] + 0.5 * bytes88[83];
				var YUVDU_148:Number =  0.5 * bytes88[81] - 0.41869 * bytes88[82] - 0.08131 * bytes88[83];
				var YUVDU_21:Number =  0.299 * bytes88[85] + 0.587 * bytes88[86] + 0.114 * bytes88[87] - 128;
				var YUVDU_85:Number = -0.16874 * bytes88[85] - 0.33126 * bytes88[86] + 0.5 * bytes88[87];
				var YUVDU_149:Number =  0.5 * bytes88[85] - 0.41869 * bytes88[86] - 0.08131 * bytes88[87];
				var YUVDU_22:Number =  0.299 * bytes88[89] + 0.587 * bytes88[90] + 0.114 * bytes88[91] - 128;
				var YUVDU_86:Number = -0.16874 * bytes88[89] - 0.33126 * bytes88[90] + 0.5 * bytes88[91];
				var YUVDU_150:Number =  0.5 * bytes88[89] - 0.41869 * bytes88[90] - 0.08131 * bytes88[91];
				var YUVDU_23:Number =  0.299 * bytes88[93] + 0.587 * bytes88[94] + 0.114 * bytes88[95] - 128;
				var YUVDU_87:Number = -0.16874 * bytes88[93] - 0.33126 * bytes88[94] + 0.5 * bytes88[95];
				var YUVDU_151:Number =  0.5 * bytes88[93] - 0.41869 * bytes88[94] - 0.08131 * bytes88[95];
				var YUVDU_24:Number =  0.299 * bytes88[97] + 0.587 * bytes88[98] + 0.114 * bytes88[99] - 128;
				var YUVDU_88:Number = -0.16874 * bytes88[97] - 0.33126 * bytes88[98] + 0.5 * bytes88[99];
				var YUVDU_152:Number =  0.5 * bytes88[97] - 0.41869 * bytes88[98] - 0.08131 * bytes88[99];
				var YUVDU_25:Number =  0.299 * bytes88[101] + 0.587 * bytes88[102] + 0.114 * bytes88[103] - 128;
				var YUVDU_89:Number = -0.16874 * bytes88[101] - 0.33126 * bytes88[102] + 0.5 * bytes88[103];
				var YUVDU_153:Number =  0.5 * bytes88[101] - 0.41869 * bytes88[102] - 0.08131 * bytes88[103];
				var YUVDU_26:Number =  0.299 * bytes88[105] + 0.587 * bytes88[106] + 0.114 * bytes88[107] - 128;
				var YUVDU_90:Number = -0.16874 * bytes88[105] - 0.33126 * bytes88[106] + 0.5 * bytes88[107];
				var YUVDU_154:Number =  0.5 * bytes88[105] - 0.41869 * bytes88[106] - 0.08131 * bytes88[107];
				var YUVDU_27:Number =  0.299 * bytes88[109] + 0.587 * bytes88[110] + 0.114 * bytes88[111] - 128;
				var YUVDU_91:Number = -0.16874 * bytes88[109] - 0.33126 * bytes88[110] + 0.5 * bytes88[111];
				var YUVDU_155:Number =  0.5 * bytes88[109] - 0.41869 * bytes88[110] - 0.08131 * bytes88[111];
				var YUVDU_28:Number =  0.299 * bytes88[113] + 0.587 * bytes88[114] + 0.114 * bytes88[115] - 128;
				var YUVDU_92:Number = -0.16874 * bytes88[113] - 0.33126 * bytes88[114] + 0.5 * bytes88[115];
				var YUVDU_156:Number =  0.5 * bytes88[113] - 0.41869 * bytes88[114] - 0.08131 * bytes88[115];
				var YUVDU_29:Number =  0.299 * bytes88[117] + 0.587 * bytes88[118] + 0.114 * bytes88[119] - 128;
				var YUVDU_93:Number = -0.16874 * bytes88[117] - 0.33126 * bytes88[118] + 0.5 * bytes88[119];
				var YUVDU_157:Number =  0.5 * bytes88[117] - 0.41869 * bytes88[118] - 0.08131 * bytes88[119];
				var YUVDU_30:Number =  0.299 * bytes88[121] + 0.587 * bytes88[122] + 0.114 * bytes88[123] - 128;
				var YUVDU_94:Number = -0.16874 * bytes88[121] - 0.33126 * bytes88[122] + 0.5 * bytes88[123];
				var YUVDU_158:Number =  0.5 * bytes88[121] - 0.41869 * bytes88[122] - 0.08131 * bytes88[123];
				var YUVDU_31:Number =  0.299 * bytes88[125] + 0.587 * bytes88[126] + 0.114 * bytes88[127] - 128;
				var YUVDU_95:Number = -0.16874 * bytes88[125] - 0.33126 * bytes88[126] + 0.5 * bytes88[127];
				var YUVDU_159:Number =  0.5 * bytes88[125] - 0.41869 * bytes88[126] - 0.08131 * bytes88[127];
				var YUVDU_32:Number =  0.299 * bytes88[129] + 0.587 * bytes88[130] + 0.114 * bytes88[131] - 128;
				var YUVDU_96:Number = -0.16874 * bytes88[129] - 0.33126 * bytes88[130] + 0.5 * bytes88[131];
				var YUVDU_160:Number =  0.5 * bytes88[129] - 0.41869 * bytes88[130] - 0.08131 * bytes88[131];
				var YUVDU_33:Number =  0.299 * bytes88[133] + 0.587 * bytes88[134] + 0.114 * bytes88[135] - 128;
				var YUVDU_97:Number = -0.16874 * bytes88[133] - 0.33126 * bytes88[134] + 0.5 * bytes88[135];
				var YUVDU_161:Number =  0.5 * bytes88[133] - 0.41869 * bytes88[134] - 0.08131 * bytes88[135];
				var YUVDU_34:Number =  0.299 * bytes88[137] + 0.587 * bytes88[138] + 0.114 * bytes88[139] - 128;
				var YUVDU_98:Number = -0.16874 * bytes88[137] - 0.33126 * bytes88[138] + 0.5 * bytes88[139];
				var YUVDU_162:Number =  0.5 * bytes88[137] - 0.41869 * bytes88[138] - 0.08131 * bytes88[139];
				var YUVDU_35:Number =  0.299 * bytes88[141] + 0.587 * bytes88[142] + 0.114 * bytes88[143] - 128;
				var YUVDU_99:Number = -0.16874 * bytes88[141] - 0.33126 * bytes88[142] + 0.5 * bytes88[143];
				var YUVDU_163:Number =  0.5 * bytes88[141] - 0.41869 * bytes88[142] - 0.08131 * bytes88[143];
				var YUVDU_36:Number =  0.299 * bytes88[145] + 0.587 * bytes88[146] + 0.114 * bytes88[147] - 128;
				var YUVDU_100:Number = -0.16874 * bytes88[145] - 0.33126 * bytes88[146] + 0.5 * bytes88[147];
				var YUVDU_164:Number =  0.5 * bytes88[145] - 0.41869 * bytes88[146] - 0.08131 * bytes88[147];
				var YUVDU_37:Number =  0.299 * bytes88[149] + 0.587 * bytes88[150] + 0.114 * bytes88[151] - 128;
				var YUVDU_101:Number = -0.16874 * bytes88[149] - 0.33126 * bytes88[150] + 0.5 * bytes88[151];
				var YUVDU_165:Number =  0.5 * bytes88[149] - 0.41869 * bytes88[150] - 0.08131 * bytes88[151];
				var YUVDU_38:Number =  0.299 * bytes88[153] + 0.587 * bytes88[154] + 0.114 * bytes88[155] - 128;
				var YUVDU_102:Number = -0.16874 * bytes88[153] - 0.33126 * bytes88[154] + 0.5 * bytes88[155];
				var YUVDU_166:Number =  0.5 * bytes88[153] - 0.41869 * bytes88[154] - 0.08131 * bytes88[155];
				var YUVDU_39:Number =  0.299 * bytes88[157] + 0.587 * bytes88[158] + 0.114 * bytes88[159] - 128;
				var YUVDU_103:Number = -0.16874 * bytes88[157] - 0.33126 * bytes88[158] + 0.5 * bytes88[159];
				var YUVDU_167:Number =  0.5 * bytes88[157] - 0.41869 * bytes88[158] - 0.08131 * bytes88[159];
				var YUVDU_40:Number =  0.299 * bytes88[161] + 0.587 * bytes88[162] + 0.114 * bytes88[163] - 128;
				var YUVDU_104:Number = -0.16874 * bytes88[161] - 0.33126 * bytes88[162] + 0.5 * bytes88[163];
				var YUVDU_168:Number =  0.5 * bytes88[161] - 0.41869 * bytes88[162] - 0.08131 * bytes88[163];
				var YUVDU_41:Number =  0.299 * bytes88[165] + 0.587 * bytes88[166] + 0.114 * bytes88[167] - 128;
				var YUVDU_105:Number = -0.16874 * bytes88[165] - 0.33126 * bytes88[166] + 0.5 * bytes88[167];
				var YUVDU_169:Number =  0.5 * bytes88[165] - 0.41869 * bytes88[166] - 0.08131 * bytes88[167];
				var YUVDU_42:Number =  0.299 * bytes88[169] + 0.587 * bytes88[170] + 0.114 * bytes88[171] - 128;
				var YUVDU_106:Number = -0.16874 * bytes88[169] - 0.33126 * bytes88[170] + 0.5 * bytes88[171];
				var YUVDU_170:Number =  0.5 * bytes88[169] - 0.41869 * bytes88[170] - 0.08131 * bytes88[171];
				var YUVDU_43:Number =  0.299 * bytes88[173] + 0.587 * bytes88[174] + 0.114 * bytes88[175] - 128;
				var YUVDU_107:Number = -0.16874 * bytes88[173] - 0.33126 * bytes88[174] + 0.5 * bytes88[175];
				var YUVDU_171:Number =  0.5 * bytes88[173] - 0.41869 * bytes88[174] - 0.08131 * bytes88[175];
				var YUVDU_44:Number =  0.299 * bytes88[177] + 0.587 * bytes88[178] + 0.114 * bytes88[179] - 128;
				var YUVDU_108:Number = -0.16874 * bytes88[177] - 0.33126 * bytes88[178] + 0.5 * bytes88[179];
				var YUVDU_172:Number =  0.5 * bytes88[177] - 0.41869 * bytes88[178] - 0.08131 * bytes88[179];
				var YUVDU_45:Number =  0.299 * bytes88[181] + 0.587 * bytes88[182] + 0.114 * bytes88[183] - 128;
				var YUVDU_109:Number = -0.16874 * bytes88[181] - 0.33126 * bytes88[182] + 0.5 * bytes88[183];
				var YUVDU_173:Number =  0.5 * bytes88[181] - 0.41869 * bytes88[182] - 0.08131 * bytes88[183];
				var YUVDU_46:Number =  0.299 * bytes88[185] + 0.587 * bytes88[186] + 0.114 * bytes88[187] - 128;
				var YUVDU_110:Number = -0.16874 * bytes88[185] - 0.33126 * bytes88[186] + 0.5 * bytes88[187];
				var YUVDU_174:Number =  0.5 * bytes88[185] - 0.41869 * bytes88[186] - 0.08131 * bytes88[187];
				var YUVDU_47:Number =  0.299 * bytes88[189] + 0.587 * bytes88[190] + 0.114 * bytes88[191] - 128;
				var YUVDU_111:Number = -0.16874 * bytes88[189] - 0.33126 * bytes88[190] + 0.5 * bytes88[191];
				var YUVDU_175:Number =  0.5 * bytes88[189] - 0.41869 * bytes88[190] - 0.08131 * bytes88[191];
				var YUVDU_48:Number =  0.299 * bytes88[193] + 0.587 * bytes88[194] + 0.114 * bytes88[195] - 128;
				var YUVDU_112:Number = -0.16874 * bytes88[193] - 0.33126 * bytes88[194] + 0.5 * bytes88[195];
				var YUVDU_176:Number =  0.5 * bytes88[193] - 0.41869 * bytes88[194] - 0.08131 * bytes88[195];
				var YUVDU_49:Number =  0.299 * bytes88[197] + 0.587 * bytes88[198] + 0.114 * bytes88[199] - 128;
				var YUVDU_113:Number = -0.16874 * bytes88[197] - 0.33126 * bytes88[198] + 0.5 * bytes88[199];
				var YUVDU_177:Number =  0.5 * bytes88[197] - 0.41869 * bytes88[198] - 0.08131 * bytes88[199];
				var YUVDU_50:Number =  0.299 * bytes88[201] + 0.587 * bytes88[202] + 0.114 * bytes88[203] - 128;
				var YUVDU_114:Number = -0.16874 * bytes88[201] - 0.33126 * bytes88[202] + 0.5 * bytes88[203];
				var YUVDU_178:Number =  0.5 * bytes88[201] - 0.41869 * bytes88[202] - 0.08131 * bytes88[203];
				var YUVDU_51:Number =  0.299 * bytes88[205] + 0.587 * bytes88[206] + 0.114 * bytes88[207] - 128;
				var YUVDU_115:Number = -0.16874 * bytes88[205] - 0.33126 * bytes88[206] + 0.5 * bytes88[207];
				var YUVDU_179:Number =  0.5 * bytes88[205] - 0.41869 * bytes88[206] - 0.08131 * bytes88[207];
				var YUVDU_52:Number =  0.299 * bytes88[209] + 0.587 * bytes88[210] + 0.114 * bytes88[211] - 128;
				var YUVDU_116:Number = -0.16874 * bytes88[209] - 0.33126 * bytes88[210] + 0.5 * bytes88[211];
				var YUVDU_180:Number =  0.5 * bytes88[209] - 0.41869 * bytes88[210] - 0.08131 * bytes88[211];
				var YUVDU_53:Number =  0.299 * bytes88[213] + 0.587 * bytes88[214] + 0.114 * bytes88[215] - 128;
				var YUVDU_117:Number = -0.16874 * bytes88[213] - 0.33126 * bytes88[214] + 0.5 * bytes88[215];
				var YUVDU_181:Number =  0.5 * bytes88[213] - 0.41869 * bytes88[214] - 0.08131 * bytes88[215];
				var YUVDU_54:Number =  0.299 * bytes88[217] + 0.587 * bytes88[218] + 0.114 * bytes88[219] - 128;
				var YUVDU_118:Number = -0.16874 * bytes88[217] - 0.33126 * bytes88[218] + 0.5 * bytes88[219];
				var YUVDU_182:Number =  0.5 * bytes88[217] - 0.41869 * bytes88[218] - 0.08131 * bytes88[219];
				var YUVDU_55:Number =  0.299 * bytes88[221] + 0.587 * bytes88[222] + 0.114 * bytes88[223] - 128;
				var YUVDU_119:Number = -0.16874 * bytes88[221] - 0.33126 * bytes88[222] + 0.5 * bytes88[223];
				var YUVDU_183:Number =  0.5 * bytes88[221] - 0.41869 * bytes88[222] - 0.08131 * bytes88[223];
				var YUVDU_56:Number =  0.299 * bytes88[225] + 0.587 * bytes88[226] + 0.114 * bytes88[227] - 128;
				var YUVDU_120:Number = -0.16874 * bytes88[225] - 0.33126 * bytes88[226] + 0.5 * bytes88[227];
				var YUVDU_184:Number =  0.5 * bytes88[225] - 0.41869 * bytes88[226] - 0.08131 * bytes88[227];
				var YUVDU_57:Number =  0.299 * bytes88[229] + 0.587 * bytes88[230] + 0.114 * bytes88[231] - 128;
				var YUVDU_121:Number = -0.16874 * bytes88[229] - 0.33126 * bytes88[230] + 0.5 * bytes88[231];
				var YUVDU_185:Number =  0.5 * bytes88[229] - 0.41869 * bytes88[230] - 0.08131 * bytes88[231];
				var YUVDU_58:Number =  0.299 * bytes88[233] + 0.587 * bytes88[234] + 0.114 * bytes88[235] - 128;
				var YUVDU_122:Number = -0.16874 * bytes88[233] - 0.33126 * bytes88[234] + 0.5 * bytes88[235];
				var YUVDU_186:Number =  0.5 * bytes88[233] - 0.41869 * bytes88[234] - 0.08131 * bytes88[235];
				var YUVDU_59:Number =  0.299 * bytes88[237] + 0.587 * bytes88[238] + 0.114 * bytes88[239] - 128;
				var YUVDU_123:Number = -0.16874 * bytes88[237] - 0.33126 * bytes88[238] + 0.5 * bytes88[239];
				var YUVDU_187:Number =  0.5 * bytes88[237] - 0.41869 * bytes88[238] - 0.08131 * bytes88[239];
				var YUVDU_60:Number =  0.299 * bytes88[241] + 0.587 * bytes88[242] + 0.114 * bytes88[243] - 128;
				var YUVDU_124:Number = -0.16874 * bytes88[241] - 0.33126 * bytes88[242] + 0.5 * bytes88[243];
				var YUVDU_188:Number =  0.5 * bytes88[241] - 0.41869 * bytes88[242] - 0.08131 * bytes88[243];
				var YUVDU_61:Number =  0.299 * bytes88[245] + 0.587 * bytes88[246] + 0.114 * bytes88[247] - 128;
				var YUVDU_125:Number = -0.16874 * bytes88[245] - 0.33126 * bytes88[246] + 0.5 * bytes88[247];
				var YUVDU_189:Number =  0.5 * bytes88[245] - 0.41869 * bytes88[246] - 0.08131 * bytes88[247];
				var YUVDU_62:Number =  0.299 * bytes88[249] + 0.587 * bytes88[250] + 0.114 * bytes88[251] - 128;
				var YUVDU_126:Number = -0.16874 * bytes88[249] - 0.33126 * bytes88[250] + 0.5 * bytes88[251];
				var YUVDU_190:Number =  0.5 * bytes88[249] - 0.41869 * bytes88[250] - 0.08131 * bytes88[251];
				var YUVDU_63:Number =  0.299 * bytes88[253] + 0.587 * bytes88[254] + 0.114 * bytes88[255] - 128;
				var YUVDU_127:Number = -0.16874 * bytes88[253] - 0.33126 * bytes88[254] + 0.5 * bytes88[255];
				var YUVDU_191:Number =  0.5 * bytes88[253] - 0.41869 * bytes88[254] - 0.08131 * bytes88[255];
				
				//processDU(YDU, fdtbl_Y, DCY, YDC_HT, YAC_HT,processObj);
				
				// Pass 1: process rows.
				tmp0 = YUVDU_0 + YUVDU_7;tmp7 = YUVDU_0 - YUVDU_7;tmp1 = YUVDU_1 + YUVDU_6;tmp6 = YUVDU_1 - YUVDU_6;tmp2 = YUVDU_2 + YUVDU_5;tmp5 = YUVDU_2 - YUVDU_5;tmp3 = YUVDU_3 + YUVDU_4;tmp4 = YUVDU_3 - YUVDU_4;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_0 = tmp10 + tmp11;YUVDU_4 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_2 = tmp13 + z1;YUVDU_6 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_5 = z13 + z2;YUVDU_3 = z13 - z2;YUVDU_1 = z11 + z4;YUVDU_7 = z11 - z4;
				
				tmp0 = YUVDU_8 + YUVDU_15;tmp7 = YUVDU_8 - YUVDU_15;tmp1 = YUVDU_9 + YUVDU_14;tmp6 = YUVDU_9 - YUVDU_14;tmp2 = YUVDU_10 + YUVDU_13;tmp5 = YUVDU_10 - YUVDU_13;tmp3 = YUVDU_11 + YUVDU_12;tmp4 = YUVDU_11 - YUVDU_12;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_8 = tmp10 + tmp11;YUVDU_12 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_10 = tmp13 + z1;YUVDU_14 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_13 = z13 + z2;YUVDU_11 = z13 - z2;YUVDU_9 = z11 + z4;YUVDU_15 = z11 - z4;
				
				tmp0 = YUVDU_16 + YUVDU_23;tmp7 = YUVDU_16 - YUVDU_23;tmp1 = YUVDU_17 + YUVDU_22;tmp6 = YUVDU_17 - YUVDU_22;tmp2 = YUVDU_18 + YUVDU_21;tmp5 = YUVDU_18 - YUVDU_21;tmp3 = YUVDU_19 + YUVDU_20;tmp4 = YUVDU_19 - YUVDU_20;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_16 = tmp10 + tmp11;YUVDU_20 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_18 = tmp13 + z1;YUVDU_22 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_21 = z13 + z2;YUVDU_19 = z13 - z2;YUVDU_17 = z11 + z4;YUVDU_23 = z11 - z4;
				
				tmp0 = YUVDU_24 + YUVDU_31;tmp7 = YUVDU_24 - YUVDU_31;tmp1 = YUVDU_25 + YUVDU_30;tmp6 = YUVDU_25 - YUVDU_30;tmp2 = YUVDU_26 + YUVDU_29;tmp5 = YUVDU_26 - YUVDU_29;tmp3 = YUVDU_27 + YUVDU_28;tmp4 = YUVDU_27 - YUVDU_28;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_24 = tmp10 + tmp11;YUVDU_28 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_26 = tmp13 + z1;YUVDU_30 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_29 = z13 + z2;YUVDU_27 = z13 - z2;YUVDU_25 = z11 + z4;YUVDU_31 = z11 - z4;
				
				tmp0 = YUVDU_32 + YUVDU_39;tmp7 = YUVDU_32 - YUVDU_39;tmp1 = YUVDU_33 + YUVDU_38;tmp6 = YUVDU_33 - YUVDU_38;tmp2 = YUVDU_34 + YUVDU_37;tmp5 = YUVDU_34 - YUVDU_37;tmp3 = YUVDU_35 + YUVDU_36;tmp4 = YUVDU_35 - YUVDU_36;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_32 = tmp10 + tmp11;YUVDU_36 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_34 = tmp13 + z1;YUVDU_38 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_37 = z13 + z2;YUVDU_35 = z13 - z2;YUVDU_33 = z11 + z4;YUVDU_39 = z11 - z4;
				
				tmp0 = YUVDU_40 + YUVDU_47;tmp7 = YUVDU_40 - YUVDU_47;tmp1 = YUVDU_41 + YUVDU_46;tmp6 = YUVDU_41 - YUVDU_46;tmp2 = YUVDU_42 + YUVDU_45;tmp5 = YUVDU_42 - YUVDU_45;tmp3 = YUVDU_43 + YUVDU_44;tmp4 = YUVDU_43 - YUVDU_44;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_40 = tmp10 + tmp11;YUVDU_44 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_42 = tmp13 + z1;YUVDU_46 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_45 = z13 + z2;YUVDU_43 = z13 - z2;YUVDU_41 = z11 + z4;YUVDU_47 = z11 - z4;
				
				tmp0 = YUVDU_48 + YUVDU_55;tmp7 = YUVDU_48 - YUVDU_55;tmp1 = YUVDU_49 + YUVDU_54;tmp6 = YUVDU_49 - YUVDU_54;tmp2 = YUVDU_50 + YUVDU_53;tmp5 = YUVDU_50 - YUVDU_53;tmp3 = YUVDU_51 + YUVDU_52;tmp4 = YUVDU_51 - YUVDU_52;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_48 = tmp10 + tmp11;YUVDU_52 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_50 = tmp13 + z1;YUVDU_54 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_53 = z13 + z2;YUVDU_51 = z13 - z2;YUVDU_49 = z11 + z4;YUVDU_55 = z11 - z4;
				
				tmp0 = YUVDU_56 + YUVDU_63;tmp7 = YUVDU_56 - YUVDU_63;tmp1 = YUVDU_57 + YUVDU_62;tmp6 = YUVDU_57 - YUVDU_62;tmp2 = YUVDU_58 + YUVDU_61;tmp5 = YUVDU_58 - YUVDU_61;tmp3 = YUVDU_59 + YUVDU_60;tmp4 = YUVDU_59 - YUVDU_60;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_56 = tmp10 + tmp11;YUVDU_60 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_58 = tmp13 + z1;YUVDU_62 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_61 = z13 + z2;YUVDU_59 = z13 - z2;YUVDU_57 = z11 + z4;YUVDU_63 = z11 - z4;
				
				// Pass 2: process columns.
				tmp0 = YUVDU_0 + YUVDU_56;tmp7 = YUVDU_0 - YUVDU_56;tmp1 = YUVDU_8 + YUVDU_48;tmp6 = YUVDU_8 - YUVDU_48;tmp2 = YUVDU_16 + YUVDU_40;tmp5 = YUVDU_16 - YUVDU_40;tmp3 = YUVDU_24 + YUVDU_32;tmp4 = YUVDU_24 - YUVDU_32;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_0 = tmp10 + tmp11;YUVDU_32 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_16 = tmp13 + z1;YUVDU_48 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_40 = z13 + z2;YUVDU_24 = z13 - z2;YUVDU_8 = z11 + z4;YUVDU_56 = z11 - z4;
				
				tmp0 = YUVDU_1 + YUVDU_57;tmp7 = YUVDU_1 - YUVDU_57;tmp1 = YUVDU_9 + YUVDU_49;tmp6 = YUVDU_9 - YUVDU_49;tmp2 = YUVDU_17 + YUVDU_41;tmp5 = YUVDU_17 - YUVDU_41;tmp3 = YUVDU_25 + YUVDU_33;tmp4 = YUVDU_25 - YUVDU_33;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_1 = tmp10 + tmp11;YUVDU_33 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_17 = tmp13 + z1;YUVDU_49 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_41 = z13 + z2;YUVDU_25 = z13 - z2;YUVDU_9 = z11 + z4;YUVDU_57 = z11 - z4;
				
				tmp0 = YUVDU_2 + YUVDU_58;tmp7 = YUVDU_2 - YUVDU_58;tmp1 = YUVDU_10 + YUVDU_50;tmp6 = YUVDU_10 - YUVDU_50;tmp2 = YUVDU_18 + YUVDU_42;tmp5 = YUVDU_18 - YUVDU_42;tmp3 = YUVDU_26 + YUVDU_34;tmp4 = YUVDU_26 - YUVDU_34;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_2 = tmp10 + tmp11;YUVDU_34 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_18 = tmp13 + z1;YUVDU_50 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_42 = z13 + z2;YUVDU_26 = z13 - z2;YUVDU_10 = z11 + z4;YUVDU_58 = z11 - z4;
				
				tmp0 = YUVDU_3 + YUVDU_59;tmp7 = YUVDU_3 - YUVDU_59;tmp1 = YUVDU_11 + YUVDU_51;tmp6 = YUVDU_11 - YUVDU_51;tmp2 = YUVDU_19 + YUVDU_43;tmp5 = YUVDU_19 - YUVDU_43;tmp3 = YUVDU_27 + YUVDU_35;tmp4 = YUVDU_27 - YUVDU_35;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_3 = tmp10 + tmp11;YUVDU_35 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_19 = tmp13 + z1;YUVDU_51 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_43 = z13 + z2;YUVDU_27 = z13 - z2;YUVDU_11 = z11 + z4;YUVDU_59 = z11 - z4;
				
				tmp0 = YUVDU_4 + YUVDU_60;tmp7 = YUVDU_4 - YUVDU_60;tmp1 = YUVDU_12 + YUVDU_52;tmp6 = YUVDU_12 - YUVDU_52;tmp2 = YUVDU_20 + YUVDU_44;tmp5 = YUVDU_20 - YUVDU_44;tmp3 = YUVDU_28 + YUVDU_36;tmp4 = YUVDU_28 - YUVDU_36;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_4 = tmp10 + tmp11;YUVDU_36 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_20 = tmp13 + z1;YUVDU_52 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_44 = z13 + z2;YUVDU_28 = z13 - z2;YUVDU_12 = z11 + z4;YUVDU_60 = z11 - z4;
				
				tmp0 = YUVDU_5 + YUVDU_61;tmp7 = YUVDU_5 - YUVDU_61;tmp1 = YUVDU_13 + YUVDU_53;tmp6 = YUVDU_13 - YUVDU_53;tmp2 = YUVDU_21 + YUVDU_45;tmp5 = YUVDU_21 - YUVDU_45;tmp3 = YUVDU_29 + YUVDU_37;tmp4 = YUVDU_29 - YUVDU_37;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_5 = tmp10 + tmp11;YUVDU_37 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_21 = tmp13 + z1;YUVDU_53 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_45 = z13 + z2;YUVDU_29 = z13 - z2;YUVDU_13 = z11 + z4;YUVDU_61 = z11 - z4;
				
				tmp0 = YUVDU_6 + YUVDU_62;tmp7 = YUVDU_6 - YUVDU_62;tmp1 = YUVDU_14 + YUVDU_54;tmp6 = YUVDU_14 - YUVDU_54;tmp2 = YUVDU_22 + YUVDU_46;tmp5 = YUVDU_22 - YUVDU_46;tmp3 = YUVDU_30 + YUVDU_38;tmp4 = YUVDU_30 - YUVDU_38;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_6 = tmp10 + tmp11;YUVDU_38 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_22 = tmp13 + z1;YUVDU_54 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_46 = z13 + z2;YUVDU_30 = z13 - z2;YUVDU_14 = z11 + z4;YUVDU_62 = z11 - z4;
				
				tmp0 = YUVDU_7 + YUVDU_63;tmp7 = YUVDU_7 - YUVDU_63;tmp1 = YUVDU_15 + YUVDU_55;tmp6 = YUVDU_15 - YUVDU_55;tmp2 = YUVDU_23 + YUVDU_47;tmp5 = YUVDU_23 - YUVDU_47;tmp3 = YUVDU_31 + YUVDU_39;tmp4 = YUVDU_31 - YUVDU_39;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_7 = tmp10 + tmp11;YUVDU_39 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_23 = tmp13 + z1;YUVDU_55 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_47 = z13 + z2;YUVDU_31 = z13 - z2;YUVDU_15 = z11 + z4;YUVDU_63 = z11 - z4;
				
				// Quantize/descale the coefficients
				// Apply the quantization and scaling factor
				// and round to nearest integer
				//for(i=0;i<64;i++){YDU[i] = Math.round((YDU[i] * fdtbl_Y[i]));}
				YUVDU_0 = Math.round((YUVDU_0 * fdtbl_Y_0));YUVDU_1 = Math.round((YUVDU_1 * fdtbl_Y_1));YUVDU_2 = Math.round((YUVDU_2 * fdtbl_Y_2));YUVDU_3 = Math.round((YUVDU_3 * fdtbl_Y_3));
				YUVDU_4 = Math.round((YUVDU_4 * fdtbl_Y_4));YUVDU_5 = Math.round((YUVDU_5 * fdtbl_Y_5));YUVDU_6 = Math.round((YUVDU_6 * fdtbl_Y_6));YUVDU_7 = Math.round((YUVDU_7 * fdtbl_Y_7));
				YUVDU_8 = Math.round((YUVDU_8 * fdtbl_Y_8));YUVDU_9 = Math.round((YUVDU_9 * fdtbl_Y_9));YUVDU_10 = Math.round((YUVDU_10 * fdtbl_Y_10));YUVDU_11 = Math.round((YUVDU_11 * fdtbl_Y_11));
				YUVDU_12 = Math.round((YUVDU_12 * fdtbl_Y_12));YUVDU_13 = Math.round((YUVDU_13 * fdtbl_Y_13));YUVDU_14 = Math.round((YUVDU_14 * fdtbl_Y_14));YUVDU_15 = Math.round((YUVDU_15 * fdtbl_Y_15));
				YUVDU_16 = Math.round((YUVDU_16 * fdtbl_Y_16));YUVDU_17 = Math.round((YUVDU_17 * fdtbl_Y_17));YUVDU_18 = Math.round((YUVDU_18 * fdtbl_Y_18));YUVDU_19 = Math.round((YUVDU_19 * fdtbl_Y_19));
				YUVDU_20 = Math.round((YUVDU_20 * fdtbl_Y_20));YUVDU_21 = Math.round((YUVDU_21 * fdtbl_Y_21));YUVDU_22 = Math.round((YUVDU_22 * fdtbl_Y_22));YUVDU_23 = Math.round((YUVDU_23 * fdtbl_Y_23));
				YUVDU_24 = Math.round((YUVDU_24 * fdtbl_Y_24));YUVDU_25 = Math.round((YUVDU_25 * fdtbl_Y_25));YUVDU_26 = Math.round((YUVDU_26 * fdtbl_Y_26));YUVDU_27 = Math.round((YUVDU_27 * fdtbl_Y_27));
				YUVDU_28 = Math.round((YUVDU_28 * fdtbl_Y_28));YUVDU_29 = Math.round((YUVDU_29 * fdtbl_Y_29));YUVDU_30 = Math.round((YUVDU_30 * fdtbl_Y_30));YUVDU_31 = Math.round((YUVDU_31 * fdtbl_Y_31));
				YUVDU_32 = Math.round((YUVDU_32 * fdtbl_Y_32));YUVDU_33 = Math.round((YUVDU_33 * fdtbl_Y_33));YUVDU_34 = Math.round((YUVDU_34 * fdtbl_Y_34));YUVDU_35 = Math.round((YUVDU_35 * fdtbl_Y_35));
				YUVDU_36 = Math.round((YUVDU_36 * fdtbl_Y_36));YUVDU_37 = Math.round((YUVDU_37 * fdtbl_Y_37));YUVDU_38 = Math.round((YUVDU_38 * fdtbl_Y_38));YUVDU_39 = Math.round((YUVDU_39 * fdtbl_Y_39));
				YUVDU_40 = Math.round((YUVDU_40 * fdtbl_Y_40));YUVDU_41 = Math.round((YUVDU_41 * fdtbl_Y_41));YUVDU_42 = Math.round((YUVDU_42 * fdtbl_Y_42));YUVDU_43 = Math.round((YUVDU_43 * fdtbl_Y_43));
				YUVDU_44 = Math.round((YUVDU_44 * fdtbl_Y_44));YUVDU_45 = Math.round((YUVDU_45 * fdtbl_Y_45));YUVDU_46 = Math.round((YUVDU_46 * fdtbl_Y_46));YUVDU_47 = Math.round((YUVDU_47 * fdtbl_Y_47));
				YUVDU_48 = Math.round((YUVDU_48 * fdtbl_Y_48));YUVDU_49 = Math.round((YUVDU_49 * fdtbl_Y_49));YUVDU_50 = Math.round((YUVDU_50 * fdtbl_Y_50));YUVDU_51 = Math.round((YUVDU_51 * fdtbl_Y_51));
				YUVDU_52 = Math.round((YUVDU_52 * fdtbl_Y_52));YUVDU_53 = Math.round((YUVDU_53 * fdtbl_Y_53));YUVDU_54 = Math.round((YUVDU_54 * fdtbl_Y_54));YUVDU_55 = Math.round((YUVDU_55 * fdtbl_Y_55));
				YUVDU_56 = Math.round((YUVDU_56 * fdtbl_Y_56));YUVDU_57 = Math.round((YUVDU_57 * fdtbl_Y_57));YUVDU_58 = Math.round((YUVDU_58 * fdtbl_Y_58));YUVDU_59 = Math.round((YUVDU_59 * fdtbl_Y_59));
				YUVDU_60 = Math.round((YUVDU_60 * fdtbl_Y_60));YUVDU_61 = Math.round((YUVDU_61 * fdtbl_Y_61));YUVDU_62 = Math.round((YUVDU_62 * fdtbl_Y_62));YUVDU_63 = Math.round((YUVDU_63 * fdtbl_Y_63));
				
				// ZigZag reorder
				//for(i=0;i<64;i++){DU[ZigZag[i]] = YDU[i];}
				
				Diff = YUVDU_0 - DCY;
				DCY = YUVDU_0;
				
				// Encode DCY
				if(Diff){// Diff might be 0
					bitStringId=category[32767 + Diff]*2;
					bGroupBitsOffset-=YDC_HT[bitStringId+1];
					bGroupValue|=YDC_HT[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					
					bitStringId=(32767 + Diff)*2;
					bGroupBitsOffset-=bitcode[bitStringId+1];
					bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}else{
					bGroupBitsOffset-=YDC_HT[1];
					bGroupValue|=YDC_HT[0]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
				
				// Encode ACs
				//var end0pos:int=64;
				//for (; (end0pos > 0) && (DU[end0pos] == 0); end0pos--){};
				if(YUVDU_63){end0pos=63;}else{if(YUVDU_62){end0pos=62;}else{if(YUVDU_55){end0pos=61;}else{if(YUVDU_47){end0pos=60;}else{if(YUVDU_54){end0pos=59;}else{if(YUVDU_61){end0pos=58;}else{if(YUVDU_60){end0pos=57;}else{if(YUVDU_53){end0pos=56;}else{if(YUVDU_46){end0pos=55;}else{if(YUVDU_39){end0pos=54;}else{if(YUVDU_31){end0pos=53;}else{if(YUVDU_38){end0pos=52;}else{if(YUVDU_45){end0pos=51;}else{if(YUVDU_52){end0pos=50;}else{if(YUVDU_59){end0pos=49;}else{if(YUVDU_58){end0pos=48;}else{if(YUVDU_51){end0pos=47;}else{if(YUVDU_44){end0pos=46;}else{if(YUVDU_37){end0pos=45;}else{if(YUVDU_30){end0pos=44;}else{if(YUVDU_23){end0pos=43;}else{if(YUVDU_15){end0pos=42;}else{if(YUVDU_22){end0pos=41;}else{if(YUVDU_29){end0pos=40;}else{if(YUVDU_36){end0pos=39;}else{if(YUVDU_43){end0pos=38;}else{if(YUVDU_50){end0pos=37;}else{if(YUVDU_57){end0pos=36;}else{if(YUVDU_56){end0pos=35;}else{if(YUVDU_49){end0pos=34;}else{if(YUVDU_42){end0pos=33;}else{if(YUVDU_35){end0pos=32;}else{if(YUVDU_28){end0pos=31;}else{if(YUVDU_21){end0pos=30;}else{if(YUVDU_14){end0pos=29;}else{if(YUVDU_7){end0pos=28;}else{if(YUVDU_6){end0pos=27;}else{if(YUVDU_13){end0pos=26;}else{if(YUVDU_20){end0pos=25;}else{if(YUVDU_27){end0pos=24;}else{if(YUVDU_34){end0pos=23;}else{if(YUVDU_41){end0pos=22;}else{if(YUVDU_48){end0pos=21;}else{if(YUVDU_40){end0pos=20;}else{if(YUVDU_33){end0pos=19;}else{if(YUVDU_26){end0pos=18;}else{if(YUVDU_19){end0pos=17;}else{if(YUVDU_12){end0pos=16;}else{if(YUVDU_5){end0pos=15;}else{if(YUVDU_4){end0pos=14;}else{if(YUVDU_11){end0pos=13;}else{if(YUVDU_18){end0pos=12;}else{if(YUVDU_25){end0pos=11;}else{if(YUVDU_32){end0pos=10;}else{if(YUVDU_24){end0pos=9;}else{if(YUVDU_17){end0pos=8;}else{if(YUVDU_10){end0pos=7;}else{if(YUVDU_3){end0pos=6;}else{if(YUVDU_2){end0pos=5;}else{if(YUVDU_9){end0pos=4;}else{if(YUVDU_16){end0pos=3;}else{if(YUVDU_8){end0pos=2;}else{if(YUVDU_1){end0pos=1;}else{end0pos=0;}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
				
				// end0pos = first element in reverse order != 0
				
				if(end0pos){
					
					DU[0] = YUVDU_0;DU[1] = YUVDU_1;DU[5] = YUVDU_2;DU[6] = YUVDU_3;
					DU[14] = YUVDU_4;DU[15] = YUVDU_5;DU[27] = YUVDU_6;DU[28] = YUVDU_7;
					DU[2] = YUVDU_8;DU[4] = YUVDU_9;DU[7] = YUVDU_10;DU[13] = YUVDU_11;
					DU[16] = YUVDU_12;DU[26] = YUVDU_13;DU[29] = YUVDU_14;DU[42] = YUVDU_15;
					DU[3] = YUVDU_16;DU[8] = YUVDU_17;DU[12] = YUVDU_18;DU[17] = YUVDU_19;
					DU[25] = YUVDU_20;DU[30] = YUVDU_21;DU[41] = YUVDU_22;DU[43] = YUVDU_23;
					DU[9] = YUVDU_24;DU[11] = YUVDU_25;DU[18] = YUVDU_26;DU[24] = YUVDU_27;
					DU[31] = YUVDU_28;DU[40] = YUVDU_29;DU[44] = YUVDU_30;DU[53] = YUVDU_31;
					DU[10] = YUVDU_32;DU[19] = YUVDU_33;DU[23] = YUVDU_34;DU[32] = YUVDU_35;
					DU[39] = YUVDU_36;DU[45] = YUVDU_37;DU[52] = YUVDU_38;DU[54] = YUVDU_39;
					DU[20] = YUVDU_40;DU[22] = YUVDU_41;DU[33] = YUVDU_42;DU[38] = YUVDU_43;
					DU[46] = YUVDU_44;DU[51] = YUVDU_45;DU[55] = YUVDU_46;DU[60] = YUVDU_47;
					DU[21] = YUVDU_48;DU[34] = YUVDU_49;DU[37] = YUVDU_50;DU[47] = YUVDU_51;
					DU[50] = YUVDU_52;DU[56] = YUVDU_53;DU[59] = YUVDU_54;DU[61] = YUVDU_55;
					DU[35] = YUVDU_56;DU[36] = YUVDU_57;DU[48] = YUVDU_58;DU[49] = YUVDU_59;
					DU[57] = YUVDU_60;DU[58] = YUVDU_61;DU[62] = YUVDU_62;DU[63] = YUVDU_63;
					
					i = 0;
					while(i++<end0pos){
						startpos = i;
						//for (; (DU[i] == 0) && (i <= end0pos); i++){}
						while(i <= end0pos){
							if(DU[i]){
								break;
							}
							i++;
						}
						nrzeroes = i - startpos;
						
						if(nrzeroes<16){
						}else{
							nrmarker=nrzeroes / 16;
							while(nrmarker--){
								bGroupBitsOffset-=YAC_HT[481];
								bGroupValue|=YAC_HT[480]<<bGroupBitsOffset;
								//向 data 写入满8位(1字节)的数据:
								while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
							}
							nrzeroes = nrzeroes & 0xF;
						}
						
						bitStringId=(nrzeroes * 16 + category[32767 + DU[i]])*2;
						bGroupBitsOffset-=YAC_HT[bitStringId+1];
						bGroupValue|=YAC_HT[bitStringId]<<bGroupBitsOffset;
						//向 data 写入满8位(1字节)的数据:
						while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
						
						bitStringId=(32767 + DU[i])*2;
						bGroupBitsOffset-=bitcode[bitStringId+1];
						bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
						//向 data 写入满8位(1字节)的数据:
						while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					}
					
					if (end0pos == 63){
					}else{
						bGroupBitsOffset-=YAC_HT[1];
						bGroupValue|=YAC_HT[0]<<bGroupBitsOffset;
						//向 data 写入满8位(1字节)的数据:
						while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					}
				}else{
					bGroupBitsOffset-=YAC_HT[1];
					bGroupValue|=YAC_HT[0]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
				
				//processDU(UDU, fdtbl_UV, DCU, UVDC_HT, UVAC_HT,processObj);
				
				// Pass 1: process rows.
				tmp0 = YUVDU_64 + YUVDU_71;tmp7 = YUVDU_64 - YUVDU_71;tmp1 = YUVDU_65 + YUVDU_70;tmp6 = YUVDU_65 - YUVDU_70;tmp2 = YUVDU_66 + YUVDU_69;tmp5 = YUVDU_66 - YUVDU_69;tmp3 = YUVDU_67 + YUVDU_68;tmp4 = YUVDU_67 - YUVDU_68;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_64 = tmp10 + tmp11;YUVDU_68 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_66 = tmp13 + z1;YUVDU_70 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_69 = z13 + z2;YUVDU_67 = z13 - z2;YUVDU_65 = z11 + z4;YUVDU_71 = z11 - z4;
				
				tmp0 = YUVDU_72 + YUVDU_79;tmp7 = YUVDU_72 - YUVDU_79;tmp1 = YUVDU_73 + YUVDU_78;tmp6 = YUVDU_73 - YUVDU_78;tmp2 = YUVDU_74 + YUVDU_77;tmp5 = YUVDU_74 - YUVDU_77;tmp3 = YUVDU_75 + YUVDU_76;tmp4 = YUVDU_75 - YUVDU_76;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_72 = tmp10 + tmp11;YUVDU_76 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_74 = tmp13 + z1;YUVDU_78 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_77 = z13 + z2;YUVDU_75 = z13 - z2;YUVDU_73 = z11 + z4;YUVDU_79 = z11 - z4;
				
				tmp0 = YUVDU_80 + YUVDU_87;tmp7 = YUVDU_80 - YUVDU_87;tmp1 = YUVDU_81 + YUVDU_86;tmp6 = YUVDU_81 - YUVDU_86;tmp2 = YUVDU_82 + YUVDU_85;tmp5 = YUVDU_82 - YUVDU_85;tmp3 = YUVDU_83 + YUVDU_84;tmp4 = YUVDU_83 - YUVDU_84;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_80 = tmp10 + tmp11;YUVDU_84 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_82 = tmp13 + z1;YUVDU_86 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_85 = z13 + z2;YUVDU_83 = z13 - z2;YUVDU_81 = z11 + z4;YUVDU_87 = z11 - z4;
				
				tmp0 = YUVDU_88 + YUVDU_95;tmp7 = YUVDU_88 - YUVDU_95;tmp1 = YUVDU_89 + YUVDU_94;tmp6 = YUVDU_89 - YUVDU_94;tmp2 = YUVDU_90 + YUVDU_93;tmp5 = YUVDU_90 - YUVDU_93;tmp3 = YUVDU_91 + YUVDU_92;tmp4 = YUVDU_91 - YUVDU_92;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_88 = tmp10 + tmp11;YUVDU_92 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_90 = tmp13 + z1;YUVDU_94 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_93 = z13 + z2;YUVDU_91 = z13 - z2;YUVDU_89 = z11 + z4;YUVDU_95 = z11 - z4;
				
				tmp0 = YUVDU_96 + YUVDU_103;tmp7 = YUVDU_96 - YUVDU_103;tmp1 = YUVDU_97 + YUVDU_102;tmp6 = YUVDU_97 - YUVDU_102;tmp2 = YUVDU_98 + YUVDU_101;tmp5 = YUVDU_98 - YUVDU_101;tmp3 = YUVDU_99 + YUVDU_100;tmp4 = YUVDU_99 - YUVDU_100;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_96 = tmp10 + tmp11;YUVDU_100 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_98 = tmp13 + z1;YUVDU_102 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_101 = z13 + z2;YUVDU_99 = z13 - z2;YUVDU_97 = z11 + z4;YUVDU_103 = z11 - z4;
				
				tmp0 = YUVDU_104 + YUVDU_111;tmp7 = YUVDU_104 - YUVDU_111;tmp1 = YUVDU_105 + YUVDU_110;tmp6 = YUVDU_105 - YUVDU_110;tmp2 = YUVDU_106 + YUVDU_109;tmp5 = YUVDU_106 - YUVDU_109;tmp3 = YUVDU_107 + YUVDU_108;tmp4 = YUVDU_107 - YUVDU_108;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_104 = tmp10 + tmp11;YUVDU_108 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_106 = tmp13 + z1;YUVDU_110 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_109 = z13 + z2;YUVDU_107 = z13 - z2;YUVDU_105 = z11 + z4;YUVDU_111 = z11 - z4;
				
				tmp0 = YUVDU_112 + YUVDU_119;tmp7 = YUVDU_112 - YUVDU_119;tmp1 = YUVDU_113 + YUVDU_118;tmp6 = YUVDU_113 - YUVDU_118;tmp2 = YUVDU_114 + YUVDU_117;tmp5 = YUVDU_114 - YUVDU_117;tmp3 = YUVDU_115 + YUVDU_116;tmp4 = YUVDU_115 - YUVDU_116;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_112 = tmp10 + tmp11;YUVDU_116 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_114 = tmp13 + z1;YUVDU_118 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_117 = z13 + z2;YUVDU_115 = z13 - z2;YUVDU_113 = z11 + z4;YUVDU_119 = z11 - z4;
				
				tmp0 = YUVDU_120 + YUVDU_127;tmp7 = YUVDU_120 - YUVDU_127;tmp1 = YUVDU_121 + YUVDU_126;tmp6 = YUVDU_121 - YUVDU_126;tmp2 = YUVDU_122 + YUVDU_125;tmp5 = YUVDU_122 - YUVDU_125;tmp3 = YUVDU_123 + YUVDU_124;tmp4 = YUVDU_123 - YUVDU_124;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_120 = tmp10 + tmp11;YUVDU_124 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_122 = tmp13 + z1;YUVDU_126 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_125 = z13 + z2;YUVDU_123 = z13 - z2;YUVDU_121 = z11 + z4;YUVDU_127 = z11 - z4;
				
				// Pass 2: process columns.
				tmp0 = YUVDU_64 + YUVDU_120;tmp7 = YUVDU_64 - YUVDU_120;tmp1 = YUVDU_72 + YUVDU_112;tmp6 = YUVDU_72 - YUVDU_112;tmp2 = YUVDU_80 + YUVDU_104;tmp5 = YUVDU_80 - YUVDU_104;tmp3 = YUVDU_88 + YUVDU_96;tmp4 = YUVDU_88 - YUVDU_96;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_64 = tmp10 + tmp11;YUVDU_96 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_80 = tmp13 + z1;YUVDU_112 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_104 = z13 + z2;YUVDU_88 = z13 - z2;YUVDU_72 = z11 + z4;YUVDU_120 = z11 - z4;
				
				tmp0 = YUVDU_65 + YUVDU_121;tmp7 = YUVDU_65 - YUVDU_121;tmp1 = YUVDU_73 + YUVDU_113;tmp6 = YUVDU_73 - YUVDU_113;tmp2 = YUVDU_81 + YUVDU_105;tmp5 = YUVDU_81 - YUVDU_105;tmp3 = YUVDU_89 + YUVDU_97;tmp4 = YUVDU_89 - YUVDU_97;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_65 = tmp10 + tmp11;YUVDU_97 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_81 = tmp13 + z1;YUVDU_113 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_105 = z13 + z2;YUVDU_89 = z13 - z2;YUVDU_73 = z11 + z4;YUVDU_121 = z11 - z4;
				
				tmp0 = YUVDU_66 + YUVDU_122;tmp7 = YUVDU_66 - YUVDU_122;tmp1 = YUVDU_74 + YUVDU_114;tmp6 = YUVDU_74 - YUVDU_114;tmp2 = YUVDU_82 + YUVDU_106;tmp5 = YUVDU_82 - YUVDU_106;tmp3 = YUVDU_90 + YUVDU_98;tmp4 = YUVDU_90 - YUVDU_98;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_66 = tmp10 + tmp11;YUVDU_98 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_82 = tmp13 + z1;YUVDU_114 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_106 = z13 + z2;YUVDU_90 = z13 - z2;YUVDU_74 = z11 + z4;YUVDU_122 = z11 - z4;
				
				tmp0 = YUVDU_67 + YUVDU_123;tmp7 = YUVDU_67 - YUVDU_123;tmp1 = YUVDU_75 + YUVDU_115;tmp6 = YUVDU_75 - YUVDU_115;tmp2 = YUVDU_83 + YUVDU_107;tmp5 = YUVDU_83 - YUVDU_107;tmp3 = YUVDU_91 + YUVDU_99;tmp4 = YUVDU_91 - YUVDU_99;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_67 = tmp10 + tmp11;YUVDU_99 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_83 = tmp13 + z1;YUVDU_115 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_107 = z13 + z2;YUVDU_91 = z13 - z2;YUVDU_75 = z11 + z4;YUVDU_123 = z11 - z4;
				
				tmp0 = YUVDU_68 + YUVDU_124;tmp7 = YUVDU_68 - YUVDU_124;tmp1 = YUVDU_76 + YUVDU_116;tmp6 = YUVDU_76 - YUVDU_116;tmp2 = YUVDU_84 + YUVDU_108;tmp5 = YUVDU_84 - YUVDU_108;tmp3 = YUVDU_92 + YUVDU_100;tmp4 = YUVDU_92 - YUVDU_100;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_68 = tmp10 + tmp11;YUVDU_100 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_84 = tmp13 + z1;YUVDU_116 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_108 = z13 + z2;YUVDU_92 = z13 - z2;YUVDU_76 = z11 + z4;YUVDU_124 = z11 - z4;
				
				tmp0 = YUVDU_69 + YUVDU_125;tmp7 = YUVDU_69 - YUVDU_125;tmp1 = YUVDU_77 + YUVDU_117;tmp6 = YUVDU_77 - YUVDU_117;tmp2 = YUVDU_85 + YUVDU_109;tmp5 = YUVDU_85 - YUVDU_109;tmp3 = YUVDU_93 + YUVDU_101;tmp4 = YUVDU_93 - YUVDU_101;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_69 = tmp10 + tmp11;YUVDU_101 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_85 = tmp13 + z1;YUVDU_117 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_109 = z13 + z2;YUVDU_93 = z13 - z2;YUVDU_77 = z11 + z4;YUVDU_125 = z11 - z4;
				
				tmp0 = YUVDU_70 + YUVDU_126;tmp7 = YUVDU_70 - YUVDU_126;tmp1 = YUVDU_78 + YUVDU_118;tmp6 = YUVDU_78 - YUVDU_118;tmp2 = YUVDU_86 + YUVDU_110;tmp5 = YUVDU_86 - YUVDU_110;tmp3 = YUVDU_94 + YUVDU_102;tmp4 = YUVDU_94 - YUVDU_102;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_70 = tmp10 + tmp11;YUVDU_102 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_86 = tmp13 + z1;YUVDU_118 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_110 = z13 + z2;YUVDU_94 = z13 - z2;YUVDU_78 = z11 + z4;YUVDU_126 = z11 - z4;
				
				tmp0 = YUVDU_71 + YUVDU_127;tmp7 = YUVDU_71 - YUVDU_127;tmp1 = YUVDU_79 + YUVDU_119;tmp6 = YUVDU_79 - YUVDU_119;tmp2 = YUVDU_87 + YUVDU_111;tmp5 = YUVDU_87 - YUVDU_111;tmp3 = YUVDU_95 + YUVDU_103;tmp4 = YUVDU_95 - YUVDU_103;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_71 = tmp10 + tmp11;YUVDU_103 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_87 = tmp13 + z1;YUVDU_119 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_111 = z13 + z2;YUVDU_95 = z13 - z2;YUVDU_79 = z11 + z4;YUVDU_127 = z11 - z4;
				
				// Quantize/descale the coefficients
				// Apply the quantization and scaling factor
				// and round to nearest integer
				//for(i=0;i<64;i++){UDU[i] = Math.round((UDU[i] * fdtbl_UV[i]));}
				YUVDU_64 = Math.round((YUVDU_64 * fdtbl_UV_0));YUVDU_65 = Math.round((YUVDU_65 * fdtbl_UV_1));YUVDU_66 = Math.round((YUVDU_66 * fdtbl_UV_2));YUVDU_67 = Math.round((YUVDU_67 * fdtbl_UV_3));
				YUVDU_68 = Math.round((YUVDU_68 * fdtbl_UV_4));YUVDU_69 = Math.round((YUVDU_69 * fdtbl_UV_5));YUVDU_70 = Math.round((YUVDU_70 * fdtbl_UV_6));YUVDU_71 = Math.round((YUVDU_71 * fdtbl_UV_7));
				YUVDU_72 = Math.round((YUVDU_72 * fdtbl_UV_8));YUVDU_73 = Math.round((YUVDU_73 * fdtbl_UV_9));YUVDU_74 = Math.round((YUVDU_74 * fdtbl_UV_10));YUVDU_75 = Math.round((YUVDU_75 * fdtbl_UV_11));
				YUVDU_76 = Math.round((YUVDU_76 * fdtbl_UV_12));YUVDU_77 = Math.round((YUVDU_77 * fdtbl_UV_13));YUVDU_78 = Math.round((YUVDU_78 * fdtbl_UV_14));YUVDU_79 = Math.round((YUVDU_79 * fdtbl_UV_15));
				YUVDU_80 = Math.round((YUVDU_80 * fdtbl_UV_16));YUVDU_81 = Math.round((YUVDU_81 * fdtbl_UV_17));YUVDU_82 = Math.round((YUVDU_82 * fdtbl_UV_18));YUVDU_83 = Math.round((YUVDU_83 * fdtbl_UV_19));
				YUVDU_84 = Math.round((YUVDU_84 * fdtbl_UV_20));YUVDU_85 = Math.round((YUVDU_85 * fdtbl_UV_21));YUVDU_86 = Math.round((YUVDU_86 * fdtbl_UV_22));YUVDU_87 = Math.round((YUVDU_87 * fdtbl_UV_23));
				YUVDU_88 = Math.round((YUVDU_88 * fdtbl_UV_24));YUVDU_89 = Math.round((YUVDU_89 * fdtbl_UV_25));YUVDU_90 = Math.round((YUVDU_90 * fdtbl_UV_26));YUVDU_91 = Math.round((YUVDU_91 * fdtbl_UV_27));
				YUVDU_92 = Math.round((YUVDU_92 * fdtbl_UV_28));YUVDU_93 = Math.round((YUVDU_93 * fdtbl_UV_29));YUVDU_94 = Math.round((YUVDU_94 * fdtbl_UV_30));YUVDU_95 = Math.round((YUVDU_95 * fdtbl_UV_31));
				YUVDU_96 = Math.round((YUVDU_96 * fdtbl_UV_32));YUVDU_97 = Math.round((YUVDU_97 * fdtbl_UV_33));YUVDU_98 = Math.round((YUVDU_98 * fdtbl_UV_34));YUVDU_99 = Math.round((YUVDU_99 * fdtbl_UV_35));
				YUVDU_100 = Math.round((YUVDU_100 * fdtbl_UV_36));YUVDU_101 = Math.round((YUVDU_101 * fdtbl_UV_37));YUVDU_102 = Math.round((YUVDU_102 * fdtbl_UV_38));YUVDU_103 = Math.round((YUVDU_103 * fdtbl_UV_39));
				YUVDU_104 = Math.round((YUVDU_104 * fdtbl_UV_40));YUVDU_105 = Math.round((YUVDU_105 * fdtbl_UV_41));YUVDU_106 = Math.round((YUVDU_106 * fdtbl_UV_42));YUVDU_107 = Math.round((YUVDU_107 * fdtbl_UV_43));
				YUVDU_108 = Math.round((YUVDU_108 * fdtbl_UV_44));YUVDU_109 = Math.round((YUVDU_109 * fdtbl_UV_45));YUVDU_110 = Math.round((YUVDU_110 * fdtbl_UV_46));YUVDU_111 = Math.round((YUVDU_111 * fdtbl_UV_47));
				YUVDU_112 = Math.round((YUVDU_112 * fdtbl_UV_48));YUVDU_113 = Math.round((YUVDU_113 * fdtbl_UV_49));YUVDU_114 = Math.round((YUVDU_114 * fdtbl_UV_50));YUVDU_115 = Math.round((YUVDU_115 * fdtbl_UV_51));
				YUVDU_116 = Math.round((YUVDU_116 * fdtbl_UV_52));YUVDU_117 = Math.round((YUVDU_117 * fdtbl_UV_53));YUVDU_118 = Math.round((YUVDU_118 * fdtbl_UV_54));YUVDU_119 = Math.round((YUVDU_119 * fdtbl_UV_55));
				YUVDU_120 = Math.round((YUVDU_120 * fdtbl_UV_56));YUVDU_121 = Math.round((YUVDU_121 * fdtbl_UV_57));YUVDU_122 = Math.round((YUVDU_122 * fdtbl_UV_58));YUVDU_123 = Math.round((YUVDU_123 * fdtbl_UV_59));
				YUVDU_124 = Math.round((YUVDU_124 * fdtbl_UV_60));YUVDU_125 = Math.round((YUVDU_125 * fdtbl_UV_61));YUVDU_126 = Math.round((YUVDU_126 * fdtbl_UV_62));YUVDU_127 = Math.round((YUVDU_127 * fdtbl_UV_63));
				
				// ZigZag reorder
				//for(i=0;i<64;i++){DU[ZigZag[i]] = UDU[i];}
				
				Diff = YUVDU_64 - DCU;
				DCU = YUVDU_64;
				
				// Encode DCU
				if(Diff){// Diff might be 0
					bitStringId=category[32767 + Diff]*2;
					bGroupBitsOffset-=UVDC_HT[bitStringId+1];
					bGroupValue|=UVDC_HT[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					
					bitStringId=(32767 + Diff)*2;
					bGroupBitsOffset-=bitcode[bitStringId+1];
					bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}else{
					bGroupBitsOffset-=UVDC_HT[1];
					bGroupValue|=UVDC_HT[0]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
				
				// Encode ACs
				//var end0pos:int=64;
				//for (; (end0pos > 0) && (DU[end0pos] == 0); end0pos--){};
				if(YUVDU_127){end0pos=63;}else{if(YUVDU_126){end0pos=62;}else{if(YUVDU_119){end0pos=61;}else{if(YUVDU_111){end0pos=60;}else{if(YUVDU_118){end0pos=59;}else{if(YUVDU_125){end0pos=58;}else{if(YUVDU_124){end0pos=57;}else{if(YUVDU_117){end0pos=56;}else{if(YUVDU_110){end0pos=55;}else{if(YUVDU_103){end0pos=54;}else{if(YUVDU_95){end0pos=53;}else{if(YUVDU_102){end0pos=52;}else{if(YUVDU_109){end0pos=51;}else{if(YUVDU_116){end0pos=50;}else{if(YUVDU_123){end0pos=49;}else{if(YUVDU_122){end0pos=48;}else{if(YUVDU_115){end0pos=47;}else{if(YUVDU_108){end0pos=46;}else{if(YUVDU_101){end0pos=45;}else{if(YUVDU_94){end0pos=44;}else{if(YUVDU_87){end0pos=43;}else{if(YUVDU_79){end0pos=42;}else{if(YUVDU_86){end0pos=41;}else{if(YUVDU_93){end0pos=40;}else{if(YUVDU_100){end0pos=39;}else{if(YUVDU_107){end0pos=38;}else{if(YUVDU_114){end0pos=37;}else{if(YUVDU_121){end0pos=36;}else{if(YUVDU_120){end0pos=35;}else{if(YUVDU_113){end0pos=34;}else{if(YUVDU_106){end0pos=33;}else{if(YUVDU_99){end0pos=32;}else{if(YUVDU_92){end0pos=31;}else{if(YUVDU_85){end0pos=30;}else{if(YUVDU_78){end0pos=29;}else{if(YUVDU_71){end0pos=28;}else{if(YUVDU_70){end0pos=27;}else{if(YUVDU_77){end0pos=26;}else{if(YUVDU_84){end0pos=25;}else{if(YUVDU_91){end0pos=24;}else{if(YUVDU_98){end0pos=23;}else{if(YUVDU_105){end0pos=22;}else{if(YUVDU_112){end0pos=21;}else{if(YUVDU_104){end0pos=20;}else{if(YUVDU_97){end0pos=19;}else{if(YUVDU_90){end0pos=18;}else{if(YUVDU_83){end0pos=17;}else{if(YUVDU_76){end0pos=16;}else{if(YUVDU_69){end0pos=15;}else{if(YUVDU_68){end0pos=14;}else{if(YUVDU_75){end0pos=13;}else{if(YUVDU_82){end0pos=12;}else{if(YUVDU_89){end0pos=11;}else{if(YUVDU_96){end0pos=10;}else{if(YUVDU_88){end0pos=9;}else{if(YUVDU_81){end0pos=8;}else{if(YUVDU_74){end0pos=7;}else{if(YUVDU_67){end0pos=6;}else{if(YUVDU_66){end0pos=5;}else{if(YUVDU_73){end0pos=4;}else{if(YUVDU_80){end0pos=3;}else{if(YUVDU_72){end0pos=2;}else{if(YUVDU_65){end0pos=1;}else{end0pos=0;}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
				
				// end0pos = first element in reverse order != 0
				if(end0pos){
					
					DU[0] = YUVDU_64;DU[1] = YUVDU_65;DU[5] = YUVDU_66;DU[6] = YUVDU_67;
					DU[14] = YUVDU_68;DU[15] = YUVDU_69;DU[27] = YUVDU_70;DU[28] = YUVDU_71;
					DU[2] = YUVDU_72;DU[4] = YUVDU_73;DU[7] = YUVDU_74;DU[13] = YUVDU_75;
					DU[16] = YUVDU_76;DU[26] = YUVDU_77;DU[29] = YUVDU_78;DU[42] = YUVDU_79;
					DU[3] = YUVDU_80;DU[8] = YUVDU_81;DU[12] = YUVDU_82;DU[17] = YUVDU_83;
					DU[25] = YUVDU_84;DU[30] = YUVDU_85;DU[41] = YUVDU_86;DU[43] = YUVDU_87;
					DU[9] = YUVDU_88;DU[11] = YUVDU_89;DU[18] = YUVDU_90;DU[24] = YUVDU_91;
					DU[31] = YUVDU_92;DU[40] = YUVDU_93;DU[44] = YUVDU_94;DU[53] = YUVDU_95;
					DU[10] = YUVDU_96;DU[19] = YUVDU_97;DU[23] = YUVDU_98;DU[32] = YUVDU_99;
					DU[39] = YUVDU_100;DU[45] = YUVDU_101;DU[52] = YUVDU_102;DU[54] = YUVDU_103;
					DU[20] = YUVDU_104;DU[22] = YUVDU_105;DU[33] = YUVDU_106;DU[38] = YUVDU_107;
					DU[46] = YUVDU_108;DU[51] = YUVDU_109;DU[55] = YUVDU_110;DU[60] = YUVDU_111;
					DU[21] = YUVDU_112;DU[34] = YUVDU_113;DU[37] = YUVDU_114;DU[47] = YUVDU_115;
					DU[50] = YUVDU_116;DU[56] = YUVDU_117;DU[59] = YUVDU_118;DU[61] = YUVDU_119;
					DU[35] = YUVDU_120;DU[36] = YUVDU_121;DU[48] = YUVDU_122;DU[49] = YUVDU_123;
					DU[57] = YUVDU_124;DU[58] = YUVDU_125;DU[62] = YUVDU_126;DU[63] = YUVDU_127;
					
					i = 0;
					while(i++<end0pos){
						startpos = i;
						//for (; (DU[i] == 0) && (i <= end0pos); i++){}
						while(i <= end0pos){
							if(DU[i]){
								break;
							}
							i++;
						}
						nrzeroes = i - startpos;
						
						if(nrzeroes<16){
						}else{
							nrmarker=nrzeroes / 16;
							while(nrmarker--){
								bGroupBitsOffset-=UVAC_HT[481];
								bGroupValue|=UVAC_HT[480]<<bGroupBitsOffset;
								//向 data 写入满8位(1字节)的数据:
								while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
							}
							nrzeroes = nrzeroes & 0xF;
						}
						
						bitStringId=(nrzeroes * 16 + category[32767 + DU[i]])*2;
						bGroupBitsOffset-=UVAC_HT[bitStringId+1];
						bGroupValue|=UVAC_HT[bitStringId]<<bGroupBitsOffset;
						//向 data 写入满8位(1字节)的数据:
						while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
						
						bitStringId=(32767 + DU[i])*2;
						bGroupBitsOffset-=bitcode[bitStringId+1];
						bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
						//向 data 写入满8位(1字节)的数据:
						while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					}
					
					if (end0pos == 63){
					}else{
						bGroupBitsOffset-=UVAC_HT[1];
						bGroupValue|=UVAC_HT[0]<<bGroupBitsOffset;
						//向 data 写入满8位(1字节)的数据:
						while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					}
				}else{
					bGroupBitsOffset-=UVAC_HT[1];
					bGroupValue|=UVAC_HT[0]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
				
				//processDU(VDU, fdtbl_UV, DCV, UVDC_HT, UVAC_HT,processObj);
				
				// Pass 1: process rows.
				tmp0 = YUVDU_128 + YUVDU_135;tmp7 = YUVDU_128 - YUVDU_135;tmp1 = YUVDU_129 + YUVDU_134;tmp6 = YUVDU_129 - YUVDU_134;tmp2 = YUVDU_130 + YUVDU_133;tmp5 = YUVDU_130 - YUVDU_133;tmp3 = YUVDU_131 + YUVDU_132;tmp4 = YUVDU_131 - YUVDU_132;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_128 = tmp10 + tmp11;YUVDU_132 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_130 = tmp13 + z1;YUVDU_134 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_133 = z13 + z2;YUVDU_131 = z13 - z2;YUVDU_129 = z11 + z4;YUVDU_135 = z11 - z4;
				
				tmp0 = YUVDU_136 + YUVDU_143;tmp7 = YUVDU_136 - YUVDU_143;tmp1 = YUVDU_137 + YUVDU_142;tmp6 = YUVDU_137 - YUVDU_142;tmp2 = YUVDU_138 + YUVDU_141;tmp5 = YUVDU_138 - YUVDU_141;tmp3 = YUVDU_139 + YUVDU_140;tmp4 = YUVDU_139 - YUVDU_140;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_136 = tmp10 + tmp11;YUVDU_140 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_138 = tmp13 + z1;YUVDU_142 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_141 = z13 + z2;YUVDU_139 = z13 - z2;YUVDU_137 = z11 + z4;YUVDU_143 = z11 - z4;
				
				tmp0 = YUVDU_144 + YUVDU_151;tmp7 = YUVDU_144 - YUVDU_151;tmp1 = YUVDU_145 + YUVDU_150;tmp6 = YUVDU_145 - YUVDU_150;tmp2 = YUVDU_146 + YUVDU_149;tmp5 = YUVDU_146 - YUVDU_149;tmp3 = YUVDU_147 + YUVDU_148;tmp4 = YUVDU_147 - YUVDU_148;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_144 = tmp10 + tmp11;YUVDU_148 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_146 = tmp13 + z1;YUVDU_150 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_149 = z13 + z2;YUVDU_147 = z13 - z2;YUVDU_145 = z11 + z4;YUVDU_151 = z11 - z4;
				
				tmp0 = YUVDU_152 + YUVDU_159;tmp7 = YUVDU_152 - YUVDU_159;tmp1 = YUVDU_153 + YUVDU_158;tmp6 = YUVDU_153 - YUVDU_158;tmp2 = YUVDU_154 + YUVDU_157;tmp5 = YUVDU_154 - YUVDU_157;tmp3 = YUVDU_155 + YUVDU_156;tmp4 = YUVDU_155 - YUVDU_156;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_152 = tmp10 + tmp11;YUVDU_156 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_154 = tmp13 + z1;YUVDU_158 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_157 = z13 + z2;YUVDU_155 = z13 - z2;YUVDU_153 = z11 + z4;YUVDU_159 = z11 - z4;
				
				tmp0 = YUVDU_160 + YUVDU_167;tmp7 = YUVDU_160 - YUVDU_167;tmp1 = YUVDU_161 + YUVDU_166;tmp6 = YUVDU_161 - YUVDU_166;tmp2 = YUVDU_162 + YUVDU_165;tmp5 = YUVDU_162 - YUVDU_165;tmp3 = YUVDU_163 + YUVDU_164;tmp4 = YUVDU_163 - YUVDU_164;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_160 = tmp10 + tmp11;YUVDU_164 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_162 = tmp13 + z1;YUVDU_166 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_165 = z13 + z2;YUVDU_163 = z13 - z2;YUVDU_161 = z11 + z4;YUVDU_167 = z11 - z4;
				
				tmp0 = YUVDU_168 + YUVDU_175;tmp7 = YUVDU_168 - YUVDU_175;tmp1 = YUVDU_169 + YUVDU_174;tmp6 = YUVDU_169 - YUVDU_174;tmp2 = YUVDU_170 + YUVDU_173;tmp5 = YUVDU_170 - YUVDU_173;tmp3 = YUVDU_171 + YUVDU_172;tmp4 = YUVDU_171 - YUVDU_172;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_168 = tmp10 + tmp11;YUVDU_172 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_170 = tmp13 + z1;YUVDU_174 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_173 = z13 + z2;YUVDU_171 = z13 - z2;YUVDU_169 = z11 + z4;YUVDU_175 = z11 - z4;
				
				tmp0 = YUVDU_176 + YUVDU_183;tmp7 = YUVDU_176 - YUVDU_183;tmp1 = YUVDU_177 + YUVDU_182;tmp6 = YUVDU_177 - YUVDU_182;tmp2 = YUVDU_178 + YUVDU_181;tmp5 = YUVDU_178 - YUVDU_181;tmp3 = YUVDU_179 + YUVDU_180;tmp4 = YUVDU_179 - YUVDU_180;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_176 = tmp10 + tmp11;YUVDU_180 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_178 = tmp13 + z1;YUVDU_182 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_181 = z13 + z2;YUVDU_179 = z13 - z2;YUVDU_177 = z11 + z4;YUVDU_183 = z11 - z4;
				
				tmp0 = YUVDU_184 + YUVDU_191;tmp7 = YUVDU_184 - YUVDU_191;tmp1 = YUVDU_185 + YUVDU_190;tmp6 = YUVDU_185 - YUVDU_190;tmp2 = YUVDU_186 + YUVDU_189;tmp5 = YUVDU_186 - YUVDU_189;tmp3 = YUVDU_187 + YUVDU_188;tmp4 = YUVDU_187 - YUVDU_188;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_184 = tmp10 + tmp11;YUVDU_188 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_186 = tmp13 + z1;YUVDU_190 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_189 = z13 + z2;YUVDU_187 = z13 - z2;YUVDU_185 = z11 + z4;YUVDU_191 = z11 - z4;
				
				// Pass 2: process columns.
				tmp0 = YUVDU_128 + YUVDU_184;tmp7 = YUVDU_128 - YUVDU_184;tmp1 = YUVDU_136 + YUVDU_176;tmp6 = YUVDU_136 - YUVDU_176;tmp2 = YUVDU_144 + YUVDU_168;tmp5 = YUVDU_144 - YUVDU_168;tmp3 = YUVDU_152 + YUVDU_160;tmp4 = YUVDU_152 - YUVDU_160;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_128 = tmp10 + tmp11;YUVDU_160 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_144 = tmp13 + z1;YUVDU_176 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_168 = z13 + z2;YUVDU_152 = z13 - z2;YUVDU_136 = z11 + z4;YUVDU_184 = z11 - z4;
				
				tmp0 = YUVDU_129 + YUVDU_185;tmp7 = YUVDU_129 - YUVDU_185;tmp1 = YUVDU_137 + YUVDU_177;tmp6 = YUVDU_137 - YUVDU_177;tmp2 = YUVDU_145 + YUVDU_169;tmp5 = YUVDU_145 - YUVDU_169;tmp3 = YUVDU_153 + YUVDU_161;tmp4 = YUVDU_153 - YUVDU_161;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_129 = tmp10 + tmp11;YUVDU_161 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_145 = tmp13 + z1;YUVDU_177 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_169 = z13 + z2;YUVDU_153 = z13 - z2;YUVDU_137 = z11 + z4;YUVDU_185 = z11 - z4;
				
				tmp0 = YUVDU_130 + YUVDU_186;tmp7 = YUVDU_130 - YUVDU_186;tmp1 = YUVDU_138 + YUVDU_178;tmp6 = YUVDU_138 - YUVDU_178;tmp2 = YUVDU_146 + YUVDU_170;tmp5 = YUVDU_146 - YUVDU_170;tmp3 = YUVDU_154 + YUVDU_162;tmp4 = YUVDU_154 - YUVDU_162;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_130 = tmp10 + tmp11;YUVDU_162 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_146 = tmp13 + z1;YUVDU_178 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_170 = z13 + z2;YUVDU_154 = z13 - z2;YUVDU_138 = z11 + z4;YUVDU_186 = z11 - z4;
				
				tmp0 = YUVDU_131 + YUVDU_187;tmp7 = YUVDU_131 - YUVDU_187;tmp1 = YUVDU_139 + YUVDU_179;tmp6 = YUVDU_139 - YUVDU_179;tmp2 = YUVDU_147 + YUVDU_171;tmp5 = YUVDU_147 - YUVDU_171;tmp3 = YUVDU_155 + YUVDU_163;tmp4 = YUVDU_155 - YUVDU_163;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_131 = tmp10 + tmp11;YUVDU_163 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_147 = tmp13 + z1;YUVDU_179 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_171 = z13 + z2;YUVDU_155 = z13 - z2;YUVDU_139 = z11 + z4;YUVDU_187 = z11 - z4;
				
				tmp0 = YUVDU_132 + YUVDU_188;tmp7 = YUVDU_132 - YUVDU_188;tmp1 = YUVDU_140 + YUVDU_180;tmp6 = YUVDU_140 - YUVDU_180;tmp2 = YUVDU_148 + YUVDU_172;tmp5 = YUVDU_148 - YUVDU_172;tmp3 = YUVDU_156 + YUVDU_164;tmp4 = YUVDU_156 - YUVDU_164;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_132 = tmp10 + tmp11;YUVDU_164 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_148 = tmp13 + z1;YUVDU_180 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_172 = z13 + z2;YUVDU_156 = z13 - z2;YUVDU_140 = z11 + z4;YUVDU_188 = z11 - z4;
				
				tmp0 = YUVDU_133 + YUVDU_189;tmp7 = YUVDU_133 - YUVDU_189;tmp1 = YUVDU_141 + YUVDU_181;tmp6 = YUVDU_141 - YUVDU_181;tmp2 = YUVDU_149 + YUVDU_173;tmp5 = YUVDU_149 - YUVDU_173;tmp3 = YUVDU_157 + YUVDU_165;tmp4 = YUVDU_157 - YUVDU_165;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_133 = tmp10 + tmp11;YUVDU_165 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_149 = tmp13 + z1;YUVDU_181 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_173 = z13 + z2;YUVDU_157 = z13 - z2;YUVDU_141 = z11 + z4;YUVDU_189 = z11 - z4;
				
				tmp0 = YUVDU_134 + YUVDU_190;tmp7 = YUVDU_134 - YUVDU_190;tmp1 = YUVDU_142 + YUVDU_182;tmp6 = YUVDU_142 - YUVDU_182;tmp2 = YUVDU_150 + YUVDU_174;tmp5 = YUVDU_150 - YUVDU_174;tmp3 = YUVDU_158 + YUVDU_166;tmp4 = YUVDU_158 - YUVDU_166;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_134 = tmp10 + tmp11;YUVDU_166 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_150 = tmp13 + z1;YUVDU_182 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_174 = z13 + z2;YUVDU_158 = z13 - z2;YUVDU_142 = z11 + z4;YUVDU_190 = z11 - z4;
				
				tmp0 = YUVDU_135 + YUVDU_191;tmp7 = YUVDU_135 - YUVDU_191;tmp1 = YUVDU_143 + YUVDU_183;tmp6 = YUVDU_143 - YUVDU_183;tmp2 = YUVDU_151 + YUVDU_175;tmp5 = YUVDU_151 - YUVDU_175;tmp3 = YUVDU_159 + YUVDU_167;tmp4 = YUVDU_159 - YUVDU_167;
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YUVDU_135 = tmp10 + tmp11;YUVDU_167 = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YUVDU_151 = tmp13 + z1;YUVDU_183 = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YUVDU_175 = z13 + z2;YUVDU_159 = z13 - z2;YUVDU_143 = z11 + z4;YUVDU_191 = z11 - z4;
				
				// Quantize/descale the coefficients
				// Apply the quantization and scaling factor
				// and round to nearest integer
				//for(i=0;i<64;i++){VDU[i] = Math.round((VDU[i] * fdtbl_UV[i]));}
				YUVDU_128 = Math.round((YUVDU_128 * fdtbl_UV_0));YUVDU_129 = Math.round((YUVDU_129 * fdtbl_UV_1));YUVDU_130 = Math.round((YUVDU_130 * fdtbl_UV_2));YUVDU_131 = Math.round((YUVDU_131 * fdtbl_UV_3));
				YUVDU_132 = Math.round((YUVDU_132 * fdtbl_UV_4));YUVDU_133 = Math.round((YUVDU_133 * fdtbl_UV_5));YUVDU_134 = Math.round((YUVDU_134 * fdtbl_UV_6));YUVDU_135 = Math.round((YUVDU_135 * fdtbl_UV_7));
				YUVDU_136 = Math.round((YUVDU_136 * fdtbl_UV_8));YUVDU_137 = Math.round((YUVDU_137 * fdtbl_UV_9));YUVDU_138 = Math.round((YUVDU_138 * fdtbl_UV_10));YUVDU_139 = Math.round((YUVDU_139 * fdtbl_UV_11));
				YUVDU_140 = Math.round((YUVDU_140 * fdtbl_UV_12));YUVDU_141 = Math.round((YUVDU_141 * fdtbl_UV_13));YUVDU_142 = Math.round((YUVDU_142 * fdtbl_UV_14));YUVDU_143 = Math.round((YUVDU_143 * fdtbl_UV_15));
				YUVDU_144 = Math.round((YUVDU_144 * fdtbl_UV_16));YUVDU_145 = Math.round((YUVDU_145 * fdtbl_UV_17));YUVDU_146 = Math.round((YUVDU_146 * fdtbl_UV_18));YUVDU_147 = Math.round((YUVDU_147 * fdtbl_UV_19));
				YUVDU_148 = Math.round((YUVDU_148 * fdtbl_UV_20));YUVDU_149 = Math.round((YUVDU_149 * fdtbl_UV_21));YUVDU_150 = Math.round((YUVDU_150 * fdtbl_UV_22));YUVDU_151 = Math.round((YUVDU_151 * fdtbl_UV_23));
				YUVDU_152 = Math.round((YUVDU_152 * fdtbl_UV_24));YUVDU_153 = Math.round((YUVDU_153 * fdtbl_UV_25));YUVDU_154 = Math.round((YUVDU_154 * fdtbl_UV_26));YUVDU_155 = Math.round((YUVDU_155 * fdtbl_UV_27));
				YUVDU_156 = Math.round((YUVDU_156 * fdtbl_UV_28));YUVDU_157 = Math.round((YUVDU_157 * fdtbl_UV_29));YUVDU_158 = Math.round((YUVDU_158 * fdtbl_UV_30));YUVDU_159 = Math.round((YUVDU_159 * fdtbl_UV_31));
				YUVDU_160 = Math.round((YUVDU_160 * fdtbl_UV_32));YUVDU_161 = Math.round((YUVDU_161 * fdtbl_UV_33));YUVDU_162 = Math.round((YUVDU_162 * fdtbl_UV_34));YUVDU_163 = Math.round((YUVDU_163 * fdtbl_UV_35));
				YUVDU_164 = Math.round((YUVDU_164 * fdtbl_UV_36));YUVDU_165 = Math.round((YUVDU_165 * fdtbl_UV_37));YUVDU_166 = Math.round((YUVDU_166 * fdtbl_UV_38));YUVDU_167 = Math.round((YUVDU_167 * fdtbl_UV_39));
				YUVDU_168 = Math.round((YUVDU_168 * fdtbl_UV_40));YUVDU_169 = Math.round((YUVDU_169 * fdtbl_UV_41));YUVDU_170 = Math.round((YUVDU_170 * fdtbl_UV_42));YUVDU_171 = Math.round((YUVDU_171 * fdtbl_UV_43));
				YUVDU_172 = Math.round((YUVDU_172 * fdtbl_UV_44));YUVDU_173 = Math.round((YUVDU_173 * fdtbl_UV_45));YUVDU_174 = Math.round((YUVDU_174 * fdtbl_UV_46));YUVDU_175 = Math.round((YUVDU_175 * fdtbl_UV_47));
				YUVDU_176 = Math.round((YUVDU_176 * fdtbl_UV_48));YUVDU_177 = Math.round((YUVDU_177 * fdtbl_UV_49));YUVDU_178 = Math.round((YUVDU_178 * fdtbl_UV_50));YUVDU_179 = Math.round((YUVDU_179 * fdtbl_UV_51));
				YUVDU_180 = Math.round((YUVDU_180 * fdtbl_UV_52));YUVDU_181 = Math.round((YUVDU_181 * fdtbl_UV_53));YUVDU_182 = Math.round((YUVDU_182 * fdtbl_UV_54));YUVDU_183 = Math.round((YUVDU_183 * fdtbl_UV_55));
				YUVDU_184 = Math.round((YUVDU_184 * fdtbl_UV_56));YUVDU_185 = Math.round((YUVDU_185 * fdtbl_UV_57));YUVDU_186 = Math.round((YUVDU_186 * fdtbl_UV_58));YUVDU_187 = Math.round((YUVDU_187 * fdtbl_UV_59));
				YUVDU_188 = Math.round((YUVDU_188 * fdtbl_UV_60));YUVDU_189 = Math.round((YUVDU_189 * fdtbl_UV_61));YUVDU_190 = Math.round((YUVDU_190 * fdtbl_UV_62));YUVDU_191 = Math.round((YUVDU_191 * fdtbl_UV_63));
				
				// ZigZag reorder
				//for(i=0;i<64;i++){DU[ZigZag[i]] = VDU[i];}
				
				Diff = YUVDU_128 - DCV;
				DCV = YUVDU_128;
				
				// Encode DCV
				if(Diff){// Diff might be 0
					bitStringId=category[32767 + Diff]*2;
					bGroupBitsOffset-=UVDC_HT[bitStringId+1];
					bGroupValue|=UVDC_HT[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					
					bitStringId=(32767 + Diff)*2;
					bGroupBitsOffset-=bitcode[bitStringId+1];
					bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}else{
					bGroupBitsOffset-=UVDC_HT[1];
					bGroupValue|=UVDC_HT[0]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
				
				// Encode ACs
				//var end0pos:int=64;
				//for (; (end0pos > 0) && (DU[end0pos] == 0); end0pos--){};
				if(YUVDU_191){end0pos=63;}else{if(YUVDU_190){end0pos=62;}else{if(YUVDU_183){end0pos=61;}else{if(YUVDU_175){end0pos=60;}else{if(YUVDU_182){end0pos=59;}else{if(YUVDU_189){end0pos=58;}else{if(YUVDU_188){end0pos=57;}else{if(YUVDU_181){end0pos=56;}else{if(YUVDU_174){end0pos=55;}else{if(YUVDU_167){end0pos=54;}else{if(YUVDU_159){end0pos=53;}else{if(YUVDU_166){end0pos=52;}else{if(YUVDU_173){end0pos=51;}else{if(YUVDU_180){end0pos=50;}else{if(YUVDU_187){end0pos=49;}else{if(YUVDU_186){end0pos=48;}else{if(YUVDU_179){end0pos=47;}else{if(YUVDU_172){end0pos=46;}else{if(YUVDU_165){end0pos=45;}else{if(YUVDU_158){end0pos=44;}else{if(YUVDU_151){end0pos=43;}else{if(YUVDU_143){end0pos=42;}else{if(YUVDU_150){end0pos=41;}else{if(YUVDU_157){end0pos=40;}else{if(YUVDU_164){end0pos=39;}else{if(YUVDU_171){end0pos=38;}else{if(YUVDU_178){end0pos=37;}else{if(YUVDU_185){end0pos=36;}else{if(YUVDU_184){end0pos=35;}else{if(YUVDU_177){end0pos=34;}else{if(YUVDU_170){end0pos=33;}else{if(YUVDU_163){end0pos=32;}else{if(YUVDU_156){end0pos=31;}else{if(YUVDU_149){end0pos=30;}else{if(YUVDU_142){end0pos=29;}else{if(YUVDU_135){end0pos=28;}else{if(YUVDU_134){end0pos=27;}else{if(YUVDU_141){end0pos=26;}else{if(YUVDU_148){end0pos=25;}else{if(YUVDU_155){end0pos=24;}else{if(YUVDU_162){end0pos=23;}else{if(YUVDU_169){end0pos=22;}else{if(YUVDU_176){end0pos=21;}else{if(YUVDU_168){end0pos=20;}else{if(YUVDU_161){end0pos=19;}else{if(YUVDU_154){end0pos=18;}else{if(YUVDU_147){end0pos=17;}else{if(YUVDU_140){end0pos=16;}else{if(YUVDU_133){end0pos=15;}else{if(YUVDU_132){end0pos=14;}else{if(YUVDU_139){end0pos=13;}else{if(YUVDU_146){end0pos=12;}else{if(YUVDU_153){end0pos=11;}else{if(YUVDU_160){end0pos=10;}else{if(YUVDU_152){end0pos=9;}else{if(YUVDU_145){end0pos=8;}else{if(YUVDU_138){end0pos=7;}else{if(YUVDU_131){end0pos=6;}else{if(YUVDU_130){end0pos=5;}else{if(YUVDU_137){end0pos=4;}else{if(YUVDU_144){end0pos=3;}else{if(YUVDU_136){end0pos=2;}else{if(YUVDU_129){end0pos=1;}else{end0pos=0;}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
				
				// end0pos = first element in reverse order != 0
				if(end0pos){
					
					DU[0] = YUVDU_128;DU[1] = YUVDU_129;DU[5] = YUVDU_130;DU[6] = YUVDU_131;
					DU[14] = YUVDU_132;DU[15] = YUVDU_133;DU[27] = YUVDU_134;DU[28] = YUVDU_135;
					DU[2] = YUVDU_136;DU[4] = YUVDU_137;DU[7] = YUVDU_138;DU[13] = YUVDU_139;
					DU[16] = YUVDU_140;DU[26] = YUVDU_141;DU[29] = YUVDU_142;DU[42] = YUVDU_143;
					DU[3] = YUVDU_144;DU[8] = YUVDU_145;DU[12] = YUVDU_146;DU[17] = YUVDU_147;
					DU[25] = YUVDU_148;DU[30] = YUVDU_149;DU[41] = YUVDU_150;DU[43] = YUVDU_151;
					DU[9] = YUVDU_152;DU[11] = YUVDU_153;DU[18] = YUVDU_154;DU[24] = YUVDU_155;
					DU[31] = YUVDU_156;DU[40] = YUVDU_157;DU[44] = YUVDU_158;DU[53] = YUVDU_159;
					DU[10] = YUVDU_160;DU[19] = YUVDU_161;DU[23] = YUVDU_162;DU[32] = YUVDU_163;
					DU[39] = YUVDU_164;DU[45] = YUVDU_165;DU[52] = YUVDU_166;DU[54] = YUVDU_167;
					DU[20] = YUVDU_168;DU[22] = YUVDU_169;DU[33] = YUVDU_170;DU[38] = YUVDU_171;
					DU[46] = YUVDU_172;DU[51] = YUVDU_173;DU[55] = YUVDU_174;DU[60] = YUVDU_175;
					DU[21] = YUVDU_176;DU[34] = YUVDU_177;DU[37] = YUVDU_178;DU[47] = YUVDU_179;
					DU[50] = YUVDU_180;DU[56] = YUVDU_181;DU[59] = YUVDU_182;DU[61] = YUVDU_183;
					DU[35] = YUVDU_184;DU[36] = YUVDU_185;DU[48] = YUVDU_186;DU[49] = YUVDU_187;
					DU[57] = YUVDU_188;DU[58] = YUVDU_189;DU[62] = YUVDU_190;DU[63] = YUVDU_191;
					
					i = 0;
					while(i++<end0pos){
						startpos = i;
						//for (; (DU[i] == 0) && (i <= end0pos); i++){}
						while(i <= end0pos){
							if(DU[i]){
								break;
							}
							i++;
						}
						nrzeroes = i - startpos;
						
						if(nrzeroes<16){
						}else{
							nrmarker=nrzeroes / 16;
							while(nrmarker--){
								bGroupBitsOffset-=UVAC_HT[481];
								bGroupValue|=UVAC_HT[480]<<bGroupBitsOffset;
								//向 data 写入满8位(1字节)的数据:
								while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
							}
							nrzeroes = nrzeroes & 0xF;
						}
						
						bitStringId=(nrzeroes * 16 + category[32767 + DU[i]])*2;
						bGroupBitsOffset-=UVAC_HT[bitStringId+1];
						bGroupValue|=UVAC_HT[bitStringId]<<bGroupBitsOffset;
						//向 data 写入满8位(1字节)的数据:
						while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
						
						bitStringId=(32767 + DU[i])*2;
						bGroupBitsOffset-=bitcode[bitStringId+1];
						bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
						//向 data 写入满8位(1字节)的数据:
						while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					}
					
					if (end0pos == 63){
					}else{
						bGroupBitsOffset-=UVAC_HT[1];
						bGroupValue|=UVAC_HT[0]<<bGroupBitsOffset;
						//向 data 写入满8位(1字节)的数据:
						while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					}
				}else{
					bGroupBitsOffset-=UVAC_HT[1];
					bGroupValue|=UVAC_HT[0]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
			}
			
			//向 data 写入有效的数据:
			while(bGroupBitsOffset<32){
				byteout[offset++]=bGroupValue>>>24;
				if((bGroupValue>>>24)==0xff){
					byteout[offset++]=0x00;
				}
				bGroupValue<<=8;
				bGroupBitsOffset+=8;
			}
			
			// Add EOI
			byteout[offset++]=0xFF;
			byteout[offset++]=0xD9;
			
			return byteout;
		}
	}
	
}