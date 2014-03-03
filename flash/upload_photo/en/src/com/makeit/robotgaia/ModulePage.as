package com.makeit.robotgaia {
	import com.greensock.TweenLite;
	import org.robotlegs.core.IInjector;
	import org.swiftsuspenders.Injector;
	import org.robotlegs.utilities.modular.core.IModuleContext;
	import org.robotlegs.utilities.modular.core.IModule;
	import com.gaiaframework.api.Gaia;
	import com.gaiaframework.api.IAsset;
	import com.gaiaframework.api.IBase;
	import com.gaiaframework.api.IBitmap;
	import com.gaiaframework.api.IBitmapSprite;
	import com.gaiaframework.api.IByteArray;
	import com.gaiaframework.api.IDisplayObject;
	import com.gaiaframework.api.IGaia;
	import com.gaiaframework.api.IJson;
	import com.gaiaframework.api.IMovieClip;
	import com.gaiaframework.api.INetStream;
	import com.gaiaframework.api.IPage;
	import com.gaiaframework.api.IPageAsset;
	import com.gaiaframework.api.IPreloader;
	import com.gaiaframework.api.ISound;
	import com.gaiaframework.api.ISprite;
	import com.gaiaframework.api.IStyleSheet;
	import com.gaiaframework.api.IText;
	import com.gaiaframework.api.IXml;
	import com.gaiaframework.assets.AbstractAsset;
	import com.gaiaframework.assets.AssetCreator;
	import com.gaiaframework.assets.AssetLoader;
	import com.gaiaframework.assets.AssetTypes;
	import com.gaiaframework.assets.BitmapAsset;
	import com.gaiaframework.assets.BitmapSpriteAsset;
	import com.gaiaframework.assets.ByteArrayAsset;
	import com.gaiaframework.assets.DisplayObjectAsset;
	import com.gaiaframework.assets.JSONAsset;
	import com.gaiaframework.assets.MovieClipAsset;
	import com.gaiaframework.assets.NetStreamAsset;
	import com.gaiaframework.assets.PageAsset;
	import com.gaiaframework.assets.SEOAsset;
	import com.gaiaframework.assets.SoundAsset;
	import com.gaiaframework.assets.SpriteAsset;
	import com.gaiaframework.assets.StyleSheetAsset;
	import com.gaiaframework.assets.TextAsset;
	import com.gaiaframework.assets.XMLAsset;
	import com.gaiaframework.templates.AbstractPage;
	import com.greensock.TweenMax;
	/**
	 * @author Happy
	 */
	public class ModulePage extends AbstractPage implements IModule {
		
		protected var context:IModuleContext;
		protected var _parentInjector:IInjector;
		public function ModulePage() {
			super();
			
		}

		override public function transitionIn() : void {
			TweenLite.to(this, .5, {alpha:1,onComplete:transitionInComplete});
			super.transitionIn();
		}

		override public function transitionOut() : void {
			TweenLite.to(this, .5, {alpha:0,onComplete:transitionOutComplete});
			super.transitionOut();
		}
		
		public function getClass(assets:DisplayObjectAsset,s:String):Class{
			return assets.loader.contentLoaderInfo.applicationDomain.getDefinition(s) as Class;
		}
		
		public function dispose():void{
        	if(context){
				context.dispose();
				context = null;
			}
			_parentInjector = null;
        }
        
		public function set parentInjector(value : IInjector) : void {
			_parentInjector=value;
        }
	}
	
}
