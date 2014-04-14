package akdcl.math{
	public class Compositor {
		protected var _compositorList:Array=new Array  ;
		protected var _elementList:Array=new Array  ;
		protected var _length:uint=0;
		public function Compositor(...elementList) {
			this._elementList=elementList;
			this._length=this._elementList.length;
			this.buildList();
		}
		protected function buildList():void {
			var tempN:Array=new Array  ;
			for (var m:uint=0; m<this._length; m++) {
				tempN.push(m);
			}
			for (var i:uint=0; i<this._length; i++) {
				var tempM:Array=tempN.slice();
				tempM.splice(i,1);
				getNext(this._elementList[i],tempM);
			}
			function getNext(inS:String,res:Array):void {
				var outS:String=inS;
				var nowLevel:uint=res.length;
				for (var l:uint=0; l<nowLevel; l++) {
					if (nowLevel>1) {
						var resN:Array=res.slice();
						resN.splice(l,1);
						getNext(outS+_elementList[res[l]],resN);
					} else {
						_compositorList.push(outS);
					}
				}
			}
		}
		public function get length():uint {
			return this._length;
		}
		public function getList():Array {
			return this._compositorList;
		}
	}
}