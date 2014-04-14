package akdcl.math {

	public class AkdclMath {
		//按照数组提示产生[a1，a2]的随机因子(如果数组都为0则返回a2+1)
		public static function rdm_a(_n0:Number, _n1:Number, _list:Array):Number {
			var _max:Number = 0;
			var _rdm:Number = Math.random();
			var _last:uint = 0;
			var _list:Array = _list.concat();
			for (var _i:int = _list.length - 1; _i >= 0; _i--){
				for (var _j:int = 0; _j < _i; _j++){
					_list[_i] = Number(_list[_i]);
					_list[_i] += Number(_list[_j]);
				}
				_max < Number(_list[_i]) && (_max = Number(_list[_i]));
				_list[_i] /= _max;
				if (_rdm >= Number(_list[_i])){
					_last = _i + 1;
					break;
				}
			}
			return _n0 + _last * (_n1 - _n0) / (_list.length - 1);
		}

		//操作数组
		public static function disorder(arr:Array):void {
			var L:uint = arr.length;
			var ran:uint;
			var temp:*;
			for (var i:uint = 0; i < L; i++){
				ran = Math.random() * L;
				temp = arr[i];
				arr[i] = arr[ran];
				arr[ran] = temp;
			}
		}

		public static function distance(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			return Math.sqrt(distanceSquared(_x0, _y0, _xt, _yt));
		}
		
		public static function distanceSquared(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			var _dx:Number = _xt - _x0;
			var _dy:Number = _yt - _y0;
			return _dx * _dx + _dy * _dy;
		}

		//_n小于_nMin返回_nMin，大于_nMax返回_nMax，反之返回_n
		public static function numRange(_n:Number, _nMin:Number, _nMax:Number):Number {
			if (_n < _nMin){
				return _nMin;
			} else if (_n > _nMax){
				return _nMax;
			}
			return _n;
		}

		//small<n<big；-1，0，1
		public static function s_b(n:Number, a:Number, b:Number):int {
			if (a < n && n < b){
				return 0;
			} else if (n <= a){
				return -1;
			} else {
				return 1;
			}
		}

		//|n|>0,t;|n|<0,-t;|n|==0,0
		public static function vpNum(_n:Number, _t:Number = 1):Number {
			if (_n == 0){
				return 0;
			} else if (_n > 0){
				return _t;
			} else {
				return -_t;
			}
		}

		//返回矩形区域最小正边长
		public static function sideMin(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			var _nDx:Number = _xt - _x0;
			var _nDy:Number = _yt - _y0;
			if (_nDx < 0) {
				_nDx = -_nDx;
			}
			if (_nDy < 0) {
				_nDy = -_nDy;
			}
			return _nDx > _nDy?_nDy:_nDx;
		}

		//返回矩形区域最大正边长
		public static function sideMax(_x0:Number, _y0:Number, _xt:Number, _yt:Number):Number {
			var _nDx:Number = _xt - _x0;
			var _nDy:Number = _yt - _y0;
			if (_nDx < 0) {
				_nDx = -_nDx;
			}
			if (_nDy < 0) {
				_nDy = -_nDy;
			}
			return _nDx > _nDy?_nDx:_nDy;
		}

		//返回正常的弧度数
		public static function rFloor(r:Number):Number {
			if (r > Math.PI){
				r -= 2 * Math.PI;
			}
			if (r <= -Math.PI){
				r += 2 * Math.PI;
			}
			return r;
		}

		//返回正常的弧度数
		public static function rFloor360(r:Number):Number {
			if (r > 180){
				r -= 2 * 180;
			}
			if (r <= -180){
				r += 2 * 180;
			}
			return r;
		}

		//周期为T，振幅为A，相位为P[0，2PI]的函数对应x的y值（默认中心对称）曲线
		public static function trigonometric(x:Number, T:Number, A:Number):Number {
			var _nT:Number = Math.PI / T;
			return A * Math.sin(_nT * x);
		}

		public static function fac(N:int):Number {
			//全称factorial阶乘
			var outN:Number = 1;
			for (var i:int = 1; i <= N; i++){
				outN *= i;
			}
			return outN;
		}

		public static function comb(A:uint, B:uint):Number {
			//全称Combination A中B项的组合数
			var outN:Number;
			if (B > A){
				outN = -1;
			} else {
				outN = fac(A) / (fac(A - B) * fac(B));
			}
			return outN;
		}

		public static function fullComb(N:uint):Number {
			//全组合，即P10-1到P10-10的和
			var outN:Number = 0;
			for (var i:uint = 1; i <= N; i++){
				outN += comb(N, i);
			}
			return outN;
		}

		public static function addup(N:int):Number {
			//累加
			var outN:Number = (1 + N) / 2 * N;
			return outN;
		}

		public static function getComb(List:Array, amount:uint):Array {
			var opA:Array = [Math.pow(2, amount) - 1];
			var outA:Array = new Array();
			amount < List.length && operationComb(opA[0], List.length, opA);
			for (var i:int = 0; i < opA.length; i++){
				outA.push(getNameByCode(opA[i], List));
			}
			return outA;
		}

		public static function getMax(n:Array):Array {
			var test:Boolean = false;
			n[0] > n[1] ? n.splice(1, 1) : n.splice(0, 1);
			if (n.length > 1){
				test = true;
				n = getMax(n);
			}
			return n;
		}

		public static function getMin(n:Array):Array {
			var test:Boolean = false;
			n[0] < n[1] ? n.splice(1, 1) : n.splice(0, 1);
			if (n.length > 1){
				test = true;
				n = getMin(n);
			}
			return n;
		}

		//-----------------------
		static protected function operationComb(N:Number, Max:uint, inA:Array):void {
			var nowlevel:Array = N.toString(2).split("").reverse();
			for (var u:int = -1; u < nowlevel.length; u++){
				if (!nowlevel[u]){
					break;
				}
			}
			if (u < Max - 1){
				var now:uint = N.toString(2).length - 1;
				for (var i:int = now; i >= 0; i--){
					N += Math.pow(2, i);
					if (N & Math.pow(2, i)){
						break;
					}
					if (N.toString(2).length < Max){
						operationComb(N, Max, inA);
					}
					inA.push(N);
				}
			}
		}

		static protected function getNameByCode(code:uint, List:Array):String {
			var outString:String = "";
			for (var i:uint = 0; i < List.length; i++){
				if (code & Math.pow(2, i)){
					outString += List[i];
				}
			}
			return outString;
		}
	}
}