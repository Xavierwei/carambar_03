/***
Duoxiangshi
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月23日 09:57:35
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	/**
	 * 
	 * 处理由单词和 +，-，*，(，) 组成的多项式
	 * 
	 */	
	public class Duoxiangshi{
		
		/*
		private static function test():void{
			var a:int=1;
			var b:int=2;
			var c:int=3;
			var d:int=4;
			var e:int=5;
			var f:int=6;
			var fL:int=7;
			var tz:int=8;
			var xc:int=9;
			var yc:int=10;
			var xo:int=11;
			var yo:int=12;
			var xoc:int=13;
			var yoc:int=14;
			var value:Number;
			
			//value=(xo*((a*fL-c*(xoc-xo))*(e*fL-f*(yoc-yo))-(d*fL-f*(xoc-xo))*(b*fL-c*(yoc-yo)))+((e*fL-f*(yoc-yo))*((xoc-xo)*fL+(xoc-xo)*tz-(xc-xo)*fL)-(d*fL-f*(xoc-xo))*((yoc-yo)*fL+(yoc-yo)*tz-(yc-yo)*fL)))
			//value=xo+(((xoc-xo)*d-(yoc-yo)*c)-((xc-xo)*d-(yc-yo)*c))/(a*d-b*c);
			//value=yo+(((xc-xo)*b-(yc-yo)*a)-((xoc-xo)*b-(yoc-yo)*a))/(a*d-b*c);
			//value=(e*fL-f*(yoc-yo))*((xoc-xo)*fL+(xoc-xo)*tz-(xc-xo)*fL)-(d*fL-f*(xoc-xo))*((yoc-yo)*fL+(yoc-yo)*tz-(yc-yo)*fL);
			//trace("value="+value);
			//value=fL*((fL*xo*(a*e-b*d)+xo*yoc*(c*d-a*f)+xo*yo*(a*f-c*d)+xo*xoc*(b*f-c*e)+xo*xo*(c*e-b*f)+e*fL*xoc+e*tz*xoc-e*tz*xo-e*fL*xc-f*xo*yoc+f*xc*yoc+f*xoc*yo-f*xc*yo-d*fL*yoc-d*tz*yoc+d*tz*yo+d*fL*yc-f*xoc*yc+f*xoc*yo-f*xo*yoc+f*xo*yc));
			//value=xo+(d*(xoc-xc)-c*(yoc-yc))/(a*d-b*c);
			//value=yo+(a*(yoc-yc)-b*(xoc-xc))/(a*d-b*c);
			//value=(+e*fL*fL*xoc+e*fL*tz*xoc-e*fL*tz*xo-e*fL*fL*xc-f*fL*xo*yoc+f*fL*xc*yoc+f*fL*xoc*yo-f*fL*xc*yo-d*fL*fL*yoc-d*fL*tz*yoc+d*fL*tz*yo+d*fL*fL*yc-f*fL*xoc*yc+f*fL*xo*yc)
			//trace("value="+value);
			
			//value=(xo*(((a*fL-c*(xoc-xo))*(e*fL-f*(yoc-yo))-(d*fL-f*(xoc-xo))*(b*fL-c*(yoc-yo))))+((e*fL-f*(yoc-yo))*((xoc-xo)*fL+(xoc-xo)*tz-(xc-xo)*fL)-(d*fL-f*(xoc-xo))*((yoc-yo)*fL+(yoc-yo)*tz-(yc-yo)*fL)));
			//trace("value="+value);
			//value=+a*e*fL*fL*xo-a*f*fL*xo*yoc+a*f*fL*xo*yo-c*e*fL*xo*xoc+c*e*fL*xo*xo-b*d*fL*fL*xo+c*d*fL*xo*yoc-c*d*fL*xo*yo+b*f*fL*xo*xoc-b*f*fL*xo*xo+e*fL*fL*xoc+e*fL*tz*xoc-e*fL*tz*xo-e*fL*fL*xc-f*fL*xo*yoc+f*fL*xc*yoc+f*fL*xoc*yo-f*fL*xc*yo-d*fL*fL*yoc-d*fL*tz*yoc+d*fL*tz*yo+d*fL*fL*yc-f*fL*xoc*yc+f*fL*xo*yc;
			//trace("value="+value);
			//
			//value=(yo*(((d*fL-f*(xoc-xo))*(b*fL-c*(yoc-yo))-(a*fL-c*(xoc-xo))*(e*fL-f*(yoc-yo))))+((b*fL-c*(yoc-yo))*((xoc-xo)*fL+(xoc-xo)*tz-(xc-xo)*fL)-(a*fL-c*(xoc-xo))*((yoc-yo)*fL+(yoc-yo)*tz-(yc-yo)*fL)));
			//trace("value="+value);
			//value=+b*d*fL*fL*yo-c*d*fL*yo*yoc+c*d*fL*yo*yo-b*f*fL*xoc*yo+b*f*fL*xo*yo-a*e*fL*fL*yo+a*f*fL*yo*yoc-a*f*fL*yo*yo+c*e*fL*xoc*yo-c*e*fL*xo*yo+b*fL*fL*xoc+b*fL*tz*xoc-b*fL*tz*xo-b*fL*fL*xc-c*fL*xo*yoc+c*fL*xc*yoc+c*fL*xoc*yo-c*fL*xc*yo-a*fL*fL*yoc-a*fL*tz*yoc+a*fL*tz*yo+a*fL*fL*yc-c*fL*xoc*yc+c*fL*xo*yc;
			//trace("value="+value);
			
			//value=(+a*e*fL*fL*xo-a*f*fL*xo*yoc+a*f*fL*xo*yo-c*e*fL*xo*xoc+c*e*fL*xo*xo-b*d*fL*fL*xo+c*d*fL*xo*yoc-c*d*fL*xo*yo+b*f*fL*xo*xoc-b*f*fL*xo*xo+e*fL*fL*xoc+e*fL*tz*xoc-e*fL*tz*xo-e*fL*fL*xc-f*fL*xo*yoc+f*fL*xc*yoc+f*fL*xoc*yo-f*fL*xc*yo-d*fL*fL*yoc-d*fL*tz*yoc+d*fL*tz*yo+d*fL*fL*yc-f*fL*xoc*yc+f*fL*xo*yc)/(a*e*fL*fL-a*f*fL*yoc+a*f*fL*yo-c*e*fL*xoc+c*e*fL*xo-b*d*fL*fL+c*d*fL*yoc-c*d*fL*yo+b*f*fL*xoc-b*f*fL*xo);
			//trace("value="+value);//8.066666666666666
			//value=(+a*e*fL*xo-a*f*xo*yoc+a*f*xo*yo-c*e*xo*xoc+c*e*xo*xo-b*d*fL*xo+c*d*xo*yoc-c*d*xo*yo+b*f*xo*xoc-b*f*xo*xo+e*fL*xoc+e*tz*xoc-e*tz*xo-e*fL*xc-f*xo*yoc+f*xc*yoc+f*xoc*yo-f*xc*yo-d*fL*yoc-d*tz*yoc+d*tz*yo+d*fL*yc-f*xoc*yc+f*xo*yc)/(a*e*fL-a*f*yoc+a*f*yo-c*e*xoc+c*e*xo-b*d*fL+c*d*yoc-c*d*yo+b*f*xoc-b*f*xo);
			//trace("value="+value);//8.066666666666666
			//value=(+b*d*fL*fL*yo-c*d*fL*yo*yoc+c*d*fL*yo*yo-b*f*fL*xoc*yo+b*f*fL*xo*yo-a*e*fL*fL*yo+a*f*fL*yo*yoc-a*f*fL*yo*yo+c*e*fL*xoc*yo-c*e*fL*xo*yo+b*fL*fL*xoc+b*fL*tz*xoc-b*fL*tz*xo-b*fL*fL*xc-c*fL*xo*yoc+c*fL*xc*yoc+c*fL*xoc*yo-c*fL*xc*yo-a*fL*fL*yoc-a*fL*tz*yoc+a*fL*tz*yo+a*fL*fL*yc-c*fL*xoc*yc+c*fL*xo*yc)/-(a*e*fL*fL-a*f*fL*yoc+a*f*fL*yo-c*e*fL*xoc+c*e*fL*xo-b*d*fL*fL+c*d*fL*yoc-c*d*fL*yo+b*f*fL*xoc-b*f*fL*xo);
			//trace("value="+value);//14.933333333333334
			//value=(+b*d*fL*yo-c*d*yo*yoc+c*d*yo*yo-b*f*xoc*yo+b*f*xo*yo-a*e*fL*yo+a*f*yo*yoc-a*f*yo*yo+c*e*xoc*yo-c*e*xo*yo+b*fL*xoc+b*tz*xoc-b*tz*xo-b*fL*xc-c*xo*yoc+c*xc*yoc+c*xoc*yo-c*xc*yo-a*fL*yoc-a*tz*yoc+a*tz*yo+a*fL*yc-c*xoc*yc+c*xo*yc)/-(a*e*fL-a*f*yoc+a*f*yo-c*e*xoc+c*e*xo-b*d*fL+c*d*yoc-c*d*yo+b*f*xoc-b*f*xo);
			//trace("value="+value);//14.933333333333334
			
			value=(fL*((a*e-b*d)*xo+e*(xoc-xc)-d*(yoc-yc))+f*(xc*(yoc-yo)-yc*(xoc-xo)+xoc*yo-xo*yoc)+((b*f-c*e)*xo+e*tz)*(xoc-xo)+((c*d-a*f)*xo-d*tz)*(yoc-yo))/((a*e-b*d)*fL+(c*d-a*f)*(yoc-yo)+(b*f-c*e)*(xoc-xo));
			trace("value="+value);//8.066666666666666
			value=(fL*((b*d-a*e)*yo+b*(xoc-xc)-a*(yoc-yc))+c*(xc*(yoc-yo)-yc*(xoc-xo)+xoc*yo-xo*yoc)+((c*e-b*f)*yo+b*tz)*(xoc-xo)+((a*f-c*d)*yo-a*tz)*(yoc-yo))/-((a*e-b*d)*fL+(c*d-a*f)*(yoc-yo)+(b*f-c*e)*(xoc-xo));
			trace("value="+value);//14.933333333333334
			
			var aebd:Number=a*e-b*d;
			var bfce:Number=b*f-c*e;
			var afcd:Number=a*f-c*d;
			var xocxc:Number=xoc-xc;
			var yocyc:Number=yoc-yc;
			var xocxo:Number=xoc-xo;
			var yocyo:Number=yoc-yo;
			var fLaebdafcdyocyobfcexocxo:Number=fL*aebd-afcd*yocyo+bfce*xocxo;
			//trace("fLaebdafcdyocyobfcexocxo="+fLaebdafcdyocyobfcexocxo,(a*e-b*d)*fL+(c*d-a*f)*(yoc-yo)+(b*f-c*e)*(xoc-xo));
			value=(fL*(aebd*xo+e*xocxc-d*yocyc)+f*(xc*yocyo-yc*xocxo+xoc*yo-xo*yoc)+(bfce*xo+e*tz)*xocxo+(-afcd*xo-d*tz)*yocyo)/fLaebdafcdyocyobfcexocxo;
			trace("value="+value);
			value=(fL*(-aebd*yo+b*xocxc-a*yocyc)+c*(xc*yocyo-yc*xocxo+xoc*yo-xo*yoc)+(-bfce*yo+b*tz)*xocxo+(afcd*yo-a*tz)*yocyo)/-fLaebdafcdyocyobfcexocxo;
			trace("value="+value);
		}
		test();
		//*/
		
		//Duoxiangshi.normalize("xo+((e*fL-f*(yoc-yo))*((xoc-xo)*fL+(xoc-xo)*tz-(xc-xo)*fL)-(d*fL-f*(xoc-xo))*((yoc-yo)*fL+(yoc-yo)*tz-(yc-yo)*fL))");
		//Duoxiangshi.normalize("((a*fL-c*(xoc-xo))*(e*fL-f*(yoc-yo))-(d*fL-f*(xoc-xo))*(b*fL-c*(yoc-yo)))");
		//Duoxiangshi.normalize("xo+((e*fL-f*(yoc-yo))*((xoc-xo)*fL+(xoc-xo)*tz-(xc-xo)*fL)-(d*fL-f*(xoc-xo))*((yoc-yo)*fL+(yoc-yo)*tz-(yc-yo)*fL))/((a*fL-c*(xoc-xo))*(e*fL-f*(yoc-yo))-(d*fL-f*(xoc-xo))*(b*fL-c*(yoc-yo)))");
		
		private static const itemReg_g:RegExp=/[\+\-]\w+(?:\*[\+\-]\w+)*/g;
		//private static const itemReg:RegExp=new RegExp(itemReg_g.source);
		
		
		/**
		 * 
		 * 标准化为没有括号的形式
		 * 
		 */
		public static function normalize(code:String):String{
			
			//去掉空白
			code=code.replace(/\s+/g,"");
			
			//把所有单词前面按类型标上正负号
			code=code.replace(/(\w+)/g,"+$1");
			code=code.replace(/\-\+/g,"-");
			
			//trace(code.replace(/([\*\(])\+/g,"$1"));
			
			var reg_g:RegExp=/(\([^\(\)]+\)|[\+\-]\w+(?:\*[\+\-]\w+)*)\*(\([^\(\)]+\)|[\+\-]\w+(?:\*[\+\-]\w+)*)/g;
			var reg:RegExp=new RegExp("^"+reg_g.source+"$");
			
			do{
				
				var oldCode:String=code;
				
				for each(var matchStr:String in code.match(reg_g)){
					if(matchStr.search(/[\(\)]/)>-1){
						var execResult:Array=reg.exec(matchStr);
						var arr1:Array=execResult[1].match(itemReg_g);
						var arr2:Array=execResult[2].match(itemReg_g);
						var normalizeSeg:String="";
						for each(var item1:String in arr1){
							for each(var item2:String in arr2){
								normalizeSeg+=item1+"*"+item2;
							}
						}
						code=code.replace(matchStr,"("+normalizeSeg+")");
					}
				}
				
				code=removeInnerBrackets(code);
				//trace(code.replace(/([\*\(])\+/g,"$1"));
				
			}while(oldCode!=code);
			
			//trace("===========================");
			
			code="("+code+")";
			for each(var groupStr:String in code.match(/\([^\(\)]+\)/g)){
				
				//trace("groupStr="+groupStr);
				
				var normalizeSegArr:Array=new Array();
				var mark:Object=new Object();
				for each(matchStr in groupStr.match(itemReg_g)){
					//trace("matchStr="+matchStr);
					normalizeSeg=matchStr;
					var negArr:Array=normalizeSeg.match(/\-/g);
					
					if(negArr&&(negArr.length%2==1)){
						var neg:Boolean=true;
					}else{
						neg=false;
					}
					//trace("neg="+neg);
					
					normalizeSeg=matchStr.replace(/\-/g,"+");
					
					var arr:Array=normalizeSeg.split("*");
					arr.sort();
					normalizeSeg=arr.join("*");
					if(mark.hasOwnProperty(normalizeSeg)){
					}else{
						normalizeSegArr.push(normalizeSeg);
						mark[normalizeSeg]=0;
					}
					if(neg){
						mark[normalizeSeg]--;
					}else{
						mark[normalizeSeg]++;
					}
				}
				var normalizeGroup:String="";
				for each(normalizeSeg in normalizeSegArr){
					//trace("normalizeSeg="+normalizeSeg);
					//trace(mark[normalizeSeg]);
					switch(mark[normalizeSeg]){
						case 0:
							//
						break;
						case 1:
							normalizeGroup+=normalizeSeg;
						break;
						case -1:
							normalizeGroup+="-"+normalizeSeg.substr(1);
						break;
						default:
							normalizeGroup+=(mark[normalizeSeg]>0?"+":"")+mark[normalizeSeg]+"*"+"("+normalizeSeg+")";
						break;
					}
				}
				
				code=code.replace(groupStr,"("+normalizeGroup+")");
			}
			
			//trace(code);
			
			code=removeInnerBrackets(code).replace(/([\*\(])\+/g,"$1");
			
			//trace(code);
			
			return code;
		}
		
		
		private static function removeInnerBrackets(code:String):String{
			while(true){
				var matchArr:Array=code.match(/(?<![\*\/=])\([^\(\)]+\)(?![\*\/=])/);
				if(matchArr&&matchArr.length){
					var normalizeSeg:String=matchArr[0].replace(/\(([^\(\)]+)\)/,"$1");
					if(code.charAt(code.search(/(?<![\*\/=])\([^\(\)]+\)(?![\*\/=])/)-1)=="-"){
						var itemArr:Array=normalizeSeg.match(itemReg_g);
						normalizeSeg="";
						for each(var item:String in itemArr){
							normalizeSeg+=(item.charAt(0)=="-"?"+":"-")+item.substr(1);
						}
						code=code.replace(/(?<![\*\/=])\-\([^\(\)]+\)(?![\*\/=])/,normalizeSeg);
					}else{
						code=code.replace(/(?<![\*\/=])(\+)?\([^\(\)]+\)(?![\*\/=])/,normalizeSeg);
					}
					//trace("  code="+code);
				}else{
					break;
				}
			}
			
			return code;
		}
	}
}