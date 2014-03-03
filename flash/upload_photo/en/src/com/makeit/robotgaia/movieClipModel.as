package com.makeit.robotgaia {
	import org.robotlegs.utilities.modular.core.IModuleContext;
	import org.robotlegs.core.IContext;
	import flash.display.MovieClip;
	import org.robotlegs.utilities.modular.core.IModule;
	import org.robotlegs.core.IInjector;

	/**
	 * @author Happy
	 */
	public class movieClipModel extends MovieClip implements IModule {
		protected var _parentInjector:IInjector;
		protected var _context:IModuleContext;
		public function dispose() : void {
			if(_context){
				_context.dispose();
				_context = null;
			}
		}
		[Inject]
		public function set parentInjector(value : IInjector) : void {
			_parentInjector=value;
		}
	}
}
