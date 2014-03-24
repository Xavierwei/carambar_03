/***
DoAction
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月24日 13:33:50（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DoAction instructs Flash Player to perform a list of actions when the current frame is
//complete. The actions are performed when the ShowFrame tag is encountered, regardless of
//where in the frame the DoAction tag appears.
//Starting with SWF 9, if the ActionScript3 field of the FileAttributes tag is 1, the contents of
//the DoAction tag will be ignored.

//Field 			Type 							Comment
//Header 			RECORDHEADER 					Tag type = 12
//Actions 			ACTIONRECORD [zero or more] 	List of actions to perform (see following table, ActionRecord)
//ActionEndFlag 	UI8 = 0 						Always set to 0

package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import zero.swf.BytesData;
	
	public class DoAction{
		
		//ActionEndFlag //经测试这是会被播放器执行的（把 ActionEndFlag 设置为 8（toggleQuality）然后执行帧动作，将发现播放质量发生变化，所以 ActionEndFlag 应是 Actions 的一部分）
		
		public var Actions:*;
		
		public function DoAction(){
			//Actions=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
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
			
			return Actions.toData(_toDataOptions);
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DoAction"/>;
			
			xml.appendChild(Actions.toXML("Actions",_toXMLOptions));
			
			if(_toXMLOptions&&_toXMLOptions.addToXMLInfos){//20130327
				_toXMLOptions.addToXMLInfos(this,xml);
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
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