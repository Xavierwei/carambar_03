package com.makeit.utils 
{
	
	public class checkInfo
	{
		
		/**
		* 检查身份证号码
		*/
		public static function checkIdcard(idcard):Boolean{
			var ereg:RegExp;
			var Errors:Array=new Array(
								true,//"验证通过!",
								false,//"身份证号码位数不对!",
								false,//"身份证号码出生日期超出范围或含有非法字符!",
								false,//"身份证号码校验错误!",
								false//"身份证地区非法!"
								);
			var area:Object = { 11:"北京", 12:"天津", 13:"河北", 14:"山西", 15:"内蒙古", 21:"辽宁", 22:"吉林", 23:"黑龙江", 31:"上海", 32:"江苏",
						 33:"浙江", 34:"安徽", 35:"福建", 36:"江西", 37:"山东", 41:"河南", 42:"湖北", 43:"湖南", 44:"广东", 45:"广西", 46:"海南",
						 50:"重庆", 51:"四川", 52:"贵州", 53:"云南", 54:"西藏", 61:"陕西", 62:"甘肃", 63:"青海", 64:"宁夏", 65:"新疆", 71:"台湾",
						 81:"香港", 82:"澳门",91:"国外"};

			var idcard,Y,JYM;
			var S,M;
			var idcard_array:Array = new Array();
			idcard_array = idcard.split("");
			//地区检验
			if(area[parseInt(idcard.substr(0,2))]==null) return Errors[4];
			//身份号码位数及格式检验
			switch(idcard.length){
				case 15:
					if ( (parseInt(idcard.substr(6,2))+1900) % 4 == 0 || ((parseInt(idcard.substr(6,2))+1900) % 100 == 0 && (parseInt(idcard.substr(6,2))+1900) % 4 == 0 )){
						ereg=/^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$/;//测试出生日期的合法性
					} else {
						ereg=/^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/;//测试出生日期的合法性
					}
					if (ereg.test(idcard)) {
						return Errors[0];
					}else {
						return Errors[2];
					}
					break;
				case 18:
				//18位身份号码检测
				//出生日期的合法性检查
				//闰年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))
				//平年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))
				if ( parseInt(idcard.substr(6,4)) % 4 == 0 || (parseInt(idcard.substr(6,4)) % 100 == 0 && parseInt(idcard.substr(6,4))%4 == 0 )){
					ereg=/^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/;//闰年出生日期的合法性正则表达式
				} else {
					ereg=/^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/;//平年出生日期的合法性正则表达式
				}
				if(ereg.test(idcard)){//测试出生日期的合法性
					//计算校验位
					S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7
					+ (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9
					+ (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10
					+ (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5
					+ (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8
					+ (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4
					+ (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2
					+ parseInt(idcard_array[7]) * 1
					+ parseInt(idcard_array[8]) * 6
					+ parseInt(idcard_array[9]) * 3 ;
					Y = S % 11;
					M = "F";
					JYM = "10X98765432";
					M = JYM.substr(Y,1);//判断校验位
					if (M == idcard_array[17]) {
						return Errors[0]; //检测ID的校验位
					}else {
						return Errors[3];
					}
				}else {
					return Errors[2];
				}
				break;
			default:
				return Errors[1];
				break;
			}

		}
		/**
		 * 检查手机号码
		 */
		public static function checkMobile(mobile:String):Boolean {
			var reg:RegExp = /^(13|15|18)\d{9}$/;
			if (reg.test(mobile)) {
				return true;
			}
			return false;
		}
		/**
		 * public检查email
		 */
		public static function checkEmail(str:String):Boolean {
			var reg:RegExp = /^[a-z0-9][_.a-z0-9]*@([a-z0-9][_.a-z0-9]*\.)+[a-z]{2,6}$/i;
			if (reg.test(str)) {
				return true;
			}
			return false;
		}
		public static function checkSampleEmail(str:String):Boolean {
			if(str.indexOf(".")!=-1&&str.indexOf("@")!=-1&&str.split("@").length==2){
				return true;
			}
			return false;
		}
		/**
		 * 检查邮政编码
		 */
		public static function checkZip(str:String):Boolean {
			var reg:RegExp = /^[1-9][0-9]{5}$/;
			if (reg.test(str)) {
				return true;
			}
			return false;
		}
		public static function checkDate(str:String):Boolean{
			// 2004-2-29
			var reg:RegExp=/^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s(((0?[1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$/;
			if (reg.test(str)) {
				return true;
			}
			return false;
		
		}
	}

}
/**
 * ActionScript 常用正则表达式
Posted by GgNET on 星期三, 十月20, 2010 0 comments
对于正则表达式，现在使用的越来越多。感觉它在验证方面和搜索方面确实方便。所以平时对于一些常用的验证表达式记录了下来。以下是ActionScript中常用的表达式。汇总如下：
1.匹配正整数：
/^[1-9]\d*$/
2.匹配负整数：
/^-[1-9]\d*$/
3.匹配浮点数：
/^-?(([1-9]\d|0))\.\d*$/
4.匹配二进制数字:
/^([0|1]{4}\s)*([0|1]{4})$/
5.匹配八进制数字:
/^0[1-7][0-7]*$]
6.匹配十六进制数字：
/^0x[0-9][A-F]*$/
7.匹配中国人姓名：通常由2到4个汉字组成。使用Unicode编码
/^[\u4e00-\u9fa5][2,4]$/
8.匹配QQ号：
/^[1-9][0-9]{4,9}$/
9.匹配日期：
中国习惯日期：
/^[19|20]\d{2}年(0[1-9]|(1(0|1|2)))月(0[1-9]|((1|2)\d))|(3(0|1)))日$/
西方习惯日期：
/^(0[1-9]|(1(0|1|2)))\/(0[1-9]|((1|2)\d)|(3(0|1)))\/(19|20)\d{2}$/
10.匹配身份证：
/(^\d{15}$)|(^\d{17}([0-9]|x)$)/i
11.匹配邮政编码：
/^[1-9][0-9]{5}$/
12.匹配电话号码：
/^\d{3,4}\-\d{7,8}$/
13.匹配手机号码：
/^(13|15|18)\d{9}$/
14.匹配电子邮箱：
/^[a-z0-9][_.a-z0-9]*@([a-z0-9][_.a-z0-9]*\.)+[a-z]{2,6}$/i
15.匹配货币：
/^\d{0,3}(,\d{3}){0,}\.\d{2}$/
16.匹配IPv4地址：
/^((\d{1,2}|1\d{2}|2[0-4]\d{1}|25[0-5])\.){3}(\d{1,2}|1\d{2}|2[0-4]\d{1}|25[0-5])$/
16.匹配颜色：
/^\#(([0-9|A-F]){6})|(([0-9|A-F]){8})$/i
 * 
 */