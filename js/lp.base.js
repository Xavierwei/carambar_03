/*
 * page base action
 */
LP.use(['jquery', 'api', 'easing', /*'fileupload', 'flash-detect', 'swfupload', 'swfupload-speed', 'swfupload-queue'*/] , function( $ , api ){
    'use strict'

    var isFirefox = navigator.userAgent.toLowerCase().indexOf('firefox') > 0;
    var isPad =navigator.userAgent.toLowerCase().indexOf('pad') > 0;
	var isIE8 = $('html').hasClass('ie8');
	var isIE10 = navigator.userAgent.toLowerCase().indexOf('msie 10') > 0;
	var isOldIE = $('html').hasClass('ie6') || $('html').hasClass('ie7');
    var API_FOLDER = "./";
    var THUMBNAIL_IMG_SIZE = "_400_400";
    var BIG_IMG_SIZE = "_640_640";

    var MIN_WIDTH = 200;
    var ITEM_WIDTH = MIN_WIDTH;
    var WIN_WIDTH = $(window).width();
    
    var monthsShort = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    var getMonth = function( index ){
        return monthsShort[ index ];
    }

    if(isPad) {
		$(window).bind('orientationchange', function() {
			var o = window.orientation;
			if (o != 90 && o != -90) {
				$('.turn_device').show();
			} else {
				$('.turn_device').hide();
			}
		});

        LP.use(['hammer'] , function(){
            $('body').hammer()
                .on("tap", '.main-item', function(ev) {
                    if($(ev.target).hasClass('item-delete')) return;
                    $(this).click();
                }
            );

            var dragDirection;
            $('body').hammer()
                .on("release dragleft dragright swipeleft swiperight", '.inner', function(ev) {
                    switch(ev.type) {
                        case 'swipeleft':
                        case 'dragleft':
                            LP.triggerAction('next');
                            break;
                        case 'swiperight':
                        case 'dragright':
                            LP.triggerAction('prev');
                            break;
                        case 'release':
                            break;
                        default:
                            dragDirection = '';
                    }
                }
            );
        });
    }

    // live for pic-item hover event
    $(document.body)
        .delegate('.pic-item' , 'mouseenter' , function(){
            if(isIE8) {
                $(this).find('.item-info-wrap').show();
				$(this).find('.item-info').show();
            }
			else {
				$(this).find('.item-info')
					.fadeIn( 500 );
			}

        })
        .delegate('.pic-item' , 'mouseleave' , function(){
            if(isIE8) {
                $(this).find('.item-info-wrap').hide();
				$(this).find('.item-info').hide();
            }
			else {
				$(this).find('.item-info')
					//.stop( true , false )
					.fadeOut( 500 );
			}

        })
        .delegate('.com-like','mouseenter',function(){
            var needLogin = $(this).find('.need-login');
            if(needLogin) {
                needLogin.fadeIn();
            }
        })
        .delegate('.com-like','mouseleave',function(){
            var needLogin = $(this).find('.need-login');
            if(needLogin) {
                needLogin.fadeOut();
            }
        })
        .delegate('.com-unlike','mouseenter',function(){
            var unlikeTip = $(this).find('.com-unlike-tip');
            if(unlikeTip) {
                unlikeTip.fadeIn();
            }
        })
        .delegate('.com-unlike','mouseleave',function(){
            var unlikeTip = $(this).find('.com-unlike-tip');
            if(unlikeTip) {
                unlikeTip.fadeOut();
            }
        });



    // fix one day animation. It is start animate from the day which is not trigger the animation
    // After the day trigger the animation 
    // Fix animation day by day
    var nodeActions = {
        loadNodes: function( ){
            var param = $main.data('param');
            if( param.page == 0 ){
                // stop all request
                nodeActions.req && nodeActions.req.abort();
                $main.removeClass('disabled')
                    .html('')
                    .data('nodes' , []);

            }

            if( !$main.hasClass('disabled') && !$main.find('.main-item:not(.time-item,.reversal)').length ){
                $main.addClass('disabled');
                var param = $main.data('param');
                param.page++;
                $listLoading.fadeIn();
                nodeActions.req = api.ajax('recent' , param , function( result ){
                    $main.removeClass('disabled');
                    nodeActions.inserNode( $main , result.data );
                    $listLoading.fadeOut();
                });
            }
        },
        prependNode: function( $dom , nodes , bShowDate ){
            var aHtml = [];
            var lastDate = null;
            var pageParm = $main.data('param');
            nodes = nodes || [];


            // fix nodes like status
            var cookieLikeStatus = LP.getCookie('_led');
            if( cookieLikeStatus && nodes.length ){
                cookieLikeStatus = cookieLikeStatus.split(',');
                $.each( nodes , function( i , node ){
                    if( $.inArray( node.nid , cookieLikeStatus ) ){
                        nodes.liked = true;
                    }
                } );
            }

            // save nodes to cache
            var cache = $dom.data('nodes') || [];
            $dom.data('nodes' , nodes.concat( cache ) );

            // if( bShowDate ){
            //     lastDate = $main.find('.time-item').last().data('date');
            // }
            // filte for date
            $.each( nodes , function( index , node ){
                // get date
                var datetime = new Date((parseInt(node.datetime)+1*3600)*1000);
                var month = (parseInt(datetime.getUTCMonth()) + 1) + '';
                month = month.length == 1 ? '0' + month : month;
                var day = datetime.getUTCDate() + '';
                day = day.length == 1 ? '0' + day : day;
                var date =  day + "/" + month + "/" + datetime.getUTCFullYear();
                if( lastDate != date){
                    LP.compile( 'time-item-template' ,
                        {date: date , day: parseInt(datetime.getUTCDate()) , month: getMonth( parseInt(datetime.getUTCMonth()) )} ,
                        function( html ){
                            aHtml.push( html );
                        });
                    lastDate = date;
                }
                // fix video type
                node.image = node.file.replace( node.type == 'video' ? '.mp4' : '.jpg' , THUMBNAIL_IMG_SIZE + '.jpg');
                node.formatDate = date;

                if( node.type == "photo" ){
                    node.image = node.image.replace('.jpg' , THUMBNAIL_IMG_SIZE + '.jpg' );
                }   
                // fix description
                node.description = node.description || '';
                node.sub_description = node.description.length > 70 ? node.description.substr(0 , 70) + '...' : node.description;
                node.sub_description = node.sub_description.replace(/#\S+/g , '<span style="color:white;">$&</span>');
                node.likecount = node.likecount || 111;

                node.str_like = node.likecount > 1 ? 'Likes' : 'Like';
                LP.compile( 'node-item-template' ,
                    node ,
                    function( html ){
                        aHtml.push( html );

                        if( index == nodes.length - 1 ){
                            // render html
                            var $oFirstTimeNode = $dom.children().eq(0);
                            // remove first time item;
                            $dom.prepend(aHtml.join(''));
                            if( bShowDate && 
                                $oFirstTimeNode.prevAll('.time-item').first().data('date')
                                == $oFirstTimeNode.data('date') ){
                                $oFirstTimeNode.remove();
                            }
                            nodeActions.setItemWidth( $dom );
                            nodeActions.setItemReversal( $dom );
                        }
                    } );

            } );
        },
        // when current dom is main , and the recent ajax param orderby is 'like' or
        // 'random' , the datetime would not be showed.
        // pageParm.orderby == 'like' || pageParm.orderby == 'random' 此时不显示日历
        inserNode: function( $dom , nodes  ){
            var aHtml = [];
            var lastDate = null;
            var pageParm = $main.data('param'); 
            nodes = nodes || [];

            // fix nodes like status
            var cookieLikeStatus = LP.getCookie('_led');
            if( cookieLikeStatus && nodes.length ){
                cookieLikeStatus = cookieLikeStatus.split(',');
                $.each( nodes , function( i , node ){
                    if( $.inArray( node.nid , cookieLikeStatus ) !== false ){
                        node.liked = true;
                    }
                } );
            }


            // save nodes to cache
            var cache = $dom.data('nodes') || [];
            $dom.data('nodes' , cache.concat( nodes ) );

            // filter for nodes , if there are nodes autoloaded in 5 minutes
            // the page index is not right.  So you should delete the same nodes
            var lastNode = cache[ cache.length - 1 ];
            if( lastNode ){
                var index = null ;
                $.each( nodes , function( i , node ){
                    if( lastNode.nid == node.nid ){
                        index = i;
                        return false;
                    }
                } );
                if( index !== null ){
                    nodes.splice( 0 , index + 1 );
                }
            }

            lastDate = $dom.find('.time-item').last().data('date');
            // filte for date
            $.each( nodes , function( index , node ){
                // get date
                var datetime = new Date((parseInt(node.datetime)+1*3600)*1000);
                var month = (parseInt(datetime.getUTCMonth()) + 1) + '';
                month = month.length == 1 ? '0' + month : month;
                var day = datetime.getUTCDate() + '';
                day = day.length == 1 ? '0' + day : day;
                var date =  day + "/" + month + "/" + datetime.getUTCFullYear();
                if( lastDate != date){
                    LP.compile( 'time-item-template' ,
                        {date: date , day: parseInt(datetime.getUTCDate()) , month: getMonth( parseInt(datetime.getUTCMonth()) )} ,
                        function( html ){
                            aHtml.push( html );
                        } );
                    lastDate = date;
                }
                // fix video type
                if(node.file) {
                    node.image = node.file;
                }
                node.formatDate = date;
                if( node.type == "photo" ){
                    node.image = node.image.replace('.jpg' , THUMBNAIL_IMG_SIZE + '.jpg' );
                }   
                // fix description
                node.description = node.description || '';
                node.sub_description = node.description.length > 70 ? node.description.substr(0 , 70) + '...' : node.description;
                node.sub_description = node.sub_description.replace(/#\S+/g , '<span style="color:white;">$&</span>');
                node.likecount = node.likecount || 111;

                node.str_like = node.likecount > 1 ? 'Likes' : 'Like';
                LP.compile( 'node-item-template' ,
                    node ,
                    function( html ){
                        aHtml.push( html );

                        if( index == nodes.length - 1 ){
                            // render html
                            $dom.append(aHtml.join(''));
                            nodeActions.setItemWidth( $dom );
                            nodeActions.setItemReversal( $dom );
                        }
                    } );

            } );
        },
        setItemWidth: function( $dom ){
            if( $dom.is(':hidden') ) return;
            var mainWidth = $dom.width();
            var min = ~~( mainWidth / MIN_WIDTH );
            // save ITEM_WIDTH and WIN_WIDTH 
            ITEM_WIDTH = ~~( mainWidth / min );
            WIN_WIDTH = $(window).width();

            $dom.find('.time-item, .main-item.reversal , .main-item.reversal img')
                .width( ITEM_WIDTH )
                .height( ITEM_WIDTH );
            $dom.find('.main-item').height( ITEM_WIDTH );
        },
        // start pic reversal animation
        setItemReversal: function( $dom ){
            // fix all the items , set position: relative
            $dom.children()
                .css('position' , 'relative');
            if( $dom.children('.isotope-item').length )
                $dom.isotope('destroy')
            // get first time item , which is not opend
            // wait for it's items prepared ( load images )
            // run the animate

            // if has time items, it means it needs to reversal from last node-item element
            // which is not be resersaled
            var $nodes = $dom.find('.pic-item:not(.reversal)');

            var startAnimate = function( $node ){
                if( $dom.is(':hidden') ) return;

                $node.addClass('reversal')
                    .width( ITEM_WIDTH )
                    .height( ITEM_WIDTH );
                var animationTimeout = 300;
                if(isIE8) {
                    $node.css({opacity:0}).animate({opacity:1});
                    animationTimeout = 50;
                }
                // fix it's img width and height
                $node.find('img')
                    .width( ITEM_WIDTH )
                    .height( ITEM_WIDTH );
                clearTimeout( nodeActions._reversalTimeout );
                nodeActions._reversalTimeout =  setTimeout(function(){
                    nodeActions.setItemReversal( $dom );
                } , animationTimeout);
            }
            // if esist node , which is not reversaled , do the animation
            if( $nodes.length  ){
                var $img = $nodes.eq(0)
                    .find('img');
                startAnimate( $nodes.eq(0) );
            } else { // judge if need to load next page
                $(window).trigger('scroll');
            }
        },
        // set items auto fix it's width
        setItemIsotope: function( $dom ){
            // if the page has unreversaled node
            if( $dom.find('.main-item:not(.time-item,.reversal)').length ) return;

            if( $dom.children('.isotope-item').length ){
                $dom.isotope('reLayout');
                return;
            }

            LP.use('isotope' , function(){
                // first init isotope , render no animate effect
                $dom
                    .addClass('no-animate')
                    .isotope({
                        resizable: false
                    });

                // after first isotope init
                // remove no animate class
                setTimeout(function(){
                    $dom.removeClass('no-animate');
                } , 100);
            });
        }
    }

    // fix window resize event
    // resize item width
    !(function(){
        var _resizeTimer = null;
        var _scrollTimer = null;
        $(window).resize(function(){
            clearTimeout( _resizeTimer );

            _resizeTimer = setTimeout(function(){
                if( !$main.hasClass('disabled') ){
                    nodeActions.setItemWidth( $main );
                    // run isotope after item width fixed
                    setTimeout(function(){
                        nodeActions.setItemIsotope( $main );
                    } , 500);
                }

                $('body')[$(window).width() < 800 ? "addClass" : "removeClass"]('sm-width');
            } , 200);

            // immediate resize
            // resize big image
            resizeInnerBox();
        })
        .scroll(function(){
            // if scroll to the botton of the window
            // ajax the next datas
            var st = $(window).scrollTop();
            var docHeight = $(document).height();
            var winHeight = document.body.clientHeight;
            if( docHeight - winHeight - st < 180 ){
                clearTimeout( _scrollTimer );
                _scrollTimer = setTimeout(function(){
                    nodeActions.loadNodes();
                } , 200);
            }
        });
    })();
    

    // ================== page actions ====================
    // view node action
    var _silderWidth = 80;
    var _animateTime = 800;
    var _animateEasing = 'easeInOutQuart';
    var _nodeCache = [];
    var _currentNodeIndex = 0;
    var _innerLock = false;
    LP.action('node' , function( data ){
        if( _innerLock ) return;
        _innerLock = true;
        var $dom = $( this );
        if(data.type) {
            var node = data; // 如果直接传入单个node，不再从列表中获取
        }
        else {
            _currentNodeIndex = $(this).prevAll(':not(.time-item)').length;
            var nodes = $main.data('nodes');
            var node = nodes[ _currentNodeIndex ];
        }
        var datetime = new Date((parseInt(node.datetime)+1*3600)*1000);
        node.year = datetime.getUTCFullYear();
        node.hour = datetime.getHours();
        node.minutes = datetime.getUTCMinutes();
        node.date = datetime.getUTCDate();
        node.month = parseInt(datetime.getUTCMonth()) + 1;

        if( node.type == "photo" )
            node.image = node.file.replace( node.type == "video" ? '.mp4' : '.jpg', BIG_IMG_SIZE + '.jpg');

        node.timestamp = (new Date()).getTime();
        console.log( node );
        LP.compile( 'inner-template' , node , function( html ){
            var mainWidth = WIN_WIDTH - _silderWidth;
            var mainWrapWidth = $main.width();
            // inner animation
            $('.inner').eq(0).fadeOut(function(){
                $(this).remove();
            });
            var $inner = $(html).insertBefore( $main )
                .css({
                    left: - WIN_WIDTH
                    //position: 'relative'
                })
                .animate({
                    left: 0
                }, _animateTime , _animateEasing , function(){
                    // show up node info
                });
            // set inner-info bottom css


            // main animation
            var scrollTop = $(window).scrollTop();
            $main
                .css({
                    //position: 'fixed',
                    width: mainWrapWidth,
                    left: 0
                    //top: 86 - scrollTop
                })
                .animate({
                    left: WIN_WIDTH
                } , _animateTime , _animateEasing , function(){
                    //$main.hide();
					$('body').css({overflow:'hidden'});
                    $('.content').css({overflow:'hidden'});
					$main.addClass('disabled');
                    _innerLock = false;
                });
            // loading comments
            // bindCommentSubmisson();
            // getCommentList(node.nid,1);

            // LP.use(['jscrollpane' , 'mousewheel'] , function(){
            //     $('.com-list').jScrollPane({autoReinitialise:true}).bind(
            //         'jsp-scroll-y',
            //         function(event, scrollPositionY, isAtTop, isAtBottom)
            //         {
            //             if(isAtBottom) {
            //                 var commentParam = $('.comment-wrap').data('param');
            //                 var page = commentParam ?  commentParam.page : 0;
            //                 getCommentList(node.nid,page + 1);
            //             }
            //         }
            //     );
            // });

            // init vide node
            if( node.type == "video" ){
                renderVideo($('.image-wrap-inner'),node);
                $('#imgLoad').attr('src', node.image);
                $('#imgLoad').ensureLoad(function(){
                    setTimeout(function(){
                        $('.image-wrap-inner object, .image-wrap-inner video').fadeIn();
                        $('.image-wrap-inner .video-js').fadeIn();
                    },400);

                    // preload before and after images
                    preLoadSiblings();
                    var $info = $inner.find('.inner-info');
                    $info.css( 'bottom' , - $info.height() );
                    slideIntroBar($info, _animateTime);
                });
            }

            // init photo node
            if( node.type == "photo" ){
                $('.image-wrap-inner img').ensureLoad(function(){
                    $(this).fadeIn();
                    // preload before and after images
                    preLoadSiblings();
                    var $info = $inner.find('.inner-info');
                    $info.css( 'bottom' , - $info.height() );
                    slideIntroBar($info, _animateTime);
                });
            }
            

            // change url
            changeUrl('/nid/' + node.nid , {event: 'back'});
            // loading image

            // Resize Inner Box
            //setTimeout(function(){
                resizeInnerBox();
            //},100);

            // save node from
            $inner.data('from' , $dom.parent() );
        } );

        return false;
    });

    // for back action
    LP.action('back' , function( data ){
        if( _innerLock ) return;
        var $inner = $('.inner');
        var infoTime = 300;
        // hide the inner info node
        var $info = $inner.find('.inner-info');
        // clean WMV player
        $inner.find('iframe').remove();

        $info.animate({
            bottom: -$info.height()
        } , infoTime);
        // back $inner and remove it
        $inner.delay(infoTime)
            .animate({
                left: - $(window).width()
            } , _animateTime , _animateEasing , function(){
                $inner.remove();
            });

        // back $main
        var $dom = $inner.data('from') || $main;

        var lastScrollTop = 86 - parseInt( $dom.css('top') );
        var _left = 0;
        $dom
            .stop()
            //.show()
            //.css('position' , 'fixed')
            .delay(infoTime)
            .animate({
                left: _left
            } , _animateTime , _animateEasing , function(){
                //if($dom.hasClass('main')) {
                    $dom.css({
                        //top: 'auto',
                        left: 'auto',
                        //position: 'relative',
                        width: 'auto'
                    });
					$main.removeClass('disabled');
                // }
                // else {
                //     $dom.css({
                //         width: 'auto'
                //     });
                // }

                //$(window).scrollTop( lastScrollTop );
                // restart reverse

				$('body').css({overflowY:'scroll'});
                $('.content').css({overflow:'visible'});
                //nodeActions.setItemReversal( $dom );
            });

        //var pageParam = $dom.data('param');
        // if(pageParam.previouspage != null) {
        //     $dom.html('');
        //     $dom.data( 'nodes', [] );
        //     $listLoading.fadeIn();

        //     LP.triggerAction('recent' , pageParam);
        // }

        changeUrl('/main' , {event:'back'});

    });

    LP.action('load-comment' , function( data ){
        $('.com-base').hide();
        $('.com-wrap').show();
        getCommentList(data.nid , data.page || 1);
        LP.use(['jscrollpane' , 'mousewheel'] , function(){
            $('.com-list').jScrollPane({autoReinitialise:true}).bind(
                'jsp-scroll-y',
                function(event, scrollPositionY, isAtTop, isAtBottom)
                {
                    if(isAtBottom) {
                        var commentParam = $('.comment-wrap').data('param');
                        getCommentList(data.nid,commentParam.page + 1);
                    }
                }
            );
        });
    });

    LP.action('com-close' , function(){
        $('.com-wrap').hide();
        $('.com-base').show();
    });
    
  //   LP.action('back_home', function(){
  //       nodeActions.stopItemReversal();
  //       _stopScrollEvent();
		// if($main.hasClass('closed')) {
		// 	LP.triggerAction('back');
		// }
		// else {
		// 	changeUrl('/main' , {event:'back'});
		// }
		// if($('.user-page').is(':visible')) {
		// 	LP.triggerAction('toggle_user_page');
		// }
		// resetQuery();
		// $('.search-hd').hide();
		// $main.html('');
		// $main.data( 'nodes', [] );
		// $listLoading.fadeIn();
		// LP.triggerAction('recent');

  //   });

    /**
     * @desc: 立方体旋转inner node
     * @date:
     * @param node {node object}
     * @param direction { 'right' or 'left' }
     */
    function cubeInnerNode( node , direction ){

        var cubeDir = 'cube-' + direction;
        var rotateDir = 'rotate-' + direction;

        // base on comment wrap width
        var dist = $('.comment-wrap').width() / 2;
        var dirData = {
            dist: dist,
            rotate: 90
        }
        if( direction == 'left' ){
            dirData.dist = - dist;
            dirData.rotate = -90;
        }

        var datetime = new Date((parseInt(node.datetime)+1*3600)*1000);
        node.date = datetime.getUTCDate();
        node.month = parseInt(datetime.getUTCMonth()) + 1;
        //node.currentUser = $('.side').data('user');
        if( node.image )
            node.image = node.file.replace( node.type == "video" ? '.mp4' : '.jpg', BIG_IMG_SIZE + '.jpg');
        node.timestamp = (new Date()).getTime();
        // if(!node.user.avatar) {
        //     node.user.avatar = "/uploads/default_avatar.gif";
        // }
        // node._e = _e;
        var $inner = $('.inner');
        LP.compile( 'inner-template' , node , function( html ){
            var $comment = $inner.find('.comment');
            // comment animation
            var $newInner = $(html);
            var transform = "translatex(" + dirData.dist + "px) translatez(" + (-dist) + "px) rotateY(" + dirData.rotate + "deg)";;
            var $nextComment = $newInner.find('.comment')
                .addClass(cubeDir)
                .css({
                    "-webkit-transform": transform,
                    "-moz-transform": transform,
					"-ms-transform": transform,
                    "transform": transform
                })
                .insertBefore( $comment )
                .find( '.com-list' )
                .css('height' , $comment.find('.com-list').height())
                .end();

			var $cube = $comment.parent();
			var rotate = "translate3d(" + ( - dirData.dist ) + "px,0," + (-dist) + "px) rotateY(" + ( -dirData.rotate ) + "deg)";
			if(!isIE10) {
				$cube.addClass(rotateDir)
					.css({
						"-webkit-transform": rotate,
						"-moz-transform": rotate,
						"-ms-transform": rotate,
						"-o-transform": rotate,
						"transform": rotate
					});
			}


            // fix ie8 and ie9 not support animate feature
            if( !$('html').hasClass('csstransforms3d') || isIE10 ){
                var cubeWidth = $cube.width();
                $cube.css({
                    width: 2 * cubeWidth
                })
                .children().css({
                    float   : 'left',
                    position: 'static',
                    width   : cubeWidth,
                    height  : '100%'
                });
                if( direction == 'left' ){
                    $cube.css({
                            left: -cubeWidth
                        })
                        .animate( {
                            left: 0
                        } , 1000 , '' , function(){
                            $comment.remove();
                            $cube.css('width' , '100%')
                                .children()
                                .css('width' , '100%');
                        });
                } else {
                    $cube.children().eq(0)
                        .appendTo( $cube );

                    $cube.css({
                            left: 0
                        })
                        .animate( {
                            left: -cubeWidth
                        } , 1000 , '' , function(){
                            $comment.remove();
                            $cube.css({
                                width: '100%',
                                left : 0
                            })
                            .children()
                                .css('width' , '100%');
                        });
                }
            }


            setTimeout(function(){
                // reset css
                $cube.addClass( 'no-animate' )
                    .removeClass( rotateDir )
                    .css({
                        "-webkit-transform": '',
                        "-moz-transform": '',
                        "-ms-transform": '',
                        "-o-transform": '',
                        "transform": ''
                    });
                $comment.remove();
                $nextComment
                    .removeClass(cubeDir)
                    .css({
                        "-webkit-transform": "",
                        "-moz-transform": "",
						"-ms-transform": "",
                        "transform": ""
                    });
                setTimeout(function(){
                    $cube.removeClass( 'no-animate' );
                    _innerLock = false;
                },20);

                $inner.removeClass('disabled');

            } , 1000);

            // picture animation,
            // append or prepend image
            // set image width
            // set .image-wrap's margin-right
            // animate the first image's margin-left style
            var $imgWrap = $inner.find('.image-wrap');
            var wrapWidth = $imgWrap.width();
            $imgWrap.css('width' , 2 * wrapWidth );

            // append dom
            var $oriItem = $imgWrap.children('.image-wrap-inner');
            // count the style
            var $newItem = $newInner.find('.image-wrap-inner')[ direction == 'left' ? 'insertBefore' : 'insertAfter' ]( $oriItem )
                .attr('style' , $oriItem.attr('style'))
                .find('img')
                .show()
                .end();

            // var $nextFlag = $newInner.find('.flag-node');
            // $inner.find('.flag-node').remove();
            // $newItem.parent().append($nextFlag);

            // var $nextTop = $newInner.find('.inner-top');
            // $inner.find('.inner-top').animate({top:-33}, function(){
            //     $(this).remove();
            // });
            // $newItem.append($nextTop);

            // Resize Image
            var slideWidth = $('.side').width();
            var imgBoxWidth = $(window).width() - 330 - slideWidth;
            var imgBoxHeight =$(window).height() - $('.header').height();
            var minSize = Math.min( imgBoxHeight , imgBoxWidth );
            var $img = $newItem.find('img').css('margin',0);
            $newItem.width(minSize).height(minSize);

            if( imgBoxHeight > imgBoxWidth ){
                var marginLeft = (imgBoxHeight - imgBoxWidth) / 2;
                $newItem.height(imgBoxHeight);
                $img.width('auto').height('100%').css('margin-left', -marginLeft);
            }

            $oriItem.find('iframe').remove();



            // set style and animation
            $imgWrap.children('.image-wrap-inner').css({
                    width: wrapWidth
                })
                .eq(0)
                .css('marginLeft' , direction == 'left' ? - wrapWidth : 0 )
                .animate({
                    marginLeft: direction == 'left' ? 0 : - wrapWidth
                } , _animateTime, _animateEasing)
                // after animation
                .promise()
                .done(function(){
                    $imgWrap.width( wrapWidth );
                    // Resize Inner Box
                    // resizeInnerBox();
                    $newItem.css('width' , '100%');
                    $newItem.siblings('.image-wrap-inner').remove();
                });

            // desc animation
            // var $info = $inner.find('.inner-info');
            // $info.animate({
            //         bottom: -$info.height()
            //     } , 500 )
            //     .promise()
            //     .done(function(){
            //         $info.remove();
            //     });
            // var $newInfo = $newInner.find('.inner-info')
            //     .insertAfter( $info );
            // $newInfo.css({
            //     'bottom' : -$newInfo.height(),
            //     'width'  : $info.width(),
            //     'left'   : $info.css('left')
            // })

            // init video
            if( node.type == "video" ){
                renderVideo($newItem,node);
                $('#imgLoad').attr('src', node.image);
                $('#imgLoad').ensureLoad(function(){
                    setTimeout(function(){
                        $('.image-wrap-inner object, .image-wrap-inner video').fadeIn();
                        $('.image-wrap-inner .video-js').fadeIn();
                        //slideIntroBar($newInfo, _animateTime);
                    },400);
                });
				// resize WMV
				var $wmvIframe = $('.image-wrap-inner iframe');
				if($wmvIframe.length > 0) {
					$wmvIframe.width('100%').height(imgBoxHeight-36);
				}
            }
            // init photo node
            if( node.type == "photo" ){
                $('.image-wrap-inner img').ensureLoad(function(){
                    $(this).fadeIn();
                    //slideIntroBar($newInfo, _animateTime);
                });
            }

            // load comment
            // bindCommentSubmisson();
            // $('.comment-wrap').removeClass('loading');
            // getCommentList(node.nid,1);
            // LP.use(['jscrollpane' , 'mousewheel'] , function(){
            //     $('.com-list').jScrollPane({autoReinitialise:true}).bind(
            //         'jsp-scroll-y',
            //         function(event, scrollPositionY, isAtTop, isAtBottom)
            //         {
            //             if(isAtBottom) {
            //                 var commentParam = $('.comment-wrap').data('param');
            //                 getCommentList(node.nid,commentParam.page + 1);
            //             }
            //         }
            //     );
            // });

            // change url
            changeUrl('/nid/' + node.nid , {event: direction});
        });
    }

    /**
     * @desc: preload sibling images
     * @date:
     */
    function preLoadSiblings(){
        var $dom = $('.inner').data('from') || $main;
        var nodes = $dom.data('nodes');
        var aftfix = '_640_640.jpg';
        // preload before and after images
        for( var i = 0 ; i < 5 ; i++ ){
            if( nodes[ _currentNodeIndex - i ] && !nodes[ _currentNodeIndex - i ].image ) continue;
            if( nodes[ _currentNodeIndex + i ] && !nodes[ _currentNodeIndex + i ].image ) continue;
            if( nodes[ _currentNodeIndex - i ] ){
                $('<img/>').attr('src' , API_FOLDER + nodes[ _currentNodeIndex - i ].image.replace(/_\d+_\d+\.jpg/ , aftfix ));
            }
            if( nodes[ _currentNodeIndex + i ] ){
                $('<img/>').attr('src' , API_FOLDER + nodes[ _currentNodeIndex + i ].image.replace(/_\d+_\d+\.jpg/ , aftfix ));
            }
        }
    }

    function slideIntroBar($info, _animateTime){
        $info.delay(_animateTime).fadeIn().dequeue()
            .animate({
                bottom: 0
            } , 300);
        $('.inner-topday').delay(_animateTime)
            .animate({
                top: 0
            } , 300);
        $('.inner-topmonth').delay(_animateTime)
            .animate({
                top: 0
            } , 300);
    }

    //for prev action
    LP.action('prev' , function( data ){
        if( _innerLock ) return;
        _innerLock = true;
        var $dom = $('.inner').data('from') || $main;

        // when reach the first, if the content opened via url id, need to check if has previous page
        if( _currentNodeIndex == 0 ){
            var param = $main.data('param');
            if(!param.previouspage || param.previouspage == 1) {
                //alert('no more nodes');
                _innerLock = false;
                return;
            } else {
                param.previouspage --;
                $dom.data('param' , param);
                param.page = param.previouspage;
                api.ajax('recent' , param , function( result ){
                    _currentNodeIndex = param.pagenum - 1;
                    nodeActions.prependNode( $dom , result.data , param.orderby == 'datetime' );
                    cubeInnerNode( $dom.data('nodes')[ _currentNodeIndex ] , 'left' );
                    preLoadSiblings();
                });
            }
            return;
        }
        // lock the animation
        if( $('.inner').hasClass('disabled') ) return;
        $('.inner').addClass('disabled');

        _currentNodeIndex -= 1;
        var node = $dom.data('nodes')[ _currentNodeIndex ];
        cubeInnerNode( node , 'left' );
        preLoadSiblings();
    });

    //for next action
    LP.action('next' , function( data ){
        if( _innerLock ) return;
        _innerLock = true;
        var $inner = $('.inner');
        var $dom = $inner.data('from') || $main;

        // lock the animation
        if( $inner.hasClass('disabled') ) return;
        $inner.addClass('disabled');

        _currentNodeIndex++;
        var nodes = $dom.data('nodes');
        var node = nodes[ _currentNodeIndex ];
        if( !node ){
            // if no more data
            if( $dom.data('end') ){
                _currentNodeIndex--;
                $inner.removeClass('disabled');
                //alert('no more nodes');
                _innerLock = false;
                return;
            }
            //ajax to get more node
            var param = $dom.data('param');
            param.page++;
            $dom.data('param' , param);
            // show loading 
            $('.inner-loading').show();
            api.ajax('recent' , param , function( result ){
                $('.inner-loading').hide();
                if( result.data.length ){
                    nodeActions.inserNode( $dom , result.data , param.orderby == 'datetime' );
                    cubeInnerNode( $dom.data('nodes')[ _currentNodeIndex ] , 'right' );
                    preLoadSiblings();
                } else {
                    $inner.removeClass('disabled');
                    $dom.data('end' , true);
                    _innerLock = false;
                }
            });
            return;
        }
        cubeInnerNode( node , 'right' );
        preLoadSiblings();
    });

  //   // get default nodes
  //   LP.action('recent', function(){
  //       var pageParam = refreshQuery();
  //       $listLoading.fadeIn();
  //       _scrollAjax = true;
		// if(req) {
		// 	req.abort();
		// }
		// req = api.ajax('recent', pageParam, function( result ){
  //           _scrollAjax = false;
  //           $main.show();
  //           // make sure it's first page
  //           if( $main.children().length ) return;
  //           $listLoading.fadeOut();
  //           nodeActions.inserNode( $main , result.data , pageParam.orderby == 'datetime' );
  //       });
  //   });

  //   LP.action('load_list', function(){
  //       // refresh main query parameter
  //       var pageParam = refreshQuery();
  //       $main.html('');
  //       $main.data('nodes', []);
  //       $listLoading.fadeIn();
		// if(req) {
		// 	req.abort();
		// }
  //       req = api.ajax('recent', pageParam, function (result) {
  //           if (result.data.length > 0) {
  //               nodeActions.inserNode($main.show(), result.data, pageParam.orderby == 'datetime');
  //               $listLoading.fadeOut();
  //           }
  //           else {
  //               api.ajax('tagTopThree', function(result){
  //                   var searchs = '';
  //                   var $selectBox = $('.select-item .select-box').each(function(){
  //                       searchs += '[' + $(this).html() + '] ';
  //                   });
  //                   // if(pageParam.country_id) {
  //                   //     var countryName = $('.select-country-option-list p[data-param="country_id='+pageParam.country_id+'"]').html();
  //                   //     result.country_name = countryName;
  //                   // }
  //                   result.searchs = searchs;
  //                   result._e = _e;
  //                   LP.compile( 'blank-filter-template' ,
  //                       result,
  //                       function( html ){
  //                           $('.main').append(html).fadeIn();
  //                       } );
  //               });
  //           }
  //       });
  //   });

    //for like action
    var updateLikeCount = function(nid, count , isLiked){
        $('.main-item-' + nid).find('.item-like').html(count).toggleClass('item-liked');

        if( isLiked ){
            $('.inner').find('a[data-a="like"]')
                .attr('data-a' , "unlike")
                .html(count + ' <i class="icon icon-liked"></i>');
        } else {
            $('.inner').find('a[data-a="unlike"]')
                .attr('data-a' , "like")
                .html(count + ' <i class="icon icon-like"></i>');
        }
        (function(){
            var nodes = $('.main').data('nodes');
			if(nodes) {
                var node = jQuery.grep(nodes, function (node) {
                    if(node.nid == nid) {
                        return node;
                    }
                });
                if(node.length > 0) {
                    node[0].likecount = count;
                    node[0].user_liked = !node[0].user_liked;
                }
			}
        })();

        (function(){
            var nodes = $('.count-com').data('nodes');
			if(nodes) {
                var node = jQuery.grep(nodes, function (node) {
                    if(node.nid == nid) {
                        return node;
                    }
                });
                if(node.length > 0) {
                    node[0].likecount = count;
                    node[0].user_liked = !node[0].user_liked;
                }
			}
        })();
        //LP.triggerAction('update_user_status');
    }

    LP.action('like' , function( data ){
        var _this = $(this);
		if(_this.hasClass('disabled')){
			return;
		}
        var _likeWrap = _this.find('span').eq(0);
		_this.addClass('disabled');
		_this.addClass('flashing');
        api.ajax('like', {nid:data.nid}, function( result ){
			_this.removeClass('flashing');
            setTimeout(function(){
				_this.removeClass('disabled');
            },1000);
            if(result.success) {
                _likeWrap.animate({opacity:0},function(){
                    _likeWrap.html(result.data);
                    _this.data('liked',true);
                    _this.attr('data-a','unlike');
                    _this.addClass('com-unlike');
                    _this.append('<div class="com-unlike-tip">' + _e.UNLIKE + '</div>');
                    $(this).animate({opacity:1});
                });
                updateLikeCount(data.nid, result.data , true);

                // add like status to cookie
                var liked = LP.getCookie('_led') || '';
                liked = liked ? liked.split(',') : [];
                liked.push( data.nid ) ;
                LP.setCookie( '_led' , liked.join(',') , 86400 * 365 );
            }
        });
    });

    LP.action('unlike' , function( data ){
        var _this = $(this);
		if(_this.hasClass('disabled')){
			return;
		}
        var _likeWrap = _this.parent().find('span').eq(0);
		_this.addClass('disabled');
		_this.addClass('flashing');
        api.ajax('unlike', {nid:data.nid}, function( result ){
			_this.removeClass('flashing');
            setTimeout(function(){
				_this.removeClass('disabled');
            },1000);
            if(result.success) {
                _likeWrap.animate({opacity:0},function(){
                    _likeWrap.html(result.data);
                    _this.parent().data('liked',false);
                    _this.removeClass('com-unlike');
                    _this.attr('data-a','like');
                    _this.find('.com-unlike-tip').remove();
                    $(this).animate({opacity:1});
                });
                updateLikeCount(data.nid, result.data , false);

                // remove like status
                var liked = LP.getCookie('_led') || '';
                liked = liked.split(',');
                liked.splice( $.inArray( data.nid , liked ) , 1 );
                LP.setCookie( '_led' , liked.join(',') , 86400 * 365 );
            }
        });
    });


    LP.action('show-nodes' , function( data ){
        $main.data('param' , $.extend( data , {page: 0} ));
        $(this).addClass('actived')
            .siblings('.actived')
            .removeClass('actived');
        nodeActions.loadNodes();
    });

    // //for flag node action
    // LP.action('flag' , function( data ){
    //     // if this node already flagged, return the action
    //     if($(this).hasClass('flagged')) {
    //         return false;
    //     }
    //     // display the modal before submit flag
    //     if(!$('.flag-confirm-modal').is(':visible')) {
    //         $('.modal-overlay').fadeIn(700);
    //         $('.flag-confirm-modal').fadeIn(700).dequeue().animate({top:'50%'}, 700, 'easeOutQuart');
    //         if(data.type == 'node') {
    //             var type = _e['CONTENT'];
    //         }
    //         else {
    //             var type = _e['COMMENT'];
    //         }
    //         $('.flag-confirm-modal .flag-confirm-text span').html(type);
    //         $('.flag-confirm-modal .ok').attr('data-a','flag');
    //         if(data.type == 'node') {
    //             $('.flag-confirm-modal .ok').attr('data-d','nid=' + data.nid + '&type=node');
    //         }
    //         if(data.type == 'comment') {
    //             $('.flag-confirm-modal .ok').attr('data-d','cid=' + data.cid + '&nid=' + data.nid + '&type=comment');
    //         }
    //     }
    //     else {
    //         if(data.type == 'node') {
    //             api.ajax('flag', {nid:data.nid});
    //             $('.inner .flag-node').addClass('flagged').removeClass('btn2').removeAttr('data-a');
    //             (function(){
    //                 var nodes = $('.main').data('nodes');
    //                 if(nodes) {
    //                     var node = jQuery.grep(nodes, function (node) {
    //                         if(node.nid == data.nid) {
    //                             return node;
    //                         }
    //                     });
    //                     if(node.length > 0) {
    //                         node[0].user_flagged = true;
    //                     }
    //                 }
    //             })();

    //             (function(){
    //                 var nodes = $('.count-com').data('nodes');
    //                 if(nodes) {
    //                     var node = jQuery.grep(nodes, function (node) {
    //                         if(node.nid == data.nid) {
    //                             return node;
    //                         }
    //                     });
    //                     if(node.length > 0) {
    //                         node[0].user_flagged = true;
    //                     }
    //                 }
    //             })();
    //         }
    //         if(data.type == 'comment') {
    //             api.ajax('flag', {cid:data.cid, comment_nid:data.nid});
    //             $('.comlist-item-' + data.cid).find('.comlist-flag').addClass('flagged').removeClass('btn2').removeAttr('data-a');
    //         }
    //         LP.triggerAction('cancel_modal');
    //     }
    // });


    // //for delete comment action
    // LP.action('delete' , function( data ){
    //     if(!$('.delete-confirm-modal').is(':visible')) {
    //         $('.modal-overlay').fadeIn(700);
    //         $('.delete-confirm-modal').fadeIn(700).dequeue().animate({top:'50%'}, 700, 'easeOutQuart');
    //         if(data.type == 'node') {
    //             var type = _e['CONTENT'];
    //         }
    //         else {
    //             var type = _e['COMMENT'];
    //         }
    //         $('.delete-confirm-modal .flag-confirm-text span').html(type);
    //         $('.delete-confirm-modal .ok').attr('data-a','delete');
    //         if(data.type == 'node') {
    //             $('.delete-confirm-modal .ok').attr('data-d','nid=' + data.nid + '&type=node');
    //         }
    //         if(data.type == 'comment') {
    //             $('.delete-confirm-modal .ok').attr('data-d','cid=' + data.cid + '&type=comment');
    //         }
    //     }
    //     else
    //     {
    //         if(data.type == 'comment') {
    //             $('.comlist-item-' + data.cid).fadeOut();
    //             api.ajax('deleteComment', data, function(){
    //                 LP.triggerAction('update_user_status');
    //             });
    //         }
    //         if(data.type == 'node') {
				// // directly remove from ui whatever the backend deleted or not.
				// var $nodes = $('.main-item-' + data.nid).css({width:0, opacity:0});
    //             $nodes.each( function( i ){
    //                 if( $(this).prev().hasClass('time-item')
    //                     && ( !$(this).next().length || $(this).next().hasClass('time-item') ) ){
    //                     $(this).prev().remove();
    //                 }
    //                 $(this).remove();
    //                 // trigger istop event
    //                 $(window).trigger('resize');
    //             } );
				// (function(){
				// 	var nodes = $('.count-com').data('nodes');
    //                 if(nodes) {
    //                     var index = -1;
    //                     jQuery.grep(nodes, function (node, i) {
    //                         if(node.nid == data.nid) {
    //                             index = i;
    //                         }
    //                     });
    //                     if(index != -1) {
    //                         nodes.splice(index, 1);
    //                     }
    //                 }
				// })();

				// (function(){
				// 	var nodes = $('.main').data('nodes');
    //                 if(nodes) {
    //                     var index = -1;
    //                     jQuery.grep(nodes, function (node, i) {
    //                         if(node.nid == data.nid) {
    //                             index = i;
    //                         }
    //                     });
    //                     if(index != -1) {
    //                         nodes.splice(index, 1);
    //                     }
    //                 }
				// })();
    //             api.ajax('deleteNode', data, function(){
    //                 LP.triggerAction('update_user_status');
    //             });
    //         }
    //         LP.triggerAction('cancel_modal');
    //     }
    // });


    // var fileUploadDone = function(data){
    //     if(!data.result.success) {
    //         if(typeof data.result.message.error != "undefined" && data.result.message.error == 508) {
    //             setTimeout(function(){
    //                 var type = $('#node_post_form input[name="type"]').val();
    //                 api.ajax('upload' , {'type':type, 'tmp_file': data.result.message.tmp_file} , function( result ){
    //                     var data = {};
    //                     data.result = result;
    //                     fileUploadDone(data);
    //                 });
    //             }, 1000*15);
    //             return;
    //         }
    //         switch(data.result.message){
    //             case 502:
    //                 var errorIndex = 0;
    //                 break;
    //             case 501:
    //                 var errorIndex = 2;
    //                 break;
    //             case 503:
    //                 var errorIndex = 1;
    //                 break;
    //             case 509:
    //                 var errorIndex = 3;
    //                 break;
    //         }
    //         $('.pop-inner').fadeOut(400);
    //         $('.pop-file').delay(800).fadeIn(400);
    //         $('.step1-tips li').removeClass('error');
    //         $('.step1-tips li').eq(errorIndex).addClass('error');
    //     } else {
    //         $('.poptxt-pic-inner').css({opacity:0});
    //         var rdata = data.result.data;
    //         if(rdata.type == 'video') {
    //             $('.poptxt-pic-inner').animate({opacity:1});
    //             $('.poptxt-pic img')
    //                 .unbind('load.forinnershow')
    //                 .bind('load.forinnershow' , function(){
    //                     $('.pop-inner').delay(400).fadeOut(400);
    //                     $('.pop-txt').delay(1200).fadeIn(400);
    //                 })
    //                 .attr('src', API_FOLDER + rdata.file.replace('.mp4', '.jpg'));
    //             $('.poptxt-submit').attr('data-d','file='+ rdata.file +'&type=' + rdata.type);

    //         } else {
    //             if (data.files && data.files[0] && window.FileReader ) {
    //                 //..create loading
    //                 var reader = new FileReader();
    //                 reader.onload = function (e) {
    //                     // change checkpage img
    //                     $('.poptxt-pic img')
    //                         .unbind('load.forinnershow')
    //                         .bind('load.forinnershow' , function(){
    //                             $('.pop-inner').delay(400).fadeOut(400);
    //                             $('.pop-txt').delay(1200).fadeIn(400);
    //                             setTimeout(function(){
    //                                 transformMgr.initialize( $('.poptxt-pic-inner') );
    //                             } , 1700 );
    //                         })
    //                         .attr('src', e.target.result/*.replace('.jpg', THUMBNAIL_IMG_SIZE + '.jpg')*/);
    //                     $('.poptxt-submit').attr('data-d','file='+ rdata.file +'&type=' + rdata.type);
    //                 };
    //                 reader.readAsDataURL(data.files[0]);
    //                 $('.poptxt-pic-inner').delay(3000).animate({opacity:1});
    //             } else {
    //                 $('.poptxt-pic img')
    //                     .unbind('load.forinnershow')
    //                     .bind('load.forinnershow' , function(){
    //                         $('.pop-inner').delay(400).fadeOut(400);
    //                         $('.pop-txt').delay(1200).fadeIn(400);
    //                         setTimeout(function(){
    //                             transformMgr.initialize( $('.poptxt-pic-inner') );
    //                         } , 1700 );
    //                     })
    //                     .attr('src', API_FOLDER + rdata.file/*.replace('.jpg', THUMBNAIL_IMG_SIZE + '.jpg')*/);
    //                 $('.poptxt-submit').attr('data-d','file='+ rdata.file +'&type=' + rdata.type);
    //             }
    //         }
    //     }
    // }

    //upload photo
    // LP.action('pop_upload' , function( data ){
    //     var acceptFileTypes;
    //     var type = data.type;
    //     if(type == 'video') {
    //         data.accept = 'video/*,video/mp4';
    //     } else {
    //         data.accept = 'image/*';
    //     }
    //     $('.side .menu-item.'+type).addClass('active');
    //     data._e = _e;
    //     LP.compile( "pop-template" , data,  function( html ){
    //         $(document.body).append( html );
    //         $('.overlay').fadeIn();
    //         $('.pop').fadeIn(_animateTime).dequeue().animate({top:'50%'}, _animateTime , _animateEasing);

    //         var $fileupload = $('#fileupload');
    //         if(type == 'video') {
    //             acceptFileTypes = /(\.|\/)(mov|wmv|mp4|avi|mpg|mpeg|3gp)$/i;
    //             var maxFileSize = 7 * 1024000;
    //         } else {
    //             acceptFileTypes = /(\.|\/)(gif|jpe?g|png)$/i;
    //             var maxFileSize = 5 * 1024000;
    //         }
    //         if(isIE8) {
    //             setTimeout(function(){
    //                 window.document.title = pageTitle;
    //             }, 1000);
    //             LP.use('flash-detect', function(){
    //                 if(FlashDetect.installed) {
    //                     if(type == 'photo') {
    //                         $('#node_post_form').hide();
    //                         data.lang = lang;
    //                         LP.compile( "flash-uploader-template" , data,  function( html ){
    //                             $('#node_post_flash').show().append(html);
    //                         });
    //                     }
    //                     else {
    //                         $('#flash-select-btn').show();
    //                         $('#select-btn').hide();
    //                         LP.use(['swfupload', 'swfupload-speed', 'swfupload-queue'], function(){
    //                             var settings = {
    //                                 flash_url : "./flash/swfupload.swf",
    //                                 upload_url: "./api/index.php/uploads/upload",
				// 					debug: false,
    //                                 file_post_name: "file",
    //                                 post_params : {type:'video'},
    //                                 file_size_limit : "7 MB",
    //                                 file_types : "*.mp4;*.mov;*.wmv;*.3gp;*.mpg;*.mpeg",
    //                                 file_upload_limit : 1,
    //                                 button_width: "326",
    //                                 button_height: "40",
    //                                 button_placeholder_id: "flash-video-popfile-btn",
				// 					button_window_mode : SWFUpload.WINDOW_MODE.OPAQUE,
				// 					button_image_url : "img/trans.gif",
    //                                 file_dialog_complete_handler: fileDialogComplete,
    //                                 upload_start_handler : uploadStart,
    //                                 upload_progress_handler : uploadProgress,
    //                                 upload_success_handler : uploadSuccess,
    //                                 upload_error_handler : uploadError
    //                             };
    //                             var swfu = new SWFUpload(settings);
    //                         });
    //                     }
    //                 }
    //                 else {
    //                     $('#select-btn input').change(function(){
    //                         $('.pop-file').fadeOut(400);
    //                         $('.pop-txt').delay(400).fadeIn(400);
    //                     });
    //                     $('#node_post_form').append('<input name="iframe" value="true" type="hidden" />');
				// 		$('.pop-video').addClass('pop-video-noflash');
    //                     $('#node-description').val($('#node-description').attr('placeholder'));
    //                 }
    //                 return;
    //             })
    //         }
    //         else {
    //             LP.use('fileupload' , function(){
    //                 $fileupload.fileupload({
    //                     url: './api/index.php/uploads/upload',
    //                     datatype:"json",
    //                     autoUpload:false
    //                 })
				// 		.bind('fileuploadadd', function (e, data) {
				// 			$('.step1-tips li').removeClass('error');
				// 			if(!acceptFileTypes.test(data.files[0].name.toLowerCase())) {
				// 				$('.step1-tips li').eq(0).addClass('error');
				// 			}
				// 			else if(data.files[0].size > maxFileSize) {
				// 				$('.step1-tips li').eq(2).addClass('error');
				// 			}
				// 			else {
				// 				data.submit();
				// 			}
				// 		})
				// 		.bind('fileuploadstart', function (e, data) {
				// 			$('.pop-inner').fadeOut(400);
				// 			$('.pop-load').delay(400).fadeIn(400);
				// 		})
				// 		.bind('fileuploadprogress', function (e, data) {
				// 			var rate = data._progress.loaded / data._progress.total * 100;
				// 			var $bar = $('.popload-percent p');
				// 			var currentRate = $bar.data('rate');
				// 			if(!currentRate) {
				// 				currentRate = 0;
				// 			}
				// 			if(rate > currentRate) {
				// 				$bar.data('rate',rate).css({width:rate + '%'});
				// 			}
				// 		})
				// 		.bind('fileuploadfail', function() {
				// 			$('.pop-inner').fadeOut(400);
				// 			$('.pop-file').delay(400).fadeIn(400);
				// 		})
				// 		.bind('fileuploaddone', function (e, data) {
    //                         fileUploadDone(data);
				// 		});
    //             });
    //         }

    //     } );
    // });
    


    // zoom video
    LP.action('video_zoom', function(){
        var $video = $('.video-js .vjs-tech');
        if($video.hasClass('zoom')) {
            $video.removeClass('zoom');
            $(this).removeClass('active');
            $('.vjs-poster').css('background-size','contain');
            $video.height('100%').width('100%').css('margin',0);
        }
        else {
            $video.addClass('zoom');
            $(this).addClass('active');
            $('.vjs-poster').css('background-size','cover');
            resizeInnerBox();
            $(window).trigger('resize');
        }
    });

    // LP.action('update_user_status', function(){
    //     // after page load , load the current user information data from server
    //     api.ajax('user' , function( result ){
    //         if(result.success) {
    //             //bind user data after success logged
    //             if(result.data.count_by_day == 0) {
    //                 delete result.data.count_by_day;
    //             }
    //             if(result.data.count_by_month == 0) {
    //                 delete result.data.count_by_month;
    //             }
    //             if(!result.data.avatar) {
    //                 result.data.avatar = "/uploads/default_avatar.gif";
    //             }
    //             result.data._e = _e;
    //             LP.compile( 'user-page-template' , result.data , function( html ){
    //                 $('.user-page .count').html($(html).find('.count').html());
    //             });
    //         }
    //     });
    // });

   //  LP.action('get_fresh_nodes', function(){
   //      // if main element is visible
   //      if( $main.is(':hidden') ) return;
   //      var nodes = $main.data('nodes');
   //      var param = $main.data('param');
   //      var lastNid = nodes && nodes.length ? nodes[0].nid : null;

   //      param = $.extend( {} , param );
   //      param.page = 1;
   //      api.ajax('recent' , param , function( r ){
   //          if( !r.data || !r.data.length ) return;
   //          var nodes = [];
   //          $.each( r.data , function( i , node ){
   //              if( node.nid == lastNid ){
   //                  return false;
   //              } else {
   //                  nodes.push( node );
   //              }
   //          } );

			// var count = nodes.length;
			// var loaded = 0;
			// // preload images before insert
			// $.each(nodes, function(i, node){
			// 	var image = node.file.split('.')[0] + '_250_250.jpg';
			// 	$('<img/>').attr('src' , API_FOLDER + image).ensureLoad(function(){
			// 		loaded ++;
			// 		if(count == loaded) {
			// 			// insert node
			// 			nodeActions.prependNode( $main , nodes , param.orderby == "datetime" );
			// 		}
			// 	});
			// });

   //      } );
   //  });


    //after selected photo
//    $('#file-photo').change(function(){
//        $('.pop-file .step1-btns').fadeOut(400);
//        $('.pop-file .step2-btns').delay(400).fadeIn(400);
//    });



    // bind document key event for back , prev , next actions
    $(document).keydown(function( ev ){
        var $inner = $('.inner');
        if( !$inner.length || !$inner.is(':visible') ) return;
        switch( ev.which ){
            case 37: // left
                LP.triggerAction('prev');
                break;
            case 39: // right
                LP.triggerAction('next');
                break;
            case 27: // esc
				ev.preventDefault();
                LP.triggerAction('back');
                break;
        }
    });

    // get month
    // var getMonth = (function(){
    //     return function( date ){
    //         date = date || new Date;
    //         var month;
    //         if( typeof date == 'object' ){
    //             month = date.getUTCMonth();
    //         } else {
    //             month = date - 1;
    //         }
    //         return aMonth[ month ];
    //     }
    // })();


  //   // get all query parameter
  //   var refreshQuery = function( query ){
  //       // get search value
  //       var $searchInput = $('.search-ipt');
		// // reset the filter when search
		// if($searchInput.val() != '') {
		// 	resetQuery();
		// }
  //       var param = { page: 1 , pagenum: 20, token: apiToken };
  //       param [ $searchInput.attr('name') ] = $.trim( $searchInput.val() ).replace( /^#+/ , '' );

  //       // get select options
  //       $('.header .select').find('.select-option p.selected')
  //           .each( function(){
  //               param = $.extend( param , LP.query2json( $(this).data('param') ) );
  //           } );

  //       $main.data('param' , $.extend( param , query || {} ) );

  //       // change hash
  //       var param = $main.data('param');
  //       var str = '';
  //       $.each( ['orderby' , 'type' , 'country'] , function( i , val){
  //           if( param[val] ){
  //               str += '/' + val + '/' + param[val];
  //           }
  //       } )

  //       $('.side .menu-item').removeClass('active');

  //       return $main.data('param');
  //   }

    // var resetQuery = function() {
    //     var param = $main.data('param') || {};
    //     param.orderby = "datetime";
    //     param.page = 1;
    //     delete param.country_id;
    //     $main.data('param',param);
    //     $.each($('.select-item'), function(index, item){
    //         $(item).find('.select-option p').removeClass('selected');
    //         var defaultVal = $(item).find('.select-option p').eq(0).addClass('selected').html();
    //         $(item).find('.select-box').html(defaultVal);
    //     })
    // }

    var currentHash = location.hash;
    var changeUrl = function( str , data ){
            location.hash = '#' + str; // removed the !, don't need search by google
            if( history.pushState ){
                history.replaceState( data , '' , location.href ) ;
            } else {
                location.hash = '#' + str;
            }
            currentHash = location.hash;
        }


    // bind history change
    !(function(){
        $(window).bind('popstate' , function( ev ){
            if( !ev.originalEvent.state || !ev.originalEvent.state.event ) return;
            $.each( transitions , function( i , trans ){
                var lastUrl = currentHash.replace('#' , '');
                var currUrl = location.hash.replace('#' , '');
                console.log( lastUrl , currUrl );
                if( trans.prev.test( lastUrl ) && 
                    trans.curr.test( currUrl ) ){
                    trans.fn( lastUrl , currUrl );
                    return false;
                }
            } );
            currentHash = location.hash;
        });

        // run the right transition for back or prev btn event on browser.
        var transitions = [];
        function addTransition( lastReg , currReg , fn ){
            transitions.push({
                prev: lastReg,
                curr: currReg,
                fn : fn
            });
        }

        // /nid/xx ==> /nid/xx
        addTransition( /^\/nid\/\d+/ , /^\/nid\/\d+/ , function( lastUrl , currUrl ){
            var lnid = lastUrl.match(/\d+/)[0];
            var nid = currUrl.match(/\d+/)[0];
            console.log( 'last nid : ' + lnid , 'currNide : ' + nid );
            LP.triggerAction( lnid > nid ? 'next' : 'prev' );
        } );
        //  ==> /nid/xx
        addTransition( /^\/main$/ , /^\/nid\/\d+/ , function( lastUrl , currUrl ){
            var nid = currUrl.match(/\d+/)[0];
            $main.children('[data-d="nid=' + nid + '"]').trigger('click');
        } );
        //  /nid/xx ==> 
        addTransition( /^\/nid\/\d+/ , /^\/main$/ , function( lastUrl , currUrl ){
            LP.triggerAction('back');
        } );

		//  /nid/xx ==>
		addTransition( /^\/nid\/\d+/ , /^\/search/ , function( lastUrl , currUrl ){
			LP.triggerAction('back');
		} );

  //       // * ==> /user 
  //       addTransition( /.*/ , /^\/user/ , function( lastUrl , currUrl ){
  //           LP.triggerAction('toggle_user_page');
  //       } );

  //       // /user ==> *
  //       addTransition( /^\/user/ , /.*/ , function( lastUrl , currUrl ){
  //           LP.triggerAction('toggle_user_page');
  //       } );

  //       // * ==> /com
  //       addTransition( /.*/ , /^\/com/ , function( lastUrl , currUrl ){
  //           LP.triggerAction('content_of_month');
  //       } );
  //       // /com ==> /nid
  //       addTransition( /^\/(com|cod)/ ,  /^\/nid\/\d+/ , function( lastUrl , currUrl ){
  //           var nid = currUrl.match(/\d+/)[0];
  //           $main.children('[data-d="nid=' + nid + '"]').trigger('click');
  //       } );
  //       // /com ==> /user
  //       addTransition( /^\/(com|cod)/ ,  /^\/nid\/\d+/ , function( lastUrl , currUrl ){
  //           LP.triggerAction('toggle_user_page');
  //       } );
  //       // /com ==> /^$/
  //       addTransition( /^\/(com|cod)/ ,  /^$/ , function( lastUrl , currUrl ){
  //           LP.triggerAction('back_home');
  //       } );
        
  //       // * ==> /cod
  //       addTransition( /.*/ , /^\/cod/ , function( lastUrl , currUrl ){
  //           LP.triggerAction('content_of_day');
  //       } );
    })();




    //-----------------------------------------------------------------------
    // init drag event for image upload
    // after image upload, init it's size to fix the window
    // use raephael js to rotate, scale , and drag the image photo
    // var transformMgr;
    // LP.use('imgUtil' , function( imgUtil ){
    //     transformMgr = imgUtil;
    // });


//     var init = function() {

// //        var datetime = new Date(((1392175200+1*3600)*1000));
// //        var country = "South Africa,Albania,Algeria,Germany,Saudi,Arabia,Argentina,Australia,Austria,Bahamas,Belgium,Benin,Brazil,Bulgaria,Burkina Faso,Canada,Chile,China,Cyprus,Korea,Republic of Ivory Coast,Croatia,Denmark,Egypt,United Arab Emirates,Spain,Estonia,USA,Finland,France,Georgia,Ghana,Greece,Guinea,Equatorial Guinea,Hungary,India,Ireland,Italy,Japan,Jordan,Latvia,Lebanon,Lithuania,Luxembourg,Macedonia,Madagascar,Morocco,Mauritania,Mexico,Moldova,Republic of Montenegro,Norway,New Caledonia,Panama,Netherlands,Peru,Poland,Portugal,Reunion,Romania,UK,Russian Federation,Senegal,Serbia,Singapore,Slovakia,Slovenia,Sweden,Switzerland,Chad,Czech Republic,Tunisia,Turkey,Ukraine,Uruguay,Vietnam";
// //        var countryArray = country.split(',');
// //        var output;
// //        $.each(countryArray, function(i,e){
// //            var string = '{"country_id":'+(i+1)+',"country":"'+e+'"},';
// //            output += string;
// //        });
// //        console.log(output);

// //        $(document).ajaxStop(function () {
// //            console.log(1);
// //        });

// //		$('.page-loading-logo img').ensureLoad(function(){
// //			$('.page-loading-logo').fadeIn().dequeue().animate({top:'50%'}, 1000, 'easeInOutQuart');
// //		});

// 		if(isOldIE) return;

//         // Get language
//         // lang = LP.getCookie('lang') || 'fr';

//         // api.ajax('i18n_' + lang , function( result ){
//         //     _e = result;

//         //     aMonth = [_e.JANUARY,_e.FEBRUARY,_e.MARCH,_e.APRIL,_e.MAY,_e.JUNE,_e.JULY,_e.AUGUST,_e.SEPTEMBER,_e.OCTOBER,_e.NOVEMBER,_e.DECEMBER];

//             LP.compile( 'base-template' , function( html ){
//                 $('body').prepend(html);
//                 $main = $('.main');
//                 $listLoading = $('.loading-list');

//                 // $('.language-item').removeClass('language-item-on')
//                 //     .filter('[data-d="lang=' + lang + '"]')
//                 //     .addClass('language-item-on');

//                 // after page load , load the current user information data from server
//       //           api.ajax('user' , function( result ){
//       //               if(result.success) {
//       //                   //bind user data after success logged
//       //                   if(result.data.count_by_day == 0) {
//       //                       delete result.data.count_by_day;
//       //                   }
//       //                   if(result.data.count_by_month == 0) {
//       //                       delete result.data.count_by_month;
//       //                   }
//       //                   if(!result.data.avatar) {
//       //                       result.data.avatar = "/uploads/default_avatar.gif";
//       //                   }
//       //                   else {
//       //                       result.data.avatar = result.data.avatar + '?' + new Date().getTime();
//       //                   }
// 						// result.data.country.country_name = _e[result.data.country.i18n];
//       //                   result.data._e = _e;
//       //                   LP.compile( 'user-page-template' , result.data , function( html ){
//       //                       $('.content').append(html);
//       //                   });

//       //                   LP.compile( 'side-template' , result.data , function( html ){
//       //                       $('.content').append(html);
//       //                       //cache the user data
//       //                       $('.side').data('user',result.data);
//       //                   });
//       //                   $('.page').addClass('logged');
//       //                   $('.header .select').fadeIn();
//       //               }
//       //               else {
//       //                   $('.header .login').fadeIn();
//       //               }
//       //           });

// 				// api.ajax('token' , function( result ){
// 				// 	apiToken = result.data;
// 				// });


//                 // var $countryList = $('.select-country-option-list');
//                 // $countryList.empty();
//                 // $countryList.append('<p data-api="recent">'+_e.ALL+'</p>');
//                 // api.ajax('countryList', function( result ){
//                 //     $.each(result, function(index, item){
//                 //         var html = '<p data-param="country_id=' + item.country_id + '" data-api="recent">' + _e[item.i18n] + '</p>';
//                 //         $countryList.append(html);
//                 //     });
//                 //     LP.use(['jscrollpane' , 'mousewheel'] , function(){
//                 //         $countryList.jScrollPane({autoReinitialise:true});
//                 //     });
//                 // });

//                 // LP.use('uicustom',function(){
//                 //     var placeHolder = $( ".search-ipt").attr('placeholder');
//                 //     $( ".search-ipt").val('').autocomplete({
//                 //         source: function( request, response ) {
//                 //             if(tagReq) {
//                 //                 tagReq.abort();
//                 //             }
//                 //             tagReq = $.ajax({
//                 //                 url: "./api/tag/list",
//                 //                 dataType: "json",
//                 //                 data: {
//                 //                     term: request.term.replace('#','')
//                 //                 },
//                 //                 success: function( data ) {
//                 //                     response( $.map( data.data, function( item ) {
//                 //                         return {
//                 //                             label: item.tag,
//                 //                             value: item.tag
//                 //                         }
//                 //                     }));
//                 //                 }
//                 //             });
//                 //         },
//                 //         minLength: 1,
//                 //         select: function( event, ui ) {
//                 //         }
//                 //     });
//                 // });


//                 LP.use('handlebars' , function(){
//                     //Handlebars helper
//                     Handlebars.registerHelper('ifvideo', function(options) {
//                         if(this.type == 'video')
//                             return options.fn(this);
//                         else
//                             return options.inverse(this);
//                     });

//                     Handlebars.registerHelper('ifliked', function(options) {
//                         if(this.user_liked == true)
//                             return options.fn(this);
//                         else
//                             return options.inverse(this);
//                     });

//                     Handlebars.registerHelper('ifzero', function(value, options) {
//                         if(value <= 1)
//                             return options.fn(this);
//                         else
//                             return options.inverse(this);
//                     });
//                 });

//                 // every five minutes get the latest nodes
//                 setInterval( function(){
//                     LP.triggerAction('get_fresh_nodes');
//                 } , 5 * 60 * 1000 );
//             });
//         //});




//         // When the init AJAX all finished, fadeOut the loading layout
//         $(document).ajaxStop(function () {
//             pageLoaded(1000);
// 			openByHash();
//             $(this).unbind('ajaxStop');
//         });

//     }



    var bindCommentSubmisson = function() {
        LP.use('form' , function(){
            var $submitBtn = $('.comment-form .submit');
            $('.comment-form').ajaxForm({
                beforeSubmit:  function($form){
                    if($submitBtn.hasClass('disabled')) {
                        return false;
                    }
                    $submitBtn.addClass('disabled');
                    $('.comment-msg-error').hide();
                    $('.com-ipt').val().length;
                    if($('.com-ipt').val().length == 0) {
                        $('.comment-msg-error').fadeIn().html(_e.WRTIE_COMMENT);
                        $submitBtn.removeClass('disabled');
                        return false;
                    }
                    if($('.com-ipt').val().length > 140) {
                        $submitBtn.removeClass('disabled');
                        $('.comment-msg-error').fadeIn().html(_e.ERROR_COMMENT_LIMITED);
                        return false;
                    }
					$('.com-loading').fadeIn();
                },
                complete: function(xhr) {
					$('.com-loading').fadeOut();
                    var res = xhr.responseJSON;
                    if(res.success) {
                        var comment = res.data;
                        var datetime = new Date((parseInt(comment.datetime)+1*3600)*1000);
                        comment.date = datetime.getUTCDate();
                        comment.month = parseInt(datetime.getUTCMonth()) + 1;
                        comment.user = $('.side').data('user');
                        comment.mycomment = true;
                        $('.comment-form').fadeOut(function(){
							$('.com-ipt').val('');
						});
                        $('.comment-msg-success').delay(500).fadeIn();
                        $('.comment-msg-success').delay(800).fadeOut();
                        $('.comment-form').delay(1800).fadeIn(function(){
							$submitBtn.removeClass('disabled');
						});
                        LP.compile( 'comment-item-template' ,
                            comment,
                            function( html ){
                                // render html
                                if($('.com-list-inner .comlist-item').length == 0) {
                                    $('.com-list-inner').html('');
                                }
                                $('.com-list-inner').first().append(html);
                                var $comCount = $('.com-com-count');
                                var newComCount = parseInt($comCount.html())+1;
                                $comCount.html(newComCount);
                                var nid = $('.comment-wrap').data('param').nid;
                                $('.main-item-' + nid).find('.item-comment').html(newComCount);

                                (function(){
                                    var nodes = $('.main').data('nodes');
                                    if(nodes) {
                                        var node = jQuery.grep(nodes, function (node) {
                                            if(node.nid == nid) {
                                                return node;
                                            }
                                        });
                                        if(node.length > 0) {
                                            node[0].commentcount = newComCount;
                                        }
                                    }
                                })();

                                (function(){
                                    var nodes = $('.count-com').data('nodes');
                                    if(nodes) {
                                        var node = jQuery.grep(nodes, function (node) {
                                            if(node.nid == nid) {
                                                return node;
                                            }
                                        });
                                        if(node.length > 0) {
                                            node[0].commentcount = newComCount;
                                        }
                                    }
                                })();

                                LP.triggerAction('update_user_status');
                            } );
                    }
                    else {
                        if(res.message === 601) {
                            $('.comment-msg-error').html(_e.LOGIN_BEFORE_COMMENT);
                        }
                    }
                }
            });
        });
    }


    /**
     * Get node comments
     * @param nid
     */
    var getCommentList = function(nid, page) {
        var $commentWrap = $('.comment-wrap');
        if($commentWrap.hasClass('loading')) return;
        $commentWrap.addClass('loading');
        var commentParam = {nid: nid, pagenum:10, page:page};
        $commentWrap.data('param', commentParam);
        api.ajax('commentList', commentParam, function( result ){
            $commentWrap.removeClass('loading');
            $('.com-list-loading').fadeOut(100);
            var comments = result.data;
            if(comments.length == 0){
                $commentWrap.addClass('loading');
            }
            if(comments.length == 0 && page == 1) {
                $('.com-list-inner').html('<div class="no-comment">no comments</div>');
            }
            else {
                $.each( comments , function( index , comment ){
                    // get date
                    var datetime = new Date((parseInt(comment.datetime)+1*3600)*1000);
                    comment.date = datetime.getUTCDate();
                    comment.month = parseInt(datetime.getUTCMonth()) + 1;
                    LP.compile( 'comment-item-template' ,
                        comment ,
                        function( html ){
                            // render html
                            $('.com-list-inner').first().append(html);
                        } );
                });
            }
            // check the flagged comment if is login user
            // var user = $('.side').data('user');
            // if(user) {
            //     api.ajax('flaggedComments', {nid: nid}, function( result ){
            //         $.each(result.data, function(index, item){
            //             $('.comlist-item-' + item.cid).find('.comlist-flag').addClass('flagged').removeClass('btn2').removeAttr('data-a');
            //         });
            //     });
            // }
        });
    }

    /**
     * Resize Inner Box width Image and Video
     */
    var resizeInnerBox = function(){
        var $side = $('.side');
        var slideWidth = $side.width();
        // Resize Inner Box
        var $inner = $('.inner');
        if( !$inner.is(':visible') ) return;
        var innerHeight = $(window).height() - $('.header').height();
        $inner.height(innerHeight);

        // Resize Comment Box
        var $comList = $('.com-list');
        var comListHeight = $(window).height() - 350 - 110;
        $comList.height(comListHeight);

        // Resize Image
        var imgBoxWidth = $(window).width() - 330 - slideWidth;
        var imgBoxHeight =$(window).height() - $('.header').height();
        var minSize = Math.min( imgBoxHeight , imgBoxWidth );
        var $img = $('.image-wrap-inner img').css('margin',0);
        $('.image-wrap-inner').width(minSize).height(minSize);

        if( imgBoxHeight > imgBoxWidth ){
            var marginLeft = (imgBoxHeight - imgBoxWidth) / 2;
            $('.image-wrap-inner').height(imgBoxHeight);
            $img.width('auto').height('100%').css('margin-left', -marginLeft);
        }
        // if(imgBoxWidth > imgBoxHeight) {
        //     var marginTop = (imgBoxWidth - imgBoxHeight) / 2;
        //     $img.css('margin',0);
        //     $img.height('auto').width('100%').css('margin-top', -marginTop);
        // } else {
        //     var marginLeft = (imgBoxHeight - imgBoxWidth) / 2;
        //     $img.css('margin',0);
        //     $img.width('auto').height('100%').css('margin-left', -marginLeft);
        // }

        // Resize Video
        // var $video = $('.video-js .vjs-tech');
        // if($video.hasClass('zoom')) {
        //     var $videoWrap = $('.video-js');
        //     var videoWrapWidth = $videoWrap.width();
        //     var videoWrapHeight = $videoWrap.height();
        //     var videoWrapRatio = videoWrapWidth/videoWrapHeight;
        //     var videoWidth = $video.width();
        //     var videoHeight = $video.height();
        //     var videoRatio = videoWidth/videoHeight;
        //     if(videoRatio < videoWrapRatio) {
        //         $video.width('100%').height('auto');
        //         var videoMarginTop = (videoHeight - videoWrapHeight)/2;
        //         $video.css('margin-top',-videoMarginTop);
        //         $video.css('margin-left',0);
        //     } else {
        //         $video.width('auto').height('100%');
        //         var videoMarginLeft = (videoWidth - videoWrapWidth)/2;
        //         $video.css('margin-left',-videoMarginLeft);
        //         $video.css('margin-top',0);
        //     }
        // }

        // Resize WMV iframe
        var $iframe = $('.image-wrap-inner iframe');
        if($iframe.length > 0) {
            $iframe.width('100%').height(imgBoxHeight-36);
        }

        // resize inner width
        var minLeft = $(window).width() - minSize;
        $('.inner').css('margin-left' , minLeft )
            // set inner info
            .find('.inner-info')
            .css({
                'width': minSize,
                'left' : minLeft 
            })
            // set .comment-wrap
            .end()
            .find('.comment-wrap')
            .css({
                'width' : minLeft - slideWidth,
                'left'  : slideWidth - minLeft
            })
            // set image wrap width
            .end()
            .find('.image-wrap')
            .width( minSize )
            // fix side size
            .end()
            .find('.inner-side')
            .css('left' , slideWidth - minLeft - 126);

    }

    /**
     * Resize User Box
    //  */
    // var resizeUserBox = function(){
    //     var userBoxHeight = $(window).height() - $('.header').height()-130;
    //     var formHeight = $('.user-edit-page form').height() + 100;
    //     $('.user-edit-page').height(userBoxHeight);
    //     $('.count-com').css('min-height',userBoxHeight);
    //     if(formHeight > userBoxHeight) {
    //         $('.user-edit-page').height(formHeight);
    //     }
    //     if((formHeight+130) > userBoxHeight){
    //         $('.editfi-country-pop').addClass('up');
    //     }
    //     else {
    //         $('.editfi-country-pop').removeClass('up');
    //     }
    // }


    /**
     * Open the content via url hash id
     */
    var openByHash = function(){
        changeUrl( location.hash.replace('#' , '') || '/main' , {event:'load'} );
        //获取nid所在的页码，然后加载该list
        var hash = location.hash;
        var match;
        if( ( match = hash.match( /#\/nid\/(\d+)/ ) ) ){
            var nid = match[1];
            var pageParam = $main.data('param') || {};
            api.ajax('getPageByNid', {nid:nid, pagenum:20}, function(result){
                pageParam.page = result.data;
                pageParam.previouspage = result.data;
                $main.data('param' , pageParam);
                api.ajax('recent', pageParam , function( result ){
                    if(result.data.length > 0) {
                        nodeActions.inserNode( $main , result.data);
                        $listLoading.fadeOut();
                        setTimeout(function(){
                            $('.main-item-'+nid).click();
                        },100);

                        // fix bug , some times the height would be 0
                        $main.height('auto');
                    }
                });
            });
        }
    }

    /**
     * Hide page loading
     */
    // var pageLoaded = function(delay){
    //     $('.page-loading').delay(delay).fadeOut(function(){
    //        $(this).remove();
    //     });
    // }

    var renderVideo = function($newItem,node){
        LP.compile( 'html5-player-template' , node , function( html ){
            $newItem.html(html);
        });
        // LP.use('flash-detect', function(){
        //     if($('html').hasClass('video') && !isFirefox) { // need to validate html5 video as well
        //         LP.compile( 'html5-player-template' , node , function( html ){
        //             $newItem.html(html);
        //             // LP.use('video-js' , function(){
        //             //     videojs( "inner-video-" + node.timestamp , {}, function(){
        //             //         $('.video-js').append('<div class="video-btn-zoom btn2" data-a="video_zoom"></div>');
        //             //         $('.vjs-big-play-button').click(function(){
        //             //             $('video').attr('poster', '');
        //             //         });
        //             //         $('.inner-infoicon .video').on('click', function(){
        //             //             if($('.video-js').hasClass('vjs-paused')) {
        //             //                 $('video')[0].play();
        //             //             }
        //             //             else {
        //             //                 $('video')[0].pause();
        //             //             }
        //             //         });
        //             //         $('video').on('ended pause', function(){
        //             //             $('.inner-infoicon .video').removeClass('pause');
        //             //         });
        //             //         $('video').on('play', function(){
        //             //             $('.inner-infoicon .video').addClass('pause');
        //             //         });
        //             //     });
        //             // });

        //             // if(isPad) {
        //             //     $('video').attr('controls', 'controls');
        //             // }
        //         });
        //     }
        //     else if(FlashDetect.installed)
        //     {
        //         LP.compile( 'flash-player-template' , node , function( html ){
        //             $newItem.html(html);
        //             if($('#flash-player').length) {
        //                 var flashPlayer=document.getElementById("flash-player");
        //                 if(!flashPlayer.play){
        //                     flashPlayer = document.getElementById("flash-player-embed");
        //                 }
        //                 $('.inner-infoicon .video').on('click', function(){
        //                     if($(this).hasClass('pause')) {
        //                         flashPlayer.pause();
        //                         $(this).removeClass('pause');
        //                     }
        //                     else {
        //                         flashPlayer.play();
        //                         $(this).addClass('pause');
        //                     }

        //                 });
        //             }
        //         });
        //     }
        //     else
        //     {
        //         node.file = node.file.replace('mp4','wmv');
        //         LP.compile( 'wmv-player-template' , node , function( html ){
        //             $newItem.html(html);
        //             $('.image-wrap-inner iframe');
        //             $('.inner-infoicon .video').on('click', function(){
        //                 if($('#wmv-iframe').length) {
        //                     $('#wmv-iframe')[0].contentWindow.iframePlay();
        //                 }
        //             });
        //         });
        //     }
        // });
    }



    jQuery.fn.extend({
        ensureLoad: function(handler) {
            return this.each(function() {
                if(this.complete) {
                    handler.call(this);
                } else {
                    $(this).load(handler);
                }
            });
        }
    });

    

    // page init here
    var $main = null;
    var $listLoading = $('.loading-list');
    $(function(){
        LP.compile( 'base-template' , {} , function( html ){
            $(document.body).append(html);
            $main = $('.main').data('param' , {page:0 , orderby: 'datetime'});
            // hide loading 
            $('.page-loading').fadeOut();
            // load first page node list

            $(window).trigger('scroll');
        });

        openByHash();
    });


     LP.use('handlebars' , function(){
        //Handlebars helper
        Handlebars.registerHelper('ifvideo', function(options) {
            if(this.type == 'video')
                return options.fn(this);
            else
                return options.inverse(this);
        });

        Handlebars.registerHelper('ifliked', function(options) {
            if(this.user_liked == true)
                return options.fn(this);
            else
                return options.inverse(this);
        });

        Handlebars.registerHelper('ifzero', function(value, options) {
            if(value <= 1)
                return options.fn(this);
            else
                return options.inverse(this);
        });

        Handlebars.registerHelper('if-exp', function(v1 , v2 , v3, options) {
            if( eval( "'" + v1 + "'" + v2 + "'" + v3 + "'" ) ){
                return options.fn(this);
            } else {
                return options.inverse(this);
            }
        });
    });
});


var flashPlay = function(){
    $('.inner-infoicon .video').addClass('pause');
}
var flashplayComplete = function(){
    $('.inner-infoicon .video').removeClass('pause');
}