/***
product
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月08日 17:32:47
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.strs{
	import zero.swf.SWF;
	import zero.swf.avm1.ACTIONRECORDs;
	import zero.swf.avm1.AVM1Ops;
	import zero.swf.avm2.ABCFileWithSimpleConstant_pool;
	import zero.swf.utils.getABCFileWithSimpleConstant_pools;
	import zero.swf.utils.getActions;

	public function product(swf:SWF):Array{
		var arr:Array=new Array();
		
		//avm1 codes
		for each(var Actions:ACTIONRECORDs in getActions(swf,null)){
			for each(var code:Object in Actions.codeArr){
				if(code.op>-1){
					switch(code.op){
						case AVM1Ops.setTarget://0x8b	//STRING
							if(code.targetname){
								arr.push([code,"targetname",code.targetname]);
							}
						break;
						case AVM1Ops.gotoLabel://0x8c	//STRING
							if(code.labelname){
								arr.push([code,"labelname",code.labelname]);
							}
						break;
						case AVM1Ops.getURL://0x83	//STRING,STRING
							if(code.urlstring){
								arr.push([code,"urlstring",code.urlstring]);
							}
							if(code.targetstring){
								arr.push([code,"targetstring",code.targetstring]);
							}
						break;
						case AVM1Ops.constantPool://0x88	//UI16,STRING[Count]
							if(code.constStrV){
								var i:int=code.constStrV.length;
								while(i--){
									if(code.constStrV[i]){
										arr.push([code.constStrV,i,code.constStrV[i]]);
									}
								}
							}
						break;
						case AVM1Ops.push://0x96	//(UI8,STRING|FLOAT|UI8|DOUBLE|UI32|UI16)s
							if(code.pushValueV){
								i=code.pushValueV.length;
								while(i--){
									if(code.pushValueV[i]&&code.pushValueV[i] is String){
										arr.push([code.pushValueV,i,code.pushValueV[i]]);
									}
								}
							}
						break;
						case AVM1Ops.try_://0x8f	//UB[8],UI16,UI16,UI16,STRING|UI8,UI8[TrySize],UI8[CatchSize],UI8[FinallySize]
							if(code.catchname){
								arr.push([code,"catchname",code.catchname]);
							}
						break;
						case AVM1Ops.defineFunction://0x9b	//STRING,UI16,STRING[NumParams],UI16(label)
							if(code.functionname){
								arr.push([code,"functionname",code.functionname]);
							}
							if(code.paramNameV){
								i=code.paramNameV.length;
								while(i--){
									if(code.paramNameV[i]){
										arr.push([code.paramNameV,i,code.paramNameV[i]]);
									}
								}
							}
						break;
						case AVM1Ops.defineFunction2://0x8e	//STRING,UI16,UI8,UB[8],UB[8],(UI8,STRING)[NumParams],UI16(label)
							if(code.functionname){
								arr.push([code,"functionname",code.functionname]);
							}
							if(code.parameterArr){
								i=code.parameterArr.length;
								while(i--){
									if(code.parameterArr[i].name){
										arr.push([code.parameterArr[i],"name",code.parameterArr[i].name]);
									}
								}
							}
						break;
					}
				}
			}
		}
		
		//avm2 codes
		for each(var ABCData:ABCFileWithSimpleConstant_pool in getABCFileWithSimpleConstant_pools(swf)){
			i=-1;
			for each(var string:String in ABCData.stringV){
				i++;
				if(string){
					arr.push([ABCData.stringV,i,string]);
				}
			}
		}
		
		_product(swf.tagV,arr);
		
		return arr;
	}
}

import zero.swf.Tag;
import zero.swf.TagTypes;
import zero.swf.tagBodys.DefineEditText;
import zero.swf.tagBodys.DefineSceneAndFrameLabelData;
import zero.swf.tagBodys.DefineSprite;
import zero.swf.tagBodys.ExportAssets;
import zero.swf.tagBodys.FrameLabel_;
import zero.swf.tagBodys.ImportAssets;
import zero.swf.tagBodys.ImportAssets2;
import zero.swf.tagBodys.PlaceObject2;
import zero.swf.tagBodys.PlaceObject3;
import zero.swf.tagBodys.SymbolClass;

function _product(tagV:Vector.<Tag>,arr:Array):void{
	for each(var tag:Tag in tagV){
		switch(tag.type){
			//case TagTypes.End://0x00
			//case TagTypes.ShowFrame://0x01
			//case TagTypes.DefineShape://0x02
			////0x03
			//case TagTypes.PlaceObject://0x04
			//case TagTypes.RemoveObject://0x05
			//case TagTypes.DefineBits://0x06
			//case TagTypes.DefineButton://0x07
			//case TagTypes.JPEGTables://0x08
			//case TagTypes.SetBackgroundColor://0x09
			//case TagTypes.DefineFont://0x0a
			//case TagTypes.DefineText://0x0b
			//case TagTypes.DoAction://0x0c
			//case TagTypes.DefineFontInfo://0x0d
			//case TagTypes.DefineSound://0x0e
			//case TagTypes.StartSound://0x0f
			////0x10
			//case TagTypes.DefineButtonSound://0x11
			//case TagTypes.SoundStreamHead://0x12
			//case TagTypes.SoundStreamBlock://0x13
			//case TagTypes.DefineBitsLossless://0x14
			//case TagTypes.DefineBitsJPEG2://0x15
			//case TagTypes.DefineShape2://0x16
			//case TagTypes.DefineButtonCxform://0x17
			//case TagTypes.Protect://0x18
			////0x19
			case TagTypes.PlaceObject2://0x1a
				var placeObject2:PlaceObject2=tag.getBody(PlaceObject2,null);
				if(placeObject2.Name){
					arr.push([placeObject2,"Name",placeObject2.Name]);
				}
			break;
			////0x1b
			//case TagTypes.RemoveObject2://0x1c
			////0x1d
			////0x1e
			////0x1f
			//case TagTypes.DefineShape3://0x20
			//case TagTypes.DefineText2://0x21
			//case TagTypes.DefineButton2://0x22
			//case TagTypes.DefineBitsJPEG3://0x23
			//case TagTypes.DefineBitsLossless2://0x24
			case TagTypes.DefineEditText://0x25
				var defineEditText:DefineEditText=tag.getBody(DefineEditText,null);
				if(defineEditText.VariableName){
					arr.push([defineEditText,"VariableName",defineEditText.VariableName]);
				}
			break;
			////0x26
			case TagTypes.DefineSprite://0x27
				var defineSprite:DefineSprite=tag.getBody(DefineSprite,null);
				_product(defineSprite.tagV,arr);
			break;
			////0x28
			//case TagTypes.ProductInfo://0x29
			////0x2a
			case TagTypes.FrameLabel_://0x2b
				var frameLabel:FrameLabel_=tag.getBody(FrameLabel_,null);
				arr.push([frameLabel,"Name",frameLabel.Name]);
			break;
			////0x2c
			//case TagTypes.SoundStreamHead2://0x2d
			//case TagTypes.DefineMorphShape://0x2e
			////0x2f
			//case TagTypes.DefineFont2://0x30
			////0x31
			////0x32
			////0x33
			////0x34
			////0x35
			////0x36
			////0x37
			case TagTypes.ExportAssets://0x38
				var exportAssets:ExportAssets=tag.getBody(ExportAssets,null);
				var i:int=-1;
				for each(var Name:String in exportAssets.NameV){
					i++;
					if(Name){
						arr.push([exportAssets.NameV,i,Name]);
					}
				}
			break;
			case TagTypes.ImportAssets://0x39
				var importAssets:ImportAssets=tag.getBody(ImportAssets,null);
				i=-1;
				for each(Name in importAssets.NameV){
					i++;
					if(Name){
						arr.push([importAssets.NameV,i,Name]);
					}
				}
			break;
			//case TagTypes.EnableDebugger://0x3a
			//case TagTypes.DoInitAction://0x3b
			//case TagTypes.DefineVideoStream://0x3c
			//case TagTypes.VideoFrame://0x3d
			//case TagTypes.DefineFontInfo2://0x3e
			//case TagTypes.DebugID://0x3f
			//case TagTypes.EnableDebugger2://0x40
			//case TagTypes.ScriptLimits://0x41
			//case TagTypes.SetTabIndex://0x42
			////0x43
			////0x44
			//case TagTypes.FileAttributes://0x45
			case TagTypes.PlaceObject3://0x46
				var placeObject3:PlaceObject3=tag.getBody(PlaceObject3,null);
				if(placeObject3.ClassName){
					arr.push([placeObject3,"ClassName",placeObject3.ClassName]);
				}
				if(placeObject3.Name){
					arr.push([placeObject3,"Name",placeObject3.Name]);
				}
			break;
			case TagTypes.ImportAssets2://0x47
				var importAssets2:ImportAssets2=tag.getBody(ImportAssets2,null);
				i=-1;
				for each(Name in importAssets2.NameV){
					i++;
					if(Name){
						arr.push([importAssets2.NameV,i,Name]);
					}
				}
			break;
			//case TagTypes.DoABCWithoutFlagsAndName://0x48
			//case TagTypes.DefineFontAlignZones://0x49
			//case TagTypes.CSMTextSettings://0x4a
			//case TagTypes.DefineFont3://0x4b
			case TagTypes.SymbolClass://0x4c
				var symbolClass:SymbolClass=tag.getBody(SymbolClass,null);
				i=-1;
				for each(Name in symbolClass.NameV){
					i++;
					if(Name){
						arr.push([symbolClass.NameV,i,Name]);
					}
				}
			break;
			//case TagTypes.Metadata://0x4d
			//case TagTypes.DefineScalingGrid://0x4e
			////0x4f
			////0x50
			////0x51
			//case TagTypes.DoABC://0x52
			//case TagTypes.DefineShape4://0x53
			//case TagTypes.DefineMorphShape2://0x54
			////0x55
			case TagTypes.DefineSceneAndFrameLabelData://0x56
				var defineSceneAndFrameLabelData:DefineSceneAndFrameLabelData=tag.getBody(DefineSceneAndFrameLabelData,null);
				i=-1;
				for each(Name in defineSceneAndFrameLabelData.NameV){
					i++;
					if(Name){
						arr.push([defineSceneAndFrameLabelData.NameV,i,Name]);
					}
				}
				i=-1;
				for each(var FrameLabel:String in defineSceneAndFrameLabelData.FrameLabelV){
					i++;
					if(FrameLabel){
						arr.push([defineSceneAndFrameLabelData.FrameLabelV,i,FrameLabel]);
					}
				}
			break;
			//case TagTypes.DefineBinaryData://0x57
			//case TagTypes.DefineFontName://0x58
			//case TagTypes.DefineBitsJPEG4://0x5a
			//case TagTypes.DefineFont4://0x5b
			////0x5c
			////0x5d
			////0x5e
			////0x5f
			////0x60
			////0x61
			////0x62
			////0x63
			////0x64
			////0x65
			////0x66
			////0x67
			////0x68
			////0x69
			////0x6a
			////0x6b
			////0x6c
			////0x6d
			////0x6e
			////0x6f
			////0x70
			////0x71
			////0x72
			////0x73
			////0x74
			////0x75
			////0x76
			////0x77
			////0x78
			////0x79
			////0x7a
			////0x7b
			////0x7c
			////0x7d
			////0x7e
			////0x7f
			////0x80
			////0x81
			////0x82
			////0x83
			////0x84
			////0x85
			////0x86
			////0x87
			////0x88
			////0x89
			////0x8a
			////0x8b
			////0x8c
			////0x8d
			////0x8e
			////0x8f
			////0x90
			////0x91
			////0x92
			////0x93
			////0x94
			////0x95
			////0x96
			////0x97
			////0x98
			////0x99
			////0x9a
			////0x9b
			////0x9c
			////0x9d
			////0x9e
			////0x9f
			////0xa0
			////0xa1
			////0xa2
			////0xa3
			////0xa4
			////0xa5
			////0xa6
			////0xa7
			////0xa8
			////0xa9
			////0xaa
			////0xab
			////0xac
			////0xad
			////0xae
			////0xaf
			////0xb0
			////0xb1
			////0xb2
			////0xb3
			////0xb4
			////0xb5
			////0xb6
			////0xb7
			////0xb8
			////0xb9
			////0xba
			////0xbb
			////0xbc
			////0xbd
			////0xbe
			////0xbf
			////0xc0
			////0xc1
			////0xc2
			////0xc3
			////0xc4
			////0xc5
			////0xc6
			////0xc7
			////0xc8
			////0xc9
			////0xca
			////0xcb
			////0xcc
			////0xcd
			////0xce
			////0xcf
			////0xd0
			////0xd1
			////0xd2
			////0xd3
			////0xd4
			////0xd5
			////0xd6
			////0xd7
			////0xd8
			////0xd9
			////0xda
			////0xdb
			////0xdc
			////0xdd
			////0xde
			////0xdf
			////0xe0
			////0xe1
			////0xe2
			////0xe3
			////0xe4
			////0xe5
			////0xe6
			////0xe7
			////0xe8
			////0xe9
			////0xea
			////0xeb
			////0xec
			////0xed
			////0xee
			////0xef
			////0xf0
			////0xf1
			////0xf2
			////0xf3
			////0xf4
			////0xf5
			////0xf6
			////0xf7
			////0xf8
			////0xf9
			////0xfa
			////0xfb
			////0xfc
			////0xfd
			////0xfe
			////0xff
		}
	}
}