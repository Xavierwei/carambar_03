/***
PlaceObject2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月25日 14:28:12（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//PlaceObject2
//Field 											Type 			Comment
//Header 											RECORDHEADER 	Tag type = 26
//PlaceFlagHasClipActions 							UB[1] 			SWF 5 and later: has clip actions (sprite characters only) Otherwise: always 0
//PlaceFlagHasClipDepth 							UB[1] 			Has clip depth
//PlaceFlagHasName 									UB[1] 			Has name
//PlaceFlagHasRatio(是否含有比例(补间))				UB[1] 			Has ratio
//PlaceFlagHasColorTransform 						UB[1] 			Has color transform
//PlaceFlagHasMatrix 								UB[1] 			Has matrix
//PlaceFlagHasCharacter 							UB[1] 			Places a character
//PlaceFlagMove 									UB[1] 			Defines a character to be moved

//PlaceFlagMove和PlaceFlagHasCharacter指出一个新的角色是否被添加入显示列表，或显示列表中的一个角色是否被修改。这两个标记的含义如下：
//• PlaceFlagMove = 0并且PlaceFlagHasCharacter = 1
//一个新的角色（带有ID或CharacterId）被指定具体的深度并且放置于显示列表。其他字段设置新角色的属性。
//• PlaceFlagMove = 1并且PlaceFlagHasCharacter = 0
//指定深度的角色被修改。其他字段修改这个角色的属性。因为一个深度只能含有一个角色，所以CharacterId为可选字段。
//• PlaceFlagMove = 1并且PlaceFlagHasCharacter = 1
//指定深度的角色被移除，同时新角色（带有ID或CharacterId）被放置于该深度。其他字段设置新角色的属性。

//Depth 											UI16 			Depth of character
//CharacterId If PlaceFlagHasCharacter				UI16			ID of character to place
//Matrix If PlaceFlagHasMatrix						MATRIX			Transform matrix data
//ColorTransform If PlaceFlagHasColorTransform		CXFORMWITHALPHA	Color transform data
//Ratio If PlaceFlagHasRatio 						UI16			
//Name If PlaceFlagHasName							STRING			Name of character
//ClipDepth If PlaceFlagHasClipDepth 				UI16 			Clip depth(see Clipping layers)
//ClipActions If PlaceFlagHasClipActions			CLIPACTIONS		SWF 5 and later:Clip Actions Data

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.MATRIX;
	import zero.swf.records.CXFORMWITHALPHA;
	import zero.swf.BytesData;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class PlaceObject2{
		
		public var PlaceFlagMove:Boolean;//00000001
		public var Depth:int;//UI16
		public var CharacterId:int;//UI16
		public var Matrix:MATRIX;
		public var ColorTransform:CXFORMWITHALPHA;
		public var Ratio:int;//UI16
		public var Name:String;//STRING
		public var ClipDepth:int;//UI16
		public var ClipActions:*;
		
		public function PlaceObject2(){
			//PlaceFlagMove=false;
			//Depth=0;
			CharacterId=-1;
			//Matrix=null;
			//ColorTransform=null;
			Ratio=-1;
			//Name=null;
			ClipDepth=-1;
			//ClipActions=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var flags:int=data[offset++];
			var PlaceFlagHasClipActions:Boolean=((flags&0x80)?true:false);//10000000
			var PlaceFlagHasClipDepth:Boolean=((flags&0x40)?true:false);//01000000
			var PlaceFlagHasName:Boolean=((flags&0x20)?true:false);//00100000
			var PlaceFlagHasRatio:Boolean=((flags&0x10)?true:false);//00010000
			var PlaceFlagHasColorTransform:Boolean=((flags&0x08)?true:false);//00001000
			var PlaceFlagHasMatrix:Boolean=((flags&0x04)?true:false);//00000100
			var PlaceFlagHasCharacter:Boolean=((flags&0x02)?true:false);//00000010
			PlaceFlagMove=((flags&0x01)?true:false);//00000001
			
			Depth=data[offset++]|(data[offset++]<<8);
			
			if(PlaceFlagHasCharacter){
				CharacterId=data[offset++]|(data[offset++]<<8);
			}else{
				CharacterId=-1;
			}
			
			if(PlaceFlagHasMatrix){
				Matrix=new MATRIX();
				offset=Matrix.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				Matrix=null;
			}
			
			if(PlaceFlagHasColorTransform){
				ColorTransform=new CXFORMWITHALPHA();
				offset=ColorTransform.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ColorTransform=null;
			}
			
			if(PlaceFlagHasRatio){
				Ratio=data[offset++]|(data[offset++]<<8);
			}else{
				Ratio=-1;
			}
			
			if(PlaceFlagHasName){
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				Name=ignoreBOMReadUTFBytes(data,get_str_size);
				offset+=get_str_size;
			}else{
				Name=null;
			}
			
			if(PlaceFlagHasClipDepth){
				ClipDepth=data[offset++]|(data[offset++]<<8);
			}else{
				ClipDepth=-1;
			}
			
			if(PlaceFlagHasClipActions){
				if(_initByDataOptions){
					if(_initByDataOptions.classes){
						var ClipActionsClass:Class=_initByDataOptions.classes["zero.swf.records.clips.CLIPACTIONs"];
					}
					if(ClipActionsClass){
					}else{
						ClipActionsClass=_initByDataOptions.ClipActionsClass;
					}
				}
				ClipActions=new (ClipActionsClass||BytesData)();
				offset=ClipActions.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ClipActions=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			var flags:int=0;
			if(ClipActions){
				flags|=0x80;//PlaceFlagHasClipActions//10000000
			}
			if(ClipDepth>-1){
				flags|=0x40;//PlaceFlagHasClipDepth//01000000
			}
			if(Name is String){
				flags|=0x20;//PlaceFlagHasName//00100000
			}
			if(Ratio>-1){
				flags|=0x10;//PlaceFlagHasRatio//00010000
			}
			if(ColorTransform){
				flags|=0x08;//PlaceFlagHasColorTransform//00001000
			}
			if(Matrix){
				flags|=0x04;//PlaceFlagHasMatrix//00000100
			}
			if(CharacterId>-1){
				flags|=0x02;//PlaceFlagHasCharacter//00000010
			}
			if(PlaceFlagMove){
				flags|=0x01;//00000001
			}
			data[0]=flags;
			
			data[1]=Depth;
			data[2]=Depth>>8;
			
			if(CharacterId>-1){
				data[3]=CharacterId;
				data[4]=CharacterId>>8;
			}
			
			if(Matrix){
				data.position=data.length;
				data.writeBytes(Matrix.toData(_toDataOptions));
			}
			
			if(ColorTransform){
				data.position=data.length;
				data.writeBytes(ColorTransform.toData(_toDataOptions));
			}
			
			if(Ratio>-1){
				data[data.length]=Ratio;
				data[data.length]=Ratio>>8;
			}
			
			if(Name is String){
				data.position=data.length;
				data.writeUTFBytes(Name+"\x00");
//				//20111208
//				if(Name){
//					for each(var c:String in Name.split("")){
//						if(c.charCodeAt(0)>0xff){
//							data.writeUTFBytes(c);
//						}else{
//							data.writeByte(c.charCodeAt(0));
//						}
//					}
//				}
//				data.writeByte(0x00);
			}
			
			if(ClipDepth>-1){
				data[data.length]=ClipDepth;
				data[data.length]=ClipDepth>>8;
			}
			
			if(ClipActions){
				data.position=data.length;
				data.writeBytes(ClipActions.toData(_toDataOptions));
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.PlaceObject2"
					PlaceFlagMove={PlaceFlagMove}
					Depth={Depth}
				/>;
				
				if(CharacterId>-1){
					xml.@CharacterId=CharacterId;
				}
				
				if(Matrix){
					xml.appendChild(Matrix.toXML("Matrix",_toXMLOptions));
				}
				
				if(ColorTransform){
					xml.appendChild(ColorTransform.toXML("ColorTransform",_toXMLOptions));
				}
				
				if(Ratio>-1){
					xml.@Ratio=Ratio;
				}
				
				if(Name is String){
					xml.@Name=Name;
				}
				
				if(ClipDepth>-1){
					xml.@ClipDepth=ClipDepth;
				}
				
				if(ClipActions){
					xml.appendChild(ClipActions.toXML("ClipActions",_toXMLOptions));
				}
				
				if(_toXMLOptions&&_toXMLOptions.addToXMLInfos){//20130327
					_toXMLOptions.addToXMLInfos(this,xml);
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				PlaceFlagMove=(xml.@PlaceFlagMove.toString()=="true");
				
				Depth=int(xml.@Depth.toString());
				
				var CharacterIdXML:XML=xml.@CharacterId[0];
				if(CharacterIdXML){
					CharacterId=int(CharacterIdXML.toString());
				}else{
					CharacterId=-1;
				}
				
				var MatrixXML:XML=xml.Matrix[0];
				if(MatrixXML){
					Matrix=new MATRIX();
					Matrix.initByXML(MatrixXML,_initByXMLOptions);
				}else{
					Matrix=null;
				}
				
				var ColorTransformXML:XML=xml.ColorTransform[0];
				if(ColorTransformXML){
					ColorTransform=new CXFORMWITHALPHA();
					ColorTransform.initByXML(ColorTransformXML,_initByXMLOptions);
				}else{
					ColorTransform=null;
				}
				
				var RatioXML:XML=xml.@Ratio[0];
				if(RatioXML){
					Ratio=int(RatioXML.toString());
				}else{
					Ratio=-1;
				}
				
				var NameXML:XML=xml.@Name[0];
				if(NameXML){
					Name=NameXML.toString();
				}else{
					Name=null;
				}
				
				var ClipDepthXML:XML=xml.@ClipDepth[0];
				if(ClipDepthXML){
					ClipDepth=int(ClipDepthXML.toString());
				}else{
					ClipDepth=-1;
				}
				
				var ClipActionsXML:XML=xml.ClipActions[0];
				if(ClipActionsXML){
					var classStr:String=ClipActionsXML["@class"].toString();
					var ClipActionsClass:Class=null;
					if(_initByXMLOptions&&_initByXMLOptions.customClasses){
						ClipActionsClass=_initByXMLOptions.customClasses[classStr];
					}
					if(ClipActionsClass){
					}else{
						try{
							import flash.utils.getDefinitionByName;
							ClipActionsClass=getDefinitionByName(classStr) as Class;
						}catch(e:Error){
							ClipActionsClass=null;
						}
					}
					ClipActions=new (ClipActionsClass||BytesData)();
					ClipActions.initByXML(ClipActionsXML,_initByXMLOptions);
				}else{
					ClipActions=null;
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}