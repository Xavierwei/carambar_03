/***
TxtEffectsClock 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月27日 18:48:15
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.*;
	import flash.utils.*;
	
	import zero.utils.getDate;
	
	public class TxtEffectsClock extends BaseCom{
		
		public var defaultXMLStr:String='<xml startTime="2013-11-03 00:00:00" endTime="2013-12-03 12:00:00"/>';
		
		public var txt0:TxtEffects;
		public var txt1:TxtEffects;
		public var txt2:TxtEffects;
		public var txt3:TxtEffects;
		public var txt4:TxtEffects;
		
		private var x0:int;
		private var x1:int;
		private var x2:int;
		private var x3:int;
		private var x4:int;
		
		public function TxtEffectsClock(){
			for(var i:int=0;i<5;i++){
				if(this["x"+i]>0){
					this["txt"+i].x=this["x"+i];
					this["txt"+i].y=hei/2;
				}
			}
			//if(txt4){
			//	txt4.txt2.visible=false;
			//}
		}
		public function initComplete():void{
			if(assets&&assets.txtSWFData){
				loadAsset("txtSWFData",loadTxtSWFComplete);
			}else{
				ServerDate.init(getTimeComplete);
			}
		}
		private function loadTxtSWFComplete(txtLoader:Loader):void{
			var TxtSWFClass:Class=txtLoader.contentLoaderInfo.applicationDomain.getDefinition("TxtSWF") as Class;
			txtLoader=null;
			for(var i:int=0;i<5;i++){
				var txt:TxtEffects=this["txt"+i];
				if(txt){
					txt.txt1.initTxts(new TxtSWFClass().getChildAt(0),new TxtSWFClass().getChildAt(0));
					txt.txt2.initTxts(new TxtSWFClass().getChildAt(0),new TxtSWFClass().getChildAt(0));
				}
			}
			ServerDate.init(getTimeComplete);
		}
		private function getTimeComplete():void{
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void{
			
			if(xml){
			}else{
				return;
			}
			
			var startTime:int=getDate(xml.@startTime.toString()).time/100;
			var endTime:int=getDate(xml.@endTime.toString()).time/100;
			
			var currTime:int=ServerDate.getDate().time/100;
			if(currTime<startTime){
				currTime=startTime;
			}else if(currTime>endTime){
				currTime=endTime;
			}
			
			var dTime:int=endTime-currTime;
			if(dTime>0){
			}else{
				dTime=0;
			}
			
			var day:int=dTime/(24*36000);
			dTime-=day*(24*36000);
			var hours:int=dTime/36000;
			dTime-=hours*36000;
			var mins:int=dTime/600;
			dTime-=mins*600;
			var secs:int=dTime/10;
			dTime-=secs*10;
			var mss:int=dTime;
			
			if(txt0){
				txt0.value=day;
			}
			if(txt1){
				if(txt0){
					txt1.value=hours;
				}else{
					txt1.value=day*24+hours;
				}
			}
			if(txt2){
				txt2.value=mins;
			}
			if(txt3){
				txt3.value=secs;
			}
			if(txt4){
				txt4.value=mss*10;
				if(currTime==startTime||currTime==endTime){
					
				}else{
					txt4.txt2.num1.getChildAt(0)["text"]=int(Math.random()*10).toString();
//这个能后一位也变化么？
//weishenchu00966(魏慎初（金花）ENTJ) 17:01:41
//弄个假的　
//weishenchu00966(魏慎初（金花）ENTJ) 17:01:46
//随便变变　就行
//weishenchu00966(魏慎初（金花）ENTJ) 17:01:47
//可以么
//luzhibin(陆志斌) 17:02:12
//可以啊
//weishenchu00966(魏慎初（金花）ENTJ) 17:02:24
//那帮忙弄一下吧　谢谢了
				}


			}
		}
	}
}