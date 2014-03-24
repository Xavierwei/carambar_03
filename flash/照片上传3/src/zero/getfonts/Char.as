/***
Char
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年7月31日 21:38:37
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.getfonts{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.SHAPE;
	import zero.swf.records.texts.ZONERECORD;
	
	public class Char{
		public var code:int;//DefineFont3.CodeV
		public var GlyphShape:SHAPE;//DefineFont3.GlyphShapeV
		public var FontAdvance:int;//DefineFont3.fontLayout.FontAdvanceV
		public var FontBounds:RECT;//DefineFont3.fontLayout.FontBoundsV
		public var ZoneRecord:ZONERECORD;//DefineFontAlignZones.ZoneRecordV
		public function Char(){
		}
		public function clear():void{
			GlyphShape=null;
			FontBounds=null;
			ZoneRecord=null;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=code;
			data[1]=code>>8;
			data.position=2;
			data.writeBytes(GlyphShape.toData(null));
			if(FontBounds){
				data[data.length]=FontAdvance;
				data[data.length]=FontAdvance>>8;
				data.position=data.length;
				data.writeBytes(FontBounds.toData(null));
			}
			if(ZoneRecord){
				data.writeBytes(ZoneRecord.toData(null));
			}
			return data;
		}
	}
}