/***
AGAL2Program
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月11日 20:46:50
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds{
	
	import flash.display3D.Context3DProgramType;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public function AGAL2Program(mode:String,source:String,info:Object=null):ByteArray{
		
		source=("\n"+source)
			.replace(/\/\*[\s\S]*?\*\//g,"")
			.replace(/\s*\n\s*/g,"\n")
			.replace(/\n\/\/.*/g,"")
			.replace(/\/\/.*\n/g,"\n")
			.replace(/^\s*|\s*$/g,"")
			.replace(/\s*\n\s*/g,"\n");
		for each(var matchStr:String in source.match(/\.[rgba]+/g)){
			source=source.replace(matchStr,matchStr.replace(/r/g,"x").replace(/g/g,"y").replace(/b/g,"z").replace(/a/g,"w"));
		}
		
		//trace(source);
		
		/*
		//1
		import com.adobe.utils.AGALMiniAssembler;
		//import com.adobe.utils.extended.AGALMiniAssembler;
		var agalMiniAssembler:AGALMiniAssembler=new AGALMiniAssembler();
		agalMiniAssembler.assemble(mode,source);
		var data:ByteArray=agalMiniAssembler.agalcode;
		import zero.BytesAndStr16;
		//trace("public static const byteV:Vector.<int>=new <int>[0x"+BytesAndStr16.bytes2str16(data,0,data.length).replace(/ /g,",0x")+"];");
		trace("0x"+BytesAndStr16.bytes2str16(data,0,data.length).replace(/ /g,",0x"));
		//*/
		
		///*
		//2
		var data:ByteArray=new ByteArray();
		data.endian=Endian.LITTLE_ENDIAN;
		
		//magic 必须为 0xa0
		data[0]=0xa0;
		
		//version 必须为 1
		data[1]=0x01;
		data[2]=0x00;
		data[3]=0x00;
		data[4]=0x00;
		
		//shader type ID 必须为 0xa1
		data[5]=0xa1;
		
		//shader type 0 表示顶点程序；1 表示片段程序
		switch(mode){
			case Context3DProgramType.VERTEX:
				data[6]=0x00;
			break;
			case Context3DProgramType.FRAGMENT:
				data[6]=0x01;
			break;
			default:
				throw new Error("不合法的 mode："+mode);
			break;
		}
		
		if(info){
			import zero.BytesAndStr16;
			info.info="\n			0x"+BytesAndStr16.bytes2str16(data,0,7).replace(/ /g,",0x")+",\n			\n";
		}
		
		var offset:int=7;
		for each(var line:String in source.split("\n")){
			var execResult:Array=/(\w{3})\s*(.*)/.exec(line);
			if(execResult){
				
				var opcode:int=opcodes[execResult[1]];
				if(info){
					var comment:String="			//"+execResult[1];
				}
				data[offset++]=opcode;
				data[offset++]=opcode>>8;
				data[offset++]=opcode>>16;
				data[offset++]=opcode>>24;
				
				var paramArr:Array=execResult[2].replace(/\s+/g,"").match(/\w+<[^<>]+>|[^,]+/g);
				
				var destination:Array=/^([a-z]+)(\d*)(\.[xyzw]+)?$/.exec(paramArr[0]);
				var destinationType:String=destination[1];
				var accessor0:Array=destination[3]?destination[3].substr(1).split(""):xyzwArr;
				//while(accessor0.length<4){
				//	accessor0[accessor0.length]=accessor0[accessor0.length-1];
				//}
				var destCMark:Object=new Object();
				var destinationMMMM:int=0;
				var i:int=-1;
				for each(c in accessor0){
					i++;
					destinationMMMM|=MMMM[c];
					destCMark[c]=i;
				}
				//trace("destCIdArr="+destCIdArr);
				accessor0=new Array();
				for(i=0;i<4;i++){
					if(destinationMMMM&(1<<i)){
						accessor0.push(xyzwArr[i]);
					}
				}
				var destinationNum:int=int(destination[2]);
				//trace(destinationType,destinationNum,accessor0);
				if(info){
					comment+=" "+destinationType+destination[2]+"."+accessor0.join("");
				}
				
				//Destination 字段格式
				//[destination] 字段的大小为 32 位：
				//	31.............................0 
				//	----TTTT----MMMMNNNNNNNNNNNNNNNN
				//T = 寄存器类型（4 位）
				//M = 写入掩码（4 位）
				//N = 寄存器编号（16 位）
				//- = 未定义，必须为 0
				data[offset++]=destinationNum;//NNNNNNNN
				data[offset++]=destinationNum>>8;//NNNNNNNN
				data[offset++]=destinationMMMM;//----MMMM
				data[offset++]=TTTT[destinationType];//----TTTT
				
				var source1:Array=/^([a-z]+)(\d*)(\.[xyzw]+)?$/.exec(paramArr[1]);
				var sourceType:String=source1[1];
				var _accessor1:Array=source1[3]?source1[3].substr(1).split(""):xyzwArr;
				while(_accessor1.length<4){
					_accessor1[_accessor1.length]=_accessor1[_accessor1.length-1];
				}
				i=-1;
				var accessor1:Array=new Array();
				for each(c in accessor0){
					i++;
					accessor1[i]=_accessor1[destCMark[c]];
				}
				var sourceNum:int=int(source1[2]);
				//trace(sourceType,sourceNum,accessor1);
				if(info){
					comment+=","+sourceType+source1[2]+"."+accessor1.join("");
				}
				
				//Source 字段格式
				//[source] 字段的大小为 64 位：
				//	63.............................................................0 
				//	D-------------QQ----IIII----TTTTSSSSSSSSOOOOOOOONNNNNNNNNNNNNNNN
				//D = Direct=0/Indirect=1 表示直接使用 Q 并忽略 I，1 位
				//Q = 索引寄存器组件选择（2 位）
				//I = 索引寄存器类型（4 位）
				//T = 寄存器类型（4 位）
				//S = 重排（8 位，每个组件 2 位）
				//O = 间接偏移量（8 位）
				//N = 寄存器编号（16 位）
				//- = 未定义，必须为 0
				data[offset++]=sourceNum;//NNNNNNNN
				data[offset++]=sourceNum>>8;//NNNNNNNN
				data[offset++]=0x00;//OOOOOOOO
				i=-1;
				var SSSSSSSS:int=0;
				for each(var c:String in accessor1){
					i++;
					SSSSSSSS|=(SS[c]<<(i<<1));
				}
				data[offset++]=SSSSSSSS;//SSSSSSSS
				data[offset++]=TTTT[sourceType];//----TTTT
				data[offset++]=0x00;//----IIII
				data[offset++]=0x00;//------QQ
				data[offset++]=0x00;//D-------
				
				if(opcode==opcodes["tex"]){
					var sampler:Array=/^([a-z]+)(\d*)<(.*)>$/.exec(paramArr[2]);
					var samplerType:String=sampler[1];
					var samplerNum:int=int(sampler[2]);
					var samplerFlagArr:Array=sampler[3].split(",");
					//trace(samplerType,samplerNum,samplerFlagArr);
					if(info){
						comment+=","+samplerType+samplerNum+"<"+samplerFlagArr.join(",")+">";
					}
					
					//Sampler 字段格式
					//tex opcode 的第二个源字段必须为 [sampler] 格式，大小为 64 位：
					//	63.............................................................0 
					//	FFFFMMMMWWWWSSSSDDDD--------TTTT--------BBBBBBBBNNNNNNNNNNNNNNNN
					//N = 取样器寄存器编号（16 位）
					//B = 纹理详细级别 (LOD) 偏差，带符号整数，以 8 为单位递增。使用的浮点值为 b/8.0（8 位）
					//T = 寄存器类型，必须为 5，Sampler（4 位）
					//F = 滤镜（0=nearest、1=linear）（4 位）
					//M = Mipmap（0=disable、1=nearest、2=linear）
					//W = 环绕（0=clamp、1=repeat）
					//S = 特殊标志位（必须为 0）
					//D = 维度（0=2D、1=Cube）
					data[offset++]=samplerNum;//NNNNNNNN
					data[offset++]=samplerNum>>8;//NNNNNNNN
					data[offset++]=0x00;//BBBBBBBB
					data[offset++]=0x00;//--------
					data[offset++]=TTTT[samplerType];//----TTTT
					var samplerFlags:int=0x00;
					for each(var samplerFlag:String in samplerFlagArr){
						samplerFlags|=samplerFlagss[samplerFlag];
					}
					data[offset++]=samplerFlags;//DDDD----
					data[offset++]=samplerFlags>>8;//WWWWSSSS
					data[offset++]=samplerFlags>>16;//FFFFMMMM
				}else{
					if(paramArr.length==3){
						var source2:Array=/^([a-z]+)(\d*)(\.[xyzw]+)?$/.exec(paramArr[2]);
						sourceType=source2[1];
						var _accessor2:Array=source2[3]?source2[3].substr(1).split(""):xyzwArr;
						while(_accessor2.length<4){
							_accessor2[_accessor2.length]=_accessor2[_accessor2.length-1];
						}
						i=-1;
						var accessor2:Array=new Array();
						for each(c in accessor0){
							i++;
							accessor2[i]=_accessor2[destCMark[c]];
						}
						sourceNum=int(source2[2]);
						//trace(sourceType,sourceNum,accessor2);
						if(info){
							comment+=","+sourceType+source2[2]+"."+accessor2.join("");
						}
						
						//Source 字段格式
						//[source] 字段的大小为 64 位：
						//	63.............................................................0 
						//	D-------------QQ----IIII----TTTTSSSSSSSSOOOOOOOONNNNNNNNNNNNNNNN
						//D = Direct=0/Indirect=1 表示直接使用 Q 并忽略 I，1 位
						//Q = 索引寄存器组件选择（2 位）
						//I = 索引寄存器类型（4 位）
						//T = 寄存器类型（4 位）
						//S = 重排（8 位，每个组件 2 位）
						//O = 间接偏移量（8 位）
						//N = 寄存器编号（16 位）
						//- = 未定义，必须为 0
						data[offset++]=sourceNum;//NNNNNNNN
						data[offset++]=sourceNum>>8;//NNNNNNNN
						data[offset++]=0x00;//OOOOOOOO
						i=-1;
						SSSSSSSS=0;
						for each(c in accessor2){
							i++;
							SSSSSSSS|=(SS[c]<<(i<<1));
						}
						data[offset++]=SSSSSSSS;//SSSSSSSS
						data[offset++]=TTTT[sourceType];//----TTTT
						data[offset++]=0x00;//----IIII
						data[offset++]=0x00;//------QQ
						data[offset++]=0x00;//D-------
					}else{
						data[offset++]=0x00;
						data[offset++]=0x00;
						data[offset++]=0x00;
						data[offset++]=0x00;
						data[offset++]=0x00;
						data[offset++]=0x00;
						data[offset++]=0x00;
						data[offset++]=0x00;
					}
				}
				
				if(info){
					import zero.BytesAndStr16;
					info.info+=
						comment+"\n"+
						"			"+("0x"+BytesAndStr16.bytes2str16(data,offset-24,24).replace(/ /g,",0x")).replace(/((?:0x..,){4})((?:0x..,){4})((?:0x..,){8})/,"$1 $2 $3 ")+",\n			\n";
				}
			}
		}
		if(info){
			info.info=info.info.replace(/,\s*$/,"\n		");
			//trace(info.info);
		}
		//trace("=================================");
		
		//import zero.BytesAndStr16;
		//trace("public static const byteV:Vector.<int>=new <int>[0x"+BytesAndStr16.bytes2str16(data,0,data.length).replace(/ /g,",0x")+"];");
		//trace("0x"+BytesAndStr16.bytes2str16(data,0,data.length).replace(/ /g,",0x"));
		//*/
		
		return data;
	}
}

const opcodes:Object={
	mov:0x00,
	add:0x01,
	sub:0x02,
	mul:0x03,
	div:0x04,
	rcp:0x05,
	min:0x06,
	max:0x07,
	frc:0x08,
	sqt:0x09,
	rsq:0x0a,
	pow:0x0b,
	log:0x0c,
	exp:0x0d,
	nrm:0x0e,
	sin:0x0f,
	cos:0x10,
	crs:0x11,
	dp3:0x12,
	dp4:0x13,
	abs:0x14,
	neg:0x15,
	sat:0x16,
	m33:0x17,
	m44:0x18,
	m34:0x19,
	kil:0x27,
	tex:0x28,
	sge:0x29,
	slt:0x2a,
	seq:0x2c,
	sne:0x2d
}
	
const TTTT:Object={
	
	//属性 0 顶点着色器输入；从使用 Context3D.setVertexBufferAt() 指定的顶点缓冲区读取。
	va:0,
	
	//常数 着色器输入；使用 Context3D.setProgramConstants() 系列函数设置。
	vc:1,
	fc:1,
	
	//临时 用于计算的临时寄存器，无法从程序外部访问。
	vt:2,
	ft:2,
	
	//输出 着色器输出：在顶点程序中，输出的是剪辑空间位置；在片段程序中，输出的是颜色。
	op:3,
	oc:3,
	
	//渐变 在顶点着色器和片段着色器之间传递插补数据。将顶点程序的渐变寄存器用作片段程序的输入。根据与三角形顶点的距离插补计算所需的值。
	v:4,
	
	//取样器 片段着色器输入；从使用 Context3D.setTextureAt() 指定的纹理读取。
	fs:5
	
}

const xyzwArr:Array=["x","y","z","w"];

const SS:Object={
	x:0x00,
	y:0x01,
	z:0x02,
	w:0x03
}

const MMMM:Object={
	x:0x01,
	y:0x02,
	z:0x04,
	w:0x08
}

const samplerFlagss:Object={}
samplerFlagss["2d"]=				0x000000;
samplerFlagss["3d"]=				0x000020;
samplerFlagss["cube"]=				0x000010;

samplerFlagss["rgba"]=				0x000000;
samplerFlagss["dxt1"]=				0x000001;
samplerFlagss["dxt5"]=				0x000002;
samplerFlagss["video"]=			0x000003;

samplerFlagss["clamp"]=			0x000000;
samplerFlagss["wrap"]=				0x001000;
samplerFlagss["repeat"]=			0x001000;

samplerFlagss["centroid"]=			0x000100;
samplerFlagss["single"]=			0x000200;
samplerFlagss["ignoresampler"]=	0x000400;

samplerFlagss["nomip"]=			0x000000;
samplerFlagss["mipnone"]=			0x000000;
samplerFlagss["mipnearest"]=		0x010000;
samplerFlagss["miplinear"]=		0x020000;

samplerFlagss["nearest"]=			0x000000;
samplerFlagss["linear"]=			0x100000;
