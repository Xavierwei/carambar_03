/***
TempFun
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月28日 17:46:40
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class TempFun{
		private var callBack:Function;
		private var params:Array;
		public function TempFun(_callBack:Function,..._params){
			callBack=_callBack;
			params=_params;
		}
		public function fun():void{
			switch(params.length){
				case 0:
					callBack();
				break;
				case 1:
					callBack(params[0]);
				break;
				case 2:
					callBack(params[0],params[1]);
				break;
				case 3:
					callBack(params[0],params[1],params[2]);
				break;
				case 4:
					callBack(params[0],params[1],params[2],params[3]);
				break;
				case 5:
					callBack(params[0],params[1],params[2],params[3],params[4]);
				break;
				case 6:
					callBack(params[0],params[1],params[2],params[3],params[4],params[5]);
				break;
				case 7:
					callBack(params[0],params[1],params[2],params[3],params[4],params[5],params[6]);
				break;
				case 8:
					callBack(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7]);
				break;
				case 9:
					callBack(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7],params[8]);
				break;
				case 10:
					callBack(params[0],params[1],params[2],params[3],params[4],params[5],params[6],params[7],params[8],params[9]);
				break;
				default:
					trace("使用 callBack 作为 this，可能会出问题");
					callBack.apply(callBack,params);
				break;
			}
			callBack=null;
			var i:int=params.length;
			while(--i>=0){
				delete params[i];
			}
			params.length=0;
			params=null;
		}
	}
}