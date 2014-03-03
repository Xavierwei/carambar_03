package com.makeit.net
{
    import flash.external.ExternalInterface;
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;   
	/**
	 * 用来获取URL地址后所带参数值对
	 * import com.reintroducing.utils.QueryString;
	*	var qs:QueryString = QueryString.getInstance();
	*	trace(qs.getValue("var1"));
	 */
    /**
     * Singleton used to grab data out of the query string.
     *
     * @author Matt Przybylski [http://www.reintroducing.com]
     * @version 1.1
	 */
	public class QueryString
    {
//- PRIVATE & PROTECTED VARIABLES -------------------------------------------------------------------------
 
        // singleton instance
        private static var _instance:QueryString;
        private static var _allowInstance:Boolean;
       
        private var _pairDict:Dictionary;
        private var _url:String;
        private var _pairs:Array;
       
//- PUBLIC & INTERNAL VARIABLES ---------------------------------------------------------------------------
       
       
       
//- CONSTRUCTOR -------------------------------------------------------------------------------------------
   
        // singleton instance of QueryString
        public static function getInstance():QueryString
        {
            if (QueryString._instance == null)
            {
                QueryString._allowInstance = true;
                QueryString._instance = new QueryString();
                QueryString._allowInstance = false;
            }
           
            return QueryString._instance;
        }

		public function QueryString()
        {
            this.parseValues();
           
            if (!QueryString._allowInstance)
            {
                throw new Error("Error: Use QueryString.getInstance() instead of the new keyword.");
            }
        }
       
//- PRIVATE & PROTECTED METHODS ---------------------------------------------------------------------------
       
        private function parseValues():void
        {
			
            this._url = ExternalInterface.call("document.location.search.toString");
            this._pairDict = new Dictionary(true);
            this._pairs = this._url.split("?")[1].split("&");
           
            var pairName:String;
            var pairValue:String;
           
            for (var i:int = 0; i <this._pairs.length; i++)
            {
                pairName = this._pairs[i].split("=")[0];
                pairValue = this._pairs[i].split("=")[1];
               
                this._pairDict[pairName] = pairValue;
            }
        }
       
//- PUBLIC & INTERNAL METHODS -----------------------------------------------------------------------------
   
        /**
         * Returns the value of the specified query string parameter.
         *
         * @param $val A string identifying the parameter for whose value you want to retrieve
         *
         * @return String The value for the given parameter
         */
        public function getValue($val:String):String
        {
			
            if (this._pairDict[$val] == null)
            {
                return "";
            }
            else
            {
                return this._pairDict[$val];
            }
        }
   
//- EVENT HANDLERS ----------------------------------------------------------------------------------------
   
       
   
//- GETTERS & SETTERS -------------------------------------------------------------------------------------
   
       
   
//- HELPERS -----------------------------------------------------------------------------------------------
   
        public function toString():String
        {
            return getQualifiedClassName(this);
        }
   
//- END CLASS ---------------------------------------------------------------------------------------------
    }
}