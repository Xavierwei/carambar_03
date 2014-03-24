/***
CXFORMWITHALPHA
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:17（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//CXFORMWITHALPHA
//Field 				Type 								Comment
//HasAddTerms 			UB[1] 								Has color addition values if equal to 1
//HasMultTerms 			UB[1] 								Has color multiply values if equal to 1
//Nbits 				UB[4] 								Bits in each value field
//RedMultTerm 			If HasMultTerms = 1, SB[Nbits] 		Red multiply value
//GreenMultTerm 		If HasMultTerms = 1, SB[Nbits] 		Green multiply value
//BlueMultTerm 			If HasMultTerms = 1, SB[Nbits] 		Blue multiply value
//AlphaMultTerm 		If HasMultTerms = 1, SB[Nbits] 		Alpha multiply value
//RedAddTerm 			If HasAddTerms = 1, SB[Nbits] 		Red addition value
//GreenAddTerm 			If HasAddTerms = 1, SB[Nbits] 		Green addition value
//BlueAddTerm 			If HasAddTerms = 1, SB[Nbits] 		Blue addition value
//AlphaAddTerm 			If HasAddTerms = 1, SB[Nbits] 		Transparency addition value
package zero.swf.records{
	import flash.utils.ByteArray;
	public class CXFORMWITHALPHA{
		
		public var HasAddTerms:Boolean;
		public var HasMultTerms:Boolean;
		public var RedMultTerm:int;
		public var GreenMultTerm:int;
		public var BlueMultTerm:int;
		public var AlphaMultTerm:int;
		public var RedAddTerm:int;
		public var GreenAddTerm:int;
		public var BlueAddTerm:int;
		public var AlphaAddTerm:int;
		
		public function CXFORMWITHALPHA(){
			//HasAddTerms=false;
			//HasMultTerms=false;
			//RedMultTerm=0;
			//GreenMultTerm=0;
			//BlueMultTerm=0;
			//AlphaMultTerm=0;
			//RedAddTerm=0;
			//GreenAddTerm=0;
			//BlueAddTerm=0;
			//AlphaAddTerm=0;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			var bGroupValue:int=(data[offset++]<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
			HasAddTerms=((bGroupValue&0x80000000)?true:false);					//10000000 00000000 00000000 00000000
			
			HasMultTerms=((bGroupValue&0x40000000)?true:false);				//01000000 00000000 00000000 00000000
			
			var Nbits:int=(bGroupValue<<2)>>>28;					//00111100 00000000 00000000 00000000
			var bGroupBitsOffset:int=6;
			
			
			if(Nbits){
				var bGroupRshiftBitsOffset:int=32-Nbits;
				var bGroupNegMask:int=1<<(Nbits-1);
				var bGroupNeg:int=0xffffffff<<Nbits;
				
				if(HasMultTerms){
					RedMultTerm=(bGroupValue<<6)>>>bGroupRshiftBitsOffset;
					if(RedMultTerm&bGroupNegMask){RedMultTerm|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
					GreenMultTerm=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(GreenMultTerm&bGroupNegMask){GreenMultTerm|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
					BlueMultTerm=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(BlueMultTerm&bGroupNegMask){BlueMultTerm|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
					AlphaMultTerm=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(AlphaMultTerm&bGroupNegMask){AlphaMultTerm|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
				}
				if(HasAddTerms){
					RedAddTerm=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(RedAddTerm&bGroupNegMask){RedAddTerm|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
					GreenAddTerm=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(GreenAddTerm&bGroupNegMask){GreenAddTerm|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
					BlueAddTerm=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(BlueAddTerm&bGroupNegMask){BlueAddTerm|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
					
					AlphaAddTerm=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(AlphaAddTerm&bGroupNegMask){AlphaAddTerm|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
				}
			}
			
			return offset-int(4-bGroupBitsOffset/8);
		}
		public function toData(_toDataOptions:Object):ByteArray{
			var data:ByteArray=new ByteArray();
			var bGroupValue:int=0;
			var offset:int=0;
			if(HasAddTerms){
				bGroupValue|=0x80000000;					//10000000 00000000 00000000 00000000
			}
			if(HasMultTerms){
				bGroupValue|=0x40000000;					//01000000 00000000 00000000 00000000
			}
			
			
			//计算所需最小位数:
			var bGroupMixNum:int=((RedMultTerm<0?-RedMultTerm:RedMultTerm)<<1)|((GreenMultTerm<0?-GreenMultTerm:GreenMultTerm)<<1)|((BlueMultTerm<0?-BlueMultTerm:BlueMultTerm)<<1)|((AlphaMultTerm<0?-AlphaMultTerm:AlphaMultTerm)<<1)|((RedAddTerm<0?-RedAddTerm:RedAddTerm)<<1)|((GreenAddTerm<0?-GreenAddTerm:GreenAddTerm)<<1)|((BlueAddTerm<0?-BlueAddTerm:BlueAddTerm)<<1)|((AlphaAddTerm<0?-AlphaAddTerm:AlphaAddTerm)<<1);
			if(bGroupMixNum>>>16){if(bGroupMixNum>>>24){if(bGroupMixNum>>>28){if(bGroupMixNum>>>30){if(bGroupMixNum>>>31){var Nbits:int=32;}else{Nbits=31;}}else{if(bGroupMixNum>>>29){Nbits=30;}else{Nbits=29;}}}else{if(bGroupMixNum>>>26){if(bGroupMixNum>>>27){Nbits=28;}else{Nbits=27;}}else{if(bGroupMixNum>>>25){Nbits=26;}else{Nbits=25;}}}}else{if(bGroupMixNum>>>20){if(bGroupMixNum>>>22){if(bGroupMixNum>>>23){Nbits=24;}else{Nbits=23;}}else{if(bGroupMixNum>>>21){Nbits=22;}else{Nbits=21;}}}else{if(bGroupMixNum>>>18){if(bGroupMixNum>>>19){Nbits=20;}else{Nbits=19;}}else{if(bGroupMixNum>>>17){Nbits=18;}else{Nbits=17;}}}}}else{if(bGroupMixNum>>>8){if(bGroupMixNum>>>12){if(bGroupMixNum>>>14){if(bGroupMixNum>>>15){Nbits=16;}else{Nbits=15;}}else{if(bGroupMixNum>>>13){Nbits=14;}else{Nbits=13;}}}else{if(bGroupMixNum>>>10){if(bGroupMixNum>>>11){Nbits=12;}else{Nbits=11;}}else{if(bGroupMixNum>>>9){Nbits=10;}else{Nbits=9;}}}}else{if(bGroupMixNum>>>4){if(bGroupMixNum>>>6){if(bGroupMixNum>>>7){Nbits=8;}else{Nbits=7;}}else{if(bGroupMixNum>>>5){Nbits=6;}else{Nbits=5;}}}else{if(bGroupMixNum>>>2){if(bGroupMixNum>>>3){Nbits=4;}else{Nbits=3;}}else{if(bGroupMixNum>>>1){Nbits=2;}else{Nbits=bGroupMixNum;}}}}}
			
			bGroupValue|=Nbits<<26;							//00111100 00000000 00000000 00000000
			var bGroupBitsOffset:int=6;
			
			var bGroupRshiftBitsOffset:int=32-Nbits;
			if(HasMultTerms){
				bGroupValue|=(RedMultTerm<<bGroupRshiftBitsOffset)>>>6;
				bGroupBitsOffset+=Nbits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
				bGroupValue|=(GreenMultTerm<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=Nbits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
				bGroupValue|=(BlueMultTerm<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=Nbits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
				bGroupValue|=(AlphaMultTerm<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=Nbits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
			}
			if(HasAddTerms){
				bGroupValue|=(RedAddTerm<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=Nbits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
				bGroupValue|=(GreenAddTerm<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=Nbits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
				bGroupValue|=(BlueAddTerm<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=Nbits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
				bGroupValue|=(AlphaAddTerm<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=Nbits;
			}
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;data[offset++]=bGroupValue;}else{data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;}else{data[offset++]=bGroupValue>>24;}
			return data;
		}

		////
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				var xml:XML=<{xmlName} class="zero.swf.records.CXFORMWITHALPHA"/>;
				if(HasMultTerms){
					xml.@HasMultTerms=HasMultTerms;
					
					xml.@RedMultTerm=RedMultTerm;
					xml.@GreenMultTerm=GreenMultTerm;
					xml.@BlueMultTerm=BlueMultTerm;
					xml.@AlphaMultTerm=AlphaMultTerm;
				}
				if(HasAddTerms){
					xml.@HasAddTerms=HasAddTerms;
					
					xml.@RedAddTerm=RedAddTerm;
					xml.@GreenAddTerm=GreenAddTerm;
					xml.@BlueAddTerm=BlueAddTerm;
					xml.@AlphaAddTerm=AlphaAddTerm;
				}
				return xml;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				HasAddTerms=(xml.@HasAddTerms.toString()=="true");
				HasMultTerms=(xml.@HasMultTerms.toString()=="true");
				if(HasMultTerms){
					RedMultTerm=int(xml.@RedMultTerm.toString());
					GreenMultTerm=int(xml.@GreenMultTerm.toString());
					BlueMultTerm=int(xml.@BlueMultTerm.toString());
					AlphaMultTerm=int(xml.@AlphaMultTerm.toString());
				}
				if(HasAddTerms){
					RedAddTerm=int(xml.@RedAddTerm.toString());
					GreenAddTerm=int(xml.@GreenAddTerm.toString());
					BlueAddTerm=int(xml.@BlueAddTerm.toString());
					AlphaAddTerm=int(xml.@AlphaAddTerm.toString());
				}
			}
		//}//end of CONFIG::USE_XML
	}
}
