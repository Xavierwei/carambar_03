package ui.transformTool
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	import flash.display.Sprite;
	internal class SpriteClass extends Sprite
	{
		private var _sprite:Sprite;
		private var _shape:ShapeClass;
		public function SpriteClass():void
		{
			_sprite = this;
			_shape = new ShapeClass();
			
			_shape.Clear();
			_sprite.addChild(_shape);
			
		}
		public function get shape():ShapeClass {
			return _shape;
		}
	}
}