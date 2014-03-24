/***
ScoreManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月24日 09:46:28
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.managers{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class ScoreManager{
		
		private static var mark:Object;
		private static var keyixiaoyulingMark:Object;
		private static var key:String;
		
		public static function init(_key:String):void{
			key=_key;
			mark=new Object();
			keyixiaoyulingMark=new Object();
		}
		
		/*//未加密
		public static function getValue(name:String):int{
			if(mark[name]>-1){
				return mark[name];
			}
			throw new Error(this+" 找不到分数："+name);
			return 0;
		}
		public static function setValue(name:String,value:int):void{
			if(value>-1){
			}else{
				trace(this+" "+value+"，自动处理成0");
				value=0;
			}
			mark[name]=value;
		}
		//*/
		
		///*//加密
		public static function getValue(name:String):int{
			var code:ByteArray=mark[name];
			if(code){
				var keyI:int=key.length;
				var L:int=code.length;
				var valueStr:String="";
				for(var i:int=0;i<L;i++){
					if(--keyI<0){
						keyI=key.length-1;
					}
					valueStr+=String.fromCharCode(code[i]^key.charCodeAt(keyI));
				}
				return int(valueStr);
			}
			//throw new Error(this+" 找不到分数："+name);
			return 0;
		}
		public static function setValue(
			name:String,
			value:int,
			keyixiaoyuling:Boolean=false//可以小于零
		):void{
			if(keyixiaoyuling){
			}else{
				if(value>-1){
				}else{
					//trace(this+" "+value+"，自动处理成0");
					value=0;
				}
			}
			var valueStr:String=value.toString();
			var keyI:int=key.length;
			var L:int=valueStr.length;
			var code:ByteArray=new ByteArray();
			for(var i:int=0;i<L;i++){
				if(--keyI<0){
					keyI=key.length-1;
				}
				code[i]=valueStr.charCodeAt(i)^key.charCodeAt(keyI);
			}
			//trace("code="+code);
			mark[name]=code;
			keyixiaoyulingMark[name]=keyixiaoyuling;
		}
		//*/
		
		public static function add(name:String,value:int):void{
			setValue(name,getValue(name)+value,keyixiaoyulingMark[name]);
		}
		public static function subtract(name:String,value:int):void{
			setValue(name,getValue(name)-value,keyixiaoyulingMark[name]);
		}
	}
}
		