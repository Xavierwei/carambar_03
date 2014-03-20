/*
 * api model
 */
define(function( require , exports , model ){
    var $ = require('jquery');

    var _api = {
        indicateResult: {path: './count.php', method:'get'}
    };

    var _unloginErrorNum = -2000;
    var _needRefresh     = {};
    var _retry = {user:1};

    var _ajaxs = [];

    function _isFormatUrl ( url ){
        return !!/#\[.*\]/.test( url );
    }
    function _load ( api , data , success , error , complete ) {
        if ( typeof data == "function" ) {
            return arguments.callee(api, {} , data, success, error);
        }
        if( typeof data == "string" ){
            data = LP.query2json( data );
        }
        var ajaxConfig = _api[api];
        if ( !ajaxConfig ) { 
            ajaxConfig = {};
            ajaxConfig.path = api;
        }

        var method = ajaxConfig.method ;
        if ( !method )  {
            var res = /get/i.exec(api);
            method = (res && res.index == 0) ? "GET" : "POST";
        } else {
            method = method.toUpperCase();
        }

        var async = ajaxConfig.async;
        if ( async == undefined )  {
            async = true;
        }

        error = error || function(){
            if( _retry[ api ] ){
                doAjax();
            }
        };

        data = LP.mix( ajaxConfig.data || {} , data );

        var doAjax = function () {
			var req = $.ajax({
                  url      : _isFormatUrl( ajaxConfig.path ) ? LP.format( ajaxConfig.path , data ) : ajaxConfig.path
                , data     : data
                , type     : method
                , dataType : ajaxConfig.dataType || 'json'
                , cache    : ajaxConfig.cache || false
                , global   : ajaxConfig.alertOnError === false || ajaxConfig.global === false ? false : true
                , error    : error
                , complete : complete
                , async    : async
                , timeout  : ajaxConfig.timeout
                , success: function(e) {
                    if ( e && typeof e == "string" ) {
                        success(e);
                    } else {
                        _callback( e , api , success , error,  ajaxConfig , doAjax );
                    }
                }
            });

            _ajaxs.push( req );
			return req;
        }

        if ( ajaxConfig.needLogin === true || (ajaxConfig.needLogin !== false && method !== "GET") ) {
            // 如果不为GET的话，则默认是要登录的
            _execAfterLogin( doAjax , api );
        } else {
            return doAjax();
        }
    }

    // err
    // msg
    function _callback ( result, api, success, error, config , ajaxFn ) {
        if ( !result ) return;
        var alertOnError = config.alertOnError;

        var error_no = result['code'] || result['status'];
        //if( result.success === true ){
            error_no = 0;
        //}
        if ( error_no != 0 ) {
            if( alertOnError !== false ){
                // 如果是未登录错误，弹出登录框
                if( error_no == _unloginErrorNum ){
                    // TODO ..  show login tempalte
                    return;
                }
            }
            error && error( result['info'] , result );
        } else if ( success ) {
            success( result );
        }

        // 用于判断页面是否需要刷新
        if( _needRefresh[api] ) {
            _needRefresh[api] = false;
            // remove url hash
            setTimeout(function() { location.href = location.href.replace(/#.*/,''); } , 1000);
        }
    }

    function _execAfterLogin ( cb , api ) {
        if( !LP.isLogin() ) {
            if ( _api[api].forceNoRefresh != true )
                _needRefresh[api] = true;
            require.async('util' , function( exports ){
                exports.trigger('login' , cb );
            });

        } else if (cb) {
            cb();
        }
    }

    $(document).ajaxError(function(evt, xhr, ajaxOptions, thrownError) {
        try{
            if ( xhr.status == 200 || thrownError.match(/^Invalid JSON/)) {
            } else if ( thrownError !== "" ) {
            }
        } catch(e) {};
    });

    // for model
    exports.ajax = _load;
    exports.stop = function(){
        $.each( _ajaxs , function( i , req ){
            req && req.abort();
        } );
    }
});
