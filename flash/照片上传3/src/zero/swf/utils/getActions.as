/***
getActions
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月30日 13:46:06
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	
	import zero.swf.*;
	import zero.swf.avm1.*;
	import zero.swf.records.buttons.*;
	import zero.swf.records.clips.*;
	import zero.swf.tagBodys.*;
	
	public function getActions(swf:SWF,_initByDataOptions:Object=null):Vector.<ACTIONRECORDs>{
		
		if(_initByDataOptions){
		}else{
			_initByDataOptions={};
		}
		_initByDataOptions.ActionsClass=ACTIONRECORDs;
		_initByDataOptions.ClipActionsClass=CLIPACTIONs;
		_initByDataOptions.swf_Version=swf.Version;
		_initByDataOptions.ButtonCondActionsClass=BUTTONCONDACTIONs;
		
		var ActionsV:Vector.<ACTIONRECORDs>=new Vector.<ACTIONRECORDs>();
		
		var tagV:Vector.<Tag>=swf.tagV;
		while(tagV.length){
			var newTagV:Vector.<Tag>=new Vector.<Tag>();
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagTypes.DefineSprite:
						newTagV=newTagV.concat(tag.getBody(DefineSprite,_initByDataOptions).tagV);
					break;
					case TagTypes.DoAction:
						//trace("帧动作："+tag.getBody(DoAction,null).Actions);
						ActionsV.push(tag.getBody(DoAction,_initByDataOptions).Actions);
					break;
					case TagTypes.DoInitAction:
						//trace("类动作："+tag.getBody(DoInitAction,null).Actions);
						ActionsV.push(tag.getBody(DoInitAction,_initByDataOptions).Actions);
					break;
					case TagTypes.PlaceObject2:
						var ClipActions:CLIPACTIONs=tag.getBody(PlaceObject2,_initByDataOptions).ClipActions;
						if(ClipActions){
							for each(var ClipActionRecord:CLIPACTIONRECORD in ClipActions.ClipActionRecordV){
								//trace("影片剪辑动作："+ClipActionRecord.Actions);
								ActionsV.push(ClipActionRecord.Actions);
							}
						}
					break;
					case TagTypes.PlaceObject3:
						ClipActions=tag.getBody(PlaceObject3,_initByDataOptions).ClipActions;
						if(ClipActions){
							for each(ClipActionRecord in ClipActions.ClipActionRecordV){
								//trace("影片剪辑动作："+ClipActionRecord.Actions);
								ActionsV.push(ClipActionRecord.Actions);
							}
						}
					break;
					case TagTypes.DefineButton2:
						var ButtonCondActions:BUTTONCONDACTIONs=tag.getBody(DefineButton2,_initByDataOptions).ButtonCondActions;
						if(ButtonCondActions){
							for each(var ButtonCondAction:BUTTONCONDACTION in ButtonCondActions.ButtonCondActionV){
								//trace("按钮动作："+ButtonCondAction.Actions);
								ActionsV.push(ButtonCondAction.Actions);
							}
						}
					break;
				}
			}
			tagV=newTagV;
		}
		return ActionsV;
	}
}