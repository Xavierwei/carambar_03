package com.makeit.utils {
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author quhuan
	 */
	public class FilterString extends EventDispatcher {
		public function FilterString() {
		}

		private var filter_ary : Array;
		private var str : String = 'h2blo草泥马fucking草泥马狗中共达赖狗日7%a的吃饭8a女优1';

		/** 读取外部敏感词库 **/
		private function getFilterLib() : void {
			var loader : URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoad);
			loader.load(new URLRequest('talkFilter.XML'));
		}

		/** 将敏感词库内容转换成数组 **/
		private function onLoad(e : Event) : void {
			var xml : String = e.target.data;
			xml = xml.replace(/\s+/g, "#");
			filter_ary = xml.split('#');
			trace('过滤前:' + str);
			filterHandler();
		}

		/** 过滤 **/
		private function filterHandler() : void {
			var replace : String;
			var filter_length : uint = filter_ary.length;

			for (var i : int = 0; i < filter_length;i++) {
				replace = '';
				for (var j : int = 0; j < filter_ary[i].length;j++) {
					replace += '*';
				}
				str = str.replace(new RegExp(filter_ary[i], 'g'), replace);
			}
			trace('过滤后:' + str);
		}
	}
}
