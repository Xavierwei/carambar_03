package com.makeit.robotgaia {
	import flash.events.Event;
	import org.robotlegs.utilities.modular.mvcs.ModuleMediator;

	/**
	 * @author Happy
	 */
	public class popMediator extends ModuleMediator {
		[Inject]
		public var view:popWindow;
		public function popMediator() {
		}

		override public function onRegister() : void {
			addViewListener(popWindow.SET_POPMEDIATOR, setPOPMediatorHandler);
			super.onRegister();
		}

		override public function onRemove() : void {
			super.onRemove();
		}
		private function setPOPMediatorHandler(e:Event):void{
			mediatorMap.mapView(view.viewClass,view.mediatorClass);
			mediatorMap.createMediator(view);
		}

	}
}
