/***
Filter
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 18:52:28
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//FILTER
//Field 			Type 										Comment
//FilterID 			UI8 										0 = Has DropShadowFilter
//																1 = Has BlurFilter
//																2 = Has GlowFilter
//																3 = Has BevelFilter
//																4 = Has GradientGlowFilter
//																5 = Has ConvolutionFilter
//																6 = Has ColorMatrixFilter
//																7 = Has GradientBevelFilter
//DropShadowFilter 		If FilterID = 0, DROPSHADOWFILTER		Drop Shadow filter
//BlurFilter 			If FilterID = 1, BLURFILTER 			Blur filter
//GlowFilter 			If FilterID = 2, GLOWFILTER 			Glow filter
//BevelFilter 			If FilterID = 3, BEVELFILTER 			Bevel filter
//GradientGlowFilter 	If FilterID = 4, GRADIENTGLOWFILTER		Gradient Glow filter
//ConvolutionFilter 	If FilterID = 5, CONVOLUTIONFILTER		Convolution filter
//ColorMatrixFilter 	If FilterID = 6, COLORMATRIXFILTER		Color Matrix filter
//GradientBevelFilter 	If FilterID = 7, GRADIENTBEVELFILTER	Gradient Bevel filter
package zero.swf.records{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import zero.BytesAndStr16;
	public class Filter{
		public var FilterID:int;						//UI8
		
		public var DropShadowColor:uint;				//RGBA
		public var BlurX:Number;						//FIXED
		public var BlurY:Number;						//FIXED
		public var Angle:Number;						//FIXED
		public var Distance:Number;					//FIXED
		public var Strength:Number;					//FIXED8
		public var InnerShadow:Boolean;
		public var Knockout:Boolean;
		public var CompositeSource:Boolean;
		public var Passes:int;
		
		public var GlowColor:uint;						//RGBA
		public var InnerGlow:Boolean;
		
		public var ShadowColor:uint;					//RGBA
		public var HighlightColor:uint;				//RGBA
		public var OnTop:Boolean;
		
		public var GradientColorV:Vector.<uint>;
		public var GradientRatioV:Vector.<int>;
		
		public var MatrixX:int;						//UI8
		public var MatrixY:int;						//UI8
		public var Divisor:Number;						//FLOAT
		public var Bias:Number;						//FLOAT
		public var MatrixV:Vector.<Number>;
		public var DefaultColor:uint;					//RGBA
		public var Clamp:Boolean;
		public var PreserveAlpha:Boolean;
		
		public function Filter(){
			//FilterID=0;
			
			//DropShadowColor=0;
			//BlurX=NaN;
			//BlurY=NaN;
			//Angle=NaN;
			//Distance=NaN;
			//Strength=NaN;
			//InnerShadow=false;
			//Knockout=false;
			//CompositeSource=false;
			//Passes=0;
			
			//GlowColor=0;
			//InnerGlow=false;
			
			//ShadowColor=0;
			//HighlightColor=0;
			//OnTop=false;
			
			//GradientColorV=null;
			//GradientRatioV=null;
			
			//MatrixX=0;
			//MatrixY=0;
			//Divisor=NaN;
			//Bias=NaN;
			//MatrixV=null;
			//DefaultColor=0;
			//Clamp=false;
			//PreserveAlpha=false;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			FilterID=data[offset];
			switch(FilterID){
				case FilterIDs.DROPSHADOWFILTER:
					//Drop Shadow filter
					//The Drop Shadow filter is based on the same median filter as the blur filter, but the filter is
					//applied only on the alpha color channel to obtain a shadow pixel plane.
					//The angle parameter is in radians. With angle set to 0, the shadow shows on the right side of
					//the object. The distance is measured in pixels. The shadow pixel plane values are interpolated
					//bilinearly if sub-pixel values are used.
					//The strength of the shadow normalized is 1.0 in fixed point. The strength value is applied by
					//multiplying each value in the shadow pixel plane.
					//Various compositing options are available for the drop shadow to support both inner and
					//outer shadows in regular or knockout modes.
					//The resulting color value of each pixel is obtained by multiplying the color channel of the
					//provided RGBA color value by the associated value in the shadow pixel plane. The resulting
					//pixel value is composited on the original input pixel plane by using one of the specified
					//compositing modes.
					//
					//DROPSHADOWFILTER
					//Field 			Type 			Comment
					//DropShadowColor 	RGBA 			Color of the shadow
					//BlurX 			FIXED 			Horizontal blur amount
					//BlurY 			FIXED 			Vertical blur amount
					//Angle 			FIXED 			Radian angle of the drop shadow
					//Distance 			FIXED 			Distance of the drop shadow
					//Strength 			FIXED8 			Strength of the drop shadow
					//InnerShadow 		UB[1] 			Inner shadow mode
					//Knockout 			UB[1] 			Knockout mode
					//CompositeSource 	UB[1] 			Composite source Always 1
					//Passes 			UB[5] 			Number of blur passes
					
					DropShadowColor=(data[offset+1]<<16)|(data[offset+2]<<8)|data[offset+3]|(data[offset+4]<<24);
					BlurX=data[offset+5]/65536+data[offset+6]/256+data[offset+7]+(data[offset+8]<<8);
					BlurY=data[offset+9]/65536+data[offset+10]/256+data[offset+11]+(data[offset+12]<<8);
					Angle=data[offset+13]/65536+data[offset+14]/256+data[offset+15]+(data[offset+16]<<8);
					Distance=data[offset+17]/65536+data[offset+18]/256+data[offset+19]+(data[offset+20]<<8);
					Strength=data[offset+21]/256+data[offset+22];
					var flags:int=data[offset+23];
					InnerShadow=((flags&0x80)?true:false);				//10000000
					Knockout=((flags&0x40)?true:false);					//01000000
					CompositeSource=((flags&0x20)?true:false);			//00100000
					Passes=flags&0x1f;								//00011111
					return offset+24;
				break;
				case FilterIDs.BLURFILTER:
					//Blur filter
					//The blur filter is based on a sub-pixel precise median filter (also known as a box filter). The
					//filter is applied on each of the RGBA color channels.
					//The general mathematical representation of a simple non-sub-pixel precise median filter is as
					//follows, and can be easily extended to support sub-pixel precision.
					//NOTE
					//This representation assumes that BlurX and BlurY are odd integers in order to get the
					//same result as Flash Player. The filter window is always centered on a pixel in Flash
					//Player.
					//When the number of passes is set to three, it closely approximates a Gaussian Blur filter. A
					//higher number of passes is possible, but for performance reasons, Adobe does not recommend
					//it.
					//
					//BLURFILTER
					//Field 		Type 		Comment
					//BlurX 		FIXED 		Horizontal blur amount
					//BlurY 		FIXED 		Vertical blur amount
					//Passes 		UB[5] 		Number of blur passes
					//Reserved 		UB[3] 		Must be 0
					
					BlurX=data[offset+1]/65536+data[offset+2]/256+data[offset+3]+(data[offset+4]<<8);
					BlurY=data[offset+5]/65536+data[offset+6]/256+data[offset+7]+(data[offset+8]<<8);
					flags=data[offset+9];
					Passes=flags&0xf8;							//11111000
					//Reserved=flags&0x07;						//00000111
					return offset+10;
				break;
				case FilterIDs.GLOWFILTER:
					//Glow filter
					//The Glow filter works in the same way as the Drop Shadow filter, except that it does not have
					//a distance and angle parameter. Therefore, it can run slightly faster.
					//
					//GLOWFILTER
					//Field 			Type 			Comment
					//GlowColor 		RGBA 			Color of the shadow
					//BlurX 			FIXED 			Horizontal blur amount
					//BlurY 			FIXED 			Vertical blur amount
					//Strength 			FIXED8 			Strength of the glow
					//InnerGlow 		UB[1] 			Inner glow mode
					//Knockout 			UB[1] 			Knockout mode
					//CompositeSource 	UB[1] 			Composite source Always 1
					//Passes 			UB[5] 			Number of blur passes
					
					GlowColor=(data[offset+1]<<16)|(data[offset+2]<<8)|data[offset+3]|(data[offset+4]<<24);
					BlurX=data[offset+5]/65536+data[offset+6]/256+data[offset+7]+(data[offset+8]<<8);
					BlurY=data[offset+9]/65536+data[offset+10]/256+data[offset+11]+(data[offset+12]<<8);
					Strength=data[offset+13]/256+data[offset+14];
					flags=data[offset+15];
					InnerGlow=((flags&0x80)?true:false);					//10000000
					Knockout=((flags&0x40)?true:false);					//01000000
					CompositeSource=((flags&0x20)?true:false);			//00100000
					Passes=flags&0x1f;								//00011111
					return offset+16;
				break;
				case FilterIDs.BEVELFILTER:
					//Bevel filter
					//The Bevel filter creates a smooth bevel on display list objects.
					//
					//BEVELFILTER
					//Field 			Type 			Comment
					//ShadowColor 		RGBA 			Color of the shadow
					//HighlightColor 	RGBA 			Color of the highlight
					//BlurX 			FIXED 			Horizontal blur amount
					//BlurY 			FIXED 			Vertical blur amount
					//Angle 			FIXED 			Radian angle of the drop shadow
					//Distance 			FIXED 			Distance of the drop shadow
					//Strength 			FIXED8 			Strength of the drop shadow
					//InnerShadow 		UB[1] 			Inner shadow mode
					//Knockout 			UB[1] 			Knockout mode
					//CompositeSource 	UB[1] 			Composite source Always 1
					//OnTop 			UB[1] 			OnTop mode
					//Passes 			UB[4] 			Number of blur passes
					
					ShadowColor=(data[offset+1]<<16)|(data[offset+2]<<8)|data[offset+3]|(data[offset+4]<<24);
					HighlightColor=(data[offset+5]<<16)|(data[offset+6]<<8)|data[offset+7]|(data[offset+8]<<24);
					BlurX=data[offset+9]/65536+data[offset+10]/256+data[offset+11]+(data[offset+12]<<8);
					BlurY=data[offset+13]/65536+data[offset+14]/256+data[offset+15]+(data[offset+16]<<8);
					Angle=data[offset+17]/65536+data[offset+18]/256+data[offset+19]+(data[offset+20]<<8);
					Distance=data[offset+21]/65536+data[offset+22]/256+data[offset+23]+(data[offset+24]<<8);
					Strength=data[offset+25]/256+data[offset+26];
					flags=data[offset+27];
					InnerShadow=((flags&0x80)?true:false);				//10000000
					Knockout=((flags&0x40)?true:false);					//01000000
					CompositeSource=((flags&0x20)?true:false);			//00100000
					OnTop=((flags&0x10)?true:false);						//00010000
					Passes=flags&0x0f;								//00001111
					return offset+28;
				break;
				case FilterIDs.GRADIENTGLOWFILTER:
					//Gradient Glow and Gradient Bevel filters
					//The Gradient Glow and Gradient Bevel filters are extensions of the normal Glow and Bevel
					//Filters and allow a gradient to be specified instead of a single color. Instead of multiplying a
					//single color value by the shadow-pixel plane value, the shadow-pixel plane value is mapped
					//directly into the gradient ramp to obtain the resulting color pixel value, which is then
					//composited by using one of the specified compositing modes.
					//
					//GRADIENTGLOWFILTER
					//Field 			Type 			Comment
					//NumColors 		UI8 			Number of colors in the gradient
					//GradientColors 	RGBA[NumColors]	Gradient colors
					//GradientRatio 	UI8[NumColors] 	Gradient ratios
					//BlurX 			FIXED 			Horizontal blur amount
					//BlurY 			FIXED 			Vertical blur amount
					//Angle 			FIXED 			Radian angle of the gradient glow
					//Distance 			FIXED 			Distance of the gradient glow
					//Strength 			FIXED8 			Strength of the gradient glow
					//InnerShadow 		UB[1] 			Inner glow mode
					//Knockout 			UB[1] 			Knockout mode
					//CompositeSource 	UB[1] 			Composite source Always 1
					//OnTop 			UB[1] 			OnTop mode
					//Passes 			UB[4] 			Number of blur passes
				
				case FilterIDs.GRADIENTBEVELFILTER:
					//GRADIENTBEVELFILTER
					//Field 			Type 			Comment
					//NumColors 		UI8 			Number of colors in thegradient
					//GradientColors 	RGBA[NumColors]	Gradient colors
					//GradientRatio 	UI8[NumColors] 	Gradient ratios
					//BlurX 			FIXED 			Horizontal blur amount
					//BlurY 			FIXED 			Vertical blur amount
					//Angle 			FIXED 			Radian angle of the gradient bevel
					//Distance 			FIXED 			Distance of the gradient bevel
					//Strength 			FIXED8 			Strength of the gradient bevel
					//InnerShadow 		UB[1] 			Inner bevel mode
					//Knockout 			UB[1] 			Knockout mode
					//CompositeSource 	UB[1] 			Composite source Always 1
					//OnTop 			UB[1] 			OnTop mode
					//Passes 			UB[4] 			Number of blur passes
					
					offset++;
					var NumColors:int=data[offset++];
					GradientColorV=new Vector.<uint>();
					GradientRatioV=new Vector.<int>();
					for(var i:int=0;i<NumColors;i++){
						GradientColorV[i]=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
						GradientRatioV[i]=data[offset++];
					}
					BlurX=data[offset++]/65536+data[offset++]/256+data[offset++]+(data[offset++]<<8);
					BlurY=data[offset++]/65536+data[offset++]/256+data[offset++]+(data[offset++]<<8);
					Angle=data[offset++]/65536+data[offset++]/256+data[offset++]+(data[offset++]<<8);
					Distance=data[offset++]/65536+data[offset++]/256+data[offset++]+(data[offset++]<<8);
					Strength=data[offset++]/256+data[offset++];
					flags=data[offset++];
					InnerShadow=((flags&0x80)?true:false);				//10000000
					Knockout=((flags&0x40)?true:false);					//01000000
					CompositeSource=((flags&0x20)?true:false);			//00100000
					OnTop=((flags&0x10)?true:false);						//00010000
					Passes=flags&0x0f;								//00001111
					return offset;
				break;
				case FilterIDs.CONVOLUTIONFILTER:
					//The Convolution filter is a two-dimensional discrete convolution. It is applied on each pixel
					//of a display object. In the following mathematical representation, F is the input pixel plane, G
					//is the input matrix, and H is the output pixel plane:
					//The convolution is applied on each of the RGBA color components and then saturated,
					//except when the PreserveAlpha flag is set; in this case, the alpha channel value is not modified.
					//The clamping flag specifies how pixels outside of the input pixel plane are handled. If set to
					//false, the DefaultColor value is used, and otherwise, the pixel is clamped to the closest valid
					//input pixel.
					
					//CONVOLUTIONFILTER
					//Field 			Type 						Comment
					//MatrixX 			UI8 						Horizontal matrix size
					//MatrixY 			UI8 						Vertical matrix size
					//Divisor 			FLOAT 						Divisor applied to the matrix values
					//Bias 				FLOAT 						Bias applied to the matrix values
					//Matrix 			FLOAT[MatrixX * MatrixY] 	Matrix values
					//DefaultColor 		RGBA 						Default color for pixels outside the image
					//Reserved 			UB[6] 						Must be 0
					//Clamp 			UB[1] 						Clamp mode
					//PreserveAlpha 	UB[1] 						Preserve the alpha
					
					data.endian=Endian.LITTLE_ENDIAN;
					MatrixX=data[offset+1];
					MatrixY=data[offset+2];
					data.position=offset+3;
					Divisor=data.readFloat();
					Bias=data.readFloat();
					var count:int=MatrixX*MatrixY;
					MatrixV=new Vector.<Number>();
					for(i=0;i<count;i++){
						MatrixV[i]=data.readFloat();
					}
					offset=data.position;
					DefaultColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
					flags=data[offset++];
					//Reserved=flags&0xfc;								//11111100
					Clamp=((flags&0x02)?true:false);							//00000010
					PreserveAlpha=((flags&0x01)?true:false);					//00000001
					return offset;
				break;
				case FilterIDs.COLORMATRIXFILTER:
					//Color Matrix filter
					//A Color Matrix filter applies a color transformation on the pixels of a display list object. Given
					//an input RGBA pixel in a display list object, the color transformation is calculated in the
					//following way:
					//The resulting RGBA values are saturated.
					//The matrix values are stored from left to right and each row from top to bottom. The last row
					//is always assumed to be (0,0,0,0,1) and does not need to be stored.
					
					//COLORMATRIXFILTER
					//Field 		Type 		Comment
					//Matrix 		FLOAT[20] 	Color matrix values
					
					data.endian=Endian.LITTLE_ENDIAN;
					MatrixV=new Vector.<Number>();
					data.position=offset+1;
					MatrixV[0]=data.readFloat();
					MatrixV[1]=data.readFloat();
					MatrixV[2]=data.readFloat();
					MatrixV[3]=data.readFloat();
					MatrixV[4]=data.readFloat();
					MatrixV[5]=data.readFloat();
					MatrixV[6]=data.readFloat();
					MatrixV[7]=data.readFloat();
					MatrixV[8]=data.readFloat();
					MatrixV[9]=data.readFloat();
					MatrixV[10]=data.readFloat();
					MatrixV[11]=data.readFloat();
					MatrixV[12]=data.readFloat();
					MatrixV[13]=data.readFloat();
					MatrixV[14]=data.readFloat();
					MatrixV[15]=data.readFloat();
					MatrixV[16]=data.readFloat();
					MatrixV[17]=data.readFloat();
					MatrixV[18]=data.readFloat();
					MatrixV[19]=data.readFloat();
					return offset+81;
				break;
				default:
					//trace("测试");
					//return offset;
					throw new Error("FilterID="+FilterID);
				break;
			}
			return -1;
		}
		public function toData(_toDataOptions:Object):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=FilterID;
			switch(FilterID){
				case FilterIDs.DROPSHADOWFILTER:
					data[1]=DropShadowColor>>16;
					data[2]=DropShadowColor>>8;
					data[3]=DropShadowColor;
					data[4]=DropShadowColor>>24;
					data[5]=BlurX*65536;
					data[6]=BlurX*256;
					data[7]=BlurX;
					data[8]=BlurX/256;
					data[9]=BlurY*65536;
					data[10]=BlurY*256;
					data[11]=BlurY;
					data[12]=BlurY/256;
					data[13]=Angle*65536;
					data[14]=Angle*256;
					data[15]=Angle;
					data[16]=Angle/256;
					data[17]=Distance*65536;
					data[18]=Distance*256;
					data[19]=Distance;
					data[20]=Distance/256;
					data[21]=Strength*256;
					data[22]=Strength;
					var flags:int=0;
					if(InnerShadow){
						flags|=0x80;							//10000000
					}
					if(Knockout){
						flags|=0x40;							//01000000
					}
					if(CompositeSource){
						flags|=0x20;							//00100000
					}
					flags|=Passes;								//00011111
					data[23]=flags;
				break;
				case FilterIDs.BLURFILTER:
					data[1]=BlurX*65536;
					data[2]=BlurX*256;
					data[3]=BlurX;
					data[4]=BlurX/256;
					data[5]=BlurY*65536;
					data[6]=BlurY*256;
					data[7]=BlurY;
					data[8]=BlurY/256;
					flags=0;
					flags|=Passes;								//11111000
					//flags|=Reserved;							//00000111
					data[9]=flags;
				break;
				case FilterIDs.GLOWFILTER:
					data[1]=GlowColor>>16;
					data[2]=GlowColor>>8;
					data[3]=GlowColor;
					data[4]=GlowColor>>24;
					data[5]=BlurX*65536;
					data[6]=BlurX*256;
					data[7]=BlurX;
					data[8]=BlurX/256;
					data[9]=BlurY*65536;
					data[10]=BlurY*256;
					data[11]=BlurY;
					data[12]=BlurY/256;
					data[13]=Strength*256;
					data[14]=Strength;
					flags=0;
					if(InnerGlow){
						flags|=0x80;							//10000000
					}
					if(Knockout){
						flags|=0x40;							//01000000
					}
					if(CompositeSource){
						flags|=0x20;							//00100000
					}
					flags|=Passes;								//00011111
					data[15]=flags;
				break;
				case FilterIDs.BEVELFILTER:
					data[1]=ShadowColor>>16;
					data[2]=ShadowColor>>8;
					data[3]=ShadowColor;
					data[4]=ShadowColor>>24;
					data[5]=HighlightColor>>16;
					data[6]=HighlightColor>>8;
					data[7]=HighlightColor;
					data[8]=HighlightColor>>24;
					data[9]=BlurX*65536;
					data[10]=BlurX*256;
					data[11]=BlurX;
					data[12]=BlurX/256;
					data[13]=BlurY*65536;
					data[14]=BlurY*256;
					data[15]=BlurY;
					data[16]=BlurY/256;
					data[17]=Angle*65536;
					data[18]=Angle*256;
					data[19]=Angle;
					data[20]=Angle/256;
					data[21]=Distance*65536;
					data[22]=Distance*256;
					data[23]=Distance;
					data[24]=Distance/256;
					data[25]=Strength*256;
					data[26]=Strength;
					flags=0;
					if(InnerShadow){
						flags|=0x80;							//10000000
					}
					if(Knockout){
						flags|=0x40;							//01000000
					}
					if(CompositeSource){
						flags|=0x20;							//00100000
					}
					if(OnTop){
						flags|=0x10;							//00010000
					}
					flags|=Passes;								//00001111
					data[27]=flags;
				break;
				case FilterIDs.GRADIENTGLOWFILTER:
				case FilterIDs.GRADIENTBEVELFILTER:
					var NumColors:int=GradientColorV.length;
					data[1]=NumColors;
					var offset:int=2;
					var i:int=-1;
					for each(var GradientColor:uint in GradientColorV){
						i++;
						data[offset++]=GradientColor>>16;
						data[offset++]=GradientColor>>8;
						data[offset++]=GradientColor;
						data[offset++]=GradientColor>>24;
						data[offset++]=GradientRatioV[i];
					}
					data[offset++]=BlurX*65536;
					data[offset++]=BlurX*256;
					data[offset++]=BlurX;
					data[offset++]=BlurX/256;
					data[offset++]=BlurY*65536;
					data[offset++]=BlurY*256;
					data[offset++]=BlurY;
					data[offset++]=BlurY/256;
					data[offset++]=Angle*65536;
					data[offset++]=Angle*256;
					data[offset++]=Angle;
					data[offset++]=Angle/256;
					data[offset++]=Distance*65536;
					data[offset++]=Distance*256;
					data[offset++]=Distance;
					data[offset++]=Distance/256;
					data[offset++]=Strength*256;
					data[offset++]=Strength;
					flags=0;
					if(InnerShadow){
						flags|=0x80;							//10000000
					}
					if(Knockout){
						flags|=0x40;							//01000000
					}
					if(CompositeSource){
						flags|=0x20;							//00100000
					}
					if(OnTop){
						flags|=0x10;							//00010000
					}
					flags|=Passes;								//00001111
					data[offset++]=flags;
				break;
				case FilterIDs.CONVOLUTIONFILTER:
					data.endian=Endian.LITTLE_ENDIAN;
					data[1]=MatrixX;
					data[2]=MatrixY;
					data.position=3;
					data.writeFloat(Divisor);
					data.writeFloat(Bias);
					offset=data.length;
					var count:int=MatrixV.length;
					for each(var Matrix:Number in MatrixV){
						data.writeFloat(Matrix);
					}
					offset=data.length;
					data[offset++]=DefaultColor>>16;
					data[offset++]=DefaultColor>>8;
					data[offset++]=DefaultColor;
					data[offset++]=DefaultColor>>24;
					flags=0;
					//flags|=Reserved;							//11111100
					if(Clamp){
						flags|=0x02;							//00000010
					}
					if(PreserveAlpha){
						flags|=0x01;							//00000001
					}
					data[offset++]=flags;
				break;
				case FilterIDs.COLORMATRIXFILTER:
					data.endian=Endian.LITTLE_ENDIAN;
					data.position=1;
					data.writeFloat(MatrixV[0]);
					data.writeFloat(MatrixV[1]);
					data.writeFloat(MatrixV[2]);
					data.writeFloat(MatrixV[3]);
					data.writeFloat(MatrixV[4]);
					data.writeFloat(MatrixV[5]);
					data.writeFloat(MatrixV[6]);
					data.writeFloat(MatrixV[7]);
					data.writeFloat(MatrixV[8]);
					data.writeFloat(MatrixV[9]);
					data.writeFloat(MatrixV[10]);
					data.writeFloat(MatrixV[11]);
					data.writeFloat(MatrixV[12]);
					data.writeFloat(MatrixV[13]);
					data.writeFloat(MatrixV[14]);
					data.writeFloat(MatrixV[15]);
					data.writeFloat(MatrixV[16]);
					data.writeFloat(MatrixV[17]);
					data.writeFloat(MatrixV[18]);
					data.writeFloat(MatrixV[19]);
				break;
				default:
					throw new Error("FilterID="+FilterID);
				break;
			}
			return data;
		}
		
		////
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				switch(FilterID){
					case FilterIDs.DROPSHADOWFILTER:
						return <{xmlName} class="zero.swf.records.Filter"
							FilterID={FilterIDs.idNameV[FilterID]}
							DropShadowColor={"0x"+BytesAndStr16._16V[(DropShadowColor>>24)&0xff]+BytesAndStr16._16V[(DropShadowColor>>16)&0xff]+BytesAndStr16._16V[(DropShadowColor>>8)&0xff]+BytesAndStr16._16V[DropShadowColor&0xff]}
							BlurX={BlurX}
							BlurY={BlurY}
							Angle={Angle}
							Distance={Distance}
							Strength={Strength}
							InnerShadow={InnerShadow}
							Knockout={Knockout}
							CompositeSource={CompositeSource}
							Passes={Passes}
						/>;
					break;
					case FilterIDs.BLURFILTER:
						return <{xmlName} class="zero.swf.records.Filter"
							FilterID={FilterIDs.idNameV[FilterID]}
							BlurX={BlurX}
							BlurY={BlurY}
							Passes={Passes}
						/>;
					break;
					case FilterIDs.GLOWFILTER:
						return <{xmlName} class="zero.swf.records.Filter"
							FilterID={FilterIDs.idNameV[FilterID]}
							GlowColor={"0x"+BytesAndStr16._16V[(GlowColor>>24)&0xff]+BytesAndStr16._16V[(GlowColor>>16)&0xff]+BytesAndStr16._16V[(GlowColor>>8)&0xff]+BytesAndStr16._16V[GlowColor&0xff]}
							BlurX={BlurX}
							BlurY={BlurY}
							Strength={Strength}
							InnerGlow={InnerGlow}
							Knockout={Knockout}
							CompositeSource={CompositeSource}
							Passes={Passes}
						/>;
					break;
					case FilterIDs.BEVELFILTER:
						return <{xmlName} class="zero.swf.records.Filter"
							FilterID={FilterIDs.idNameV[FilterID]}
							ShadowColor={"0x"+BytesAndStr16._16V[(ShadowColor>>24)&0xff]+BytesAndStr16._16V[(ShadowColor>>16)&0xff]+BytesAndStr16._16V[(ShadowColor>>8)&0xff]+BytesAndStr16._16V[ShadowColor&0xff]}
							HighlightColor={"0x"+BytesAndStr16._16V[(HighlightColor>>24)&0xff]+BytesAndStr16._16V[(HighlightColor>>16)&0xff]+BytesAndStr16._16V[(HighlightColor>>8)&0xff]+BytesAndStr16._16V[HighlightColor&0xff]}
							BlurX={BlurX}
							BlurY={BlurY}
							Angle={Angle}
							Distance={Distance}
							Strength={Strength}
							InnerShadow={InnerShadow}
							Knockout={Knockout}
							CompositeSource={CompositeSource}
							OnTop={OnTop}
							Passes={Passes}
						/>;
					break;
					case FilterIDs.GRADIENTGLOWFILTER:
					case FilterIDs.GRADIENTBEVELFILTER:
						var xml:XML=<{xmlName} class="zero.swf.records.Filter"
							FilterID={FilterIDs.idNameV[FilterID]}
							BlurX={BlurX}
							BlurY={BlurY}
							Angle={Angle}
							Distance={Distance}
							Strength={Strength}
							InnerShadow={InnerShadow}
							Knockout={Knockout}
							CompositeSource={CompositeSource}
							OnTop={OnTop}
							Passes={Passes}
						/>;
						if(GradientColorV.length){
							var GradientColorAndGradientRatioListXML:XML=<GradientColorAndGradientRatioList count={GradientColorV.length}/>
							var i:int=-1;
							for each(var GradientColor:uint in GradientColorV){
								i++;
								GradientColorAndGradientRatioListXML.appendChild(<GradientColor value={"0x"+BytesAndStr16._16V[(GradientColor>>24)&0xff]+BytesAndStr16._16V[(GradientColor>>16)&0xff]+BytesAndStr16._16V[(GradientColor>>8)&0xff]+BytesAndStr16._16V[GradientColor&0xff]}/>);
								GradientColorAndGradientRatioListXML.appendChild(<GradientRatio value={GradientRatioV[i]}/>);
							}
							xml.appendChild(GradientColorAndGradientRatioListXML);
						}
						return xml;
					break;
					case FilterIDs.CONVOLUTIONFILTER:
						xml=<{xmlName} class="zero.swf.records.Filter"
							FilterID={FilterIDs.idNameV[FilterID]}
							MatrixX={MatrixX}
							MatrixY={MatrixY}
							Divisor={Divisor}
							Bias={Bias}
							DefaultColor={"0x"+BytesAndStr16._16V[(DefaultColor>>24)&0xff]+BytesAndStr16._16V[(DefaultColor>>16)&0xff]+BytesAndStr16._16V[(DefaultColor>>8)&0xff]+BytesAndStr16._16V[DefaultColor&0xff]}
							Clamp={Clamp}
							PreserveAlpha={PreserveAlpha}
						/>;
						if(MatrixV.length){
							var MatrixListXML:XML=<MatrixList count={MatrixV.length}/>
							for each(var Matrix:Number in MatrixV){
								MatrixListXML.appendChild(<Matrix value={Matrix}/>);
							}
							xml.appendChild(MatrixListXML);
						}
						return xml;
					break;
					case FilterIDs.COLORMATRIXFILTER:
						return <{xmlName} class="zero.swf.records.Filter"
							FilterID={FilterIDs.idNameV[FilterID]}
						>
							<MatrixList count="20">
								<Matrix value={MatrixV[0]}/>
								<Matrix value={MatrixV[1]}/>
								<Matrix value={MatrixV[2]}/>
								<Matrix value={MatrixV[3]}/>
								<Matrix value={MatrixV[4]}/>
								<Matrix value={MatrixV[5]}/>
								<Matrix value={MatrixV[6]}/>
								<Matrix value={MatrixV[7]}/>
								<Matrix value={MatrixV[8]}/>
								<Matrix value={MatrixV[9]}/>
								<Matrix value={MatrixV[10]}/>
								<Matrix value={MatrixV[11]}/>
								<Matrix value={MatrixV[12]}/>
								<Matrix value={MatrixV[13]}/>
								<Matrix value={MatrixV[14]}/>
								<Matrix value={MatrixV[15]}/>
								<Matrix value={MatrixV[16]}/>
								<Matrix value={MatrixV[17]}/>
								<Matrix value={MatrixV[18]}/>
								<Matrix value={MatrixV[19]}/>
							</MatrixList>
						</{xmlName}>
					break;
					default:
						//trace("测试");
						//return <{xmlName} class="zero.swf.records.Filter"/>;
						throw new Error("FilterID="+FilterID);
					break;
				}
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				FilterID=FilterIDs[xml.@FilterID.toString()];
				switch(FilterID){
					case FilterIDs.DROPSHADOWFILTER:
						DropShadowColor=uint(xml.@DropShadowColor.toString());
						BlurX=Number(xml.@BlurX.toString());
						BlurY=Number(xml.@BlurY.toString());
						Angle=Number(xml.@Angle.toString());
						Distance=Number(xml.@Distance.toString());
						Strength=Number(xml.@Strength.toString());
						InnerShadow=(xml.@InnerShadow.toString()=="true");
						Knockout=(xml.@Knockout.toString()=="true");
						CompositeSource=(xml.@CompositeSource.toString()=="true");
						Passes=int(xml.@Passes.toString());
					break;
					case FilterIDs.BLURFILTER:
						BlurX=Number(xml.@BlurX.toString());
						BlurY=Number(xml.@BlurY.toString());
						Passes=int(xml.@Passes.toString());
					break;
					case FilterIDs.GLOWFILTER:
						GlowColor=uint(xml.@GlowColor.toString());
						BlurX=Number(xml.@BlurX.toString());
						BlurY=Number(xml.@BlurY.toString());
						Strength=Number(xml.@Strength.toString());
						InnerGlow=(xml.@InnerGlow.toString()=="true");
						Knockout=(xml.@Knockout.toString()=="true");
						CompositeSource=(xml.@CompositeSource.toString()=="true");
						Passes=int(xml.@Passes.toString());
					break;
					case FilterIDs.BEVELFILTER:
						ShadowColor=uint(xml.@ShadowColor.toString());
						HighlightColor=uint(xml.@HighlightColor.toString());
						BlurX=Number(xml.@BlurX.toString());
						BlurY=Number(xml.@BlurY.toString());
						Angle=Number(xml.@Angle.toString());
						Distance=Number(xml.@Distance.toString());
						Strength=Number(xml.@Strength.toString());
						InnerShadow=(xml.@InnerShadow.toString()=="true");
						Knockout=(xml.@Knockout.toString()=="true");
						CompositeSource=(xml.@CompositeSource.toString()=="true");
						OnTop=(xml.@OnTop.toString()=="true");
						Passes=int(xml.@Passes.toString());
					break;
					case FilterIDs.GRADIENTGLOWFILTER:
					case FilterIDs.GRADIENTBEVELFILTER:
						var GradientRatioXMLList:XMLList=xml.GradientColorAndGradientRatioList.GradientRatio;
						var i:int=-1;
						GradientColorV=new Vector.<uint>();
						GradientRatioV=new Vector.<int>();
						for each(var GradientColorXML:XML in xml.GradientColorAndGradientRatioList.GradientColor){
							i++;
							GradientColorV[i]=uint(GradientColorXML.@value.toString());
							GradientRatioV[i]=int(GradientRatioXMLList[i].@value.toString());
						}
						BlurX=Number(xml.@BlurX.toString());
						BlurY=Number(xml.@BlurY.toString());
						Angle=Number(xml.@Angle.toString());
						Distance=Number(xml.@Distance.toString());
						Strength=Number(xml.@Strength.toString());
						InnerShadow=(xml.@InnerShadow.toString()=="true");
						Knockout=(xml.@Knockout.toString()=="true");
						CompositeSource=(xml.@CompositeSource.toString()=="true");
						OnTop=(xml.@OnTop.toString()=="true");
						Passes=int(xml.@Passes.toString());
					break;
					case FilterIDs.CONVOLUTIONFILTER:
						MatrixX=int(xml.@MatrixX.toString());
						MatrixY=int(xml.@MatrixY.toString());
						Divisor=Number(xml.@Divisor.toString());
						Bias=Number(xml.@Bias.toString());
						i=-1;
						MatrixV=new Vector.<Number>();
							for each(var MatrixXML:XML in xml.MatrixList.Matrix){
							i++;
							MatrixV[i]=Number(MatrixXML.@value.toString());
						}
						DefaultColor=uint(xml.@DefaultColor.toString());
						Clamp=(xml.@Clamp.toString()=="true");
						PreserveAlpha=(xml.@PreserveAlpha.toString()=="true");
					break;
					case FilterIDs.COLORMATRIXFILTER:
						var MatrixXMLList:XMLList=xml.MatrixList.Matrix
						MatrixV=new Vector.<Number>();
						MatrixV[0]=Number(MatrixXMLList[0].@value.toString());
						MatrixV[1]=Number(MatrixXMLList[1].@value.toString());
						MatrixV[2]=Number(MatrixXMLList[2].@value.toString());
						MatrixV[3]=Number(MatrixXMLList[3].@value.toString());
						MatrixV[4]=Number(MatrixXMLList[4].@value.toString());
						MatrixV[5]=Number(MatrixXMLList[5].@value.toString());
						MatrixV[6]=Number(MatrixXMLList[6].@value.toString());
						MatrixV[7]=Number(MatrixXMLList[7].@value.toString());
						MatrixV[8]=Number(MatrixXMLList[8].@value.toString());
						MatrixV[9]=Number(MatrixXMLList[9].@value.toString());
						MatrixV[10]=Number(MatrixXMLList[10].@value.toString());
						MatrixV[11]=Number(MatrixXMLList[11].@value.toString());
						MatrixV[12]=Number(MatrixXMLList[12].@value.toString());
						MatrixV[13]=Number(MatrixXMLList[13].@value.toString());
						MatrixV[14]=Number(MatrixXMLList[14].@value.toString());
						MatrixV[15]=Number(MatrixXMLList[15].@value.toString());
						MatrixV[16]=Number(MatrixXMLList[16].@value.toString());
						MatrixV[17]=Number(MatrixXMLList[17].@value.toString());
						MatrixV[18]=Number(MatrixXMLList[18].@value.toString());
						MatrixV[19]=Number(MatrixXMLList[19].@value.toString());
					break;
					default:
						throw new Error("FilterID="+FilterID);
					break;
				}
			}
		//}//end of CONFIG::USE_XML
	}
}	