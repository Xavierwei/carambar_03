/***
DoInitAction
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 19:08:40（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The DoInitAction tag is similar to the DoInitAction tag: it defines a series of bytecodes to be
//executed. However, the actions defined with DoInitAction are executed earlier than the usual
//DoInitAction actions, and are executed only once.
//In some situations, actions must be executed before the ActionScript representation of the first
//instance of a particular sprite is created. The most common such action is calling
//Object.registerClass to associate an ActionScript class with a sprite. Such a call is generally
//found within the #initclip pragma in the ActionScript language. DoInitAction is used to
//implement the #initclip pragma.
//A DoInitAction tag specifies a particular sprite to which its actions apply. A single frame can
//contain multiple DoInitAction tags; their actions are executed in the order in which the tags
//appear. However, the SWF file can contain only one DoInitAction tag for any particular
//sprite.
//The specified actions are executed immediately before the normal actions of the frame in
//which the DoInitAction tag appears. This only occurs the first time that this frame is
//encountered; playback reaches the same frame again later, actions provided in DoInitAction
//are skipped.
//Starting with SWF 9, if the ActionScript3 field of the FileAttributes tag is 1, the contents of
//the DoInitAction tag will be ignored.

//NOTE
//Specifying actions at the beginning of a DoInitAction tag is not the same as specifying them
//in a DoInitAction tag. Flash Player takes steps before the first action in a DoInitAction tag,
//most relevantly the creation of ActionScript objects that represent sprites. The actions in
//DoInitAction occur before these implicit steps are performed.

//Field 			Type 						Comment
//Header 			RECORDHEADER 				Tag type = 59
//Sprite ID 		UI16 						Sprite to which these actions apply
//Actions 			ACTIONRECORD[zero or more] 	List of actions to perform
//ActionEndFlag 	UI8 						Always set to 0

package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import zero.swf.BytesData;
	
	public class DoInitAction{
		
		//ActionEndFlag //经测试这是会被播放器执行的（把 ActionEndFlag 设置为 8（toggleQuality）然后执行帧动作，将发现播放质量发生变化，所以 ActionEndFlag 应是 Actions 的一部分）
		
		public var SpriteID:int;//UI16
		public var Actions:*;
		
		public function DoInitAction(){
			//SpriteID=0;
			//Actions=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			SpriteID=data[offset++]|(data[offset++]<<8);
			
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					var ActionsClass:Class=_initByDataOptions.classes["zero.swf.avm1.ACTIONRECORDs"];
				}
				if(ActionsClass){
				}else{
					ActionsClass=_initByDataOptions.ActionsClass;
				}
			}
			Actions=new (ActionsClass||BytesData)();
			return Actions.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=SpriteID;
			data[1]=SpriteID>>8;
			
			data.position=2;
			data.writeBytes(Actions.toData(_toDataOptions));
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DoInitAction"
				SpriteID={SpriteID}
			/>;
			
			xml.appendChild(Actions.toXML("Actions",_toXMLOptions));
			
			if(_toXMLOptions&&_toXMLOptions.addToXMLInfos){//20130327
				_toXMLOptions.addToXMLInfos(this,xml);
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			SpriteID=int(xml.@SpriteID.toString());
			
			var ActionsXML:XML=xml.Actions[0];
			var classStr:String=ActionsXML["@class"].toString();
			var ActionsClass:Class=null;
			if(_initByXMLOptions&&_initByXMLOptions.customClasses){
				ActionsClass=_initByXMLOptions.customClasses[classStr];
			}
			if(ActionsClass){
			}else{
				try{
					ActionsClass=getDefinitionByName(classStr) as Class;
				}catch(e:Error){
					ActionsClass=null;
				}
			}
			Actions=new (ActionsClass||BytesData)();
			Actions.initByXML(ActionsXML,_initByXMLOptions);
			
		}
		
	}
}