/***
SubXMLLoader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月27日 14:38:20
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class SubXMLLoader{
		private static var xml:XML;
		private static var onLoadComplete:Function;
		private static var subXMLLoader:URLLoader;
		public static function loadSubXMLs(_xml:XML,_onLoadComplete:Function):void{
			xml=_xml;
			onLoadComplete=_onLoadComplete;
			subXMLLoader=new URLLoader();
			subXMLLoader.addEventListener(Event.COMPLETE,loadSubXMLComplete);
			loadSubXML();
		}
		private static function loadSubXML():void{
			var hasAttXMLXML:XML=getHasAttXMLXML(xml);
			if(hasAttXMLXML){
				subXMLLoader.load(new URLRequest(hasAttXMLXML.@xml.toString()));
				return;
			}
			subXMLLoader.removeEventListener(Event.COMPLETE,loadSubXMLComplete);
			subXMLLoader=null;
			if(onLoadComplete==null){
			}else{
				if(onLoadComplete.length==1){
					onLoadComplete(xml);
				}else{
					onLoadComplete();
				}
				onLoadComplete=null;
			}
		}
		private static function loadSubXMLComplete(...args):void{
			var subXML:XML=new XML(subXMLLoader.data);
			var hasAttXMLXML:XML=getHasAttXMLXML(xml);
			delete hasAttXMLXML.@xml;
			for each(var attXML:XML in subXML.attributes()){
				hasAttXMLXML["@"+attXML.name().toString()]=attXML.toString();
			}
			for each(var childXML:XML in subXML.children()){
				hasAttXMLXML.appendChild(childXML);
			}
			loadSubXML();
		}
		private static function getHasAttXMLXML(xml:XML):XML{
			for each(var subXML:XML in xml.children()){
				if(subXML.@xml.toString()){
					return subXML;
				}
				var hasAttXMLXML:XML=getHasAttXMLXML(subXML);
				if(hasAttXMLXML){
					return hasAttXMLXML;
				}
			}
			return null;
		}
	}
}