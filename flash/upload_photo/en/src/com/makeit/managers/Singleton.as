/**
我在大多数我的企业应用里都使用了这个类作为管理各种单例的核心类。
你在实际使用中要注意确保你的类继承了这个Singleton类， 
然后在视图中获取一个这个单例管理类的实例。继承这个基类你不但能够同时发送事件
，就如你的类继承了eventDispatcher一样， 同时通过这个Singleton 类，你能够合理管理内存使用，
不再用到的哪些单例能够从内存中删除。 这个类是一个简单的核心类， 
但能够在你的企业应用中发挥很大的作用。

var viewManager:ViewManager = Singleton.getInstance(ViewManager);

package com.justinimhoff.library.managers
{
    public class ViewManager extends Singleton{
    }
}



*/


package com.makeit.managers
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
 
    /**
     *
     * 通用单例管理基类， 继承此类来实现基类管理器。
     *
     */
    public class Singleton implements IEventDispatcher
    {
        /**
         * 内部字典保存类的实例
         * @private
         */
        private static var instanceDict:Dictionary = new Dictionary();
 
        /**
         * 把一个实例从字典删除，清理内存
         * @param managementClass
         *
         */
        public static function removeInstance(managementClass:Class):void
        {
            var instance:Singleton = instanceDict[managementClass];
            if (instance != null)
            {
                delete instanceDict[managementClass];
            }
        }
 
        /**
         * 得到实例
         * @return the single instance
         *
         */
        public static function getInstance(managementClass:Class):*
        {
            var instance:Singleton = instanceDict[managementClass];
            if (instance == null)
            {
                //创建单例管理类的实例
                instance = Singleton(new managementClass());
 
                if (instance == null)
                {
                    throw("getInstance can only be called for Classes extending Singleton");
                }
            }
            return instance;
        }
 
        /**
         * 供单例使用的消息派送实例
         */
        protected var dispatcher:EventDispatcher = new EventDispatcher();
 
        /**
         *
         * 我们只需要这个类的一个实例 - 单例一般比静态管理类更有优势
         */
        public function Singleton()
        {
            onConstructor();
        }
 
        /**
         * 使用此方法和内部的eventDispatcher交互
         * @param type
         * @param listener
         * @param useCapture
         * @param priority
         * @param useWeakReference
         *
         */
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }
 
        /**
         * 使用此方法和内部的eventDispatcher交互
         * @param type
         * @param listener
         * @param useCapture
         *
         */
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            dispatcher.removeEventListener(type, listener, useCapture);
        }
 
        /**
         * 使用此方法和内部的eventDispatcher交互
         * @param event
         * @return
         *
         */
        public function dispatchEvent(event:Event):Boolean
        {
            return dispatcher.dispatchEvent(event);
        }
 
        /**
         * 使用此方法和内部的eventDispatcher交互
         * @param type
         * @return
         *
         */
        public function hasEventListener(type:String):Boolean
        {
            return dispatcher.hasEventListener(type);
        }
 
        /**
         * 使用此方法和内部的eventDispatcher交互
         * @param type
         * @return
         *
         */
        public function willTrigger(type:String):Boolean
        {
            return dispatcher.willTrigger(type);
        }
 
        /**
         *
         * 概念上的内部构造函数， 实例化单例管理类
         */
        protected function onConstructor():void
        {
            var className:String = getQualifiedClassName(this);
			trace(className);
            var managementClass:Class = getDefinitionByName(className) as Class;
            if (managementClass == Singleton)
            {
                throw("Singleton is a base class that cannot be instantiated");
            }
            var instance:Singleton = instanceDict[managementClass];
            if (instance != null)
            {
                throw("Classes extending Singleton can only be instantiated once by the getInstance method");
            }
            else
            {
                instanceDict[managementClass] = this;
            }
        }
    }
}