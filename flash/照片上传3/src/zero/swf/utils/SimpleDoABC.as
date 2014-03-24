/***
SimpleDoABC 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月13日 21:36:05
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.utils{
	import zero.swf.Tag;
	import zero.swf.avm2.ABCClass;
	import zero.swf.avm2.ABCClasses;
	import zero.swf.avm2.ABCMethod;
	import zero.swf.avm2.ABCMultiname;
	import zero.swf.avm2.ABCNamespace;
	import zero.swf.avm2.ABCScript;
	import zero.swf.avm2.ABCTrait;
	import zero.swf.avm2.AVM2Codes;
	import zero.swf.avm2.AVM2Ops;
	import zero.swf.avm2.NamespaceKinds;
	import zero.swf.avm2.TraitTypeAndAttributes;
	import zero.swf.tagBodys.DoABC;
	
	public class SimpleDoABC{
		
		public static const BMD:String="bmd";
		public static const SND:String="snd";
		public static const SP:String="sp";
		public static const MC:String="mc";
		public static const DAT:String="dat";
		
		private static const classValues:Object={
			bmd:{
				//dynamic:false,
				args:true,
				max_stack:3,
				superCode:[
					//super(0,0);
					{op:AVM2Ops.pushbyte,byte:0},
					{op:AVM2Ops.dup},
					{op:AVM2Ops.constructsuper,arg_count:2}
				],initNameArr:[
					new ABCMultiname("Object"),
					new ABCMultiname("flash.display.BitmapData")
				]
			},snd:{
				//dynamic:false,
				//args:false,
				//max_stack:1,
				initNameArr:[
					new ABCMultiname("Object"),
					new ABCMultiname("flash.events.EventDispatcher"),
					new ABCMultiname("flash.media.Sound")
				]
			},sp:{
				dynamic:true,
				//args:false,
				//max_stack:1,
				initNameArr:[
					new ABCMultiname("Object"),
					new ABCMultiname("flash.events.EventDispatcher"),
					new ABCMultiname("flash.display.DisplayObject"),
					new ABCMultiname("flash.display.InteractiveObject"),
					new ABCMultiname("flash.display.DisplayObjectContainer"),
					new ABCMultiname("flash.display.Sprite")
				]
			},mc:{
				dynamic:true,
				//args:false,
				//max_stack:1,
				initNameArr:[
					new ABCMultiname("Object"),
					new ABCMultiname("flash.events.EventDispatcher"),
					new ABCMultiname("flash.display.DisplayObject"),
					new ABCMultiname("flash.display.InteractiveObject"),
					new ABCMultiname("flash.display.DisplayObjectContainer"),
					new ABCMultiname("flash.display.Sprite"),
					new ABCMultiname("flash.display.MovieClip")
				]
			},dat:{
				//dynamic:false,
				//args:false,
				//max_stack:1,
				initNameArr:[
					new ABCMultiname("Object"),
					new ABCMultiname("flash.utils.ByteArray")
				]
			}
		}
		
		
		/**
		 * 
		 * @param className 类名，例如："Bmd1"，"assets.Snd1"，"assets::Snd1"
		 * @param type 类型，例如：SimpleDoABC.BMD
		 * @param use72 是否使用 DoABCWithoutFlagsAndName
		 * @return doABCTag 或 doABCWithoutFlagsAndNameTag
		 * 
		 */		
		public static function getDoABCTag(className:String,type:String,swc:Boolean):Tag{
			
			var classValue:Object=classValues[type];
			
			var clazz:ABCClass=new ABCClass();
			clazz.name=new ABCMultiname(nameComplexString.escape(className));
			clazz.super_name=classValue.initNameArr[classValue.initNameArr.length-1];
			
			if(classValue.dynamic){
			}else{
				clazz.ClassSealed=true;
			}
			
			clazz.protectedNs=new ABCNamespace();
			clazz.protectedNs.kind=NamespaceKinds.ProtectedNamespace;
			if(clazz.name.ns.name){
				clazz.protectedNs.name=clazz.name.ns.name+":"+clazz.name.name;
			}else{
				clazz.protectedNs.name=clazz.name.name;
			}
			clazz.intrfV=new Vector.<ABCMultiname>();
			
			var script:ABCScript=new ABCScript();
			script.init=new ABCMethod();
			if(swc){
				script.init.name="";
			}
			script.init.param_typeV=new Vector.<ABCMultiname>();
			script.init.traitV=new Vector.<ABCTrait>();
			script.init.max_stack=2;
			script.init.local_count=1;
			script.init.init_scope_depth=1;
			script.init.max_scope_depth=script.init.init_scope_depth+classValue.initNameArr.length+1;
			script.init.codes=new AVM2Codes();
			script.init.codes.codeArr=[
				{op:AVM2Ops.getlocal0},
				{op:AVM2Ops.pushscope},
				{op:AVM2Ops.findpropstrict,multiname:clazz.name},
			];
			for each(var initName:ABCMultiname in classValue.initNameArr){
				script.init.codes.codeArr.push(
					{op:AVM2Ops.getlex,multiname:initName},
					{op:AVM2Ops.pushscope}
				);
			}
			script.init.codes.codeArr.push(
				{op:AVM2Ops.getlex,multiname:initName},
				{op:AVM2Ops.newclass,"class":clazz.name}
			);
			for each(initName in classValue.initNameArr){
				script.init.codes.codeArr.push(
					{op:AVM2Ops.popscope}
				);
			}
			script.init.codes.codeArr.push(
				{op:AVM2Ops.initproperty,multiname:clazz.name},
				{op:AVM2Ops.returnvoid}
			);
			var trait:ABCTrait=new ABCTrait();
			trait.name=clazz.name;
			trait.kind_trait_type=TraitTypeAndAttributes.Class_;
			trait.slot_id=1;
			trait.classi=clazz.name;
			script.traitV=new <ABCTrait>[trait];
			
			clazz.cinit=new ABCMethod();
			if(swc){
				clazz.cinit.name="";
			}
			clazz.cinit.param_typeV=new Vector.<ABCMultiname>();
			clazz.cinit.traitV=new Vector.<ABCTrait>();
			clazz.cinit.max_stack=1;
			clazz.cinit.local_count=1;
			clazz.cinit.init_scope_depth=script.init.max_scope_depth;
			clazz.cinit.max_scope_depth=clazz.cinit.init_scope_depth+1;
			clazz.cinit.codes=new AVM2Codes();
			clazz.cinit.codes.codeArr=[
				{op:AVM2Ops.getlocal0},
				{op:AVM2Ops.pushscope},
				{op:AVM2Ops.returnvoid}
			];
			
			clazz.iinit=new ABCMethod();
			if(swc){
				clazz.iinit.name="";
			}
			clazz.iinit.param_typeV=new Vector.<ABCMultiname>();
			clazz.iinit.traitV=new Vector.<ABCTrait>();
			if(classValue.max_stack>0){
				clazz.iinit.max_stack=classValue.max_stack;
			}else{
				clazz.iinit.max_stack=1;
			}
			if(classValue.args){
				clazz.iinit.NeedRest=true;
				clazz.iinit.local_count=2;
			}else{
				clazz.iinit.local_count=1;
			}
			clazz.iinit.init_scope_depth=clazz.cinit.max_scope_depth;
			clazz.iinit.max_scope_depth=clazz.iinit.init_scope_depth+1;
			clazz.iinit.codes=new AVM2Codes();
			clazz.iinit.codes.codeArr=[
				{op:AVM2Ops.getlocal0},
				{op:AVM2Ops.pushscope},
				{op:AVM2Ops.getlocal0}
			].concat(
				classValue.superCode
				||
				[{op:AVM2Ops.constructsuper,arg_count:0}]
			);
			clazz.iinit.codes.codeArr.push({op:AVM2Ops.returnvoid});
			
			clazz.itraitV=new Vector.<ABCTrait>();
			clazz.ctraitV=new Vector.<ABCTrait>();
			
			var ABCData:ABCClasses=new ABCClasses();
			ABCData.major_version=46;
			ABCData.minor_version=16;
			ABCData.classV=new <ABCClass>[clazz];
			ABCData.scriptV=new <ABCScript>[script];
			
			//trace(ABCData.toXML("ABCData",null));
			
			var tag:Tag=new Tag();
			//if(use72){
			//	var doABCWithoutFlagsAndName:DoABCWithoutFlagsAndName=new DoABCWithoutFlagsAndName();
			//	doABCWithoutFlagsAndName.ABCData=ABCData;
			//	tag.setBody(doABCWithoutFlagsAndName);
			//}else{
				var doABC:DoABC=new DoABC();
				doABC.Flags=1;
				//doABC.Name="";
				doABC.Name=swc?className.replace(/[\:\.]+/g,"/"):"";
				doABC.ABCData=ABCData;
				tag.setBody(doABC);
			//}
			return tag;
		}
		
		/*
		private static var classNameOffsetDict:Dictionary=new Dictionary();
		
		//ByteArray
		public static const datClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 06 00 09 42 79 74 65 41 72 72 61 79 0a 43 6c 61 73 73 31 32 33 34 35 06 4f 62 6a 65 63 74 0b 66 6c 61 73 68 2e 75 74 69 6c 73 04 18 03 16 01 16 05 00 04 07 02 03 07 03 02 07 02 04 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 0a 0b 06 d0 30 d0 49 00 47 00 00 01 01 01 09 0a 03 d0 30 47 00 00 02 02 01 01 04 13 d0 30 65 00 60 03 30 60 02 30 60 02 58 00 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/ByteArray/Class12345_compilation.swf
		
		//BitmapData
		//public static const bmdClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 06 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0a 42 69 74 6d 61 70 44 61 74 61 06 4f 62 6a 65 63 74 04 16 01 16 03 18 02 00 04 07 01 02 07 02 04 07 01 05 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 03 00 01 00 00 00 01 02 01 01 04 01 00 03 00 01 01 04 05 03 d0 30 47 00 00 01 03 01 05 06 09 d0 30 d0 24 00 2a 49 02 47 00 00 02 02 01 01 04 13 d0 30 65 00 60 03 30 60 02 30 60 02 58 00 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/BitmapData/Class12345_compilation.swf
		
		//BitmapData (...args): 貌似不加 ...args 会引起部分位图填充出问题
		public static const bmdClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 06 00 0a 42 69 74 6d 61 70 44 61 74 61 0a 43 6c 61 73 73 31 32 33 34 35 06 4f 62 6a 65 63 74 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 04 18 03 16 01 16 05 00 04 07 02 03 07 03 02 07 02 04 03 00 00 00 04 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 03 02 05 06 09 d0 30 d0 24 00 2a 49 02 47 00 00 01 01 01 04 05 03 d0 30 47 00 00 02 02 01 01 04 13 d0 30 65 00 60 03 30 60 02 30 60 02 58 00 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/BitmapData/Class12345_compilation.swf
		
		//Shape (貌似失败了)
		//public static const shapeClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 09 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 06 4f 62 6a 65 63 74 05 53 68 61 70 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 07 16 08 00 06 07 02 02 07 03 06 07 02 05 07 04 04 07 03 03 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 0a 0b 06 d0 30 d0 49 00 47 00 00 01 01 01 09 0a 03 d0 30 47 00 00 02 02 01 01 07 1b d0 30 65 00 60 03 30 60 04 30 60 05 30 60 02 30 60 02 58 00 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/Shape/Class12345_compilation.swf
		
		//Sprite
		//public static const spClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 0b 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 16 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 43 6f 6e 74 61 69 6e 65 72 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 11 49 6e 74 65 72 61 63 74 69 76 65 4f 62 6a 65 63 74 06 4f 62 6a 65 63 74 06 53 70 72 69 74 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 09 16 0a 00 08 07 02 02 07 03 08 07 02 07 07 04 05 07 03 03 07 03 06 07 03 04 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 09 0a 06 d0 30 d0 49 00 47 00 00 01 01 01 08 09 03 d0 30 47 00 00 02 02 01 01 08 23 d0 30 65 00 60 03 30 60 04 30 60 05 30 60 06 30 60 07 30 60 02 30 60 02 58 00 1d 1d 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/Sprite/Class12345_compilation.swf
		
		//Sprite dynamic: 如果不加 dynamic 那么当此 sprite 里放有带实例名的元件时将出问题
		public static const spClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 0b 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 16 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 43 6f 6e 74 61 69 6e 65 72 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 11 49 6e 74 65 72 61 63 74 69 76 65 4f 62 6a 65 63 74 06 4f 62 6a 65 63 74 06 53 70 72 69 74 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 09 16 0a 00 08 07 02 02 07 03 08 07 02 07 07 04 05 07 03 03 07 03 06 07 03 04 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 08 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 09 0a 06 d0 30 d0 49 00 47 00 00 01 01 01 08 09 03 d0 30 47 00 00 02 02 01 01 08 23 d0 30 65 00 60 03 30 60 04 30 60 05 30 60 06 30 60 07 30 60 02 30 60 02 58 00 1d 1d 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/Sprite/Class12345_compilation.swf
		
		//MovieClip
		//public static const mcClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 0c 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 16 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 43 6f 6e 74 61 69 6e 65 72 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 11 49 6e 74 65 72 61 63 74 69 76 65 4f 62 6a 65 63 74 09 4d 6f 76 69 65 43 6c 69 70 06 4f 62 6a 65 63 74 06 53 70 72 69 74 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 0a 16 0b 00 09 07 02 02 07 03 07 07 02 08 07 04 05 07 03 03 07 03 06 07 03 04 07 03 09 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 0a 0b 06 d0 30 d0 49 00 47 00 00 01 01 01 09 0a 03 d0 30 47 00 00 02 02 01 01 09 27 d0 30 65 00 60 03 30 60 04 30 60 05 30 60 06 30 60 07 30 60 08 30 60 02 30 60 02 58 00 1d 1d 1d 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/MovieClip/Class12345_compilation.swf
		
		//MovieClip dynamic: 如果不加 dynamic 那么当此 movieclip 里放有带实例名的元件时将出问题
		public static const mcClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 00 00 00 0c 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 16 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 43 6f 6e 74 61 69 6e 65 72 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 11 49 6e 74 65 72 61 63 74 69 76 65 4f 62 6a 65 63 74 09 4d 6f 76 69 65 43 6c 69 70 06 4f 62 6a 65 63 74 06 53 70 72 69 74 65 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 05 18 02 16 01 16 0a 16 0b 00 09 07 02 02 07 03 07 07 02 08 07 04 05 07 03 03 07 03 06 07 03 04 07 03 09 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 08 01 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 0a 0b 06 d0 30 d0 49 00 47 00 00 01 01 01 09 0a 03 d0 30 47 00 00 02 02 01 01 09 27 d0 30 65 00 60 03 30 60 04 30 60 05 30 60 06 30 60 07 30 60 08 30 60 02 30 60 02 58 00 1d 1d 1d 1d 1d 1d 1d 68 01 47 00 00");//来自: F:/src/zero/swf/funs/fla/Class12345/MovieClip/Class12345_compilation.swf
		
		//Sound
		public static const sndClassData:ByteArray=getClassData("01 00 00 00 00 10 00 2e 00 01 01 01 08 0a 43 6c 61 73 73 31 32 33 34 35 00 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 0b 66 6c 61 73 68 2e 6d 65 64 69 61 06 4f 62 6a 65 63 74 05 53 6f 75 6e 64 05 16 02 16 04 16 05 18 01 01 05 07 01 01 07 03 07 07 01 06 07 02 03 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 04 00 00 00 01 00 01 02 01 01 04 01 00 03 00 01 01 06 07 06 d0 30 d0 49 00 47 00 00 01 01 01 05 06 03 d0 30 47 00 00 02 02 01 01 05 17 d0 30 65 00 60 03 30 60 04 30 60 02 30 60 02 58 00 1d 1d 1d 68 01 47 00 00");
		*/
		
		/*
		private static function getClassData(str16:String):ByteArray{
			var classNameOffset:int=str16.indexOf("0a 43 6c 61 73 73 31 32 33 34 35 ")/3;
			if(classNameOffset>0){
				var classData:ByteArray=BytesAndStr16.str162bytes(str16);
				classNameOffsetDict[classData]=classNameOffset;
			}else{
				throw new Error("找不到 className: Class12345");
			}
			
			return classData;
		}
		public static function getDoABCTag(className:String,classDataOrTypeOrStr16:*,use72:Boolean):Tag{
			if(className.search(/\:+|\./)>-1){
				throw new Error("暂不支持的 className："+className);
			}
			if(classDataOrTypeOrStr16 is ByteArray){
				var classData:ByteArray=classDataOrTypeOrStr16;
			}else if(SimpleDoABC[classDataOrTypeOrStr16+"ClassData"]){
				classData=SimpleDoABC[classDataOrTypeOrStr16+"ClassData"];
			}else{
				classData=getClassData(classDataOrTypeOrStr16);
			}
			if(classData){
				var classNameOffset:int=classNameOffsetDict[classData];
				if(classNameOffset>0){
					//trace("classNameOffset="+classNameOffset);
					var doABCData:ByteArray=new ByteArray();
					doABCData.writeBytes(classData,0,classNameOffset);
					doABCData[classNameOffset]=0x00;
					doABCData.position=classNameOffset+1;
					
					//doABCData.writeUTFBytes(className);
					
					//20111208
					//if(className){
					//	for each(var c:String in className.split("")){
					//		if(c.charCodeAt(0)>0xff){
					//			doABCData.writeUTFBytes(c);
					//		}else{
					//			doABCData.writeByte(c.charCodeAt(0));
					//		}
					//	}
					//}
					
					//20120413
					if(className){
						if(className.search(/[\xf0-\xff]/)>-1){
							for each(var c:String in className.split("")){
								if(/[\xf0-\xff]/.test(c)){
									doABCData.writeByte(c.charCodeAt(0));//这么写，个别字符能使 asv 显示不出来
								}else{
									doABCData.writeUTFBytes(c);
								}
							}
						}else{
							doABCData.writeUTFBytes(className);
						}
					}
					
					var strSize:int=doABCData.length-classNameOffset-1;
					if(strSize>0x7f){
						throw new Error("暂不支持长度超过 0x7f 的 className: "+className);
					}
					doABCData[classNameOffset]=strSize;
					doABCData.writeBytes(classData,classNameOffset+11);
					//trace(BytesAndStr16.bytes2str16(doABCData,0,doABCData.length));
					var tag:Tag=new Tag();
					if(use72){
						//01 00 00 00,00
						tag.type=TagTypes.DoABCWithoutFlagsAndName;
						var _doABCData:ByteArray=new ByteArray();
						_doABCData.writeBytes(doABCData,5);
						tag.setBodyData(_doABCData);
					}else{
						tag.type=TagTypes.DoABC;
						tag.setBodyData(doABCData);
					}
					return tag;
				}
				throw new Error("classNameOffset="+classNameOffset);
			}
			throw new Error("classData="+classData);
		}
		*/
	}
}

