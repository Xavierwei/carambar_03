/***
ComplexStringTests
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月23日 20:37:48
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class ComplexStringTests extends BaseTests{
		public function ComplexStringTests(){
			var str:String;
			
			str="\b\t\n\v\f\r";
			check(str,"	\n\r");
			str=ComplexString.normal.escape(str);
			check(str,"\\b\\t\\n\\v\\f\\r");
			str=ComplexString.normal.escape(str);
			check(str,"\\\\b\\\\t\\\\n\\\\v\\\\f\\\\r");
			str=ComplexString.normal.unescape(str);
			check(str,"\\b\\t\\n\\v\\f\\r");
			str=ComplexString.normal.unescape(str);
			check(str,"	\n\r");

			str="";
			for(var i:int=0;i<256;i++){
				str+=String.fromCharCode(i);
			}
			check(str,"\x00"+"	\n\r !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ");
			str=ComplexString.ext.escape(str);
			check(str,"\\x00\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\b\\t\\n\\v\\f\\r\\x0e\\x0f\\x10\\x11\\x12\\x13\\x14\\x15\\x16\\x17\\x18\\x19\\x1a\\x1b\\x1c\\x1d\\x1e\\x1f !\\\"#$%&\\'\\(\\)*+\\,-./0123456789\\:;\\<\\=\\>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ\\[\\\\\\]^_`abcdefghijklmnopqrstuvwxyz\\{|\\}~\\x7f\\x80\\x81\\x82\\x83\\x84\\x85\\x86\\x87\\x88\\x89\\x8a\\x8b\\x8c\\x8d\\x8e\\x8f\\x90\\x91\\x92\\x93\\x94\\x95\\x96\\x97\\x98\\x99\\x9a\\x9b\\x9c\\x9d\\x9e\\x9f\\xa0\\xa1\\xa2\\xa3\\xa4\\xa5\\xa6\\xa7\\xa8\\xa9\\xaa\\xab\\xac\\xad\\xae\\xaf\\xb0\\xb1\\xb2\\xb3\\xb4\\xb5\\xb6\\xb7\\xb8\\xb9\\xba\\xbb\\xbc\\xbd\\xbe\\xbf\\xc0\\xc1\\xc2\\xc3\\xc4\\xc5\\xc6\\xc7\\xc8\\xc9\\xca\\xcb\\xcc\\xcd\\xce\\xcf\\xd0\\xd1\\xd2\\xd3\\xd4\\xd5\\xd6\\xd7\\xd8\\xd9\\xda\\xdb\\xdc\\xdd\\xde\\xdf\\xe0\\xe1\\xe2\\xe3\\xe4\\xe5\\xe6\\xe7\\xe8\\xe9\\xea\\xeb\\xec\\xed\\xee\\xef\\xf0\\xf1\\xf2\\xf3\\xf4\\xf5\\xf6\\xf7\\xf8\\xf9\\xfa\\xfb\\xfc\\xfd\\xfe\\xff");
			str=ComplexString.ext.escape(str);
			check(str,"\\\\x00\\\\x01\\\\x02\\\\x03\\\\x04\\\\x05\\\\x06\\\\x07\\\\b\\\\t\\\\n\\\\v\\\\f\\\\r\\\\x0e\\\\x0f\\\\x10\\\\x11\\\\x12\\\\x13\\\\x14\\\\x15\\\\x16\\\\x17\\\\x18\\\\x19\\\\x1a\\\\x1b\\\\x1c\\\\x1d\\\\x1e\\\\x1f !\\\\\\\"#$%&\\\\\\'\\\\\\(\\\\\\)*+\\\\\\,-./0123456789\\\\\\:;\\\\\\<\\\\\\=\\\\\\>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\\\\[\\\\\\\\\\\\\\]^_`abcdefghijklmnopqrstuvwxyz\\\\\\{|\\\\\\}~\\\\x7f\\\\x80\\\\x81\\\\x82\\\\x83\\\\x84\\\\x85\\\\x86\\\\x87\\\\x88\\\\x89\\\\x8a\\\\x8b\\\\x8c\\\\x8d\\\\x8e\\\\x8f\\\\x90\\\\x91\\\\x92\\\\x93\\\\x94\\\\x95\\\\x96\\\\x97\\\\x98\\\\x99\\\\x9a\\\\x9b\\\\x9c\\\\x9d\\\\x9e\\\\x9f\\\\xa0\\\\xa1\\\\xa2\\\\xa3\\\\xa4\\\\xa5\\\\xa6\\\\xa7\\\\xa8\\\\xa9\\\\xaa\\\\xab\\\\xac\\\\xad\\\\xae\\\\xaf\\\\xb0\\\\xb1\\\\xb2\\\\xb3\\\\xb4\\\\xb5\\\\xb6\\\\xb7\\\\xb8\\\\xb9\\\\xba\\\\xbb\\\\xbc\\\\xbd\\\\xbe\\\\xbf\\\\xc0\\\\xc1\\\\xc2\\\\xc3\\\\xc4\\\\xc5\\\\xc6\\\\xc7\\\\xc8\\\\xc9\\\\xca\\\\xcb\\\\xcc\\\\xcd\\\\xce\\\\xcf\\\\xd0\\\\xd1\\\\xd2\\\\xd3\\\\xd4\\\\xd5\\\\xd6\\\\xd7\\\\xd8\\\\xd9\\\\xda\\\\xdb\\\\xdc\\\\xdd\\\\xde\\\\xdf\\\\xe0\\\\xe1\\\\xe2\\\\xe3\\\\xe4\\\\xe5\\\\xe6\\\\xe7\\\\xe8\\\\xe9\\\\xea\\\\xeb\\\\xec\\\\xed\\\\xee\\\\xef\\\\xf0\\\\xf1\\\\xf2\\\\xf3\\\\xf4\\\\xf5\\\\xf6\\\\xf7\\\\xf8\\\\xf9\\\\xfa\\\\xfb\\\\xfc\\\\xfd\\\\xfe\\\\xff");
			str=ComplexString.ext.unescape(str);
			check(str,"\\x00\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\b\\t\\n\\v\\f\\r\\x0e\\x0f\\x10\\x11\\x12\\x13\\x14\\x15\\x16\\x17\\x18\\x19\\x1a\\x1b\\x1c\\x1d\\x1e\\x1f !\\\"#$%&\\'\\(\\)*+\\,-./0123456789\\:;\\<\\=\\>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ\\[\\\\\\]^_`abcdefghijklmnopqrstuvwxyz\\{|\\}~\\x7f\\x80\\x81\\x82\\x83\\x84\\x85\\x86\\x87\\x88\\x89\\x8a\\x8b\\x8c\\x8d\\x8e\\x8f\\x90\\x91\\x92\\x93\\x94\\x95\\x96\\x97\\x98\\x99\\x9a\\x9b\\x9c\\x9d\\x9e\\x9f\\xa0\\xa1\\xa2\\xa3\\xa4\\xa5\\xa6\\xa7\\xa8\\xa9\\xaa\\xab\\xac\\xad\\xae\\xaf\\xb0\\xb1\\xb2\\xb3\\xb4\\xb5\\xb6\\xb7\\xb8\\xb9\\xba\\xbb\\xbc\\xbd\\xbe\\xbf\\xc0\\xc1\\xc2\\xc3\\xc4\\xc5\\xc6\\xc7\\xc8\\xc9\\xca\\xcb\\xcc\\xcd\\xce\\xcf\\xd0\\xd1\\xd2\\xd3\\xd4\\xd5\\xd6\\xd7\\xd8\\xd9\\xda\\xdb\\xdc\\xdd\\xde\\xdf\\xe0\\xe1\\xe2\\xe3\\xe4\\xe5\\xe6\\xe7\\xe8\\xe9\\xea\\xeb\\xec\\xed\\xee\\xef\\xf0\\xf1\\xf2\\xf3\\xf4\\xf5\\xf6\\xf7\\xf8\\xf9\\xfa\\xfb\\xfc\\xfd\\xfe\\xff");
			str=ComplexString.ext.unescape(str);
			check(str,"\x00"+"	\n\r !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ");
			

			str="\\\\x5b";
			str=ComplexString.normal.unescape(str);
			check(str,"\\x5b");
			
			str="\\x5b";
			str=ComplexString.normal.unescape(str);
			check(str,"[");
			
			str="\\x5";
			str=ComplexString.normal.unescape(str);
			check(str,"x5");
			
			str="\\x";
			str=ComplexString.normal.unescape(str);
			check(str,"x");
			
			str="\\";
			str=ComplexString.normal.unescape(str);
			check(str,"\\");
			
			str="\\xooo";
			str=ComplexString.normal.unescape(str);
			check(str,"xooo");
			
		}
	}
}
		