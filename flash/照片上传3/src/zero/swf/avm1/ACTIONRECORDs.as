/***
ACTIONRECORDs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 14:22:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Actions are an essential part of an interactive SWF file. Actions allow a file to react to events
//such as mouse movements or mouse clicks. The SWF 3 action model and earlier supports a
//simple action model. The SWF 4 action model supports a greatly enhanced action model that
//includes an expression evaluator, variables, and conditional branching and looping. The
//SWF 5 action model adds a JavaScript-style object model, data types, and functions.
//
//DoAction
//DoAction instructs Flash Player to perform a list of actions when the current frame is
//complete. The actions are performed when the ShowFrame tag is encountered, regardless of
//where in the frame the DoAction tag appears.
//Starting with SWF 9, if the ActionScript3 field of the FileAttributes tag is 1, the contents of
//the DoAction tag will be ignored.
//
//Field 			Type 							Comment
//Header 			RECORDHEADER 					Tag type = 12
//Actions 			ACTIONRECORD [zero or more] 	List of actions to perform (see following table, ActionRecord)
//ActionEndFlag 	UI8 = 0 						Always set to 0
//
//ACTIONRECORD
//An ACTIONRECORD consists of an ACTIONRECORDHEADER followed by a possible
//data payload. The ACTIONRECORDHEADER describes the action using an ActionCode.
//If the action also carries data, the ActionCode's high bit will be set which indicates that the
//ActionCode is followed by a 16-bit length and a data payload. Note that many actions have
//no data payload and only consist of a single byte value.
//An ACTIONRECORDHEADER has the following layout:
//Field 			Type 					Comment
//ActionCode 		UI8 					An action code
//Length 			If code >= 0x80, UI16 	The number of bytes in the ACTIONRECORDHEADER, not counting the ActionCode and Length fields.
package zero.swf.avm1{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	
	import zero.BytesAndStr16;
	import zero.output;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	import zero.swf.utils.stringComplexString;
	
	public class ACTIONRECORDs{
		
		public var codeArr:Array;
		
		public function ACTIONRECORDs(){
		}
		
		public function initByData(codesData:ByteArray,codeOffset:int,codeEndOffset:int,_initByDataOptions:Object):int{
			
			if(codeOffset<codeEndOffset){
				if(_initByDataOptions&&_initByDataOptions.optimizeAVM1Codes){
					
					codeArr=_initByDataOptions.optimizeAVM1Codes(codesData,codeOffset,codeEndOffset,_initByDataOptions);
				
				}else{
					
					var startPos:int=codeOffset;
					
					var labelByPosArr:Array=new Array();
					var codeByPosArr:Array=new Array();
					
					while(codeOffset<codeEndOffset){
						
						var code:Object=codeByPosArr[codeOffset]={
							ownData:codesData,
							pos:codeOffset,
							op:codesData[codeOffset]
						};
						
						if(AVM1Ops.nameV[code.op]){
							codeOffset++;
							if(code.op<0x80){
							}else{
								code.Length=(codesData[codeOffset++]|(codesData[codeOffset++]<<8));
								switch(code.op){
									case AVM1Ops.call://0x9e	//
										//
									break;
									case AVM1Ops.storeRegister://0x87	//UI8
										code.registerid=codesData[codeOffset++];
									break;
									case AVM1Ops.gotoFrame://0x81	//UI16
										code.frameid=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
									break;
									case AVM1Ops.gotoFrame2://0x9f	//UB[8],UI16
										var flags:int=codesData[codeOffset++];
										//Reserved=flags&0xfc;								//11111100
										if(flags&0x02){//SceneBiasFlag						//00000010
											code.scenebias=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										}
										code.play=((flags&0x01)?true:false);	//00000001
									break;
									case AVM1Ops.setTarget://0x8b	//STRING
										codesData.position=codeOffset;
										code.targetname=ignoreBOMReadUTFBytes(codesData,code.Length);
										codeOffset+=code.Length;
									break;
									case AVM1Ops.gotoLabel://0x8c	//STRING
										codesData.position=codeOffset;
										code.labelname=ignoreBOMReadUTFBytes(codesData,code.Length);
										codeOffset+=code.Length;
									break;
									case AVM1Ops.waitForFrame://0x8a	//UI16,UI8(label)
										code.frameid=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										var skipId:int=codesData[codeOffset++];
										var offsetPos:int=code.pos+3+code.Length;
										while(skipId--){
											if(codesData[offsetPos++]<0x80){
											}else{
												var Length2:int=codesData[offsetPos++]|(codesData[offsetPos++]<<8);
												offsetPos+=Length2;
											}
										}
										code.end=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
									break;
									case AVM1Ops.waitForFrame2://0x8d	//UI8(label)
										skipId=codesData[codeOffset++];
										offsetPos=code.pos+3+code.Length;
										while(skipId--){
											if(codesData[offsetPos++]<0x80){
											}else{
												Length2=codesData[offsetPos++]|(codesData[offsetPos++]<<8);
												offsetPos+=Length2;
											}
										}
										code.end=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
									break;
									case AVM1Ops.with_://0x94	//UI16(label)
										var posOffset:int=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										offsetPos=code.pos+3+code.Length+posOffset;
										code.end=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
									break;
									case AVM1Ops.jump://0x99	//SI16(label)
									case AVM1Ops.if_://0x9d		//SI16(label)
										posOffset=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										if(posOffset&0x00008000){posOffset|=0xffff0000}//最高位为1,表示负数
										offsetPos=code.pos+3+code.Length+posOffset;
										if(offsetPos<startPos){
											outputCodeError("不合法的偏移量："+(offsetPos-startPos));
										}
										code.label=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
									break;
									case AVM1Ops.getURL://0x83	//STRING,STRING
										codesData.position=codeOffset;
										var get_str_size:int=0;
										while(codesData[codeOffset+(get_str_size++)]){}
										code.urlstring=ignoreBOMReadUTFBytes(codesData,get_str_size);
										codeOffset+=get_str_size;
										get_str_size=0;
										while(codesData[codeOffset+(get_str_size++)]){}
										code.targetstring=ignoreBOMReadUTFBytes(codesData,get_str_size);
										codeOffset+=get_str_size;
									break;
									case AVM1Ops.getURL2://0x9a	//UB[8]
										//9a 01 00 00	getURL(url,target);
										//9a 01 00 01	getURL(url,target,"get");
										//9a 01 00 02	getURL(url,target,"post");
										//9a 01 00 03	getURL(url,target);
										
										//9a 01 00 40	loadMovie(url,mc);
										//9a 01 00 41	loadMovie(url,mc,"get");
										//9a 01 00 42	loadMovie(url,mc,"post");
										//9a 01 00 43	loadMovie(url,mc);
										
										//9a 01 00 80	loadVariablesNum(url,num);
										//9a 01 00 81	loadVariablesNum(url,num,"get");
										//9a 01 00 82	loadVariablesNum(url,num,"post");
										//9a 01 00 83	loadVariablesNum(url,num);
										
										//9a 01 00 c0	loadVariables(url,mc);
										//9a 01 00 c1	loadVariables(url,mc,"get");
										//9a 01 00 c2	loadVariables(url,mc,"post");
										//9a 01 00 c3	loadVariables(url,mc);
										
										flags=codesData[codeOffset++];
										code.loadvariables=((flags&0x80)?true:false);			//10000000
										code.loadtarget=((flags&0x40)?true:false);				//01000000
										//Reserved:flags&0x3c									//00111100
										code.sendvarsmethod=flags&0x03;							//00000011
									break;
									case AVM1Ops.constantPool://0x88	//UI16,STRING[Count]
										if(constStrV){
											outputCodeError("发现多个 constCode");
										}
										var Count:int=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										var constStrV:Vector.<String>=new Vector.<String>(Count);
										constStrV.fixed=true;
										codesData.position=codeOffset;
										for(var i:int=0;i<Count;i++){
											get_str_size=0;
											while(codesData[codeOffset+(get_str_size++)]){}
											constStrV[i]=ignoreBOMReadUTFBytes(codesData,get_str_size);
											codeOffset+=get_str_size;
										}
										code.constStrV=constStrV;
									break;
									case AVM1Ops.push://0x96	//(UI8,STRING|FLOAT|UI8|DOUBLE|UI32|UI16)s
										i=-1;
										var pushValueV:Array=new Array();
										while(codeOffset<code.pos+3+code.Length){
											switch(codesData[codeOffset++]){
												case 0:
													get_str_size=0;
													while(codesData[codeOffset+(get_str_size++)]){}
													codesData.position=codeOffset;
													pushValueV[++i]=ignoreBOMReadUTFBytes(codesData,get_str_size);
													codeOffset+=get_str_size;
													if(_initByDataOptions.avm1ReplaceStrs){//20130709
														var replaceStr:String=_initByDataOptions.avm1ReplaceStrs["~"+pushValueV[i]];
														if(replaceStr||replaceStr===""){
															pushValueV[i]=replaceStr;
														}
													}
												break;
												case 1:
													//好像没见过。。。
													codesData.endian=Endian.LITTLE_ENDIAN;
													codesData.position=codeOffset;
													pushValueV[++i]=codesData.readFloat();
													codeOffset=codesData.position;
												break;
												case 2:
													pushValueV[++i]=null;
												break;
												case 3:
													pushValueV[++i]=undefined;
												break;
												case 4:
													pushValueV[++i]={r:codesData[codeOffset++]};
												break;
												case 5:
													pushValueV[++i]=(codesData[codeOffset++]?true:false);
												break;
												case 6:
													codesData.endian=Endian.LITTLE_ENDIAN;
													codesData.position=codeOffset;
													pushValueV[++i]=codesData.readDouble();
													codeOffset=codesData.position;
												break;
												case 7:
													pushValueV[++i]=codesData[codeOffset++]|(codesData[codeOffset++]<<8)|(codesData[codeOffset++]<<16)|(codesData[codeOffset++]<<24);
												break;
												case 8:
													pushValueV[++i]=constStrV[codesData[codeOffset++]];
												break;
												case 9:
													pushValueV[++i]=constStrV[codesData[codeOffset++]|(codesData[codeOffset++]<<8)];
												break;
												default:
													outputCodeError("未知 pushType");
												break;
											}
										}
										code.pushValueV=pushValueV;
									break;
									case AVM1Ops.try_://0x8f	//UB[8],UI16,UI16,UI16,STRING|UI8,UI8[TrySize],UI8[CatchSize],UI8[FinallySize]
										flags=codesData[codeOffset++];
										//Reserved=flags&0xf8;									//11111000
										var TrySize:int=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										var CatchSize:int=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										var FinallySize:int=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										if(flags&0x04){//CatchInRegisterFlag					//00000100
											code.catchregisterid=codesData[codeOffset++];
										}else{
											codesData.position=codeOffset;
											get_str_size=0;
											while(codesData[codeOffset+(get_str_size++)]){}
											code.catchname=ignoreBOMReadUTFBytes(codesData,get_str_size);
											codeOffset+=get_str_size;
										}
										offsetPos=code.pos+3+code.Length+TrySize;
										code.tryEnd=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
										if(flags&0x01){//CatchBlockFlag							//00000001
											offsetPos=code.pos+3+code.Length+TrySize+CatchSize;
											code.catchEnd=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
										}else{
											CatchSize=0;
										}
										if(flags&0x02){//FinallyBlockFlag						//00000010
											offsetPos=code.pos+3+code.Length+TrySize+CatchSize+FinallySize;
											code.finallyEnd=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
										}
									break;
									case AVM1Ops.defineFunction://0x9b	//STRING,UI16,STRING[NumParams],UI16(label)
										codesData.position=codeOffset;
										get_str_size=0;
										while(codesData[codeOffset+(get_str_size++)]){}
										code.functionname=ignoreBOMReadUTFBytes(codesData,get_str_size);
										codeOffset+=get_str_size;
										
										var NumParams:int=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										if(NumParams){
											code.paramNameV=new Vector.<String>(NumParams);
											codesData.position=codeOffset;
											for(i=0;i<NumParams;i++){
												get_str_size=0;
												while(codesData[codeOffset+(get_str_size++)]){}
												code.paramNameV[i]=ignoreBOMReadUTFBytes(codesData,get_str_size);
												codeOffset+=get_str_size;
											}
										}
										
										posOffset=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										offsetPos=code.pos+3+code.Length+posOffset;
										code.end=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
									break;
									case AVM1Ops.defineFunction2://0x8e	//STRING,UI16,UI8,UB[8],UB[8],(UI8,STRING)[NumParams],UI16(label)
										codesData.position=codeOffset;
										get_str_size=0;
										while(codesData[codeOffset+(get_str_size++)]){}
										code.functionname=ignoreBOMReadUTFBytes(codesData,get_str_size);
										codeOffset+=get_str_size;
										
										NumParams=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										
										code.registercount=codesData[codeOffset++];
										
										flags=codesData[codeOffset++];
										if(flags&0x80){code.preloadparent=true;}				//10000000
										if(flags&0x40){code.preloadroot=true;}					//01000000
										if(flags&0x20){code.suppresssuper=true;}				//00100000
										if(flags&0x10){code.preloadsuper=true;}					//00010000
										if(flags&0x08){code.suppressarguments=true;}			//00001000
										if(flags&0x04){code.preloadarguments=true;}				//00000100
										if(flags&0x02){code.suppressthis=true;}					//00000010
										if(flags&0x01){code.preloadthis=true;}					//00000001
										
										flags=codesData[codeOffset++];
										//Reserved=flags&0xfe;									//11111110
										if(flags&0x01){code.preloadglobal=true;}				//00000001
										
										if(NumParams){
											code.parameterArr=new Array(NumParams);
											for(i=0;i<NumParams;i++){
												code.parameterArr[i]={registerid:codesData[codeOffset++]};
												codesData.position=codeOffset;
												get_str_size=0;
												while(codesData[codeOffset+(get_str_size++)]){}
												code.parameterArr[i].name=ignoreBOMReadUTFBytes(codesData,get_str_size);
												codeOffset+=get_str_size;
											}
										}
										
										posOffset=codesData[codeOffset++]|(codesData[codeOffset++]<<8);
										offsetPos=code.pos+3+code.Length+posOffset;
										code.end=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
									break;
								}//end of switch(code.op)...
								
								if(codeOffset==code.pos+3+code.Length){
								}else{
									outputCodeError(AVM1Ops.nameV[code.op]+" codeOffset 不正确, codeOffset="+codeOffset+"，code.pos+3+code.Length="+(code.pos+3+code.Length));
									codeOffset=code.pos+code.Length;
								}
							}//end of if(code.op<0x80)...else...
							
						}else{
							if(code.op<0x80){
								code.dataLen=1;
							}else{
								code.dataLen=3+(codesData[codeOffset+1]|(codesData[codeOffset+2]<<8));
							}
							if(code.pos+code.dataLen>code.ownData.length){//20130709
								code.dataLen=code.ownData.length-code.pos;
							}
							codeOffset+=code.dataLen;
							output("未知 op 0x"+BytesAndStr16._16V[code.op]+"（"+BytesAndStr16.bytes2str16(code.ownData,code.pos,code.dataLen)+"）","brown");
						}//end of if(AVM1Ops.nameV[code.op])...else...
						
					}//end of while(codeOffset<codeEndOffset)...
					
					//labelByPosArr 的最后一个索引最大的合法值是 codeEndOffset
					if((labelByPosArr.length-1)>codeEndOffset){
						outputCodeError("不合法的偏移量："+((labelByPosArr.length-1)-startPos));
					}
					
					codeArr=new Array();
					var codeId:int=-1;
					
					for(codeOffset=startPos;codeOffset<codeEndOffset;codeOffset++){
						if(labelByPosArr[codeOffset]){
							if(codeByPosArr[codeOffset]){
								codeArr[++codeId]=labelByPosArr[codeOffset];
								codeArr[++codeId]=codeByPosArr[codeOffset];
							}else{
								outputCodeError("不合法的偏移量："+(codeOffset-startPos));
							}
						}else if(codeByPosArr[codeOffset]){
							codeArr[++codeId]=codeByPosArr[codeOffset];
						}
					}
					if(labelByPosArr[codeEndOffset]){//可能有的最后一个 label
						codeArr[++codeId]=labelByPosArr[codeEndOffset];
					}
					
				}
				
				var infos:String="";
				for each(code in codeArr){
					if(code.info){
						infos+=code.info;
					}
				}
				if(infos){
					output(infos,"brown");
				}
				
			}else{
				codeArr=null;
			}
			
			return codeEndOffset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			if(codeArr&&codeArr.length){
				
				//统计需要放 const 里的字符串
				var i:int=-1;
				var constStrV:Vector.<String>=new Vector.<String>();
				loop:for each(var code:Object in codeArr){
					if(code.ownData&&code.pos>-1&&code.dataLen>0){
					}else if(code.op>-1){
						switch(code.op){
							case AVM1Ops.constantPool://0x88
								var constCode:Object=code;
								break loop;
							break;
							case AVM1Ops.push://0x96
								for each(var pushValue:* in code.pushValueV){
									if(pushValue){//pushValue===""的不需要
										if(pushValue.constructor==String){
											constStrV[++i]=pushValue;
										}
									}
								}
							break;
						}
					}
				}
				
				if(constCode){
					
					//如果本来就已经有 constCode ，则不自动计算 constCode
					constStrV=constCode.constStrV;
					
					var constStrMark:Object=new Object();//统计次数用；记录id用
					var constId:int=-1;
					for each(pushValue in constStrV){
						constStrMark["~"+pushValue]=++constId;
					}
					
				}else{
					
					constStrMark=new Object();//统计次数用；记录id用
					for each(pushValue in constStrV){
						if(constStrMark["~"+pushValue]){
							constStrMark["~"+pushValue]++;
						}else{
							constStrMark["~"+pushValue]=1;
						}
					}
					
					//次数越多排的越靠前
					//总个数不能多于 1000000000
					var _strArr:Array=new Array();
					for(var _str:String in constStrMark){
						_strArr.push((2000000000-constStrMark[_str])+_str);
					}
					_strArr.sort(Array.CASEINSENSITIVE);
					constId=-1;
					constStrV.length=0;
					for each(_str in _strArr){
						pushValue=_str.substr(11);
						if(constStrMark["~"+pushValue]>1){//使用2次或以上的字符串才有需要放常量池里
							constStrV[++constId]=pushValue;
							constStrMark["~"+pushValue]=constId;
						}else{
							delete constStrMark["~"+pushValue];
						}
					}
					constStrV.fixed=true;
					codeArr.unshift(constCode={op:AVM1Ops.constantPool,constStrV:constStrV});
					
				}
				if(constStrV.length){
				}else{
					codeArr.splice(codeArr.indexOf(constCode),1);
					constStrMark=null;
				}
				constCode=null;
				constStrV=null;
				//
				
				var codesData:ByteArray=new ByteArray();
				var codeOffset:int=0;
				var labelObjArr:Array=new Array();
				var labelDict:Dictionary=new Dictionary();
				for each(code in codeArr){
					if(code.ownData&&code.pos>-1&&code.dataLen>0){
						//output("直接写入的字节码："+BytesAndStr16.bytes2str16(code.ownData,code.pos,code.dataLen),"brown");
						codesData.position=codeOffset;
						codesData.writeBytes(code.ownData,code.pos,code.dataLen);
						codeOffset=codesData.length;
					}else if(code.op>-1){
						if(AVM1Ops.nameV[code.op]){
							codesData[codeOffset++]=code.op;
							switch(code.op){
								case AVM1Ops.call://0x9e	//
									codesData[codeOffset++]=0x00;
									codesData[codeOffset++]=0x00;//Length==0
								break;
								case AVM1Ops.storeRegister://0x87	//UI8
									codesData[codeOffset++]=0x01;
									codesData[codeOffset++]=0x00;//Length==1
									if(code.registerid>-1&&code.registerid<0x100){
										codesData[codeOffset++]=code.registerid;
									}else{
										outputCodeError("code.registerid="+code.registerid+"，超出范围");
									}
								break;
								case AVM1Ops.gotoFrame://0x81	//UI16
									codesData[codeOffset++]=0x02;
									codesData[codeOffset++]=0x00;//Length==2
									if(code.frameid>-1&&code.frameid<0x10000){
										codesData[codeOffset++]=code.frameid;
										codesData[codeOffset++]=code.frameid>>8;
									}else{
										outputCodeError("code.frameid="+code.frameid+"，超出范围");
									}
								break;
								case AVM1Ops.gotoFrame2://0x9f	//UB[8],UI16
									var flags:int=0;
									if(code.play){
										flags|=0x01;							//00000001
									}
									//flags|=Reserved;							//11111100
									if(code.scenebias>-1){
										flags|=0x02;//SceneBiasFlag				//00000010
										codesData[codeOffset++]=0x03;
										codesData[codeOffset++]=0x00;//Length==3
										codesData[codeOffset++]=flags;
										if(code.scenebias>-1&&code.scenebias<0x10000){
											codesData[codeOffset++]=code.scenebias;
											codesData[codeOffset++]=code.scenebias>>8;
										}else{
											outputCodeError("code.scenebias="+code.scenebias+"，超出范围");
										}
									}else{
										codesData[codeOffset++]=0x01;
										codesData[codeOffset++]=0x00;//Length==1
										codesData[codeOffset++]=flags;
									}
								break;
								case AVM1Ops.setTarget://0x8b	//STRING
									codeOffset+=2;//Length
									codesData.position=codeOffset;
									codesData.writeUTFBytes(code.targetname+"\x00");
									var Length:int=codesData.length-codeOffset;
									if(Length<0x10000){
										codesData[codeOffset-2]=Length;
										codesData[codeOffset-1]=Length>>8;
									}else{
										outputCodeError("Length="+Length+"，超出范围");
									}
									codeOffset=codesData.length;
								break;
								case AVM1Ops.gotoLabel://0x8c	//STRING
									codeOffset+=2;//Length
									codesData.position=codeOffset;
									codesData.writeUTFBytes(code.labelname+"\x00");
									Length=codesData.length-codeOffset;
									if(Length<0x10000){
										codesData[codeOffset-2]=Length;
										codesData[codeOffset-1]=Length>>8;
									}else{
										outputCodeError("Length="+Length+"，超出范围");
									}
									codeOffset=codesData.length;
								break;
								case AVM1Ops.waitForFrame://0x8a	//UI16,UI8(label)
									codesData[codeOffset++]=0x03;
									codesData[codeOffset++]=0x00;//Length==3
									if(code.frameid>-1&&code.frameid<0x10000){
										codesData[codeOffset++]=code.frameid;
										codesData[codeOffset++]=code.frameid>>8;
									}else{
										outputCodeError("code.frameid="+code.frameid+"，超出范围");
									}
									i=codeArr.indexOf(code.end);
									var j:int=codeArr.indexOf(code);
									if(i>j){
									}else{
										outputCodeError("code.end 必须在 code 的后面");
									}
									var skipId:int=0;
									while(--i!=j){
										if(codeArr[i].op>-1){
											skipId++;
										}//else{
										//	//label
										//}
									}
									if(skipId<0x100){
										codesData[codeOffset++]=skipId;
									}else{
										outputCodeError("skipId="+skipId+"，超出范围");
									}
								break;
								case AVM1Ops.waitForFrame2://0x8d	//UI8(label)
									codesData[codeOffset++]=0x01;
									codesData[codeOffset++]=0x00;//Length==1
									i=codeArr.indexOf(code.end);
									j=codeArr.indexOf(code);
									if(i>j){
									}else{
										outputCodeError("code.end 必须在 code 的后面");
									}
									skipId=0;
									while(--i!=j){
										if(codeArr[i].op>-1){
											skipId++;
										}//else{
										//	//label
										//}
									}
									if(skipId<0x100){
										codesData[codeOffset++]=skipId;
									}else{
										outputCodeError("skipId="+skipId+"，超出范围");
									}
								break;
								case AVM1Ops.with_://0x94	//UI16(label)
									codesData[codeOffset++]=0x02;
									codesData[codeOffset++]=0x00;//Length==2
									labelObjArr.push({code:code,label:code.end,startPos:codeOffset+2,offsetCodePos:codeOffset});
									codesData[codeOffset++]=0x00;
									codesData[codeOffset++]=0x00;
								break;
								case AVM1Ops.jump://0x99	//SI16(label)
								case AVM1Ops.if_://0x9d		//SI16(label)
									codesData[codeOffset++]=0x02;
									codesData[codeOffset++]=0x00;//Length==2
									labelObjArr.push({code:code,label:code.label,startPos:codeOffset+2,offsetCodePos:codeOffset,offsetIsSI16:true});
									codesData[codeOffset++]=0x00;
									codesData[codeOffset++]=0x00;
								break;
								case AVM1Ops.getURL://0x83	//STRING,STRING
									codeOffset+=2;//Length
									codesData.position=codeOffset;
									codesData.writeUTFBytes(code.urlstring+"\x00");
									codesData.writeUTFBytes(code.targetstring+"\x00");
									Length=codesData.length-codeOffset;
									if(Length<0x10000){
										codesData[codeOffset-2]=Length;
										codesData[codeOffset-1]=Length>>8;
									}else{
										outputCodeError("Length="+Length+"，超出范围");
									}
									codeOffset=codesData.length;
								break;
								case AVM1Ops.getURL2://0x9a	//UB[8]
									codesData[codeOffset++]=0x01;
									codesData[codeOffset++]=0x00;//Length==1
									flags=0;
									if(code.loadvariables){
										flags|=0x80;							//10000000
									}
									if(code.loadtarget){
										flags|=0x40;							//01000000
									}
									//flags|=Reserved;							//00111100
									flags|=code.sendvarsmethod;					//00000011
									codesData[codeOffset++]=flags;
								break;
								case AVM1Ops.constantPool://0x88	//UI16,STRING[Count]
									codeOffset+=2;//Length
									i=code.constStrV.length;
									codesData[codeOffset++]=i;
									codesData[codeOffset++]=i>>8;
									codesData.position=codeOffset;
									for each(pushValue in code.constStrV){
										codesData.writeUTFBytes(pushValue+"\x00");
									}
									Length=codesData.length-codeOffset+2;
									if(Length<0x10000){
										codesData[codeOffset-4]=Length;
										codesData[codeOffset-3]=Length>>8;
									}else{
										outputCodeError("Length="+Length+"，超出范围");
									}
									codeOffset=codesData.length;
								break;
								case AVM1Ops.push://0x96	//(UI8,STRING|FLOAT|UI8|DOUBLE|UI32|UI16)s
									codeOffset+=2;//Length
									var pos:int=codeOffset-3;
									for each(pushValue in code.pushValueV){
										switch(pushValue){
											case null:
												codesData[codeOffset++]=0x02;
											break;
											case undefined:
												codesData[codeOffset++]=0x03;
											break;
											case true:
												codesData[codeOffset++]=0x05;
												codesData[codeOffset++]=0x01;
											break;
											case false:
												codesData[codeOffset++]=0x05;
												codesData[codeOffset++]=0x00;
											break;
											default:
												switch(pushValue.constructor){
													case String:
														if(constStrMark&&constStrMark["~"+pushValue]>-1){
															if(constStrMark["~"+pushValue]>0xff){
																codesData[codeOffset++]=0x09;
																codesData[codeOffset++]=constStrMark["~"+pushValue];
																codesData[codeOffset++]=constStrMark["~"+pushValue]>>8;
															}else{
																codesData[codeOffset++]=0x08;
																codesData[codeOffset++]=constStrMark["~"+pushValue];
															}
														}else{
															codesData[codeOffset++]=0x00;
															codesData.position=codeOffset;
															codesData.writeUTFBytes(pushValue+"\x00");
															codeOffset=codesData.length;
														}
													break;
													case Object:
														if(pushValue.r>-1){
															codesData[codeOffset++]=0x04;
															codesData[codeOffset++]=pushValue.r;
														}else if(pushValue.c>-1){
															if(pushValue.c<0x100){
																codesData[codeOffset++]=0x08;
																codesData[codeOffset++]=pushValue.c;
															}else if(pushValue.c<0x10000){
																codesData[codeOffset++]=0x09;
																codesData[codeOffset++]=pushValue.c;
																codesData[codeOffset++]=pushValue.c>>8;
															}else{
																outputCodeError("pushValue.c="+pushValue.c+"，超出范围");
															}
														}else{
															outputCodeError("不支持的 pushValue："+pushValue);
														}
													break;
													case Number:
														if(pushValue is int){
															codesData[codeOffset++]=0x07;
															codesData[codeOffset++]=pushValue;
															codesData[codeOffset++]=pushValue>>8;
															codesData[codeOffset++]=pushValue>>16;
															codesData[codeOffset++]=pushValue>>24;
														}else{
															codesData[codeOffset++]=0x06;
															codesData.endian=Endian.LITTLE_ENDIAN;
															codesData.position=codeOffset;
															codesData.writeDouble(pushValue);
															codeOffset=codesData.length;
														}
													break;
													default:
														outputCodeError("不支持的 pushValue："+pushValue);
													break;
												}
											break;
										}
									}
									codeOffset=codesData.length;
									Length=codeOffset-pos-3;
									if(Length<0x10000){
										codesData[pos+1]=Length;
										codesData[pos+2]=Length>>8;
									}else{
										outputCodeError("Length="+Length+"，超出范围");
									}
								
								break;
								case AVM1Ops.try_://0x8f	//UB[8],UI16,UI16,UI16,STRING|UI8,UI8[TrySize],UI8[CatchSize],UI8[FinallySize]
									codeOffset+=2;//Length
									pos=codeOffset-3;
									flags=0;
									//flags|=Reserved;							//11111000
									if(code.catchregisterid>-1){
										flags|=0x04;//CatchInRegisterFlag		//00000100
									}
									if(code.catchEnd){
										flags|=0x01;//CatchBlockFlag			//00000001
									}
									if(code.finallyEnd){
										flags|=0x02;//FinallyBlockFlag			//00000010
									}
									codesData[codeOffset++]=flags;
									
									if(tryDict){
									}else{
										var tryDict:Dictionary=new Dictionary();
									}
									tryDict[code]={pos1:codeOffset};
									
									codeOffset+=6;//TrySize,CatchSize,FinallySize
									
									if(code.catchregisterid>-1){
										if(code.catchregisterid>-1&&code.catchregisterid<0x100){
											codesData[codeOffset++]=code.catchregisterid;
										}else{
											outputCodeError("code.catchregisterid="+code.catchregisterid+"，超出范围");
										}
									}else{
										codesData.position=codeOffset;
										codesData.writeUTFBytes(code.catchname+"\x00");
										codeOffset=codesData.length;
									}
									tryDict[code].pos2=codeOffset;
									Length=codeOffset-pos-3;
									if(Length<0x10000){
										codesData[pos+1]=Length;
										codesData[pos+2]=Length>>8;
									}else{
										outputCodeError("Length="+Length+"，超出范围");
									}
								break;
								case AVM1Ops.defineFunction://0x9b	//STRING,UI16,STRING[NumParams],UI16(label)
									codeOffset+=2;//Length
									pos=codeOffset-3;
									codesData.position=codeOffset;
									codesData.writeUTFBytes(code.functionname+"\x00");
									codeOffset=codesData.length;
									if(code.paramNameV){
										var NumParams:int=code.paramNameV.length;
										if(NumParams){
											codesData[codeOffset++]=NumParams;
											codesData[codeOffset++]=NumParams>>8;
											codesData.position=codeOffset;
											for each(var paramName:String in code.paramNameV){
												codesData.writeUTFBytes(paramName+"\x00");
											}
											codeOffset=codesData.length;
										}else{
											codeOffset+=2;
										}
									}else{
										codeOffset+=2;
									}
									
									labelObjArr.push({code:code,label:code.end,startPos:codeOffset+2,offsetCodePos:codeOffset});
									codesData[codeOffset++]=0x00;
									codesData[codeOffset++]=0x00;
									Length=codeOffset-pos-3;
									if(Length<0x10000){
										codesData[pos+1]=Length;
										codesData[pos+2]=Length>>8;
									}else{
										outputCodeError("Length="+Length+"，超出范围");
									}
									
								break;
								case AVM1Ops.defineFunction2://0x8e	//STRING,UI16,UI8,UB[8],UB[8],(UI8,STRING)[NumParams],UI16(label)
									codeOffset+=2;//Length
									pos=codeOffset-3;
									codesData.position=codeOffset;
									codesData.writeUTFBytes(code.functionname+"\x00");
									codeOffset=codesData.length;
									if(code.parameterArr){
										NumParams=code.parameterArr.length;
										if(NumParams){
											codesData[codeOffset++]=NumParams;
											codesData[codeOffset++]=NumParams>>8;
										}else{
											codeOffset+=2;
										}
									}else{
										NumParams=0;
										codeOffset+=2;
									}
									
									codesData[codeOffset++]=code.registercount;
									
									flags=0;
									if(code.preloadparent){
										flags|=0x80;
									}
									if(code.preloadroot){
										flags|=0x40;
									}
									if(code.suppresssuper){
										flags|=0x20;
									}
									if(code.preloadsuper){
										flags|=0x10;
									}
									if(code.suppressarguments){
										flags|=0x08;
									}
									if(code.preloadarguments){
										flags|=0x04;
									}
									if(code.suppressthis){
										flags|=0x02;
									}
									if(code.preloadthis){
										flags|=0x01;
									}
									codesData[codeOffset++]=flags;
									
									flags=0;
									//flags|=Reserved;
									if(code.preloadglobal){
										flags|=0x01;
									}
									codesData[codeOffset++]=flags;
									
									if(NumParams){
										for each(var parameter:Object in code.parameterArr){
											if(parameter.registerid>-1&&parameter.registerid<0x100){
												codesData[codeOffset++]=parameter.registerid;
											}else{
												outputCodeError("parameter.registerid="+parameter.registerid+"，超出范围");
											}
											codesData.position=codeOffset;
											codesData.writeUTFBytes(parameter.name+"\x00");
											codeOffset=codesData.length;
										}
									}
									
									labelObjArr.push({code:code,label:code.end,startPos:codeOffset+2,offsetCodePos:codeOffset});
									codesData[codeOffset++]=0x00;
									codesData[codeOffset++]=0x00;
									Length=codeOffset-pos-3;
									if(Length<0x10000){
										codesData[pos+1]=Length;
										codesData[pos+2]=Length>>8;
									}else{
										outputCodeError("Length="+Length+"，超出范围");
									}
									
								break;
								//default:
								//	//
								//break;
							}//end of switch(code.op)...
							
						}else{
							outputCodeError("未知 op 0x"+BytesAndStr16._16V[code.op]);
						}//end of if(AVM1Ops.nameV[code.op])...else...
						
					}else{
						//label
						labelDict[code]=true;
						code.pos=codeOffset;
					}//end of if(code.ownData&&code.pos>-1&&code.dataLen>0)...else if(code.op>-1)...else...
					
				}//end of for each(code in codeArr)...
				
				for each(var labelObj:Object in labelObjArr){
					if(labelDict[labelObj.label]){
						var posOffset:int=labelObj.label.pos-labelObj.startPos;
						if(labelObj.offsetIsSI16){
							if(posOffset>=-0x8000&&posOffset<0x8000){
							}else{
								outputCodeError("posOffset="+posOffset+"，超出范围");
							}
						}else{
							if(posOffset>-1&&posOffset<0x10000){
							}else{
								outputCodeError("posOffset="+posOffset+"，超出范围");
							}
						}
						codesData[labelObj.offsetCodePos]=posOffset;
						codesData[labelObj.offsetCodePos+1]=posOffset>>8;
					}else{
						outputCodeError("找不到对应的 label：code.op="+AVM1Ops.nameV[labelObj.code.op]+"，labelObj.startPos="+labelObj.startPos+"，labelObj.offsetCodePos="+labelObj.offsetCodePos);
					}
				}
				
				for(code in tryDict){
					var TrySize:int=code.tryEnd.pos-tryDict[code].pos2;
					if(TrySize>-1&&TrySize<0x10000){
						codesData[tryDict[code].pos1]=TrySize;
						codesData[tryDict[code].pos1+1]=TrySize>>8;
					}else{
						outputCodeError("TrySize="+TrySize+"，超出范围");
					}
					if(code.catchEnd){
						if(labelDict[code.catchEnd]){
							var CatchSize:int=code.catchEnd.pos-code.tryEnd.pos;
							if(CatchSize>-1&&CatchSize<0x10000){
								codesData[tryDict[code].pos1+2]=CatchSize;
								codesData[tryDict[code].pos1+3]=CatchSize>>8;
							}else{
								outputCodeError("CatchSize="+CatchSize+"，超出范围");
							}
						}else{
							outputCodeError("找不到对应的 catchEnd：code.op="+AVM1Ops.nameV[code.op]);
						}
					}
					if(code.finallyEnd){
						if(labelDict[code.finallyEnd]){
							if(code.catchEnd){
								var FinallySize:int=code.finallyEnd.pos-code.catchEnd.pos;
							}else{
								FinallySize=code.finallyEnd.pos-code.tryEnd.pos;
							}
							if(FinallySize>-1&&FinallySize<0x10000){
								codesData[tryDict[code].pos1+4]=FinallySize;
								codesData[tryDict[code].pos1+5]=FinallySize>>8;
							}else{
								outputCodeError("FinallySize="+FinallySize+"，超出范围");
							}
						}else{
							outputCodeError("找不到对应的 finallyEnd：code.op="+AVM1Ops.nameV[code.op]);
						}
					}
				}
				
				//trace("toData codesData="+BytesAndStr16.bytes2str16(codesData,0,codesData.length));
				return codesData;
			}
import zero.swf.utils.stringComplexString;
			
			return new ByteArray();
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			var str:String=toStr(_toXMLOptions);
			if(str){
				return new XML("<"+xmlName+" class=\"zero.swf.avm1.ACTIONRECORDs\"><![CDATA[\n"+
					str.replace(/\]\]\>/g,"\\]\\]\\>")
					+"\t\t\t\t]]></"+xmlName+">");
			}
			return <{xmlName}/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			initByStr(xml.toString(),_initByXMLOptions);
		}
		
		public function toStr(_toXMLOptions:Object):String{
			
			if(codeArr&&codeArr.length){
				
				var labelId:int=-1;
				var labelIdDict:Dictionary=new Dictionary();
				for each(var code:Object in codeArr){
					if(code.op>-1){
					}else{
						//label
						labelIdDict[code]=++labelId;
					}
				}
				
				var str:String="";
				
				for each(code in codeArr){
					if(code.ownData&&code.pos>-1&&code.dataLen>0){
						if(_toXMLOptions&&_toXMLOptions.ActionsOutputPos){
							str+="\t\t\t\t\t//pos="+code.pos+"\n";
						}
						if(code.info){
							str+=code.info.replace(/(.+)/g,"\t\t\t\t\t//$1");
						}
						//str+="\t\t\t\t\t"+BytesAndStr16.bytes2str16(code.ownData,code.pos,code.dataLen)+"\n";//个别很长的数据会引起代码块过大
					}else if(code.op>-1){
						if(AVM1Ops.nameV[code.op]){
							if(_toXMLOptions&&_toXMLOptions.ActionsOutputPos){
								if(code.pos>-1){
									str+="\t\t\t\t\t//pos="+code.pos+"\n";
								}else{
									str+="\t\t\t\t\t//（无 pos）\n";
								}
							}
							if(code.info){
								str+=code.info.replace(/(.+)/g,"\t\t\t\t\t//$1");
							}
							if(_toXMLOptions&&_toXMLOptions.ActionsGetHexArr){
								if(code.ownData&&code.pos>-1){
									str+="\t\t\t\t\t//"+BytesAndStr16.bytes2str16(code.ownData,code.pos,code.op<0x80?1:3+code.Length)+"\n";
								}else{
									str+="\t\t\t\t\t//（无 hex）\n";
								}
							}
							
							str+="\t\t\t\t\t"+AVM1Ops.nameV[code.op];
							switch(code.op){
								case AVM1Ops.call://0x9e	//
									//
								break;
								case AVM1Ops.storeRegister://0x87	//UI8
									str+=" registerid="+code.registerid;
								break;
								case AVM1Ops.gotoFrame://0x81	//UI16
									str+=" frameid="+code.frameid;
								break;
								case AVM1Ops.gotoFrame2://0x9f	//UB[8],UI16
									str+=(code.scenebias>-1?" scenebias="+code.scenebias:"")+" play="+code.play;
								break;
								case AVM1Ops.setTarget://0x8b	//STRING
									str+=" targetname=\""+stringComplexString.escape(code.targetname)+"\"";
								break;
								case AVM1Ops.gotoLabel://0x8c	//STRING
									str+=" labelname=\""+stringComplexString.escape(code.labelname)+"\"";
								break;
								case AVM1Ops.waitForFrame://0x8a	//UI16,UI8(label)
									if(labelIdDict[code.end]>-1){
									}else{
										outputCodeError("找不到 code.end 对应的位置");
									}
									str+=" frameid="+code.frameid+" end=label"+labelIdDict[code.end];
								break;
								case AVM1Ops.waitForFrame2://0x8d	//UI8(label)
									if(labelIdDict[code.end]>-1){
									}else{
										outputCodeError("找不到 code.end 对应的位置");
									}
									str+=" end=label"+labelIdDict[code.end];
								break;
								case AVM1Ops.with_://0x94	//UI16(label)
									if(labelIdDict[code.end]>-1){
									}else{
										outputCodeError("找不到 code.end 对应的位置");
									}
									str+=" end=label"+labelIdDict[code.end];
								break;
								case AVM1Ops.jump://0x99	//SI16(label)
								case AVM1Ops.if_://0x9d		//SI16(label)
									if(labelIdDict[code.label]>-1){
									}else{
										///*//临时分析时可以直接注掉，将会输出：jump/if_ labelundefined
										outputCodeError("找不到 code.label 对应的位置");
										//*/output("找不到 code.label 对应的位置","brown");
									}
									str+=" label"+labelIdDict[code.label];
								break;
								case AVM1Ops.getURL://0x83	//STRING,STRING
									str+=" urlstring=\""+stringComplexString.escape(code.urlstring)+"\" targetstring=\""+stringComplexString.escape(code.targetstring)+"\"";
								break;
								case AVM1Ops.getURL2://0x9a	//UB[8]
									if(code.loadvariables){
										if(code.loadtarget){
											str+=" LOAD_VARIABLES";
										}else{
											str+=" LOAD_VARIABLES_NUM";
										}
									}else{
										if(code.loadtarget){
											str+=" LOAD_MOVIE";
										}else{
											str+=" GET_URL";
										}
									}
									switch(code.sendvarsmethod){
										case 1:
											str+=" GET";
										break;
										case 2:
											str+=" POST";
										break;
										default://0 或 3
											//
										break;
									}
								break;
								case AVM1Ops.constantPool://0x88	//UI16,STRING[Count]
									var subStr:String="";
									for each(var pushValue:* in code.constStrV){
										subStr+=",\""+stringComplexString.escape(pushValue)+"\"";
									}
									str+=" "+subStr.substr(1);
								break;
								case AVM1Ops.push://0x96	//(UI8,STRING|FLOAT|UI8|DOUBLE|UI32|UI16)s
									subStr="";
									for each(pushValue in code.pushValueV){
										if(pushValue){
											switch(pushValue.constructor){
												case String:
													subStr+=",\""+stringComplexString.escape(pushValue)+"\"";
												break;
												case Object:
													if(pushValue.r>-1){
														subStr+=",r:"+pushValue.r;
													}else if(pushValue.c>-1){
														subStr+=",c:"+pushValue.c;
													}else{
														outputCodeError("不支持的 pushValue："+pushValue);
													}
												break;
												case Number:
												case Boolean:
													subStr+=","+pushValue;
												break;
												default:
													outputCodeError("不支持的 pushValue："+pushValue);
												break;
											}
										}else{
											if(pushValue===""){
												subStr+=",\"\"";
											}else{
												subStr+=","+pushValue;
											}
										}
									}
									str+=" "+subStr.substr(1);
								break;
								case AVM1Ops.try_://0x8f	//UB[8],UI16,UI16,UI16,STRING|UI8,UI8[TrySize],UI8[CatchSize],UI8[FinallySize]
									if(code.catchregisterid>-1){
										str+=" catchregisterid="+code.catchregisterid;
									}else{
										str+=" catchname=\""+stringComplexString.escape(code.catchname)+"\"";
									}
									if(labelIdDict[code.tryEnd]>-1){
									}else{
										outputCodeError("找不到 code.tryEnd 对应的位置");
									}
									str+=" tryEnd=label"+labelIdDict[code.tryEnd];
									if(code.catchEnd){
										if(labelIdDict[code.catchEnd]>-1){
										}else{
											outputCodeError("找不到 code.catchEnd 对应的位置");
										}
										str+=" catchEnd=label"+labelIdDict[code.catchEnd];
									}
									if(code.finallyEnd){
										if(labelIdDict[code.finallyEnd]>-1){
										}else{
											outputCodeError("找不到 code.finallyEnd 对应的位置");
										}
										str+=" finallyEnd=label"+labelIdDict[code.finallyEnd];
									}
								break;
								case AVM1Ops.defineFunction://0x9b	//STRING,UI16,STRING[NumParams],UI16(label)
									str+=" functionname=\""+stringComplexString.escape(code.functionname)+"\"";
									if(code.paramNameV){
										if(code.paramNameV.length){
											subStr="";
											for each(var paramName:String in code.paramNameV){
												subStr+=",\""+stringComplexString.escape(paramName)+"\"";
											}
											str+=" paramNameV=["+subStr.substr(1)+"]";
										}
									}
									if(labelIdDict[code.end]>-1){
									}else{
										outputCodeError("找不到 code.end 对应的位置");
									}
									str+=" end=label"+labelIdDict[code.end];
								break;
								case AVM1Ops.defineFunction2://0x8e	//STRING,UI16,UI8,UB[8],UB[8],(UI8,STRING)[NumParams],UI16(label)
									str+=" functionname=\""+stringComplexString.escape(code.functionname)+"\" registercount="+code.registercount;
									subStr="";
									if(code.preloadparent){
										subStr+="|PRELOAD_PARENT";
									}
									if(code.preloadroot){
										subStr+="|PRELOAD_ROOT";
									}
									if(code.suppresssuper){
										subStr+="|SUPPRESS_SUPER";
									}
									if(code.preloadsuper){
										subStr+="|PRELOAD_SUPER";
									}
									if(code.suppressarguments){
										subStr+="|SUPPRESS_ARGUMENTS";
									}
									if(code.preloadarguments){
										subStr+="|PRELOAD_ARGUMENTS";
									}
									if(code.suppressthis){
										subStr+="|SUPPRESS_THIS";
									}
									if(code.preloadthis){
										subStr+="|PRELOAD_THIS";
									}
									if(code.preloadglobal){
										subStr+=",PRELOAD_GLOBAL";
									}
									if(subStr){
										str+=" flags=["+subStr.substr(1)+"]";
									}
									if(code.parameterArr){
										if(code.parameterArr.length){
											subStr="";
											for each(var parameter:Object in code.parameterArr){
												subStr+=",r:"+parameter.registerid+" \""+stringComplexString.escape(parameter.name)+"\"";
											}
											str+=" parameterArr=["+subStr.substr(1)+"]";
										}
									}
									if(labelIdDict[code.end]>-1){
									}else{
										outputCodeError("找不到 code.end 对应的位置");
									}
									str+=" end=label"+labelIdDict[code.end];
								break;
								//default:
								//	//
								//break;
							}//end of switch(code.op)...
							str+="\n";
							
						}else{
							outputCodeError("未知 op 0x"+BytesAndStr16._16V[code.op]);
						}//end of if(AVM1Ops.nameV[code.op])...else...
						
					}else{
						//label
						str+="\t\t\t\tlabel"+labelIdDict[code]+":\n";
					}//end of if(code.ownData&&code.pos>-1&&code.dataLen>0)...else if(code.op>-1)...else...
					
				}//end of for each(code in codeArr)...
				
				return str;
			}
			
			return "";
			
		}
		public function initByStr(str:String,_initByXMLOptions:Object):void{
			
			str=("\n"+str)
				.replace(/\s*\n\s*\/\/.*/g,"")
				.replace(/^\s*|\s*$/g,"");
			
			if(str){
				
				var codeStrArr:Array=str.split(/\s*\n\s*/);
				
				var labels:Object=new Object();
				for each(var codeStr:String in codeStrArr){
					execResult=/^(label\d+)\:/.exec(codeStr);
					if(execResult){
						if(labels[execResult[1]]){
							outputCodeError(codeStr+"，重复的 label");
						}else{
							labels[execResult[1]]={};
						}
					}
				}
				
				var codeId:int=-1;
				codeArr=new Array();
				for each(codeStr in codeStrArr){
					var execResult:Array=/^(\w+)([\s\S]*)$/.exec(codeStr);
					if(execResult){
						codeId++;
						
						var code:Object={op:AVM1Ops[execResult[1]]};
						if(code.op>-1){
							var codeStr2:String=execResult[2].replace(/^\s*|\s*$/g,"");
							switch(code.op){
								case AVM1Ops.call://0x9e	//
									if(codeStr2){
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，"+AVM1Ops.nameV[code.op]+" 不需要参数");
									}
								break;
								case AVM1Ops.storeRegister://0x87	//UI8
									execResult=/^(registerid=)?(\w+)$/.exec(codeStr2);
									if(execResult){
										code.registerid=int(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“storeRegister registerid=1”）");
									}
								break;
								case AVM1Ops.gotoFrame://0x81	//UI16
									execResult=/^(frameid=)?(\w+)$/.exec(codeStr2);
									if(execResult){
										code.frameid=int(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“gotoFrame frameid=0”）");
									}
								break;
								case AVM1Ops.gotoFrame2://0x9f	//UB[8],UI16
									execResult=/^(scenebias=)?(\w+)\s+(play=)?(true|false)$/.exec(codeStr2);
									if(execResult){
										code.scenebias=int(execResult[2]);
										code.play=(execResult[4]=="true");
									}else{
										execResult=/^(play=)?(true|false)$/.exec(codeStr2);
										if(execResult){
											code.play=(execResult[2]=="true");
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“gotoFrame2 scenebias=3 play=true”）");
										}
									}
								break;
								case AVM1Ops.setTarget://0x8b	//STRING
									execResult=/("|')([\s\S]*)\1$/.exec(codeStr2);
									if(execResult){
										code.targetname=stringComplexString.unescape(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“setTarget \"mc\"”）");
									}
								break;
								case AVM1Ops.gotoLabel://0x8c	//STRING
									execResult=/("|')([\s\S]*)\1$/.exec(codeStr2);
									if(execResult){
										code.labelname=stringComplexString.unescape(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“gotoLabel \"f\"”）");
									}
								break;
								case AVM1Ops.waitForFrame://0x8a	//UI16,UI8(label)
									execResult=/^(frameid=)?(\w+)\s+(end=)?(label\d+)$/.exec(codeStr2);
									if(execResult){
										if(labels[execResult[4]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[4]+" 对应的位置");
										}
										code.frameid=int(execResult[2]);
										code.end=labels[execResult[4]];
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“waitForFrame frameid=3 end=label0”）");
									}
								break;
								case AVM1Ops.waitForFrame2://0x8d	//UI8(label)
									execResult=/^(end=)?(label\d+)$/.exec(codeStr2);
									if(execResult){
										if(labels[execResult[2]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[2]+" 对应的位置");
										}
										code.end=labels[execResult[2]];
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“waitForFrame2 end=label0”）");
									}
								break;
								case AVM1Ops.with_://0x94	//UI16(label)
									execResult=/^(end=)?(label\d+)$/.exec(codeStr2);
									if(execResult){
										if(labels[execResult[2]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[2]+" 对应的位置");
										}
										code.end=labels[execResult[2]];
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“with_ end=label0”）");
									}
								break;
								case AVM1Ops.jump://0x99	//SI16(label)
								case AVM1Ops.if_://0x9d		//SI16(label)
									if(/^label\d+$/.test(codeStr2)){
										if(labels[codeStr2]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+codeStr2+" 对应的位置");
										}
										code.label=labels[codeStr2];
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM1Ops.nameV[code.op]+" label0”）");
									}
								break;
								case AVM1Ops.getURL://0x83	//STRING,STRING
									execResult=/^(urlstring=)?("|')([\s\S]*)\2\s+(targetstring=)?("|')([\s\S]*)\5$/.exec(codeStr2.replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27"));
									if(execResult){
										code.urlstring=stringComplexString.unescape(execResult[3]);
										code.targetstring=stringComplexString.unescape(execResult[6]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“getURL urlstring=\"http://zero.flashwing.net\" targetstring=\"_blank\"”）");
									}
								break;
								case AVM1Ops.getURL2://0x9a	//UB[8]
									execResult=/^(GET_URL|LOAD_MOVIE|LOAD_VARIABLES_NUM|LOAD_VARIABLES)\s*(GET|POST)?$/.exec(codeStr2);
									if(execResult){
										switch(execResult[1]){
											case "GET_URL":
												code.loadvariables=false;
												code.loadtarget=false;
											break;
											case "LOAD_MOVIE":
												code.loadvariables=false;
												code.loadtarget=true;
											break;
											case "LOAD_VARIABLES_NUM":
												code.loadvariables=true;
												code.loadtarget=false;
											break;
											case "LOAD_VARIABLES":
												code.loadvariables=true;
												code.loadtarget=true;
											break;
											default:
												outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“getURL2 LOAD_VARIABLES POST”）");
											break;
										}
										switch(execResult[2]){
											case "GET":
												code.sendvarsmethod=1;
											break;
											case "POST":
												code.sendvarsmethod=2;
											break;
											default:
												code.sendvarsmethod=0;//0 或 3
											break;
										}
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“getURL2 LOAD_VARIABLES POST”）");
									}
								break;
								case AVM1Ops.constantPool://0x88	//UI16,STRING[Count]
									execResult=codeStr2.replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27").match(/("|')[\s\S]*?\1/g);
									if(execResult){
										var i:int=-1;
										var constStrV:Vector.<String>=new Vector.<String>();
										for each(var subStr:String in execResult){
											i++;
											constStrV[i]=stringComplexString.unescape(subStr.substr(1,subStr.length-2));
										}
										code.constStrV=constStrV;
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“constantPool \"a\",\"b\",\"c\"”）");
									}
								break;
								case AVM1Ops.push://0x96	//(UI8,STRING|FLOAT|UI8|DOUBLE|UI32|UI16)s
									execResult=(codeStr2.replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27")+",").match(/("|')[\s\S]*?\1,|[^,]*?,/g);
									if(execResult){
										i=-1;
										var pushValueV:Array=new Array();
										for each(subStr in execResult){
											i++;
											codeStr=subStr.replace(/^\s*|,\s*$/g,"");
											switch(codeStr){
												case "null":
													pushValueV[i]=null;
												break;
												case "undefined":
													pushValueV[i]=undefined;
												break;
												case "true":
													pushValueV[i]=true;
												break;
												case "false":
													pushValueV[i]=false;
												break;
												default:
													if(/^("|')[\s\S]*\1$/.test(codeStr)){
														pushValueV[i]=stringComplexString.unescape(codeStr.substr(1,codeStr.length-2));
													}else if(codeStr.indexOf("r:")==0){
														pushValueV[i]={r:int(codeStr.substr(2))};
													}else if(codeStr.indexOf("c:")==0){
														pushValueV[i]={c:int(codeStr.substr(2))};
													}else{
														pushValueV[i]=Number(codeStr);
													}
												break;
											}
										}
										code.pushValueV=pushValueV;
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“push \"a\",\"b\",\"c\",1,2,3.14,true,false,null,undefined,Infinity,-Infinity,NaN,r:1,c:1”）");
									}
								break;
								case AVM1Ops.try_://0x8f	//UB[8],UI16,UI16,UI16,STRING|UI8,UI8[TrySize],UI8[CatchSize],UI8[FinallySize]
									execResult=/^([\s\S]*?)\s+(tryEnd=)?(label\d+)([\s\S]*?)$/.exec(codeStr2);
									if(execResult){
										var execResult2:Array=/^(catchname=)?("|')([\s\S]*)\2$/.exec(execResult[1]);
										if(execResult2){
											code.catchname=stringComplexString.unescape(execResult2[3]);
										}else{
											execResult2=/^(catchregisterid=)?(\w+)$/.exec(execResult[1]);
											if(execResult2){
												code.catchregisterid=int(execResult2[2]);
											}else{
												outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“try_ catchname=\"e\" tryEnd=label0 catchEnd=label1 finallyEnd=label2”）");
											}
										}
										if(labels[execResult[3]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[3]+" 对应的位置");
										}
										code.tryEnd=labels[execResult[3]];
										for each(codeStr2 in execResult[4].match(/catchEnd=label\d+|finallyEnd=label\d+/g)){
											execResult=codeStr2.split("=");
											if(labels[execResult[1]]){
											}else{
												outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[1]+" 对应的位置");
											}
											code[execResult[0]]=labels[execResult[1]];
										}
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“try_ catchname=\"e\" tryEnd=label0 catchEnd=label1 finallyEnd=label2”）");
									}
								break;
								case AVM1Ops.defineFunction://0x9b	//STRING,UI16,STRING[NumParams],UI16(label)
									execResult=/^functionname=("|')([\s\S]*?)\1(\s+paramNameV=\[[\s\S]*?\])?\s+end=(label\d+)$/.exec(codeStr2);
									if(execResult){
										if(labels[execResult[4]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[4]+" 对应的位置");
										}
										code.functionname=stringComplexString.unescape(execResult[2]);
										code.end=labels[execResult[4]];
										if(execResult[3]){
											i=-1;
											code.paramNameV=new Vector.<String>();
											for each(var paramStr:String in execResult[3].replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27").match(/("|')[\s\S]*?\1/g)){
												i++;
												code.paramNameV[i]=stringComplexString.unescape(paramStr.substr(1,paramStr.length-2));
											}
										}
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“defineFunction functionname=\"fun\" paramNameV=[\"a\",\"b\",\"c\"] end=label0”）");
									}
								break;
								case AVM1Ops.defineFunction2://0x8e	//STRING,UI16,UI8,UB[8],UB[8],(UI8,STRING)[NumParams],UI16(label)
									execResult=/^functionname=("|')([\s\S]*?)\1\s+registercount=(\w+)(\s+flags=\[[\s\S]*?\])?(\s+parameterArr=\[[\s\S]*?\])?\s+end=(label\d+)$/.exec(codeStr2);
									if(execResult){
										if(labels[execResult[6]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[6]+" 对应的位置");
										}
										code.functionname=stringComplexString.unescape(execResult[2]);
										code.registercount=int(execResult[3]);
										code.end=labels[execResult[6]];
										if(execResult[4]){
											for each(var Flag:String in execResult[4].match(/[A-Z_]+/g)){
												switch(Flag){
													case "PRELOAD_PARENT":
														code.preloadparent=true;
													break;
													case "PRELOAD_ROOT":
														code.preloadroot=true;
													break;
													case "SUPPRESS_SUPER":
														code.suppresssuper=true;
													break;
													case "PRELOAD_SUPER":
														code.preloadsuper=true;
													break;
													case "SUPPRESS_ARGUMENTS":
														code.suppressarguments=true;
													break;
													case "PRELOAD_ARGUMENTS":
														code.preloadarguments=true;
													break;
													case "SUPPRESS_THIS":
														code.suppressthis=true;
													break;
													case "PRELOAD_THIS":
														code.preloadthis=true;
													break;
													case "PRELOAD_GLOBAL":
														code.preloadglobal=true;
													break;
													default:
														outputCodeError("codeArr["+codeId+"] "+codeStr+"，Flag="+Flag);
													break;
												}
											}
										}
										if(execResult[5]){
											i=-1;
											code.parameterArr=new Array();
											for each(paramStr in execResult[5].replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27").match(/r\:\w+\s+("|')[\s\S]*?\1/g)){
												i++;
												execResult=/r\:(\w+)\s+("|')([\s\S]*?)\2/.exec(paramStr);
												code.parameterArr[i]={registerid:int(execResult[1]),name:stringComplexString.unescape(execResult[3])};
											}
										}
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“defineFunction2 functionname=\"fun\" registercount=5 flags=[PRELOAD_THIS,PRELOAD_GLOBAL] parameterArr=[r:1 \"a\",r:2 \"b\",r:3 \"c\"] end=label0”）");
									}
								break;
								default:
									if(codeStr2){
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，code.op="+code.op+"<0x80，不需要参数");
									}
								break;
							}//end of switch(code.op)...
							
						}else{
							execResult=/^(label\d+)\:/.exec(codeStr);
							if(execResult){
								code=labels[execResult[1]];
							}else{
								if(/^([0-9a-fA-F]{2}\s+)+$/.test(codeStr+" ")){
									output("使用 ByteArray 进行记录的未知代码："+codeStr,"brown");
									code={ownData:BytesAndStr16.str162bytes(codeStr),pos:0};
									code.op=code.ownData[0];
									code.dataLen=code.ownData.length;
								}else{
									if(/^(label\d+)$/.test(codeStr)){
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，貌似缺少“:”（应该为：“"+codeStr+":”）");
									}else{
										switch(codeStr){
											case "dup":
												outputCodeError("codeArr["+codeId+"] "+codeStr+"，不支持的 op，请改用“pushDuplicate”");
											break;
											case "swap":
												outputCodeError("codeArr["+codeId+"] "+codeStr+"，不支持的 op，请改用“stackSwap”");
											break;
											case "mod":
												outputCodeError("codeArr["+codeId+"] "+codeStr+"，不支持的 op，请改用“modulo”");
											break;
											default:
												outputCodeError("codeArr["+codeId+"] "+codeStr+"，未知 op");
											break;
										}
									}
								}
							}
						}//end of if(code.op>-1)...else...
						
						codeArr[codeId]=code;
					}else{
						codeId++;
						outputCodeError("codeArr["+codeId+"] "+codeStr+"，未知  code");
					}//end of if(execResult)...else...
					
				}//end of for each(codeStr in codeStrArr)...
			}else{
				codeArr=null;
			}
		}
		
		private static function outputCodeError(msg:String):void{
			throw new Error(msg);
		}
		
		public static function test20130419():void{
			
			var codeStr2:String="',',','";
			trace("codeStr2="+codeStr2);
			
			trace("constantPool");
			var execResult:Array=codeStr2.replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27").match(/("|')[\s\S]*?\1/g);
			for each(var subStr:String in execResult){
				trace(subStr.substr(1,subStr.length-2));
			}
			
			trace("push");
			execResult=(codeStr2.replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27")+",").match(/("|')[\s\S]*?\1,|[^,]*?,/g);
			for each(subStr in execResult){
				trace(subStr.substr(1,subStr.length-3));
			}

		}
		
	}
}
