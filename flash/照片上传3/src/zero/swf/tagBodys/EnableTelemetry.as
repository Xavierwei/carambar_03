/***
UseScout
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年01月15日 18:05:51
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//ZЁЯ¤  18:04:40
//来咱给起个名字吧
//〆戀❤ぁぃ  18:04:58
//额。
//UseScout
//肿么样
//ZЁЯ¤  18:05:24
//挺好


//20130130
//EnableTelemetry
//Telemetry is a a Flash player feature that sends profiling information about the runtime and the currently running content. The EnableTelemetry tag controls whether the advanced features of telemetry are included in the profile data. If the tag isn’t present, only basic information is available.
//Field			Type			Comment
//Header		RECORDHEADER	Tag type = 93
//Reserved		UB[16]			Must be 0
//PasswordHash	UI8[32]			Optional: SHA-256 hash of the UTF-8 representation of the password. If not present, SWF opts in to advanced telemetry.

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	public class EnableTelemetry{
		
		public var password:String;//Password
		
		public function EnableTelemetry(){
			//password=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			password="";
			while(offset<endOffset){
				password+=String.fromCharCode(data[offset]);
				offset++;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			if(password){
				data.writeUTFBytes(password);
//				//20111208
//				if(password){
//					for each(var c:String in password.split("")){
//						if(c.charCodeAt(0)>0xff){
//							data.writeUTFBytes(c);
//						}else{
//							data.writeByte(c.charCodeAt(0));
//						}
//					}
//				}
			}
			
			return data;
			
		}
		
		//CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.tagBodys.EnableTelemetry"
					password={password}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				password=xml.@password.toString();
				
			}
		//}//end of CONFIG::USE_XML
	}
}