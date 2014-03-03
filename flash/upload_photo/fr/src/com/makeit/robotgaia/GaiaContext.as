package com.makeit.robotgaia {
	import org.robotlegs.base.ViewInterfaceMediatorMap;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;

	import flash.system.ApplicationDomain;

	import org.robotlegs.core.IInjector;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Happy
	 */
	public class GaiaContext extends ModuleContext {
		public function GaiaContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true, parentInjector : IInjector = null, applicationDomain : ApplicationDomain = null) {
			super(contextView, autoStartup, parentInjector, applicationDomain);
		}

		override protected function get mediatorMap() : IMediatorMap {
			return _mediatorMap ||= new ViewInterfaceMediatorMap(contextView, createChildInjector(), reflector);
		}
		override protected function set mediatorMap(value : IMediatorMap) : void {
			super.mediatorMap = value;
		}

	}
}
