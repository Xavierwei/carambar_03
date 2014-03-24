/***
DefineEditText
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月27日 11:27:36（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The DefineEditText tag defines a dynamic text object, or text field.
//A text field is associated with an ActionScript variable name where the contents of the text
//field are stored. The SWF file can read and write the contents of the variable, which is always
//kept in sync with the text being displayed. If the ReadOnly flag is not set, users may change
//the value of a text field interactively.
//Fonts used by DefineEditText must be defined using DefineFont2, not DefineFont.
//
//The minimum file format version is SWF 4.
//
//DefineEditText
//Field 			Type 						Comment
//Header 			RECORDHEADER 				Tag type = 37.
//CharacterID 		UI16 						ID for this dynamic text character.
//Bounds 			RECT 						Rectangle that completely encloses the text field.
//HasText 			UB[1] 						0 = text field has no default text.
//												1 = text field initially displays the string specified by InitialText.
//WordWrap 			UB[1] 						0 = text will not wrap and will scroll sideways.
//												1 = text will wrap automatically when the end of line is reached.
//Multiline 		UB[1] 						0 = text field is one line only.
//												1 = text field is multi-line and scrollable.
//Password 			UB[1] 						0 = characters are displayed as typed.
//												1 = all characters are displayed as an asterisk.
//ReadOnly 			UB[1] 						0 = text editing is enabled.
//												1 = text editing is disabled.
//HasTextColor 		UB[1] 						0 = use default color.
//												1 = use specified color (TextColor).
//HasMaxLength 		UB[1] 						0 = length of text is unlimited.
//												1 = maximum length of string is specified by MaxLength.
//HasFont 			UB[1] 						0 = use default font.
//												1 = use specified font (FontID) and height (FontHeight). (Can't be true if HasFontClass is true).
//HasFontClass 		UB[1] 						0 = no fontClass, 1 = fontClass and Height specified for this text. (can't be true if HasFont is true). Supported in Flash Player 9.0.45.0 and later.
//AutoSize 			UB[1] 						0 = fixed size.
//												1 = sizes to content (SWF 6 or later only).
//HasLayout 		UB[1] 						Layout information provided.
//NoSelect 			UB[1] 						Enables or disables interactive text selection.
//Border 			UB[1] 						Causes a border to be drawn around the text field.
//WasStatic 		UB[1] 						0 = Authored as dynamic text
//												1 = Authored as static text
//HTML 				UB[1] 						0 = plaintext content.
//												1 = HTML content (see following).
//UseOutlines 		UB[1] 						0 = use device font.
//												1 = use glyph font.
//FontID 			If HasFont, UI16 			ID of font to use.
//FontClass 		If HasFontClass, STRING 	Class name of font to be loaded from another SWF and used for this text.
//FontHeight 		If HasFont, UI16 			Height of font in twips.
//TextColor 		If HasTextColor, RGBA 		Color of text.
//MaxLength 		If HasMaxLength, UI16 		Text is restricted to this length.
//Align 			If HasLayout, UI8 			0 = Left
//												1 = Right
//												2 = Center
//												3 = Justify
//LeftMargin 		If HasLayout, UI16 			Left margin in twips.
//RightMargin 		If HasLayout, UI16 			Right margin in twips.
//Indent 			If HasLayout, UI16 			Indent in twips.
//Leading 			If HasLayout, SI16 			Leading in twips (vertical distance between bottom of descender of one line and top of ascender of the next).
//VariableName 		STRING 						Name of the variable where the contents of the text field are stored. May be qualified with dot syntax or slash syntax for non-global variables.
//InitialText 		If HasText STRING 			Text that is initially displayed.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	import zero.swf.records.RECT;
	import zero.swf.records.texts.TEXTLAYOUT;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class DefineEditText{
		
		public var id:int;//UI16
		public var Bounds:RECT;
		public var WordWrap:Boolean;//01000000
		public var Multiline:Boolean;//00100000
		public var Password:Boolean;//00010000
		public var ReadOnly:Boolean;//00001000
		public var HasTextColor:Boolean;//00000100
		public var AutoSize:Boolean;//01000000
		public var NoSelect:Boolean;//00010000
		public var Border:Boolean;//00001000
		public var WasStatic:Boolean;//00000100
		public var HTML:Boolean;//00000010
		public var UseOutlines:Boolean;//00000001
		public var FontID:int;//UI16
		public var FontClass:String;//STRING
		public var FontHeight:int;//UI16
		public var TextColor:uint;//RGBA
		public var MaxLength:int;//UI16
		public var textLayout:TEXTLAYOUT;
		public var VariableName:String;//STRING
		public var InitialText:String;//STRING
		
		public function DefineEditText(){
			//id=0;
			//Bounds=null;
			//WordWrap=false;
			//Multiline=false;
			//Password=false;
			//ReadOnly=false;
			//HasTextColor=false;
			//AutoSize=false;
			//NoSelect=false;
			//Border=false;
			//WasStatic=false;
			//HTML=false;
			//UseOutlines=false;
			FontID=-1;
			//FontClass=null;
			FontHeight=-1;
			//TextColor=0;
			MaxLength=-1;
			//textLayout=null;
			VariableName="";
			//InitialText=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			Bounds=new RECT();
			offset=Bounds.initByData(data,offset,endOffset,_initByDataOptions);
			
			var flags:int=data[offset++];
			var HasText:Boolean=((flags&0x80)?true:false);//10000000
			WordWrap=((flags&0x40)?true:false);//01000000
			Multiline=((flags&0x20)?true:false);//00100000
			Password=((flags&0x10)?true:false);//00010000
			ReadOnly=((flags&0x08)?true:false);//00001000
			HasTextColor=((flags&0x04)?true:false);//00000100
			var HasMaxLength:Boolean=((flags&0x02)?true:false);//00000010
			var HasFont:Boolean=((flags&0x01)?true:false);//00000001
			
			flags=data[offset++];
			var HasFontClass:Boolean=((flags&0x80)?true:false);//10000000
			AutoSize=((flags&0x40)?true:false);//01000000
			var HasLayout:Boolean=((flags&0x20)?true:false);//00100000
			NoSelect=((flags&0x10)?true:false);//00010000
			Border=((flags&0x08)?true:false);//00001000
			WasStatic=((flags&0x04)?true:false);//00000100
			HTML=((flags&0x02)?true:false);//00000010
			UseOutlines=((flags&0x01)?true:false);//00000001
			
			if(HasFont){
				FontID=data[offset++]|(data[offset++]<<8);
			}else{
				FontID=-1;
			}
			
			if(HasFontClass){
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				FontClass=ignoreBOMReadUTFBytes(data,get_str_size);
				offset+=get_str_size;
			}else{
				FontClass=null;
			}
			
			if(HasFont){
				FontHeight=data[offset++]|(data[offset++]<<8);
			}else{
				FontHeight=-1;
			}
			
			if(HasTextColor){
				TextColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			}
			
			if(HasMaxLength){
				MaxLength=data[offset++]|(data[offset++]<<8);
			}else{
				MaxLength=-1;
			}
			
			if(HasLayout){
				textLayout=new TEXTLAYOUT();
				offset=textLayout.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				textLayout=null;
			}
			
			get_str_size=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			VariableName=ignoreBOMReadUTFBytes(data,get_str_size);
			offset+=get_str_size;
			
			if(HasText){
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				InitialText=ignoreBOMReadUTFBytes(data,get_str_size);
				offset+=get_str_size;
			}else{
				InitialText=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data.position=2;
			data.writeBytes(Bounds.toData(_toDataOptions));
			
			var flags:int=0;
			if(InitialText is String){
				flags|=0x80;//HasText//10000000
			}
			if(WordWrap){
				flags|=0x40;//01000000
			}
			if(Multiline){
				flags|=0x20;//00100000
			}
			if(Password){
				flags|=0x10;//00010000
			}
			if(ReadOnly){
				flags|=0x08;//00001000
			}
			if(HasTextColor){
				flags|=0x04;//00000100
			}
			if(MaxLength>-1){
				flags|=0x02;//HasMaxLength//00000010
			}
			if(FontID>-1){
				flags|=0x01;//HasFont//00000001
			}
			data[data.length]=flags;
			
			flags=0;
			if(FontClass is String){
				flags|=0x80;//HasFontClass//10000000
			}
			if(AutoSize){
				flags|=0x40;//01000000
			}
			if(textLayout){
				flags|=0x20;//HasLayout//00100000
			}
			if(NoSelect){
				flags|=0x10;//00010000
			}
			if(Border){
				flags|=0x08;//00001000
			}
			if(WasStatic){
				flags|=0x04;//00000100
			}
			if(HTML){
				flags|=0x02;//00000010
			}
			if(UseOutlines){
				flags|=0x01;//00000001
			}
			data[data.length]=flags;
			
			if(FontID>-1){
				data[data.length]=FontID;
				data[data.length]=FontID>>8;
			}
			
			if(FontClass is String){
				data.position=data.length;
				data.writeUTFBytes(FontClass+"\x00");
//				//20111208
//				if(FontClass){
//					for each(var c:String in FontClass.split("")){
//						if(c.charCodeAt(0)>0xff){
//							data.writeUTFBytes(c);
//						}else{
//							data.writeByte(c.charCodeAt(0));
//						}
//					}
//				}
//				data.writeByte(0x00);
			}
			
			if(FontHeight>-1){
				data[data.length]=FontHeight;
				data[data.length]=FontHeight>>8;
			}
			
			if(HasTextColor){
				data[data.length]=TextColor>>16;
				data[data.length]=TextColor>>8;
				data[data.length]=TextColor;
				data[data.length]=TextColor>>24;
			}
			
			if(MaxLength>-1){
				data[data.length]=MaxLength;
				data[data.length]=MaxLength>>8;
			}
			
			if(textLayout){
				data.position=data.length;
				data.writeBytes(textLayout.toData(_toDataOptions));
			}
			
			data.position=data.length;
			data.writeUTFBytes(VariableName+"\x00");
//			//20111208
//			if(VariableName){
//				for each(c in VariableName.split("")){
//					if(c.charCodeAt(0)>0xff){
//						data.writeUTFBytes(c);
//					}else{
//						data.writeByte(c.charCodeAt(0));
//					}
//				}
//			}
//			data.writeByte(0x00);
			
			if(InitialText is String){
				data.writeUTFBytes(InitialText+"\x00");
//				//20111208
//				if(InitialText){
//					for each(c in InitialText.split("")){
//						if(c.charCodeAt(0)>0xff){
//							data.writeUTFBytes(c);
//						}else{
//							data.writeByte(c.charCodeAt(0));
//						}
//					}
//				}
//				data.writeByte(0x00);
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineEditText"
					id={id}
					WordWrap={WordWrap}
					Multiline={Multiline}
					Password={Password}
					ReadOnly={ReadOnly}
					AutoSize={AutoSize}
					NoSelect={NoSelect}
					Border={Border}
					WasStatic={WasStatic}
					HTML={HTML}
					UseOutlines={UseOutlines}
					VariableName={VariableName}
				/>;
				
				xml.appendChild(Bounds.toXML("Bounds",_toXMLOptions));
				
				if(FontID>-1){
					xml.@FontID=FontID;
				}
				
				if(FontClass is String){
					xml.@FontClass=FontClass;
				}
				
				if(FontHeight>-1){
					xml.@FontHeight=FontHeight;
				}
				
				if(HasTextColor){
					xml.@TextColor="0x"+BytesAndStr16._16V[(TextColor>>24)&0xff]+BytesAndStr16._16V[(TextColor>>16)&0xff]+BytesAndStr16._16V[(TextColor>>8)&0xff]+BytesAndStr16._16V[TextColor&0xff];
				}
				
				if(MaxLength>-1){
					xml.@MaxLength=MaxLength;
				}
				
				if(textLayout){
					xml.appendChild(textLayout.toXML("textLayout",_toXMLOptions));
				}
				
				if(InitialText is String){
					xml.@InitialText=InitialText;
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				Bounds=new RECT();
				Bounds.initByXML(xml.Bounds[0],_initByXMLOptions);
				
				WordWrap=(xml.@WordWrap.toString()=="true");
				Multiline=(xml.@Multiline.toString()=="true");
				Password=(xml.@Password.toString()=="true");
				ReadOnly=(xml.@ReadOnly.toString()=="true");
				
				AutoSize=(xml.@AutoSize.toString()=="true");
				NoSelect=(xml.@NoSelect.toString()=="true");
				Border=(xml.@Border.toString()=="true");
				WasStatic=(xml.@WasStatic.toString()=="true");
				HTML=(xml.@HTML.toString()=="true");
				UseOutlines=(xml.@UseOutlines.toString()=="true");
				
				var FontIDXML:XML=xml.@FontID[0];
				if(FontIDXML){
					FontID=int(FontIDXML.toString());
				}else{
					FontID=-1;
				}
				
				var FontClassXML:XML=xml.@FontClass[0];
				if(FontClassXML){
					FontClass=FontClassXML.toString();
				}else{
					FontClass=null;
				}
				
				var FontHeightXML:XML=xml.@FontHeight[0];
				if(FontHeightXML){
					FontHeight=int(FontHeightXML.toString());
				}else{
					FontHeight=-1;
				}
				
				var TextColorXML:XML=xml.@TextColor[0];
				if(TextColorXML){
					HasTextColor=true;
					TextColor=uint(TextColorXML.toString());
				}else{
					HasTextColor=false;
				}
				
				var MaxLengthXML:XML=xml.@MaxLength[0];
				if(MaxLengthXML){
					MaxLength=int(MaxLengthXML.toString());
				}else{
					MaxLength=-1;
				}
				
				var textLayoutXML:XML=xml.textLayout[0];
				if(textLayoutXML){
					textLayout=new TEXTLAYOUT();
					textLayout.initByXML(textLayoutXML,_initByXMLOptions);
				}else{
					textLayout=null;
				}
				
				VariableName=xml.@VariableName.toString();
				
				var InitialTextXML:XML=xml.@InitialText[0];
				if(InitialTextXML){
					InitialText=InitialTextXML.toString();
				}else{
					InitialText=null;
				}
				
			}
		//}//end of CONFIG::USE_XML
	}
}