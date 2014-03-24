/***
DOSTime
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月20日 13:20:15
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.codec{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class DOSTime{
		public static function decode(dosDateTime:int):Date{
			return new Date(
				1980+(dosDateTime>>>25),
				((dosDateTime>>21)&0x0f)-1,
				(dosDateTime>>16)&0x1f,
				(dosDateTime>>11)&0x1f,
				(dosDateTime>>5)&0x3f,
				(dosDateTime&0x1f)<<1
			);
		}
		public static function encode(date:Date):int{
			return ((date.fullYear-1980)<<25)
			|
			((date.month+1)<<21)
			|
			(date.date<<16)
			|
			(date.hours<<11)
			|
			(date.minutes<<5)
			|
			int(date.seconds/2);
		}
	}
}

//http://proger.i-forge.net/MS-DOS_date_and_time_format/OFz

//MS-DOS date and time format
//...describing the format of MS-DOS date and time (16-bit unsigned integers) with bit masks and PHP code to parse them and convert to an Unix timestamp.
//You'd probably ask: «Where is MS-DOS time and date used nowadays?». Well, one of the places I'm aware of are ZIP archives. Yeah, those are pretty old! PKZIP standard dates back to early '90s.
//Both MS-DOS date and time are 16-bit unsigned integers (2 bytes) which contain date or time components in different bits of a Word. Their format is (taken from DosDateTimeToFileTime() Windows function):
//date:   YYYYYYYM MMMDDDDD
//time:   HHHHHMMM MMMSSSSS
//A few notes:
//day of month is always within 1-31 range;
//month is always within 1-12 range;
//year starts from 1980 and continues for 127 years (which allows DOS date to hold twice as many years as the Unix epoch lasts – interesting fact :));
//seconds are actually not 0-59 but rather 0-29 as there are only 32 possible values – to get actual seconds multiply this field by 2;
//minutes are always within 0-59 range;
//hours are always within 0-23 range.
//If you encounter a component that doesn't fall within the above ranges the value you're parsing is probably not a DOS time/date after all.
//A few examples:
//date: 16093 (0x3EDD), bits: 00111110 11011101, which stands for 29th June of 2011:
//	0011111 = 31 + 1980 = 2011 year
//	0110 = 6th month (June)
//	11101 = 29th day
//time: 23492 (0x5B24), bits: 01011011 11000100, which stands for 11:30:08 (AM):
//	01011 = 11 hours
//	011110 = 30 minutes
//	00100 = 4 * 2 = 8 seconds
//PHP functions
//Below are PHP functions that parse MS-DOS time and date. You can use them to convert DOS date/time to Unix timestamp as well.
//PHP
//// MS-DOS date/time parsing functions (in public domain) | http://proger.i-forge.net
//function ParseDosDate($int) {
//  $day = $int & 31;
//  $month = ($int & 480) >> 5;
//  $year = 1980 + (($int & 65024) >> 9);
//
//  if ($day >= 1 and $day <= 31 and $month >= 1 and $month <= 12 and $year <= 2040) {
//    return array($day, $month, $year);
//  }
//}
//function ParseDostIME($int) {
//  $sec = 2 * ($int & 31);
//  $min = ($int & 2016) >> 5;
//  $hour = ($int & 63488) >> 11;
//
//  if ($sec <= 60 and $min <= 59 and $hour <= 23) {
//    return array($hour, $min, $sec);
//  }
//}
//The above functions will return null for invalid values (as per rules described above). To convert their result to corresponding Unix timestamp mktime() can be used:
//PHP
//$date = ParseDosDate(16093);
//if ($date) { $timestamp = mktime(0, 0, 0, $date[1], $date[0], $date[2]); }
//// => 00:00:00 Jun 29 2011
//$time = ParseDosTime(23492);
//if ($time) { $timestamp = mktime($time[0], $time[1], $time[2]); }
//// => 11:30:08 Jun 29 2011