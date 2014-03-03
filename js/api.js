/*
 * api model
 */
define(function( require , exports , model ){
    var $ = require('jquery');
    // 公开的API
    // 签名：ajax = function ( api, data, successHandler, errorHandler, completeHandler ) {}
    // 备注：POST操作默认要登录，GET操作默认不需要登录
    //       默认是POST操作

    // api 配置
    //      path: {string} ajax path, 支持为seo处理的url。 例如/uid/#[uid], 只要在传的参数data中传递uid值，自动会把
                // #[uid] 替换成正确的值
    //      data: {object} ajax data
    //      info: {string} desc, this would used in net error info
    //      method: {string} ajax type ['get' | 'post' ] //  default is get
    //      dataType: {string} 返回的数据格式，默认是json
    //      cache: {boolean} 是否缓存
    //      alertOnError：{boolean} ajax出错的时候，是否需要强出提示，主要用于一些不重要的ajax，即使出错了，也不要告诉用户的
    //      global: {boolean} 是否触发全局的ajax错误处理
    //      timeout: {number} 超时时间
    //      needLogin: {boolean} 是否需要登录
    // 配置
    var _api = {
        // searchHosts: {path: '/Ajax/searchHosts' , data: {key: ''} , m: '检索小组' , method: 'get' },
        commentList: {path: './api/index.php/comment/list', method:'get'},
        recent: {path: './api/index.php/node/list', method: 'get', cache: true},
        getPageByNid: {path: './api/index.php/node/getPageByNid', method: 'get'},
        getNode: {path: './admin/app/json/node/photo.json'},
        nodeList: {path: './api/index.php/node/list?$orderby=datetime&pagenum=100'},
        tagTopThree: {path: './api/index.php/tag/topthree', method:'get'},
        deleteNode: {path: './api/index.php/node/delete', method:'post'},
        like: {path: './api/index.php/like/post'},
        unlike: {path: './api/index.php/like/delete'},
        // 
        flag: {path: './api/index.php/flag/post', method:'post'},
        flaggedComments: {path: './api/index.php/comment/flaggedcommentslist', method:'get'},
        deleteComment: {path: './api/index.php/comment/delete', method:'post'},
        // get user info
        login: {path: './api/index.php/user/login'},
        logout: {path: './api/index.php/user/logout'},
        user: {path: './api/index.php/user/getcurrent' , method: 'get'},
		token: {path: './api/index.php/user/gettoken' , method: 'get'},
        //user: {path: './json/user.json' , method: 'get'},
        saveUser: {path: './api/index.php/user/put' , method: 'post'},
        saveAvatar: {path: './api/index.php/user/saveavatar' , method: 'post'},
        // get user's nodes
        userNode: {path: './admin/app/json/node/recent.json' , data:{ uid: 0 , page: 1 }, method: 'get'},
        saveNode: {path: './api/index.php/node/post'},
        neighbor: {path: './api/index.php/node/getneighbor', method:'get'},
        countryList: {path: './json/country.json', method:'get', cache: true},
        i18n_en: {path: './lang/en.json', method:'get', async: false, cache:true},
        i18n_fr: {path: './lang/fr.json', method:'get', async: false, cache:true}
    };

    // 内部API
    var _unloginErrorNum = -2000;
    var _needRefresh     = {};
    var _retry = {user:1};

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
                    /*
                    require.async('login' , function( exports ){
                        exports.login( ajaxFn );
                    });
                    */
                    return;
                }
                //LP.error( result['info'] || _api[api].info + _e('出错啦，请稍候重试...') );
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
            // require login
            /*
            require.async('login' , function( exports ){
                exports.login( cb );
            });
            */
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
                //LP.alert( _e(' (*´Д｀*) 系统出错了。请反馈给我们。'), 3000 );
            } else if ( thrownError !== "" ) {
                // 请求被Canceled的时候，thrownError为空【未验证】。这时候直接忽略。
                //LP.alert( _e('发生了未知的网络错误，请稍后重试。') , 3000);
            }
        } catch(e) {};
    });

    // for model
    exports.ajax = _load;
});
