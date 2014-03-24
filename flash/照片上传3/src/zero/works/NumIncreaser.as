/***
NumIncreaser
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月20日 19:55:47
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.utils.getDate;
	
	public class NumIncreaser extends BaseCom{
		
		public var defaultXMLStr:String='<xml startTime="2012-02-10 00:00:00" endTime="2012-03-03 00:00:00" startNum="0" endNum="1000000"/>';
		
		private var ranArrStr:String="1211111323112121122132222212122212121211211211121222212311212221112221112222221222221122212221121211";
		
		private var size:int;
		private var color:int;
		private var bold:Boolean;
		private var align:String;
		
		private var txt:TextField;
		
		public function NumIncreaser(){
		}
		public function initComplete():void{
			var i:int=this.numChildren;
			while(--i>=0){
				var txt:TextField=this.getChildAt(i) as TextField;
				if(txt){
					initTxt(txt);
					return;
				}
			}
			loadAsset("txtSWFData",loadTxtSWFComplete);
		}
		private function loadTxtSWFComplete(txtLoader:Loader):void{
			var txt:TextField=txtLoader.content["getChildAt"](0);
			this.addChild(txt);
			initTxt(txt);
		}
		private function initTxt(_txt:TextField):void{
			txt=_txt;
			txt.text="";
			ServerDate.init(getTimeComplete);
		}
		public function update():void{
			if(xml){
				getTimeComplete();
			}
		}
		public function getTimeComplete():void{
			var startTime:int=getDate(xml.@startTime.toString()).time/1000;
			var endTime:int=getDate(xml.@endTime.toString()).time/1000;
			
			var currTime:int=ServerDate.getDate().time/1000;
			if(currTime<startTime){
				currTime=startTime;
			}else if(currTime>endTime){
				currTime=endTime;
			}
			
			var dTime:int=currTime-startTime;
			if(dTime>0){
			}else{
				dTime=0;
			}
			
			var ranArr:Array=ranArrStr.split("");
			var i:int=ranArr.length;
			while(--i>=0){
				ranArr[i]=int(ranArr[i]);
			}
			
			var startNum:int=int(xml.@startNum.toString());
			var endNum:int=int(xml.@endNum.toString());
			
			var k:Number=(endNum-startNum)/getNum(endTime-startTime,ranArr);
			//trace("k="+k);
			
			showNum(int(startNum+getNum(dTime,ranArr)*k));
		}
		private function getNum(dTime:int,ranArr:Array):int{
			var i:int;
			
			var arrSum:int=0;
			for(i=0;i<100;i++){
				arrSum+=ranArr[i];
			}
			var dateSum:int=arrSum*864;
			
			var num:int=int(dTime/86400)*dateSum;
			dTime=dTime%86400;
			num+=int(dTime/100)*arrSum;
			dTime=dTime%100;
			for(i=0;i<dTime;i++){
				num+=ranArr[i];
			}
			return num;
		}
		private function showNum(num:int):void{
			var htmlText:String=num.toString();
			if(size>0){
				htmlText='<font size="'+size+'" color="#'+(0x1000000+color).toString(16).substr(1)+'">'+htmlText+'</font>';
			}
			if(bold){
				htmlText="<b>"+htmlText+"</b>";
			}
			txt.htmlText=htmlText;
			
			if(align){
				txt.transform.matrix=new Matrix(1,0,0,1,0,0);
				switch(align){
					case "左":
						txt.autoSize=TextFieldAutoSize.LEFT;
						txt.x=0;
					break;
					case "中":
						txt.autoSize=TextFieldAutoSize.CENTER;
						txt.x=(wid-txt.width)/2;
					break;
					case "右":
						txt.autoSize=TextFieldAutoSize.RIGHT;
						txt.x=wid-txt.width;
					break;
				}
				txt.y=(hei-txt.height)/2;
			}
		}
	}
}