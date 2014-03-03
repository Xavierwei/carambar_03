package com.makeit.utils
{
	import flash.display.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;

	/**
	 * 1.对象池是存储对象的一个池,当不使用某个对象时,对象将放回到池中(内存中)可再次使用,避免又一次创建对象的过程,以及内存泄漏
	 * 2.FFilmation引擎使用此对象池主要重复使用Sprite 和 MovieClip,也可用于其他对象
	 */
	public class objectPool
	{

		private static var classInstances:Dictionary=new Dictionary(false);

		/**
		 * 此方法返回一个给定类的实例(生产对象),如果该对象存在对象池的数组中,则返回该对象,否则创建该对象
		 * @param c
		 * @return
		 */
		public static function CheckOut(c:Class):Object
		{
			trace(c)
			// 检索此类的可用对象列表
			if (!objectPool.classInstances[c])
				objectPool.classInstances[c]=new Array();
			var instances:Array=objectPool.classInstances[c];

			// 如果长度为0,则添加
			if (instances.length == 0)
			{
				instances.push(new c());
			}

			// 删除数组中最后一个元素,并返回该元素的值
			var r:Object=instances.pop();
			if (r is MovieClip)
				(r as MovieClip).gotoAndPlay(1);
			return r;

		}

		/**
		 * 将不再使用的对象放回到池中,供以后再次使用
		 * @param object
		 */
		public static function CheckIn(object:Object):void
		{

			if (!object)
				return;
			var c:Class=object.constructor as Class;

			if (object is MovieClip)
			{
				var m:MovieClip=object as MovieClip;
				m.gotoAndStop(1);
			}

			if (object is Sprite)
			{
				var s:Sprite=object as Sprite;
				s.graphics.clear();
			}

			if (object is Shape)
			{
				var sh:Shape=object as Shape;
				sh.graphics.clear();
			}

			if (object is DisplayObject)
			{

				var d:DisplayObject=object as DisplayObject;
				d.x=0;
				d.y=0;
				d.alpha=1;
				d.blendMode=BlendMode.NORMAL;
				d.cacheAsBitmap=false;
				d.filters=[];
				d.mask=null;
				d.rotation=0;
				d.scaleX=1;
				d.scaleY=1;
				d.scrollRect=null;
				d.visible=true;
				d.transform.matrix=new Matrix();
				d.transform.colorTransform=new ColorTransform();

			}

			if (!objectPool.classInstances[c])
				objectPool.classInstances[c]=new Array();
			var instances:Array=objectPool.classInstances[c];
			instances.push(object);

		}

		/**
		 * 使用此方法删除存储对象和释放一些内存
		 * @param c		从对象池中删除指定对象,无参数则删除全部
		 * @param isGC	是否需要强制垃圾回收
		 */
		public static function removes(c:Class=null,isGC:Boolean=false):void
		{

			if (c)
			{
				objectPool.classInstances[c]=null;
			}
			else
			{
				for (var i:* in objectPool.classInstances)
					objectPool.classInstances[i]=null;
			}
			if(isGC)
			{
				objectPool.garbageCollect();
			}
		}

		/**
		 * 显式调用垃圾收集器
		 * @private
		 */
		private static function garbageCollect():void
		{
			try
			{
				var hlcp:LocalConnection=new LocalConnection();
				var hlcs:LocalConnection=new LocalConnection();
				hlcp.connect('name');
				hlcs.connect('name');
			}
			catch (e:Error)
			{
				System.gc();
				System.gc();
			}
		}


	}

}