package com.util.http
{
	public class HttpParameter
	{
		private var _mName:String;
		private var _mValue:String;
		
		public function HttpParameter(name:String, value:String)
		{
			this._mName = name;
			this._mValue = value;
		}

		public function get mValue():String
		{
			return _mValue;
		}

		public function get mName():String
		{
			return _mName;
		}
	}
}