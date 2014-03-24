/***
CharSets 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年12月16日 10:19:12
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	//编码们
	public class CharSets{
		/*public static function getCodes():void{
			//Flash Player and AIR support a subset of the style character set definitions specified by the IANA (http://www.iana.org/assignments/character-sets).  The following table lists the supported character sets, and either the label value or an alias value (aliases point to the same base definition) can be used to specify the desired character set
			
			var fb4CharsetArr:Array=[
				["Arabic (ASMO 708)","ASMO-708",""],
				["Arabic (DOS)","DOS-720",""],
				["Arabic (ISO)","iso-8859-6","arabic, csISOLatinArabic, ECMA-114, ISO_8859-6, ISO_8859-6:1987, iso-ir-127"],
				["Arabic (Mac)","x-mac-arabic",""],
				["Arabic (Windows)","windows-1256","cp1256"],
				["Baltic (DOS)","ibm775","CP500"],
				["Baltic (ISO)","iso-8859-4","csISOLatin4, ISO_8859-4, ISO_8859-4:1988, iso-ir-110, l4, latin4"],
				["Baltic (Windows)","windows-1257",""],
				["Central European (DOS)","ibm852","cp852"],
				["Central European (ISO)","iso-8859-2","csISOLatin2, iso_8859-2, iso_8859-2:1987, iso8859-2, iso-ir-101, l2, latin2"],
				["Central European (Mac)","x-mac-ce",""],
				["Central European (Windows)","windows-1250","x-cp1250"],
				["Chinese National Standard","gb18030",""],
				["Chinese Simplified (EUC)","EUC-CN","x-euc-cn"],
				["Chinese Simplified (GB2312)","gb2312","chinese, CN-GB, csGB2312, csGB231280, csISO58GB231280, GB_2312-80, GB231280, GB2312-80, GBK, iso-ir-58"],
				["Chinese Simplified (GB18030)","gb18030",""],
				["Chinese Simplified (HZ)","hz-gb-2312",""],
				["Chinese Simplified (Mac)","x-mac-chinesesimp",""],
				["Chinese Traditional (Big5)","big5","cn-big5, csbig5, x-x-big5"],
				["Chinese Traditional (CNS)","x-Chinese-CNS",""],
				["Chinese Traditional (Eten)","x-Chinese-Eten",""],
				["Chinese Traditional (Mac)","x-mac-chinesetrad",""],
				["Cyrillic (DOS)","cp866","ibm866"],
				["Cyrillic (ISO)","iso-8859-5","csISOLatin5, csISOLatinCyrillic, cyrillic, ISO_8859-5, ISO_8859-5:1988, iso-ir-144, l5"],
				["Cyrillic (KOI8-R)","koi8-r","csKOI8R, koi, koi8, koi8r"],
				["Cyrillic (KOI8-U)","koi8-u","koi8-ru"],
				["Cyrillic (Mac)","x-mac-cyrillic",""],
				["Cyrillic (Windows)","windows-1251","x-cp1251"],
				["Europa","x-Europa",""],
				["German (IA5)","x-IA5-German",""],
				["Greek (DOS)","ibm737",""],
				["Greek (ISO)","iso-8859-7","csISOLatinGreek, ECMA-118, ELOT_928, greek, greek8, ISO_8859-7, ISO_8859-7:1987, iso-ir-126"],
				["Greek (Mac)","x-mac-greek",""],
				["Greek (Windows)","windows-1253",""],
				["Greek, Modern (DOS)","ibm869",""],
				["Hebrew (DOS)","DOS-862",""],
				["Hebrew (ISO-Logical)","iso-8859-8-i","logical"],
				["Hebrew (ISO-Visual)","iso-8859-8","csISOLatinHebrew, hebrew, ISO_8859-8, ISO_8859-8:1988, ISO-8859-8, iso-ir-138, visual"],
				["Hebrew (Mac)","x-mac-hebrew",""],
				["Hebrew (Windows)","windows-1255","ISO_8859-8-I, ISO-8859-8, visual"],
				["IBM EBCDIC (Arabic)","x-EBCDIC-Arabic",""],
				["IBM EBCDIC (Cyrillic Russian)","x-EBCDIC-CyrillicRussian",""],
				["IBM EBCDIC (Cyrillic Serbian-Bulgarian)","x-EBCDIC-CyrillicSerbianBulgarian",""],
				["IBM EBCDIC (Denmark-Norway)","x-EBCDIC-DenmarkNorway",""],
				["IBM EBCDIC (Denmark-Norway-Euro)","x-ebcdic-denmarknorway-euro",""],
				["IBM EBCDIC (Finland-Sweden)","x-EBCDIC-FinlandSweden",""],
				["IBM EBCDIC (Finland-Sweden-Euro)","x-ebcdic-finlandsweden-euro",""],
				["IBM EBCDIC (Finland-Sweden-Euro)","x-ebcdic-finlandsweden-euro","X-EBCDIC-France"],
				["IBM EBCDIC (France-Euro)","x-ebcdic-france-euro",""],
				["IBM EBCDIC (Germany)","x-EBCDIC-Germany",""],
				["IBM EBCDIC (Germany-Euro)","x-ebcdic-germany-euro",""],
				["IBM EBCDIC (Greek Modern)","x-EBCDIC-GreekModern",""],
				["IBM EBCDIC (Greek)","x-EBCDIC-Greek",""],
				["IBM EBCDIC (Hebrew)","x-EBCDIC-Hebrew",""],
				["IBM EBCDIC (Icelandic)","x-EBCDIC-Icelandic",""],
				["IBM EBCDIC (Icelandic-Euro)","x-ebcdic-icelandic-euro",""],
				["IBM EBCDIC (International-Euro)","x-ebcdic-international-euro",""],
				["IBM EBCDIC (Italy)","x-EBCDIC-Italy",""],
				["IBM EBCDIC (Italy-Euro)","x-ebcdic-italy-euro",""],
				["IBM EBCDIC (Japanese and Japanese Katakana)","x-EBCDIC-JapaneseAndKana",""],
				["IBM EBCDIC (Japanese and Japanese-Latin)","x-EBCDIC-JapaneseAndJapaneseLatin",""],
				["IBM EBCDIC (Japanese and US-Canada)","x-EBCDIC-JapaneseAndUSCanada",""],
				["IBM EBCDIC (Japanese katakana)","x-EBCDIC-JapaneseKatakana",""],
				["IBM EBCDIC (Korean and Korean Extended)","x-EBCDIC-KoreanAndKoreanExtended",""],
				["IBM EBCDIC (Korean Extended)","x-EBCDIC-KoreanExtended",""],
				["IBM EBCDIC (Multilingual Latin-2)","CP870",""],
				["IBM EBCDIC (Simplified Chinese)","x-EBCDIC-SimplifiedChinese",""],
				["IBM EBCDIC (Spain)","X-EBCDIC-Spain",""],
				["IBM EBCDIC (Spain-Euro)","x-ebcdic-spain-euro",""],
				["IBM EBCDIC (Thai)","x-EBCDIC-Thai",""],
				["IBM EBCDIC (Traditional Chinese)","x-EBCDIC-TraditionalChinese",""],
				["IBM EBCDIC (Turkish Latin-5)","CP1026",""],
				["IBM EBCDIC (Turkish)","x-EBCDIC-Turkish",""],
				["IBM EBCDIC (UK)","x-EBCDIC-UK",""],
				["IBM EBCDIC (UK-Euro)","x-ebcdic-uk-euro",""],
				["IBM EBCDIC (US-Canada)","ebcdic-cp-us",""],
				["IBM EBCDIC (US-Canada-Euro)","x-ebcdic-cp-us-euro",""],
				["Icelandic (DOS)","ibm861",""],
				["Icelandic (Mac)","x-mac-icelandic",""],
				["ISCII Assamese","x-iscii-as",""],
				["ISCII Bengali","x-iscii-be",""],
				["ISCII Devanagari","x-iscii-de",""],
				["ISCII Gujarathi","x-iscii-gu",""],
				["ISCII Kannada","x-iscii-ka",""],
				["ISCII Malayalam","x-iscii-ma",""],
				["ISCII Oriya","x-iscii-or",""],
				["ISCII Panjabi","x-iscii-pa",""],
				["ISCII Tamil","x-iscii-ta",""],
				["ISCII Telugu","x-iscii-te",""],
				["Japanese (EUC)","euc-jp","csEUCPkdFmtJapanese, Extended_UNIX_Code_Packed_Format_for_Japanese, x-euc, x-euc-jp"],
				["Japanese (JIS)","iso-2022-jp",""],
				["Japanese (JIS-Allow 1 byte Kana - SO/SI)","iso-2022-jp","_iso-2022-jp$SIO"],
				["Japanese (JIS-Allow 1 byte Kana)","csISO2022JP","_iso-2022-jp"],
				["Japanese (Mac)","x-mac-japanese",""],
				["Japanese (Shift-JIS)","shift_jis","csShiftJIS, csWindows31J, ms_Kanji, shift-jis, x-ms-cp932, x-sjis"],
				["Korean","ks_c_5601-1987","csKSC56011987, euc-kr, iso-ir-149, korean, ks_c_5601, ks_c_5601_1987, ks_c_5601-1989, KSC_5601, KSC5601"],
				["Korean (EUC)","euc-kr","csEUCKR"],
				["Korean (ISO)","iso-2022-kr","csISO2022KR"],
				["Korean (Johab)","Johab",""],
				["Korean (Mac)","x-mac-korean",""],
				["Latin 3 (ISO)","iso-8859-3","csISO, Latin3, ISO_8859-3, ISO_8859-3:1988, iso-ir-109, l3, latin3"],
				["Latin 9 (ISO)","iso-8859-15","csISO, Latin9, ISO_8859-15, l9, latin9"],
				["Norwegian (IA5)","x-IA5-Norwegian",""],
				["OEM United States","IBM437","437, cp437, csPC8, CodePage437"],
				["Swedish (IA5)","x-IA5-Swedish",""],
				["Thai (Windows)","windows-874","DOS-874, iso-8859-11, TIS-620"],
				["Turkish (DOS)","ibm857",""],
				["Turkish (ISO)","iso-8859-9","csISO, Latin5, ISO_8859-9, ISO_8859-9:1989, iso-ir-148, l5, latin5"],
				["Turkish (Mac)","x-mac-turkish",""],
				["Turkish (Windows)","windows-1254","ISO_8859-9, ISO_8859-9:1989, iso-8859-9, iso-ir-148, latin5"],
				["Unicode","unicode","utf-16"],
				["Unicode (Big-Endian)","unicodeFFFE",""],
				["Unicode (UTF-7)","utf-7","csUnicode11UTF7, unicode-1-1-utf-7, x-unicode-2-0-utf-7"],
				["Unicode (UTF-8)","utf-8","unicode-1-1-utf-8, unicode-2-0-utf-8, x-unicode-2-0-utf-8"],
				["US-ASCII","us-ascii","ANSI_X3.4-1968, ANSI_X3.4-1986, ascii, cp367, csASCII, IBM367, ISO_646.irv:1991, ISO646-US, iso-ir-6us"],
				["Vietnamese (Windows)","windows-1258",""],
				["Western European (DOS)","ibm850",""],
				["Western European (IA5)","x-IA5",""],
				["Western European (ISO)","iso-8859-1","cp819, csISO, Latin1, ibm819, iso_8859-1, iso_8859-1:1987, iso8859-1, iso-ir-100, l1, latin1"],
				["Western European (Mac)","macintosh",""],
				["Western European (Windows)","Windows-1252","ANSI_X3.4-1968, ANSI_X3.4-1986, ascii, cp367, cp819, csASCII, IBM367, ibm819, ISO_646.irv:1991, iso_8859-1, iso_8859-1:1987, ISO646-US, iso8859-1, iso-8859-1, iso-ir-100, iso-ir-6, latin1, us, us-ascii, x-ansi"]
			];
			
			//Flash Player 支持一组由 IANA (http://www.iana.org/assignments/character-sets") 指定的样式字符集定义。您可以使用标签值或别名值（指向同一个基本定义的别名）来指定所需的字符集
			
			var cs4CharsetArr:Array=[
				["阿拉伯语 (ASMO 708)","ASMO-708",""],
				["阿拉伯语 (DOS)","DOS-720",""],
				["阿拉伯语 (ISO)","iso-8859-6","arabic, csISOLatinArabic, ECMA-114, ISO_8859-6, ISO_8859-6:1987, iso-ir-127"],
				["阿拉伯语 (Mac)","x-mac-arabic",""],
				["阿拉伯语 (Windows)","windows-1256","cp1256"],
				["波罗的语 (DOS)","ibm775","CP500"],
				["波罗的语 (ISO)","iso-8859-4","csISOLatin4, ISO_8859-4, ISO_8859-4:1988, iso-ir-110, l4, latin4"],
				["波罗的语 (Windows)","windows-1257",""],
				["中欧语 (DOS)","ibm852","cp852"],
				["中欧语 (ISO)","iso-8859-2","csISOLatin2, iso_8859-2, iso_8859-2:1987, iso8859-2, iso-ir-101, l2, latin2"],
				["中欧语 (Mac)","x-mac-ce",""],
				["中欧语 (Windows)","windows-1250","x-cp1250"],
				["中国国家标准","gb18030",""],
				["简体中文 (EUC)","EUC-CN","x-euc-cn"],
				["简体中文 (GB2312)","gb2312","chinese, CN-GB, csGB2312, csGB231280, csISO58GB231280, GB_2312-80, GB231280, GB2312-80, GBK, iso-ir-58"],
				["简体中文 (HZ)","hz-gb-2312",""],
				["简体中文 (Mac)","x-mac-chinesesimp",""],
				["繁体中文 (Big5)","big5","cn-big5, csbig5, x-x-big5"],
				["繁体中文 (CNS)","x-Chinese-CNS",""],
				["繁体中文 (Eten)","x-Chinese-Eten",""],
				["繁体中文 (Mac)","x-mac-chinesetrad",""],
				["西里尔语 (DOS)","cp866","ibm866"],
				["西里尔语 (ISO)","iso-8859-5","csISOLatin5, csISOLatinCyrillic, cyrillic, ISO_8859-5, ISO_8859-5:1988, iso-ir-144, l5"],
				["西里尔语 (KOI8-R)","koi8-r","csKOI8R, koi, koi8, koi8r"],
				["西里尔语 (KOI8-U)","koi8-u","koi8-ru"],
				["西里尔语 (Mac)","x-mac-cyrillic",""],
				["西里尔语 (Windows)","windows-1251","x-cp1251"],
				["欧罗巴语","x-Europa",""],
				["德语 (IA5)","x-IA5-German",""],
				["希腊语 (DOS)","ibm737",""],
				["希腊语 (ISO)","iso-8859-7","csISOLatinGreek, ECMA-118, ELOT_928, greek, greek8, ISO_8859-7, ISO_8859-7:1987, iso-ir-126"],
				["希腊语 (Mac)","x-mac-greek",""],
				["希腊语 (Windows)","windows-1253",""],
				["现代希腊语 (DOS)","ibm869",""],
				["希伯来语 (DOS)","DOS-862",""],
				["希伯来语 (ISO-Logical)","iso-8859-8-i","逻辑"],
				["希伯来语 (ISO-Visual)","iso-8859-8","csISOLatinHebrew, hebrew, ISO_8859-8, ISO_8859-8:1988, ISO-8859-8, iso-ir-138, visual"],
				["希伯来语 (Mac)","x-mac-hebrew",""],
				["希伯来语 (Windows)","windows-1255","ISO_8859-8-I, ISO-8859-8, visual"],
				["IBM EBCDIC (阿拉伯语)","x-EBCDIC-Arabic",""],
				["IBM EBCDIC (西里尔文俄语)","x-EBCDIC-CyrillicRussian",""],
				["IBM EBCDIC (西里尔文塞尔维亚语-保加利亚语)","x-EBCDIC-CyrillicSerbianBulgarian",""],
				["IBM EBCDIC (丹麦-挪威)","x-EBCDIC-DenmarkNorway",""],
				["IBM EBCDIC (丹麦-挪威-欧洲)","x-ebcdic-denmarknorway-euro",""],
				["IBM EBCDIC (芬兰-瑞典)","x-EBCDIC-FinlandSweden",""],
				["IBM EBCDIC (Finland-Sweden-Euro)","x-ebcdic-finlandsweden-euro",""],
				["IBM EBCDIC (Finland-Sweden-Euro)","x-ebcdic-finlandsweden-euro","X-EBCDIC-France"],
				["IBM EBCDIC (法国-欧洲)","x-ebcdic-france-euro",""],
				["IBM EBCDIC (德国)","x-EBCDIC-Germany",""],
				["IBM EBCDIC (德国-欧洲)","x-ebcdic-germany-euro",""],
				["IBM EBCDIC (现代希腊语)","x-EBCDIC-GreekModern",""],
				["IBM EBCDIC (希腊语)","x-EBCDIC-Greek",""],
				["IBM EBCDIC (希伯来语)","x-EBCDIC-Hebrew",""],
				["IBM EBCDIC (冰岛语)","x-EBCDIC-Icelandic",""],
				["IBM EBCDIC (冰岛语-欧洲)","x-ebcdic-icelandic-euro",""],
				["IBM EBCDIC (国际-欧洲)","x-ebcdic-international-euro",""],
				["IBM EBCDIC (意大利语)","x-EBCDIC-Italy",""],
				["IBM EBCDIC (意大利-欧洲)","x-ebcdic-italy-euro",""],
				["IBM EBCDIC (日语和日语片假名)","x-EBCDIC-JapaneseAndKana",""],
				["IBM EBCDIC (日语和日语-拉丁语)","x-EBCDIC-JapaneseAndJapaneseLatin",""],
				["IBM EBCDIC (日语和美国-加拿大)","x-EBCDIC-JapaneseAndUSCanada",""],
				["IBM EBCDIC (日语片假名)","x-EBCDIC-JapaneseKatakana",""],
				["IBM EBCDIC (朝鲜语和朝鲜语扩展)","x-EBCDIC-KoreanAndKoreanExtended",""],
				["IBM EBCDIC (朝鲜语扩展)","x-EBCDIC-KoreanExtended",""],
				["IBM EBCDIC (多语言拉丁语-2)","CP870",""],
				["IBM EBCDIC (简体中文)","x-EBCDIC-SimplifiedChinese",""],
				["IBM EBCDIC (西班牙语)","X-EBCDIC-Spain",""],
				["IBM EBCDIC (西班牙语-欧洲)","x-ebcdic-spain-euro",""],
				["IBM EBCDIC (泰语)","x-EBCDIC-Thai",""],
				["IBM EBCDIC (繁体中文)","x-EBCDIC-TraditionalChinese",""],
				["IBM EBCDIC (土耳其拉丁语-5)","CP1026",""],
				["IBM EBCDIC (土耳其语)","x-EBCDIC-Turkish",""],
				["IBM EBCDIC (英国)","x-EBCDIC-UK",""],
				["IBM EBCDIC (英国-欧洲)","x-ebcdic-uk-euro",""],
				["IBM EBCDIC (美国-加拿大)","ebcdic-cp-us",""],
				["IBM EBCDIC (美国-加拿大-欧洲)","x-ebcdic-cp-us-euro",""],
				["冰岛语 (DOS)","ibm861",""],
				["冰岛语 (Mac)","x-mac-icelandic",""],
				["ISCII 阿萨姆语","x-iscii-as",""],
				["ISCII 孟加拉语","x-iscii-be",""],
				["ISCII 梵文","x-iscii-de",""],
				["ISCII 古吉拉特语","x-iscii-gu",""],
				["ISCII 埃纳德语","x-iscii-ka",""],
				["ISCII 马拉雅拉姆语","x-iscii-ma",""],
				["ISCII 奥里亚语","x-iscii-or",""],
				["ISCII 旁遮普文","x-iscii-pa",""],
				["ISCII 泰米尔语","x-iscii-ta",""],
				["ISCII 泰卢固语","x-iscii-te",""],
				["日语 (EUC)","euc-jp","csEUCPkdFmtJapanese, Extended_UNIX_Code_Packed_Format_for_Japanese, x-euc, x-euc-jp"],
				["日语 (JIS)","iso-2022-jp",""],
				["日语 (JIS-允许 1 个字节的假名-SO/SI)","iso-2022-jp","_iso-2022-jp$SIO"],
				["日语 (JIS-允许 1 个字节的假名)","csISO2022JP","_iso-2022-jp"],
				["日语 (Mac)","x-mac-japanese",""],
				["日语 (Shift-JIS)","shift_jis","csShiftJIS, csWindows31J, ms_Kanji, shift-jis, x-ms-cp932, x-sjis"],
				["朝鲜语","ks_c_5601-1987","csKSC56011987, euc-kr, iso-ir-149, korean, ks_c_5601, ks_c_5601_1987, ks_c_5601-1989, KSC_5601, KSC5601"],
				["朝鲜语 (EUC)","euc-kr","csEUCKR"],
				["朝鲜语 (ISO)","iso-2022-kr","csISO2022KR"],
				["朝鲜语 (Johab)","Johab",""],
				["朝鲜语 (Mac)","x-mac-korean",""],
				["Latin 3 (ISO)","iso-8859-3","csISO, Latin3, ISO_8859-3, ISO_8859-3:1988, iso-ir-109, l3, latin3"],
				["Latin 9 (ISO)","iso-8859-15","csISO, Latin9, ISO_8859-15, l9, latin9"],
				["挪威语 (IA5)","x-IA5-Norwegian",""],
				["OEM 美国","IBM437","437, cp437, csPC8, CodePage437"],
				["瑞典语 (IA5)","x-IA5-Swedish",""],
				["泰语 (Windows)","windows-874","DOS-874, iso-8859-11, TIS-620"],
				["土耳其语 (DOS)","ibm857",""],
				["土耳其语 (ISO)","iso-8859-9","csISO, Latin5, ISO_8859-9, ISO_8859-9:1989, iso-ir-148, l5, latin5"],
				["土耳其语 (Mac)","x-mac-turkish",""],
				["土耳其语 (Windows)","windows-1254","ISO_8859-9, ISO_8859-9:1989, iso-8859-9, iso-ir-148, latin5"],
				["Unicode","unicode","utf-16"],
				["Unicode (Big-Endian)","unicodeFFFE",""],
				["Unicode (UTF-7)","utf-7","csUnicode11UTF7, unicode-1-1-utf-7, x-unicode-2-0-utf-7"],
				["Unicode (UTF-8)","utf-8","unicode-1-1-utf-8, unicode-2-0-utf-8, x-unicode-2-0-utf-8"],
				["US-ASCII","us-ascii","ANSI_X3.4-1968, ANSI_X3.4-1986, ascii, cp367, csASCII, IBM367, ISO_646.irv:1991, ISO646-US, iso-ir-6us"],
				["越南语 (Windows)","windows-1258",""],
				["西欧语 (DOS)","ibm850",""],
				["西欧语 (IA5)","x-IA5",""],
				["西欧语 (ISO)","iso-8859-1","cp819, csISO, Latin1, ibm819, iso_8859-1, iso_8859-1:1987, iso8859-1, iso-ir-100, l1, latin1"],
				["西欧语 (Mac)","macintosh",""],
				["西欧语 (Windows)","Windows-1252","ANSI_X3.4-1968, ANSI_X3.4-1986, ascii, cp367, cp819, csASCII, IBM367, ibm819, ISO_646.irv:1991, iso_8859-1, iso_8859-1:1987, ISO646-US, iso8859-1, iso-8859-1, iso-ir-100, iso-ir-6, latin1, us, us-ascii, x-ansi"]
			];
			
			var charsetArr:Array=fb4CharsetArr.concat(cs4CharsetArr);
			var nameMark:Object=new Object();
			var labelMark:Object=new Object();
			var name:String;
			var label:String;
			var labelArr:Array;
			var nameAndLabelArr:Array;
			for each(var arr:Array in charsetArr){
				name=arr[0];
				label=arr[1];
				if(name&&label){
					labelArr=[label];
					if(arr[2]){
						for each(var aliasStr:String in arr[2].split(", ")){
							var alias:String=aliasStr.replace(/^\s*|\s*$/g,"");
							if(alias){
								labelArr[labelArr.length]=alias;
							}else{
								throw new Error("2");
							}
						}
					}
					
					for each(label in labelArr){
						if(labelMark[label]){
							break;
						}
					}
					nameAndLabelArr=labelMark[label];
					if(!nameAndLabelArr){
						labelMark[label]=nameAndLabelArr=[[],[]];
					}
					
					nameAndLabelArr[0][nameAndLabelArr[0].length]=name;
					for each(label in labelArr){
						nameAndLabelArr[1][nameAndLabelArr[1].length]=label;
						labelMark[label]=nameAndLabelArr;
					}
				}else{
					throw new Error("1");
				}
			}
			
			labelArr=new Array();
			for(label in labelMark){
				nameAndLabelArr=labelMark[label];
				if(nameAndLabelArr[0]){
					labelArr[labelArr.length]={names:nameAndLabelArr[0],labels:nameAndLabelArr[1]};
					nameAndLabelArr[0]=null;
					nameAndLabelArr[1]=null;
				}
			}
			
			var sortByFirstLabel:Function=function(item1:Object,item2:Object):int{
				return item1.labels[0]<item2.labels[0]?-1:1;
			}
			labelArr.sort(sortByFirstLabel);
			
			var labelToName:Function=function(label:String):String{
				return label.replace(/[-.:]/g,"_");
			}
			var deleteSame:Function=function(arr:Array):Array{
				var newArr:Array=new Array();
				for each(var value:String in arr){
					if(newArr.indexOf(value)==-1){
						newArr[newArr.length]=value;
					}
				}
				newArr.sort();
				return newArr;
			}
			var firstLabelArr:Array=new Array();
			var labelNameMark:Object=new Object();
			for each(var item:Object in labelArr){
				firstLabelArr[firstLabelArr.length]=labelToName(item.labels[0]);
				trace("//"+deleteSame(item.names));
				for each(label in deleteSame(item.labels)){
					var labelName:String=labelToName(label);
					trace((labelNameMark[labelName]?"//":"")+"public static const "+labelName+":String=\""+label+"\";");
					labelNameMark[labelName]=true;
				}
				trace("");
			}
			trace("public static const charsetV:Vector.<String>=new <String>["+firstLabelArr+"];");
		}
		*/
		
		//Arabic (ASMO 708),阿拉伯语 (ASMO 708)
		public static const ASMO_708:String="ASMO-708";
		
		//IBM EBCDIC (Turkish Latin-5),IBM EBCDIC (土耳其拉丁语-5)
		public static const CP1026:String="CP1026";
		
		//IBM EBCDIC (Multilingual Latin-2),IBM EBCDIC (多语言拉丁语-2)
		public static const CP870:String="CP870";
		
		//Arabic (DOS),阿拉伯语 (DOS)
		public static const DOS_720:String="DOS-720";
		
		//Hebrew (DOS),希伯来语 (DOS)
		public static const DOS_862:String="DOS-862";
		
		//Chinese Simplified (EUC),简体中文 (EUC)
		public static const EUC_CN:String="EUC-CN";
		public static const x_euc_cn:String="x-euc-cn";
		
		//OEM United States,OEM 美国
		//public static const 437:String="437";
		public static const CodePage437:String="CodePage437";
		public static const IBM437:String="IBM437";
		public static const cp437:String="cp437";
		public static const csPC8:String="csPC8";
		
		//Korean (Johab),朝鲜语 (Johab)
		public static const Johab:String="Johab";
		
		//IBM EBCDIC (Spain),IBM EBCDIC (西班牙语)
		public static const X_EBCDIC_Spain:String="X-EBCDIC-Spain";
		
		//Chinese Traditional (Big5),繁体中文 (Big5)
		public static const big5:String="big5";
		public static const cn_big5:String="cn-big5";
		public static const csbig5:String="csbig5";
		public static const x_x_big5:String="x-x-big5";
		
		//Cyrillic (DOS),西里尔语 (DOS)
		public static const cp866:String="cp866";
		public static const ibm866:String="ibm866";
		
		//Japanese (JIS-Allow 1 byte Kana),日语 (JIS-允许 1 个字节的假名)
		public static const _iso_2022_jp:String="_iso-2022-jp";
		public static const csISO2022JP:String="csISO2022JP";
		
		//IBM EBCDIC (US-Canada),IBM EBCDIC (美国-加拿大)
		public static const ebcdic_cp_us:String="ebcdic-cp-us";
		
		//Japanese (EUC),日语 (EUC)
		public static const Extended_UNIX_Code_Packed_Format_for_Japanese:String="Extended_UNIX_Code_Packed_Format_for_Japanese";
		public static const csEUCPkdFmtJapanese:String="csEUCPkdFmtJapanese";
		public static const euc_jp:String="euc-jp";
		public static const x_euc:String="x-euc";
		public static const x_euc_jp:String="x-euc-jp";
		
		//Chinese National Standard,Chinese Simplified (GB18030),中国国家标准
		public static const gb18030:String="gb18030";
		
		//Chinese Simplified (GB2312),简体中文 (GB2312)
		public static const CN_GB:String="CN-GB";
		public static const GB2312_80:String="GB2312-80";
		public static const GB231280:String="GB231280";
		public static const GBK:String="GBK";
		public static const GB_2312_80:String="GB_2312-80";
		public static const chinese:String="chinese";
		public static const csGB2312:String="csGB2312";
		public static const csGB231280:String="csGB231280";
		public static const csISO58GB231280:String="csISO58GB231280";
		public static const gb2312:String="gb2312";
		public static const iso_ir_58:String="iso-ir-58";
		
		//Chinese Simplified (HZ),简体中文 (HZ)
		public static const hz_gb_2312:String="hz-gb-2312";
		
		//Greek (DOS),希腊语 (DOS)
		public static const ibm737:String="ibm737";
		
		//Baltic (DOS),波罗的语 (DOS)
		public static const CP500:String="CP500";
		public static const ibm775:String="ibm775";
		
		//Western European (DOS),西欧语 (DOS)
		public static const ibm850:String="ibm850";
		
		//Central European (DOS),中欧语 (DOS)
		public static const cp852:String="cp852";
		public static const ibm852:String="ibm852";
		
		//Turkish (DOS),土耳其语 (DOS)
		public static const ibm857:String="ibm857";
		
		//Icelandic (DOS),冰岛语 (DOS)
		public static const ibm861:String="ibm861";
		
		//Greek, Modern (DOS),现代希腊语 (DOS)
		public static const ibm869:String="ibm869";
		
		//Japanese (JIS),Japanese (JIS-Allow 1 byte Kana - SO/SI),日语 (JIS),日语 (JIS-允许 1 个字节的假名-SO/SI)
		public static const _iso_2022_jp$SIO:String="_iso-2022-jp$SIO";
		public static const iso_2022_jp:String="iso-2022-jp";
		
		//Korean (ISO),朝鲜语 (ISO)
		public static const csISO2022KR:String="csISO2022KR";
		public static const iso_2022_kr:String="iso-2022-kr";
		
		//Central European (ISO),中欧语 (ISO)
		public static const csISOLatin2:String="csISOLatin2";
		public static const iso_8859_2:String="iso-8859-2";
		public static const iso_ir_101:String="iso-ir-101";
		public static const iso8859_2:String="iso8859-2";
		//public static const iso_8859_2:String="iso_8859-2";
		public static const iso_8859_2_1987:String="iso_8859-2:1987";
		public static const l2:String="l2";
		public static const latin2:String="latin2";
		
		//Latin 3 (ISO),Latin 9 (ISO),Turkish (ISO),Turkish (Windows),Western European (ISO),土耳其语 (ISO),土耳其语 (Windows)
		public static const ISO_8859_15:String="ISO_8859-15";
		public static const ISO_8859_3:String="ISO_8859-3";
		public static const ISO_8859_3_1988:String="ISO_8859-3:1988";
		public static const ISO_8859_9:String="ISO_8859-9";
		public static const ISO_8859_9_1989:String="ISO_8859-9:1989";
		public static const Latin1:String="Latin1";
		public static const Latin3:String="Latin3";
		public static const Latin5:String="Latin5";
		public static const Latin9:String="Latin9";
		public static const cp819:String="cp819";
		public static const csISO:String="csISO";
		public static const ibm819:String="ibm819";
		public static const iso_8859_1:String="iso-8859-1";
		public static const iso_8859_15:String="iso-8859-15";
		public static const iso_8859_3:String="iso-8859-3";
		public static const iso_8859_9:String="iso-8859-9";
		public static const iso_ir_100:String="iso-ir-100";
		public static const iso_ir_109:String="iso-ir-109";
		public static const iso_ir_148:String="iso-ir-148";
		public static const iso8859_1:String="iso8859-1";
		//public static const iso_8859_1:String="iso_8859-1";
		public static const iso_8859_1_1987:String="iso_8859-1:1987";
		public static const l1:String="l1";
		public static const l3:String="l3";
		public static const l5:String="l5";
		public static const l9:String="l9";
		public static const latin1:String="latin1";
		public static const latin3:String="latin3";
		public static const latin5:String="latin5";
		public static const latin9:String="latin9";
		public static const windows_1254:String="windows-1254";
		
		//Baltic (ISO),波罗的语 (ISO)
		public static const ISO_8859_4:String="ISO_8859-4";
		public static const ISO_8859_4_1988:String="ISO_8859-4:1988";
		public static const csISOLatin4:String="csISOLatin4";
		public static const iso_8859_4:String="iso-8859-4";
		public static const iso_ir_110:String="iso-ir-110";
		public static const l4:String="l4";
		public static const latin4:String="latin4";
		
		//Cyrillic (ISO),��里尔语 (ISO)
		public static const ISO_8859_5:String="ISO_8859-5";
		public static const ISO_8859_5_1988:String="ISO_8859-5:1988";
		public static const csISOLatin5:String="csISOLatin5";
		public static const csISOLatinCyrillic:String="csISOLatinCyrillic";
		public static const cyrillic:String="cyrillic";
		public static const iso_8859_5:String="iso-8859-5";
		public static const iso_ir_144:String="iso-ir-144";
		//public static const l5:String="l5";
		
		//Arabic (ISO),阿拉伯语 (ISO)
		public static const ECMA_114:String="ECMA-114";
		public static const ISO_8859_6:String="ISO_8859-6";
		public static const ISO_8859_6_1987:String="ISO_8859-6:1987";
		public static const arabic:String="arabic";
		public static const csISOLatinArabic:String="csISOLatinArabic";
		public static const iso_8859_6:String="iso-8859-6";
		public static const iso_ir_127:String="iso-ir-127";
		
		//Greek (ISO),希腊语 (ISO)
		public static const ECMA_118:String="ECMA-118";
		public static const ELOT_928:String="ELOT_928";
		public static const ISO_8859_7:String="ISO_8859-7";
		public static const ISO_8859_7_1987:String="ISO_8859-7:1987";
		public static const csISOLatinGreek:String="csISOLatinGreek";
		public static const greek:String="greek";
		public static const greek8:String="greek8";
		public static const iso_8859_7:String="iso-8859-7";
		public static const iso_ir_126:String="iso-ir-126";
		
		//Hebrew (ISO-Visual),Hebrew (Windows),希伯来语 (ISO-Visual),希伯来语 (Windows)
		public static const ISO_8859_8:String="ISO-8859-8";
		//public static const ISO_8859_8:String="ISO_8859-8";
		public static const ISO_8859_8_I:String="ISO_8859-8-I";
		public static const ISO_8859_8_1988:String="ISO_8859-8:1988";
		public static const csISOLatinHebrew:String="csISOLatinHebrew";
		public static const hebrew:String="hebrew";
		public static const iso_8859_8:String="iso-8859-8";
		public static const iso_ir_138:String="iso-ir-138";
		public static const visual:String="visual";
		public static const windows_1255:String="windows-1255";
		
		//Hebrew (ISO-Logical),希伯来语 (ISO-Logical)
		public static const iso_8859_8_i:String="iso-8859-8-i";
		public static const logical:String="logical";
		public static const 逻辑:String="逻辑";
		
		//Cyrillic (KOI8-R),西里尔语 (KOI8-R)
		public static const csKOI8R:String="csKOI8R";
		public static const koi:String="koi";
		public static const koi8:String="koi8";
		public static const koi8_r:String="koi8-r";
		public static const koi8r:String="koi8r";
		
		//Cyrillic (KOI8-U),西里尔语 (KOI8-U)
		public static const koi8_ru:String="koi8-ru";
		public static const koi8_u:String="koi8-u";
		
		//Korean,Korean (EUC),朝鲜语,朝鲜语 (EUC)
		public static const KSC5601:String="KSC5601";
		public static const KSC_5601:String="KSC_5601";
		public static const csEUCKR:String="csEUCKR";
		public static const csKSC56011987:String="csKSC56011987";
		public static const euc_kr:String="euc-kr";
		public static const iso_ir_149:String="iso-ir-149";
		public static const korean:String="korean";
		public static const ks_c_5601:String="ks_c_5601";
		public static const ks_c_5601_1987:String="ks_c_5601-1987";
		public static const ks_c_5601_1989:String="ks_c_5601-1989";
		//public static const ks_c_5601_1987:String="ks_c_5601_1987";
		
		//Western European (Mac),西欧语 (Mac)
		public static const macintosh:String="macintosh";
		
		//Japanese (Shift-JIS),日语 (Shift-JIS)
		public static const csShiftJIS:String="csShiftJIS";
		public static const csWindows31J:String="csWindows31J";
		public static const ms_Kanji:String="ms_Kanji";
		public static const shift_jis:String="shift-jis";
		//public static const shift_jis:String="shift_jis";
		public static const x_ms_cp932:String="x-ms-cp932";
		public static const x_sjis:String="x-sjis";
		
		//Unicode
		public static const unicode:String="unicode";
		public static const utf_16:String="utf-16";
		
		//Unicode (Big-Endian)
		public static const unicodeFFFE:String="unicodeFFFE";
		
		//US-ASCII,Western European (Windows),西欧语 (ISO),西欧语 (Windows)
		public static const ANSI_X3_4_1968:String="ANSI_X3.4-1968";
		public static const ANSI_X3_4_1986:String="ANSI_X3.4-1986";
		public static const IBM367:String="IBM367";
		public static const ISO646_US:String="ISO646-US";
		public static const ISO_646_irv_1991:String="ISO_646.irv:1991";
		//public static const Latin1:String="Latin1";
		public static const Windows_1252:String="Windows-1252";
		public static const ascii:String="ascii";
		public static const cp367:String="cp367";
		//public static const cp819:String="cp819";
		public static const csASCII:String="csASCII";
		//public static const csISO:String="csISO";
		//public static const ibm819:String="ibm819";
		//public static const iso_8859_1:String="iso-8859-1";
		//public static const iso_ir_100:String="iso-ir-100";
		public static const iso_ir_6:String="iso-ir-6";
		public static const iso_ir_6us:String="iso-ir-6us";
		//public static const iso8859_1:String="iso8859-1";
		//public static const iso_8859_1:String="iso_8859-1";
		//public static const iso_8859_1_1987:String="iso_8859-1:1987";
		//public static const l1:String="l1";
		//public static const latin1:String="latin1";
		public static const us:String="us";
		public static const us_ascii:String="us-ascii";
		public static const x_ansi:String="x-ansi";
		
		//Unicode (UTF-7)
		public static const csUnicode11UTF7:String="csUnicode11UTF7";
		public static const unicode_1_1_utf_7:String="unicode-1-1-utf-7";
		public static const utf_7:String="utf-7";
		public static const x_unicode_2_0_utf_7:String="x-unicode-2-0-utf-7";
		
		//Unicode (UTF-8)
		public static const unicode_1_1_utf_8:String="unicode-1-1-utf-8";
		public static const unicode_2_0_utf_8:String="unicode-2-0-utf-8";
		public static const utf_8:String="utf-8";
		public static const x_unicode_2_0_utf_8:String="x-unicode-2-0-utf-8";
		
		//Central European (Windows),中欧语 (Windows)
		public static const windows_1250:String="windows-1250";
		public static const x_cp1250:String="x-cp1250";
		
		//Cyrillic (Windows),西里尔语 (Windows)
		public static const windows_1251:String="windows-1251";
		public static const x_cp1251:String="x-cp1251";
		
		//Greek (Windows),希腊语 (Windows)
		public static const windows_1253:String="windows-1253";
		
		//Arabic (Windows),阿拉伯语 (Windows)
		public static const cp1256:String="cp1256";
		public static const windows_1256:String="windows-1256";
		
		//Baltic (Windows),波罗的语 (Windows)
		public static const windows_1257:String="windows-1257";
		
		//Vietnamese (Windows),越南语 (Windows)
		public static const windows_1258:String="windows-1258";
		
		//Thai (Windows),泰语 (Windows)
		public static const DOS_874:String="DOS-874";
		public static const TIS_620:String="TIS-620";
		public static const iso_8859_11:String="iso-8859-11";
		public static const windows_874:String="windows-874";
		
		//Chinese Traditional (CNS),繁体中文 (CNS)
		public static const x_Chinese_CNS:String="x-Chinese-CNS";
		
		//Chinese Traditional (Eten),繁体中文 (Eten)
		public static const x_Chinese_Eten:String="x-Chinese-Eten";
		
		//IBM EBCDIC (Arabic),IBM EBCDIC (阿拉伯语)
		public static const x_EBCDIC_Arabic:String="x-EBCDIC-Arabic";
		
		//IBM EBCDIC (Cyrillic Russian),IBM EBCDIC (西里尔文俄语)
		public static const x_EBCDIC_CyrillicRussian:String="x-EBCDIC-CyrillicRussian";
		
		//IBM EBCDIC (Cyrillic Serbian-Bulgarian),IBM EBCDIC (西里尔文塞尔维亚语-保加利亚语)
		public static const x_EBCDIC_CyrillicSerbianBulgarian:String="x-EBCDIC-CyrillicSerbianBulgarian";
		
		//IBM EBCDIC (Denmark-Norway),IBM EBCDIC (丹麦-挪威)
		public static const x_EBCDIC_DenmarkNorway:String="x-EBCDIC-DenmarkNorway";
		
		//IBM EBCDIC (Finland-Sweden),IBM EBCDIC (芬兰-瑞典)
		public static const x_EBCDIC_FinlandSweden:String="x-EBCDIC-FinlandSweden";
		
		//IBM EBCDIC (Germany),IBM EBCDIC (德国)
		public static const x_EBCDIC_Germany:String="x-EBCDIC-Germany";
		
		//IBM EBCDIC (Greek),IBM EBCDIC (希腊语)
		public static const x_EBCDIC_Greek:String="x-EBCDIC-Greek";
		
		//IBM EBCDIC (Greek Modern),IBM EBCDIC (现代希腊语)
		public static const x_EBCDIC_GreekModern:String="x-EBCDIC-GreekModern";
		
		//IBM EBCDIC (Hebrew),IBM EBCDIC (希伯来语)
		public static const x_EBCDIC_Hebrew:String="x-EBCDIC-Hebrew";
		
		//IBM EBCDIC (Icelandic),IBM EBCDIC (冰岛语)
		public static const x_EBCDIC_Icelandic:String="x-EBCDIC-Icelandic";
		
		//IBM EBCDIC (Italy),IBM EBCDIC (意大利语)
		public static const x_EBCDIC_Italy:String="x-EBCDIC-Italy";
		
		//IBM EBCDIC (Japanese and Japanese-Latin),IBM EBCDIC (日语和日语-拉丁语)
		public static const x_EBCDIC_JapaneseAndJapaneseLatin:String="x-EBCDIC-JapaneseAndJapaneseLatin";
		
		//IBM EBCDIC (Japanese and Japanese Katakana),IBM EBCDIC (日语和日语片假名)
		public static const x_EBCDIC_JapaneseAndKana:String="x-EBCDIC-JapaneseAndKana";
		
		//IBM EBCDIC (Japanese and US-Canada),IBM EBCDIC (日语和美国-加拿大)
		public static const x_EBCDIC_JapaneseAndUSCanada:String="x-EBCDIC-JapaneseAndUSCanada";
		
		//IBM EBCDIC (Japanese katakana),IBM EBCDIC (日语片假名)
		public static const x_EBCDIC_JapaneseKatakana:String="x-EBCDIC-JapaneseKatakana";
		
		//IBM EBCDIC (Korean and Korean Extended),IBM EBCDIC (朝鲜语和朝鲜语扩展)
		public static const x_EBCDIC_KoreanAndKoreanExtended:String="x-EBCDIC-KoreanAndKoreanExtended";
		
		//IBM EBCDIC (Korean Extended),IBM EBCDIC (朝鲜语扩展)
		public static const x_EBCDIC_KoreanExtended:String="x-EBCDIC-KoreanExtended";
		
		//IBM EBCDIC (Simplified Chinese),IBM EBCDIC (简体中文)
		public static const x_EBCDIC_SimplifiedChinese:String="x-EBCDIC-SimplifiedChinese";
		
		//IBM EBCDIC (Thai),IBM EBCDIC (泰语)
		public static const x_EBCDIC_Thai:String="x-EBCDIC-Thai";
		
		//IBM EBCDIC (Traditional Chinese),IBM EBCDIC (繁体中文)
		public static const x_EBCDIC_TraditionalChinese:String="x-EBCDIC-TraditionalChinese";
		
		//IBM EBCDIC (Turkish),IBM EBCDIC (土耳其语)
		public static const x_EBCDIC_Turkish:String="x-EBCDIC-Turkish";
		
		//IBM EBCDIC (UK),IBM EBCDIC (英国)
		public static const x_EBCDIC_UK:String="x-EBCDIC-UK";
		
		//Europa,欧罗巴语
		public static const x_Europa:String="x-Europa";
		
		//Western European (IA5),西欧语 (IA5)
		public static const x_IA5:String="x-IA5";
		
		//German (IA5),德语 (IA5)
		public static const x_IA5_German:String="x-IA5-German";
		
		//Norwegian (IA5),挪威语 (IA5)
		public static const x_IA5_Norwegian:String="x-IA5-Norwegian";
		
		//Swedish (IA5),瑞典语 (IA5)
		public static const x_IA5_Swedish:String="x-IA5-Swedish";
		
		//IBM EBCDIC (US-Canada-Euro),IBM EBCDIC (美国-加拿大-欧洲)
		public static const x_ebcdic_cp_us_euro:String="x-ebcdic-cp-us-euro";
		
		//IBM EBCDIC (Denmark-Norway-Euro),IBM EBCDIC (丹麦-挪威-欧洲)
		public static const x_ebcdic_denmarknorway_euro:String="x-ebcdic-denmarknorway-euro";
		
		//IBM EBCDIC (Finland-Sweden-Euro)
		public static const X_EBCDIC_France:String="X-EBCDIC-France";
		public static const x_ebcdic_finlandsweden_euro:String="x-ebcdic-finlandsweden-euro";
		
		//IBM EBCDIC (France-Euro),IBM EBCDIC (法国-欧洲)
		public static const x_ebcdic_france_euro:String="x-ebcdic-france-euro";
		
		//IBM EBCDIC (Germany-Euro),IBM EBCDIC (德国-欧洲)
		public static const x_ebcdic_germany_euro:String="x-ebcdic-germany-euro";
		
		//IBM EBCDIC (Icelandic-Euro),IBM EBCDIC (冰岛语-欧洲)
		public static const x_ebcdic_icelandic_euro:String="x-ebcdic-icelandic-euro";
		
		//IBM EBCDIC (International-Euro),IBM EBCDIC (国际-欧洲)
		public static const x_ebcdic_international_euro:String="x-ebcdic-international-euro";
		
		//IBM EBCDIC (Italy-Euro),IBM EBCDIC (意大利-欧洲)
		public static const x_ebcdic_italy_euro:String="x-ebcdic-italy-euro";
		
		//IBM EBCDIC (Spain-Euro),IBM EBCDIC (西班牙语-欧洲)
		public static const x_ebcdic_spain_euro:String="x-ebcdic-spain-euro";
		
		//IBM EBCDIC (UK-Euro),IBM EBCDIC (英国-欧洲)
		public static const x_ebcdic_uk_euro:String="x-ebcdic-uk-euro";
		
		//ISCII Assamese,ISCII 阿萨姆语
		public static const x_iscii_as:String="x-iscii-as";
		
		//ISCII Bengali,ISCII 孟加拉语
		public static const x_iscii_be:String="x-iscii-be";
		
		//ISCII Devanagari,ISCII 梵文
		public static const x_iscii_de:String="x-iscii-de";
		
		//ISCII Gujarathi,ISCII 古吉拉特语
		public static const x_iscii_gu:String="x-iscii-gu";
		
		//ISCII Kannada,ISCII 埃纳德语
		public static const x_iscii_ka:String="x-iscii-ka";
		
		//ISCII Malayalam,ISCII 马拉雅拉姆语
		public static const x_iscii_ma:String="x-iscii-ma";
		
		//ISCII Oriya,ISCII 奥里亚语
		public static const x_iscii_or:String="x-iscii-or";
		
		//ISCII Panjabi,ISCII 旁遮普文
		public static const x_iscii_pa:String="x-iscii-pa";
		
		//ISCII Tamil,ISCII 泰米尔语
		public static const x_iscii_ta:String="x-iscii-ta";
		
		//ISCII Telugu,ISCII 泰卢固语
		public static const x_iscii_te:String="x-iscii-te";
		
		//Arabic (Mac),阿拉伯语 (Mac)
		public static const x_mac_arabic:String="x-mac-arabic";
		
		//Central European (Mac),中欧语 (Mac)
		public static const x_mac_ce:String="x-mac-ce";
		
		//Chinese Simplified (Mac),简体中文 (Mac)
		public static const x_mac_chinesesimp:String="x-mac-chinesesimp";
		
		//Chinese Traditional (Mac),繁体中文 (Mac)
		public static const x_mac_chinesetrad:String="x-mac-chinesetrad";
		
		//Cyrillic (Mac),西里尔语 (Mac)
		public static const x_mac_cyrillic:String="x-mac-cyrillic";
		
		//Greek (Mac),希腊语 (Mac)
		public static const x_mac_greek:String="x-mac-greek";
		
		//Hebrew (Mac),希伯来语 (Mac)
		public static const x_mac_hebrew:String="x-mac-hebrew";
		
		//Icelandic (Mac),冰岛语 (Mac)
		public static const x_mac_icelandic:String="x-mac-icelandic";
		
		//Japanese (Mac),日语 (Mac)
		public static const x_mac_japanese:String="x-mac-japanese";
		
		//Korean (Mac),朝鲜语 (Mac)
		public static const x_mac_korean:String="x-mac-korean";
		
		//Turkish (Mac),土耳其语 (Mac)
		public static const x_mac_turkish:String="x-mac-turkish";
		
		public static const charsetV:Vector.<String>=new <String>[ASMO_708,CP1026,CP870,DOS_720,DOS_862,EUC_CN,IBM437,Johab,X_EBCDIC_Spain,big5,cp866,csISO2022JP,ebcdic_cp_us,euc_jp,gb18030,gb2312,hz_gb_2312,ibm737,ibm775,ibm850,ibm852,ibm857,ibm861,ibm869,iso_2022_jp,iso_2022_kr,iso_8859_2,iso_8859_3,iso_8859_4,iso_8859_5,iso_8859_6,iso_8859_7,iso_8859_8,iso_8859_8_i,koi8_r,koi8_u,ks_c_5601_1987,macintosh,shift_jis,unicode,unicodeFFFE,us_ascii,utf_7,utf_8,windows_1250,windows_1251,windows_1253,windows_1256,windows_1257,windows_1258,windows_874,x_Chinese_CNS,x_Chinese_Eten,x_EBCDIC_Arabic,x_EBCDIC_CyrillicRussian,x_EBCDIC_CyrillicSerbianBulgarian,x_EBCDIC_DenmarkNorway,x_EBCDIC_FinlandSweden,x_EBCDIC_Germany,x_EBCDIC_Greek,x_EBCDIC_GreekModern,x_EBCDIC_Hebrew,x_EBCDIC_Icelandic,x_EBCDIC_Italy,x_EBCDIC_JapaneseAndJapaneseLatin,x_EBCDIC_JapaneseAndKana,x_EBCDIC_JapaneseAndUSCanada,x_EBCDIC_JapaneseKatakana,x_EBCDIC_KoreanAndKoreanExtended,x_EBCDIC_KoreanExtended,x_EBCDIC_SimplifiedChinese,x_EBCDIC_Thai,x_EBCDIC_TraditionalChinese,x_EBCDIC_Turkish,x_EBCDIC_UK,x_Europa,x_IA5,x_IA5_German,x_IA5_Norwegian,x_IA5_Swedish,x_ebcdic_cp_us_euro,x_ebcdic_denmarknorway_euro,x_ebcdic_finlandsweden_euro,x_ebcdic_france_euro,x_ebcdic_germany_euro,x_ebcdic_icelandic_euro,x_ebcdic_international_euro,x_ebcdic_italy_euro,x_ebcdic_spain_euro,x_ebcdic_uk_euro,x_iscii_as,x_iscii_be,x_iscii_de,x_iscii_gu,x_iscii_ka,x_iscii_ma,x_iscii_or,x_iscii_pa,x_iscii_ta,x_iscii_te,x_mac_arabic,x_mac_ce,x_mac_chinesesimp,x_mac_chinesetrad,x_mac_cyrillic,x_mac_greek,x_mac_hebrew,x_mac_icelandic,x_mac_japanese,x_mac_korean,x_mac_turkish];
	}
}

