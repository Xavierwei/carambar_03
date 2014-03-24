/***
AVM1Ops
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:17（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm1{

	public class AVM1Ops{
		public static const end:int=0;//0x00
		public static const nop:int=1;//0x01
		//0x02
		//0x03
		public static const nextFrame:int=4;//0x04
		public static const previousFrame:int=5;//0x05
		public static const play:int=6;//0x06
		public static const stop:int=7;//0x07
		public static const toggleQuality:int=8;//0x08
		public static const stopSounds:int=9;//0x09
		public static const add:int=10;//0x0a
		public static const subtract:int=11;//0x0b
		public static const multiply:int=12;//0x0c
		public static const divide:int=13;//0x0d
		public static const equals:int=14;//0x0e
		public static const less:int=15;//0x0f
		public static const and:int=16;//0x10
		public static const or:int=17;//0x11
		public static const not:int=18;//0x12
		public static const stringEquals:int=19;//0x13
		public static const stringLength:int=20;//0x14
		public static const stringExtract:int=21;//0x15
		//0x16
		public static const pop:int=23;//0x17
		public static const toInteger:int=24;//0x18
		//0x19
		//0x1a
		//0x1b
		public static const getVariable:int=28;//0x1c
		public static const setVariable:int=29;//0x1d
		//0x1e
		//0x1f
		public static const setTarget2:int=32;//0x20
		public static const stringAdd:int=33;//0x21
		public static const getProperty:int=34;//0x22
		public static const setProperty:int=35;//0x23
		public static const cloneSprite:int=36;//0x24
		public static const removeSprite:int=37;//0x25
		public static const trace:int=38;//0x26
		public static const startDrag:int=39;//0x27
		public static const endDrag:int=40;//0x28
		public static const stringLess:int=41;//0x29
		public static const throw_:int=42;//0x2a
		public static const castOp:int=43;//0x2b
		public static const implementsOp:int=44;//0x2c
		public static const FSCommand2:int=45;//0x2d //asv2010
		//0x2e
		//0x2f
		public static const randomNumber:int=48;//0x30
		public static const mbStringLength:int=49;//0x31
		public static const charToAscii:int=50;//0x32
		public static const asciiToChar:int=51;//0x33
		public static const getTime:int=52;//0x34
		public static const mbStringExtract:int=53;//0x35
		public static const mbCharToAscii:int=54;//0x36
		public static const mbAsciiToChar:int=55;//0x37
		//0x38
		//0x39
		public static const delete_:int=58;//0x3a
		public static const delete2:int=59;//0x3b
		public static const defineLocal:int=60;//0x3c
		public static const callFunction:int=61;//0x3d
		public static const return_:int=62;//0x3e
		public static const modulo:int=63;//0x3f
		public static const newObject:int=64;//0x40
		public static const defineLocal2:int=65;//0x41
		public static const initArray:int=66;//0x42
		public static const initObject:int=67;//0x43
		public static const typeOf:int=68;//0x44
		public static const targetPath:int=69;//0x45
		public static const enumerate:int=70;//0x46
		public static const add2:int=71;//0x47
		public static const less2:int=72;//0x48
		public static const equals2:int=73;//0x49
		public static const toNumber:int=74;//0x4a
		public static const toString:int=75;//0x4b
		public static const pushDuplicate:int=76;//0x4c
		public static const stackSwap:int=77;//0x4d
		public static const getMember:int=78;//0x4e
		public static const setMember:int=79;//0x4f
		public static const increment:int=80;//0x50
		public static const decrement:int=81;//0x51
		public static const callMethod:int=82;//0x52
		public static const newMethod:int=83;//0x53
		public static const instanceOf:int=84;//0x54
		public static const enumerate2:int=85;//0x55
		//0x56
		//0x57
		//0x58
		//0x59
		//0x5a
		//0x5b
		//0x5c
		//0x5d
		//0x5e
		//0x5f
		public static const bitAnd:int=96;//0x60
		public static const bitOr:int=97;//0x61
		public static const bitXor:int=98;//0x62
		public static const bitLShift:int=99;//0x63
		public static const bitRShift:int=100;//0x64
		public static const bitURShift:int=101;//0x65
		public static const strictEquals:int=102;//0x66
		public static const greater:int=103;//0x67
		public static const stringGreater:int=104;//0x68
		public static const extends_:int=105;//0x69
		//0x6a
		//0x6b
		//0x6c
		//0x6d
		//0x6e
		//0x6f
		//0x70
		//0x71
		//0x72
		//0x73
		//0x74
		//0x75
		//0x76
		//0x77
		//0x78
		//0x79
		//0x7a
		//0x7b
		//0x7c
		//0x7d
		//0x7e
		//0x7f
		//0x80
		public static const gotoFrame:int=129;//0x81
		//0x82
		public static const getURL:int=131;//0x83
		//0x84
		//0x85
		//0x86
		public static const storeRegister:int=135;//0x87
		public static const constantPool:int=136;//0x88
		//0x89
		public static const waitForFrame:int=138;//0x8a
		public static const setTarget:int=139;//0x8b
		public static const gotoLabel:int=140;//0x8c
		public static const waitForFrame2:int=141;//0x8d
		public static const defineFunction2:int=142;//0x8e
		public static const try_:int=143;//0x8f
		//0x90
		//0x91
		//0x92
		//0x93
		public static const with_:int=148;//0x94
		//0x95
		public static const push:int=150;//0x96
		//0x97
		//0x98
		public static const jump:int=153;//0x99
		public static const getURL2:int=154;//0x9a
		public static const defineFunction:int=155;//0x9b
		//0x9c
		public static const if_:int=157;//0x9d
		public static const call:int=158;//0x9e
		public static const gotoFrame2:int=159;//0x9f
		//0xa0
		//0xa1
		//0xa2
		//0xa3
		//0xa4
		//0xa5
		//0xa6
		//0xa7
		//0xa8
		//0xa9
		//0xaa
		//0xab
		//0xac
		//0xad
		//0xae
		//0xaf
		//0xb0
		//0xb1
		//0xb2
		//0xb3
		//0xb4
		//0xb5
		//0xb6
		//0xb7
		//0xb8
		//0xb9
		//0xba
		//0xbb
		//0xbc
		//0xbd
		//0xbe
		//0xbf
		//0xc0
		//0xc1
		//0xc2
		//0xc3
		//0xc4
		//0xc5
		//0xc6
		//0xc7
		//0xc8
		//0xc9
		//0xca
		//0xcb
		//0xcc
		//0xcd
		//0xce
		//0xcf
		//0xd0
		//0xd1
		//0xd2
		//0xd3
		//0xd4
		//0xd5
		//0xd6
		//0xd7
		//0xd8
		//0xd9
		//0xda
		//0xdb
		//0xdc
		//0xdd
		//0xde
		//0xdf
		//0xe0
		//0xe1
		//0xe2
		//0xe3
		//0xe4
		//0xe5
		//0xe6
		//0xe7
		//0xe8
		//0xe9
		//0xea
		//0xeb
		//0xec
		//0xed
		//0xee
		//0xef
		//0xf0
		//0xf1
		//0xf2
		//0xf3
		//0xf4
		//0xf5
		//0xf6
		//0xf7
		//0xf8
		//0xf9
		//0xfa
		//0xfb
		//0xfc
		//0xfd
		//0xfe
		//0xff
		
		public static const nameV:Vector.<String>=new <String>[
			"end",//0x00
			"nop",//0x01
			null,//0x02
			null,//0x03
			"nextFrame",//0x04
			"previousFrame",//0x05
			"play",//0x06
			"stop",//0x07
			"toggleQuality",//0x08
			"stopSounds",//0x09
			"add",//0x0a
			"subtract",//0x0b
			"multiply",//0x0c
			"divide",//0x0d
			"equals",//0x0e
			"less",//0x0f
			"and",//0x10
			"or",//0x11
			"not",//0x12
			"stringEquals",//0x13
			"stringLength",//0x14
			"stringExtract",//0x15
			null,//0x16
			"pop",//0x17
			"toInteger",//0x18
			null,//0x19
			null,//0x1a
			null,//0x1b
			"getVariable",//0x1c
			"setVariable",//0x1d
			null,//0x1e
			null,//0x1f
			"setTarget2",//0x20
			"stringAdd",//0x21
			"getProperty",//0x22
			"setProperty",//0x23
			"cloneSprite",//0x24
			"removeSprite",//0x25
			"trace",//0x26
			"startDrag",//0x27
			"endDrag",//0x28
			"stringLess",//0x29
			"throw_",//0x2a
			"castOp",//0x2b
			"implementsOp",//0x2c
			"FSCommand2",//0x2d //asv2010
			null,//0x2e
			null,//0x2f
			"randomNumber",//0x30
			"mbStringLength",//0x31
			"charToAscii",//0x32
			"asciiToChar",//0x33
			"getTime",//0x34
			"mbStringExtract",//0x35
			"mbCharToAscii",//0x36
			"mbAsciiToChar",//0x37
			null,//0x38
			null,//0x39
			"delete_",//0x3a
			"delete2",//0x3b
			"defineLocal",//0x3c
			"callFunction",//0x3d
			"return_",//0x3e
			"modulo",//0x3f
			"newObject",//0x40
			"defineLocal2",//0x41
			"initArray",//0x42
			"initObject",//0x43
			"typeOf",//0x44
			"targetPath",//0x45
			"enumerate",//0x46
			"add2",//0x47
			"less2",//0x48
			"equals2",//0x49
			"toNumber",//0x4a
			"toString",//0x4b
			"pushDuplicate",//0x4c
			"stackSwap",//0x4d
			"getMember",//0x4e
			"setMember",//0x4f
			"increment",//0x50
			"decrement",//0x51
			"callMethod",//0x52
			"newMethod",//0x53
			"instanceOf",//0x54
			"enumerate2",//0x55
			null,//0x56
			null,//0x57
			null,//0x58
			null,//0x59
			null,//0x5a
			null,//0x5b
			null,//0x5c
			null,//0x5d
			null,//0x5e
			null,//0x5f
			"bitAnd",//0x60
			"bitOr",//0x61
			"bitXor",//0x62
			"bitLShift",//0x63
			"bitRShift",//0x64
			"bitURShift",//0x65
			"strictEquals",//0x66
			"greater",//0x67
			"stringGreater",//0x68
			"extends_",//0x69
			null,//0x6a
			null,//0x6b
			null,//0x6c
			null,//0x6d
			null,//0x6e
			null,//0x6f
			null,//0x70
			null,//0x71
			null,//0x72
			null,//0x73
			null,//0x74
			null,//0x75
			null,//0x76
			null,//0x77
			null,//0x78
			null,//0x79
			null,//0x7a
			null,//0x7b
			null,//0x7c
			null,//0x7d
			null,//0x7e
			null,//0x7f
			null,//0x80
			"gotoFrame",//0x81
			null,//0x82
			"getURL",//0x83
			null,//0x84
			null,//0x85
			null,//0x86
			"storeRegister",//0x87
			"constantPool",//0x88
			null,//0x89
			"waitForFrame",//0x8a
			"setTarget",//0x8b
			"gotoLabel",//0x8c
			"waitForFrame2",//0x8d
			"defineFunction2",//0x8e
			"try_",//0x8f
			null,//0x90
			null,//0x91
			null,//0x92
			null,//0x93
			"with_",//0x94
			null,//0x95
			"push",//0x96
			null,//0x97
			null,//0x98
			"jump",//0x99
			"getURL2",//0x9a
			"defineFunction",//0x9b
			null,//0x9c
			"if_",//0x9d
			"call",//0x9e
			"gotoFrame2",//0x9f
			null,//0xa0
			null,//0xa1
			null,//0xa2
			null,//0xa3
			null,//0xa4
			null,//0xa5
			null,//0xa6
			null,//0xa7
			null,//0xa8
			null,//0xa9
			null,//0xaa
			null,//0xab
			null,//0xac
			null,//0xad
			null,//0xae
			null,//0xaf
			null,//0xb0
			null,//0xb1
			null,//0xb2
			null,//0xb3
			null,//0xb4
			null,//0xb5
			null,//0xb6
			null,//0xb7
			null,//0xb8
			null,//0xb9
			null,//0xba
			null,//0xbb
			null,//0xbc
			null,//0xbd
			null,//0xbe
			null,//0xbf
			null,//0xc0
			null,//0xc1
			null,//0xc2
			null,//0xc3
			null,//0xc4
			null,//0xc5
			null,//0xc6
			null,//0xc7
			null,//0xc8
			null,//0xc9
			null,//0xca
			null,//0xcb
			null,//0xcc
			null,//0xcd
			null,//0xce
			null,//0xcf
			null,//0xd0
			null,//0xd1
			null,//0xd2
			null,//0xd3
			null,//0xd4
			null,//0xd5
			null,//0xd6
			null,//0xd7
			null,//0xd8
			null,//0xd9
			null,//0xda
			null,//0xdb
			null,//0xdc
			null,//0xdd
			null,//0xde
			null,//0xdf
			null,//0xe0
			null,//0xe1
			null,//0xe2
			null,//0xe3
			null,//0xe4
			null,//0xe5
			null,//0xe6
			null,//0xe7
			null,//0xe8
			null,//0xe9
			null,//0xea
			null,//0xeb
			null,//0xec
			null,//0xed
			null,//0xee
			null,//0xef
			null,//0xf0
			null,//0xf1
			null,//0xf2
			null,//0xf3
			null,//0xf4
			null,//0xf5
			null,//0xf6
			null,//0xf7
			null,//0xf8
			null,//0xf9
			null,//0xfa
			null,//0xfb
			null,//0xfc
			null,//0xfd
			null,//0xfe
			null//0xff
		];
		nameV.fixed=true;
		
	}
}