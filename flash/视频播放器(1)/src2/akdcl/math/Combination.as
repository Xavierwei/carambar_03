package akdcl.math{
	import akdcl.math.AkdclMath;
	public class Combination {
		protected var _combinationList:Array=new Array  ;
		protected var _elementList:Array=new Array  ;
		protected var _length:uint=0;
		protected var _fieldName:String;
		protected var _codeArray:Array=new Array  ;
		public function Combination(elementList:Array,fieldName:String="name"):void {
			this._elementList=elementList;
			this._length=this._elementList.length;
			this._fieldName=fieldName;
			this.buildList();
		}
		protected function buildList():void {
			var max:uint=this._elementList.length;
			for (var i:uint=0; i<=AkdclMath.fullComb(max); i++) {
				//var nowCode:String=(Math.pow(2,max)+i).toString(2).slice(1,max+1)
				var nowName:String=this.getNameByCode(i);
				var nowLevel:uint=this.getLevel(i);
				this._codeArray.push(nowName);
				if (! this._combinationList[nowLevel]) {
					this._combinationList[nowLevel]=new Array();
				}
				this._combinationList[nowLevel].push({name:nowName,code:i});
			}
			//this._codeArray.sort()
			for (i=0; i<this._combinationList.length; i++) {
				this._combinationList[i].sortOn(this._fieldName,Array.CASEINSENSITIVE);
			}
			//trace(this._codeArray+ "   "+max)
		}
		protected function getLevel(code:uint):uint {
			var outN:uint=0;
			for (var i:uint=0; i<this._elementList.length; i++) {
				if (code&Math.pow(2,i)) {
					outN++;
				}
			}
			return outN;
		}
		public function getNameByCode(code:uint):String {
			var outString:String="";
			for (var i:uint=0; i<this._elementList.length; i++) {
				if (code&Math.pow(2,i)) {
					outString+=this._elementList[i];
				}
			}
			return outString;
		}
		public function getList(Length:uint=0):Array {
			var outArray:Array=new Array();
			if (! Length) {
				Length=this._elementList.length;
				for (var i:int=0; i<this._combinationList.length; i++) {
					for (var l:int=0; l<this._combinationList[i].length; l++) {
						outArray.push(this._combinationList[i][l]);
					}
				}
			} else {
				for (l=0; l<this._combinationList[Length].length; l++) {
					outArray.push(this._combinationList[Length][l]);
				}
			}
			return outArray;
		}
		public function getNameList(Length:uint=0):Array {
			var outArray:Array=new Array();
			if (! Length) {
				Length=this._elementList.length;
				for (var i:int=0; i<this._combinationList.length; i++) {
					for (var l:int=0; l<this._combinationList[i].length; l++) {
						outArray.push(this._combinationList[i][l].name);
					}
				}
			} else {
				for (l=0; l<this._combinationList[Length].length; l++) {
					outArray.push(this._combinationList[Length][l].name);
				}
			}
			return outArray;
		}
		public function getCodeList(Length:uint=0):Array {
			var outArray:Array=new Array();
			if (! Length) {
				Length=this._elementList.length;
				for (var i:int=0; i<this._combinationList.length; i++) {
					for (var l:int=0; l<this._combinationList[i].length; l++) {
						outArray.push(this._combinationList[i][l].code);
					}
				}
			} else {
				for (l=0; l<this._combinationList[Length].length; l++) {
					outArray.push(this._combinationList[Length][l].code);
				}
			}
			return outArray;
		}
		public function get combinationList():Array {
			return this.getList();
		}
		public function get length():uint {
			return this._length;
		}
	}
}