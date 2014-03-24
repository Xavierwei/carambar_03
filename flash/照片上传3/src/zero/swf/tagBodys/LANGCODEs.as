/***
LANGCODEs
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月29日 14:36:03（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//Language code
//A language code identifies a spoken language that applies to text. Language codes are
//associated with font specifications in the SWF file format.
//NOTE
//A language code does not specify a text encoding; it specifies a spoken language.
//LANGCODE
//Field 			Type 			Comment
//LanguageCode 		UI8 			Language code (see following)
//Flash Player uses language codes to determine line-breaking rules for dynamic text, and to
//choose backup fonts when a specified device font is unavailable. Other uses for language codes
//may be found in the future.
//A language code of zero means no language. This code results in behavior that is dependent on
//the locale in which Flash Player is running.
//At the time of writing, the following language codes are recognized by Flash Player:
//■ 1 = Latin (the western languages covered by Latin-1: English, French, German, and so on)
//■ 2 = Japanese
//■ 3 = Korean
//■ 4 = Simplified Chinese
//■ 5 = Traditional Chinese

package zero.swf.tagBodys{
	
	
	
	public class LANGCODEs{
		
		public static const no_language:int=0;//0x00
		public static const Latin:int=1;//0x01
		public static const Japanese:int=2;//0x02
		public static const Korean:int=3;//0x03
		public static const Simplified_Chinese:int=4;//0x04
		public static const Traditional_Chinese:int=5;//0x05
		
		public static const codeV:Vector.<String>=new <String>[
			"no_language",//0x00
			"Latin",//0x01
			"Japanese",//0x02
			"Korean",//0x03
			"Simplified_Chinese",//0x04
			"Traditional_Chinese"//0x05
		];
		codeV.fixed=true;
	}
}