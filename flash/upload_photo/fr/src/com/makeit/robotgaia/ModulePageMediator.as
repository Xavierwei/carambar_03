package com.makeit.robotgaia {
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.utilities.modular.core.IModule;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Happy
	 */
	public class ModulePageMediator extends ModuleMediator {
		[Inject]
		public var view:IModule;

		[Inject]
		public var injector:IInjector;
		
		public function ModulePageMediator() {
			super()	;
		}
		override public function onRegister() : void
		{
			view.parentInjector = injector;
		}

		override public function onRemove() : void
		{
			view.dispose();
			view=null;
		}
	}
}
