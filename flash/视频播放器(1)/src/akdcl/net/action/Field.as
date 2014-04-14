package akdcl.net.action {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;

	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import fl.controls.Label;

	import akdcl.manager.RequestManager;
	import akdcl.events.UIEventDispatcher;
	import akdcl.utils.stringToBoolean;
	import akdcl.utils.replaceString;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Field extends UIEventDispatcher {

		public static const A_REQUIRED:String = "required";
		public static const A_LEAST:String = "least";
		public static const A_MOST:String = "most";
		public static const A_REG:String = "reg";
		public static const A_STYLE_TYPE:String = "styleType";
		public static const A_RESTRICT:String = "restrict";
		public static const A_ROW_COUNT:String = "rowCount";
		public static const A_PROMPT:String = "prompt";
		public static const A_EDITABLE:String = "editable";
		public static const A_HINT:String = "hint";
		
		public static const A_PASSWORD:String = "password";

		public static const ST_TEXT_INPUT:String = "TextInput";
		public static const ST_TEXT_AREA:String = "TextArea";
		public static const ST_COMBO_BOX:String = "ComboBox";
		public static const ST_RADIO_BUTTON:String = "RadioButton";
		public static const ST_CHECK_BOX:String = "CheckBox";
		public static const ST_CHECK:String = "Check";
		
		public static const ST_LABEL:String = "Label";

		public static const STRING_DEFAULT:String = "";

		public static const VALUE_UNSELECT:int = -1;
		public static const VALUE_UNINPUT:String = "";

		public static const ERROR_UNSELECTED:String = "errorUnselected";
		public static const ERROR_UNINPUT:String = "errorUninput";
		public static const ERROR_LEAST:String = "errorLeast";
		public static const ERROR_MOST:String = "errorMost";
		public static const ERROR_LEAST_CHAR:String = "errorLeastChar";
		public static const ERROR_MOST_CHAR:String = "errorLeastChar";
		public static const ERROR_REG:String = "errorREG";
		public static const ERROR_UNINPUT_CUSTOM:String = "errorUndataCustom";

		//√×✔✘☜☞
		public static var TIP_ERROR_UNSELECTED:String = "×请选择${" + RemoteAction.A_LABEL + "}";
		public static var TIP_ERROR_UNINPUT:String = "×请输入${" + RemoteAction.A_LABEL + "}";
		public static var TIP_ERROR_REG:String = "×${" + RemoteAction.A_LABEL + "}输入不正确";
		public static var TIP_ERROR_UNINPUT_CUSTOM:String = "×请输入${" + RemoteAction.A_LABEL + "}的自定义项";
		
		public static var TIP_ERROR_LEAST:String = "×请至少选择${" + A_LEAST + "}项";
		public static var TIP_ERROR_MOST:String = "×至多仅能选择${" + A_MOST + "}项";
		public static var TIP_ERROR_LEAST_CHAR:String = "×请至少输入${" + A_LEAST + "}位字符";
		public static var TIP_ERROR_MOST_CHAR:String = "×至多仅能输入${" + A_LEAST + "}位字符";

		public static var TIP_REQUIRED_COMPLETE:String = "√";
		public static var TIP_REQUIRED:String = "*";
		
		protected static const rM:RequestManager = RequestManager.getInstance();

		private static const OFFY_LABEL:uint = 2;
		
		protected static function testStringReg(_str:String, _regStr:String):Boolean {
			if (_regStr) {
				var _reg:RegExp = new RegExp(_regStr);
				return _reg.test(_str);
			}else {
				return true;
			}
		}

		protected static function setHtmlColor(_str:String, _color:String):String {
			return "<font color='" + _color + "'>" + _str + "</font>";
		}
		
		public var x:int;
		public var y:int;
		public var width:uint;
		public var height:uint;
		public var followLabelToBottom:Boolean = false;
		
		public var required:Boolean;
		
		protected var __data:*;
		public function get data():*{
			return __data;
		}
		public function set data(_data:*):void{
			
		}
		
		public function get orgData():* {
			return data;
		}
		
		protected var options:XML;
		protected var formAction:FormAction;
		protected var container:DisplayObjectContainer;
		protected var style:FormStyle;
		
		protected var view:*;
		protected var label:Label;
		protected var followLabel:Label;
		protected var blendField:Field;
		
		protected var reg:String;
		protected var least:uint;
		protected var most:uint;
		protected var timeOutID:uint;
		
		public function Field(_name:String) {
			name = _name;
			super();
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			clear();
			options = null;
			formAction = null;
			container = null;
			style = null;
			//
			label = null;
			followLabel = null;
			view = null;
			blendField = null;
			
			name = null;
			reg = null;
			//不完善
		}
		
		public function clear():void {
			isInputComplete(false);
		}

		public function setOptions(_xml:XML, _formAction:FormAction, _x:int = 0, _y:int = 0):void {
			options = _xml;
			formAction = _formAction;
			x = _x;
			y = _y;
			container = formAction.container;
			style = formAction.style;
			width = style.width + style.widthLabel + 1;
			height = style.height;
			
			name = options.attribute(RemoteAction.A_NAME)[0];
			required = stringToBoolean(options.attribute(A_REQUIRED)[0]);
			reg = options.attribute(A_REG)[0];
			least = int(options.attribute(A_LEAST)[0]);
			most = int(options.attribute(A_MOST)[0]);
			
			setLabels();
			
			var _source:String = options.attribute(RemoteAction.A_SOURCE)[0];
			if (_source && options.elements(RemoteAction.E_CASE).length() <= 0) {
				if (RemoteAction.isRemoteNode(options)) {
					var _remoteAction:RemoteAction = new RemoteAction(options);
					_remoteAction.addEventListener(Event.COMPLETE, onOptionsCompleteHandler);
					_remoteAction.sendAndLoad();
				}else {
					var _otherFieldName:String = RemoteAction.getValue(_source, 0);
					blendField = formAction.getField(_otherFieldName);
					if (blendField) {
						//绑定其他Field的数据
						blendField.addEventListener(Event.CHANGE, onBlendFieldChangeHandler);
					}else {
						//xml远程列表
						rM.load(_source, onOptionsCompleteHandler);
					}
				}
			}
			setView();
		}
		
		//返回true（字段为非必要且没有数据）,false（没有数据或数据非法）或data（数据）
		public function isInputComplete(_checkUndata:Boolean = true):* {
			var _data:*= data;
			if (_data === VALUE_UNSELECT){
				_data = ERROR_UNSELECTED;
			} else if (_data === VALUE_UNINPUT){
				_data = ERROR_UNINPUT;
			} else if (_data is String){
				if (least && _data.length < least){
					_data = ERROR_LEAST_CHAR;
				} else if (most && _data.length > most){
					_data = ERROR_MOST_CHAR;
				} else if (testStringReg(_data, reg)){
					//通过
				} else {
					_data = ERROR_REG;
				}
			} else if (_data is Number){
				//通过
			} else if (_data is Array){
				if (least && _data.length < least){
					_data = ERROR_LEAST;
				} else if (most && _data.length > most){
					_data = ERROR_MOST;
				} else if (_data[_data.length - 1] is String){
					var _customData:String = _data[_data.length - 1];
					if (_customData){
						if (testStringReg(_customData, reg)){
							//通过
						} else {
							_data = ERROR_REG;
						}
					} else {
						_data = ERROR_UNINPUT_CUSTOM;
					}
				} else {
					//通过
				}
			} else if (_data){
				//通过（其他数据格式）
			} else {
				_data = ERROR_UNSELECTED;
			}
			//
			var _isComplete:Boolean;
			var _hint:String = STRING_DEFAULT;
			var _isBottom:Boolean;
			switch (_data){
				case ERROR_UNSELECTED:
					if (required && _checkUndata){
						_hint = setHtmlColor(formatString(TIP_ERROR_UNSELECTED), style.colorError);
						_isBottom = true;
					} else {
						_hint = setHtmlColor(getNormalFollowText(), style.colorNormal);
					}
					break;
				case ERROR_UNINPUT:
					if (required && _checkUndata){
						_hint = setHtmlColor(formatString(TIP_ERROR_UNINPUT), style.colorError);
						_isBottom = true;
					} else {
						_hint = setHtmlColor(getNormalFollowText(), style.colorNormal);
					}
					break;
				case ERROR_UNINPUT_CUSTOM:
					_hint = setHtmlColor(formatString(TIP_ERROR_UNINPUT_CUSTOM), style.colorError);
					_isBottom = true;
					break;
				case ERROR_LEAST:
					_hint = setHtmlColor(formatString(TIP_ERROR_LEAST), style.colorError);
					_isBottom = true;
					break;
				case ERROR_MOST:
					_hint = setHtmlColor(formatString(TIP_ERROR_MOST), style.colorError);
					_isBottom = true;
					break;
				case ERROR_LEAST_CHAR:
					_hint = setHtmlColor(formatString(TIP_ERROR_LEAST_CHAR), style.colorError);
					_isBottom = true;
					break;
				case ERROR_MOST_CHAR:
					_hint = setHtmlColor(formatString(TIP_ERROR_MOST_CHAR), style.colorError);
					_isBottom = true;
					break;
				case ERROR_REG:
					_hint = setHtmlColor(formatString(TIP_ERROR_REG), style.colorError);
					_isBottom = true;
					break;
				default:
					_isComplete = true;
					if (required){
						_hint = setHtmlColor(formatString(TIP_REQUIRED_COMPLETE), style.colorComplete);
					} else {
						_hint = setHtmlColor(getNormalFollowText(), style.colorNormal);
					}
			}
			hint(_hint,_isBottom);

			clearTimeout(timeOutID);
			timeOutID=setTimeout(fixComponentTextY, 45);

			if (_isComplete){
				//需要format数据
				return _data;
			} else if (!required && (_data === ERROR_UNSELECTED || _data === ERROR_UNINPUT)){
				//字段为非必要且没有数据
				return true;
			} else {
				//没有数据或数据非法
				return false;
			}
		}
		
		protected function setLabels():void {
			if (label){
			} else {
				label = new Label();
			}
			label.enabled = false;
			label.mouseChildren = false;
			label.mouseEnabled = false;
			label.autoSize = TextFieldAutoSize.RIGHT;
			//
			var _eLabel:XML = options.elements(RemoteAction.A_LABEL)[0];
			var _aLabel:XML = options.attribute(RemoteAction.A_LABEL)[0];
			if (_eLabel) {
				label.htmlText = replaceString(_eLabel.text().toXMLString());
			}else if (_aLabel) {
				label.htmlText = setHtmlColor(_aLabel, style.colorLabel);
			}else {
				label.htmlText = replaceString(options.text().toXMLString());
			}
			//
			if (followLabel){
			} else {
				followLabel = new Label();
			}
			followLabel.enabled = false;
			followLabel.mouseChildren = false;
			followLabel.mouseEnabled = false;
			followLabel.autoSize = TextFieldAutoSize.LEFT;
		}
		
		protected function setView():void {
			/*case ST_LABEL:
					view = _view || label;
					view.autoSize = TextFieldAutoSize.LEFT;
					view.wordWrap = true;
					break;*/
		}
		
		protected function setViewStyle():void {
			label.x = x;
			label.y = y;
			label.width = style.widthLabel;
			
			hint(setHtmlColor(getNormalFollowText(), style.colorNormal), false);
			container.addChild(label);
			container.addChild(followLabel);
			fixComponentTextY();
		}
		
		protected function onOptionsCompleteHandler(_evtOrData:*):void {
			if (_evtOrData is Event) {
				var _remoteAction:RemoteAction = _evtOrData.currentTarget;
				if (_remoteAction.data is Array) {
					//暂支持第一层数组，后续支持自动解析对象
					for each(var _item:Object in _remoteAction.data) {
						options.appendChild(<{RemoteAction.E_CASE} {RemoteAction.A_LABEL}={_item[RemoteAction.A_LABEL]} {RemoteAction.A_VALUE}={_item[RemoteAction.A_VALUE]}/>);
					}
				}
				_remoteAction.remove();
			}else {
				options.appendChild(_evtOrData.elements(RemoteAction.E_CASE));
			}
			setView();
		}
		
		protected function fixComponentTextY():void {
			clearTimeout(timeOutID);
			label.textField.y = OFFY_LABEL;
			followLabel.textField.y = OFFY_LABEL;
		}

		protected function onChangeHandler(_e:Event):void {
			if (hasEventListener(Event.CHANGE)){
				dispatchEvent(_e);
			}
		}
		
		protected function onBlendFieldChangeHandler(_e:Event):void {
			
		}

		protected function onFocusInHandler(_e:Event):void {
			hint(setHtmlColor(formatString(options.attribute(A_HINT)), style.colorHint), true);
		}

		protected function onFocusOutHandler(_e:Event):void {
			isInputComplete(false);
		}

		protected function hint(_htmlString:String, _isBottom:Boolean = false):void {
			if (followLabel){
				followLabel.htmlText = _htmlString;

				if (_isBottom && followLabelToBottom){
					followLabel.x = x + style.widthLabel + 1;
					followLabel.y = y + height;
				} else {
					followLabel.x = x + width + 1;
					followLabel.y = y;
				}
			}
		}

		protected function setEachItem(_item:*, _i:uint, _id:uint):uint {
			var _width:uint = int(options.style.@width);
			if (_i > 0){
				var _itemPrev:* = view[_i - 1];
				if (_width == 0){
					_item.x = _itemPrev.x + _itemPrev.getRect(_itemPrev).width;
					_item.y = y;
				} else if (_width <= options.elements(RemoteAction.E_CASE).length()){
					_id = _i % _width;
					if (_id > 0){
						_item.x = _itemPrev.x + _itemPrev.getRect(_itemPrev).width;
					} else {
						_item.x = view[0].x;
					}
					_item.y = y + (style.height + style.dyFF) * int(_i / _width);
				} else {
					_width = Math.max(_width, style.width);
					if (_itemPrev.x + _itemPrev.width - view[0].x > _width){
						_id++;
						_item.x = view[0].x;
					} else {
						_item.x = _itemPrev.x + _itemPrev.getRect(_itemPrev).width;
					}
					_item.y = y + (style.height + style.dyFF) * _id;
				}
				
				width = Math.max(style.width, _item.x + _item.getRect(_item).width - view[0].x) + style.widthLabel + 1;
			} else {
				_item.x = x + style.widthLabel + 1;
				_item.y = y;
			}
			return _id;
		}

		protected function getNormalFollowText():String {
			if (required){
				return TIP_REQUIRED;
			} else {
				return STRING_DEFAULT;
			}
		}

		protected function formatString(_str:String):String {
			for each (var _eachAtt:XML in options.attributes()){
				_str = RemoteAction.replaceValue(_str, _eachAtt.name(), _eachAtt).replace(/：/g,"");
			}
			return _str;
		}
	}
}