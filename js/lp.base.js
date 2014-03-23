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
    
    var monthsShort = ["Jan", "Feb", "Mars", "Apr", "Mai", "Juin", "Départ", "Août", "Sept", "Oct", "Nov", "Déc"];
    var getMonth = function( index ){
        return monthsShort[ index ];
    }
	var styleIndex = 0;

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
            var likedTip = $(this).find('.liked-tip');
            if(likedTip) {
                likedTip.fadeIn();
            }
        })
        .delegate('.com-like','mouseleave',function(){
            var likedTip = $(this).find('.liked-tip');
            if(likedTip) {
                likedTip.fadeOut();
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
        })



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

                node.style = styleIndex;
				styleIndex ++;
				if(styleIndex == 3) {
					styleIndex = 0;
				}
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
                    if( $.inArray( node.nid , cookieLikeStatus ) !== -1 ){
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
                if( node.type == "photo" || node.type == "video"){
                    node.image = node.image.replace('.jpg' , THUMBNAIL_IMG_SIZE + '.jpg' );
                }   
                // fix description
                node.description = node.description || '';
                node.sub_description = node.description.length > 70 ? node.description.substr(0 , 70) + '...' : node.description;
                node.sub_description = node.sub_description.replace(/#\S+/g , '<span style="color:white;">$&</span>');
                node.likecount = node.likecount || 111;

                node.str_like = node.likecount > 1 ? 'Likes' : 'Like';

				node.style = styleIndex;
				styleIndex ++;
				if(styleIndex == 3) {
					styleIndex = 0;
				}
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
            var isAdmin = 1;
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
        node.share = encodeURIComponent(node.description);
		node.encode_username = encodeURIComponent(node.screen_name);

        if( node.type == "photo" )
            node.image = node.file.replace( node.type == "video" ? '.mp4' : '.jpg', BIG_IMG_SIZE + '.jpg');

        node.timestamp = (new Date()).getTime();
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
            if(!isAdmin) {
                $inner.data('from' , $dom.parent() );
            }

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

				$('body').css({overflowY:'scroll'});
                $('.content').css({overflow:'visible'});
                //nodeActions.setItemReversal( $dom );
            });


        changeUrl('/main' , {event:'back'});

    });

    LP.action('load-comment' , function( data ){

        if($('.com-wrap').is(':visible')) return;
        LP.triggerAction('com-share-close');
        $('.com-wrap').css({top:'100%'}).fadeIn().dequeue().animate({top:'0%'}, 500, 'easeOutQuart');
        bindCommentSubmisson();
        if($('.com-wrap .comlist-item').length == 0) {
            getCommentList(data.nid , data.page || 1);
        }


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
        $('.com-wrap').fadeOut().dequeue().animate({top:'100%'}, 500, 'easeInQuart');
    });

    LP.action('com-share-close', function(){
        $('.com-share').fadeOut().dequeue().animate({top:'100%'}, 500, 'easeInQuart');
    });

    LP.action('com-open-share', function(){
        if($('.com-share').is(':visible')) return;
        LP.triggerAction('com-close');
        $('.com-share').css({top:'100%'}).fadeIn().dequeue().animate({top:'0%'}, 500, 'easeOutQuart');
    });
    


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

  //       var datetime = new Date((parseInt(node.datetime)+1*3600)*1000);
  //       node.date = datetime.getUTCDate();
  //       node.month = parseInt(datetime.getUTCMonth()) + 1;
		// node.hour = datetime.getHours();
		// node.minutes = datetime.getUTCMinutes();

        var datetime = new Date((parseInt(node.datetime)+1*3600)*1000);
        node.year = datetime.getUTCFullYear();
        node.hour = datetime.getHours();
        node.minutes = datetime.getUTCMinutes();
        node.date = datetime.getUTCDate();
        node.month = parseInt(datetime.getUTCMonth()) + 1;
        node.share = encodeURIComponent(node.description);
        node.encode_username = encodeURIComponent(node.screen_name);
        //node.currentUser = $('.side').data('user');
        if( node.image )
            node.image = node.file.replace( node.type == "video" ? '.mp4' : '.jpg', BIG_IMG_SIZE + '.jpg');
        node.timestamp = (new Date()).getTime();
        node.share = encodeURIComponent(node.description);
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
//				var $wmvIframe = $('.image-wrap-inner iframe');
//				if($wmvIframe.length > 0) {
//					$wmvIframe.width('100%').height(imgBoxHeight-36);
//				}
            }
            // init photo node
            if( node.type == "photo" ){
                $('.image-wrap-inner img').ensureLoad(function(){
                    $(this).fadeIn();
                    //slideIntroBar($newInfo, _animateTime);
                });
            }

            //  reset the location
            $inner.find('.com-loc')
                .html($newInner.find('.com-loc').html());

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



    //for like action
    var updateLikeCount = function(nid, count , isLiked){
        $('.main-item-' + nid).find('.item-like').html(count).toggleClass('item-liked');

        if( isLiked ){
            $('.inner').find('a[data-a="like"]')
                .attr('data-a' , "unlike")
                .addClass('com-liked')
                .html(count + ' <i class="icon icon-liked"></i><span class="liked-tip">Vous avez aimé</span>');
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


    });


    LP.action('show-nodes' , function( data ){
        $main.data('param' , $.extend( data , {page: 0} ));
        $(this).addClass('actived')
            .siblings('.actived')
            .removeClass('actived');
        nodeActions.loadNodes();
    });




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


    })();






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
                    var data = LP.query2json( $('.comment-form').serialize() );
                    var error = "";
                    if(data.content.length == 0) {
                        error = "Veuillez écrire votre commentaire pour publier";
                    }
                    if(data.content.length > 140) {
                        error = "Comment'length doit être inférieure à 140";
                    }
                    if( !data.email.match(/^[a-zA-Z.\-0-9]+@[a-zA-Z0-9]+(.[a-zA-Z\-0-9]+)+$/) ){
                        error = "Veuillez remplir votre adresse mail.";
                    }
                    if( !data.name ){
                        error = "Veuillez remplir votre nom.";
                    }
                    if( error ){
                        $('.comment-msg-error').fadeIn()
                            .html( error );
                        $submitBtn.removeClass('disabled');
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

                    }
                    else {
                        // if(res.message === 601) {
                        //     $('.comment-msg-error').html(_e.LOGIN_BEFORE_COMMENT);
                        // }
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
                $('.com-list-inner').html('<div class="no-comment">Aucun commentaire</div>');
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
        var comListHeight = $(window).height() - 400 - 110;
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


        // Resize WMV iframe
        var $iframe = $('.image-wrap-inner iframe');
        if($iframe.length > 0) {
            $iframe.width('100%').height(imgBoxHeight);
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
     * Open the content via url hash id
     */
    var openByHash = function(){
        var isAdmin = getQueryString('admin');
        changeUrl( location.hash.replace('#' , '') || '/main' , {event:'load'} );
        //获取nid所在的页码，然后加载该list
        var hash = location.hash;
        var match;
        if( ( match = hash.match( /#\/nid\/(\d+)/ ) ) ){
            var nid = match[1];
            var pageParam = $main.data('param') || {};
            if(isAdmin) {
                api.ajax('getNode', {nid:nid}, function(result){
                    LP.triggerAction('node',result.data);
                });
                api.ajax('recent', pageParam , function( result ){
                    if(result.data.length > 0) {
                        nodeActions.inserNode( $main , result.data , pageParam.orderby == 'datetime' );
                        $listLoading.fadeOut();
                        // fix bug , some times the height would be 0
                        $main.height('auto');
                        $('.inner').data('from', $main);
                    }
                });
                return;
            }
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
        if(node.from == 'instagram') {
            node.embed = 'instagram.php?url=' + node.url;
        }
        LP.compile( 'html5-player-template' , node , function( html ){
            $newItem.html(html);
        });

    }

    var getQueryString = function(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
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
			$listLoading = $('.loading-list');
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


