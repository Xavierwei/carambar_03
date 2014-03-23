/*
 * page base action
 */
LP.use(['jquery', 'api', 'easing','transit','hammer', 'mousewheel', 'scrollfix'] , function( $ , api ){
    'use strict'

    var isFirefox = navigator.userAgent.toLowerCase().indexOf('firefox') > 0;
    var isPad =navigator.userAgent.toLowerCase().indexOf('pad') > 0;
	var isIE8 = $('html').hasClass('ie8');
	var isIE10 = navigator.userAgent.toLowerCase().indexOf('msie 10') > 0;
	var isOldIE = $('html').hasClass('ie6') || $('html').hasClass('ie7');
    var API_FOLDER = "./";
    var THUMBNAIL_IMG_SIZE = "_640_640";
    var BIG_IMG_SIZE = "_640_640";
	var winWidth = 640;
    var MIN_WIDTH = 200;
    var ITEM_WIDTH = MIN_WIDTH;
    var WIN_WIDTH = $(window).width();
	var $mainWrap = $('.main-wrap');

	var scrollTimeout;
    var monthsShort = ["Jan", "Feb", "Mars", "Apr", "Mai", "Juin", "Départ", "Août", "Sept", "Oct", "Nov", "Déc"];
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

	var sideDirection;
	$('body').hammer()
		.on("release dragleft dragright swipeleft swiperight", function(ev) {
			switch(ev.type) {
				case 'swipeleft':
					break;
				case 'dragleft':
					sideDirection = 'right';
					$('body').bind('touchmove', function(e){e.preventDefault()});
					break;
				case 'swiperight':
					break;
				case 'dragright':
					sideDirection = 'left';
					$('body').bind('touchmove', function(e){e.preventDefault()});
					break;
				case 'release':
					$('body').unbind('touchmove');
					if(sideDirection && !$('.inner').is(':visible') || sideDirection == 'right' && !$('.side').hasClass('closed')) {
						if(Math.abs(ev.gesture.deltaX) < 160 && sideDirection == 'left') {
							return;
						}
						LP.triggerAction('toggle_side_bar', sideDirection);
						sideDirection = '';
					}
					break;
				default:
					sideDirection = '';
			}
		}
	);

	var dragDirection;
	var _innerDragging = false;
	$('body').hammer()
		.on("release dragleft dragright swipeleft swiperight dragup dragdown", '.image-wrap-inner', function(ev) {
			switch(ev.type) {
				case 'dragup':
					return false;
					break;
				case 'swipeleft':
					break;
				case 'dragleft':
					dragDirection = 'right';
					LP.triggerAction('next', true);
					draggingNode(dragDirection,  ev.gesture.deltaX);
					_innerDragging = true;
					break;
				case 'swiperight':
					break;
				case 'dragright':
					dragDirection = 'left';
					LP.triggerAction('prev', true);
					draggingNode(dragDirection,  ev.gesture.deltaX);
					_innerDragging = true;
					break;
				case 'release':
					if(dragDirection && $('.inner').is(':visible')) {
						releaseDragNode(dragDirection);
					}
					_innerDragging = false;
					break;

			}
		}
	);

	$('body').hammer()
		.on("tap", '.main-item', function(ev) {
			if($(ev.target).hasClass('item-delete')) return;
			var _this = $(this);
			setTimeout(function(){
				if(navigator.userAgent.toLowerCase().indexOf('iphone') > 0) {
					if($('.main-wrap').hasClass('scrolling')) return;
				}
				if(_this.hasClass('opening')) return;
				_this.addClass('opening');
				setTimeout(function(){
					_innerLock = false; // force unlock
					_this.removeClass('opening');
				}, 1000);
				_this.addClass('active');
				setTimeout(function(){
					_this.removeClass('active');
				},200);
				setTimeout(function(){
					LP.triggerAction('node', _this);
				},400);
			}, 200);
		}
	);


	var _resizeTimer = null;
	$(document).hammer().on('dragup dragdown relase', '.main, .count-inner',function(ev){
		// if scroll to the botton of the window
		// ajax the next datas
		var $dom = $(this);
		var st = $dom.parent().scrollTop();
		var docHeight = $dom.height();
		//var winHeight = document.body.clientHeight;
		if( docHeight - st < 2000 ){

			// fix main element
			// it must visible and in main element has unreversaled node
			if( $main.is(':visible') ){
				if($main.hasClass('loading')) return;
				if($main.hasClass('end')) return;
				$main.addClass('loading');
				var param = $main.data('param');
				param.page++;
				$main.data('param' , param);
				$listLoading.css({opacity:1});
				api.ajax('recent' , param , function( result ){
					$listLoading.css({opacity:0});
					$main.removeClass('loading');
					if(result.data.length > 0)
					{
						nodeActions.inserNode( $main , result.data , param.orderby == 'datetime');
					}

					if(result.data.length < pagenum) {
						$main.addClass('end');
					}
				});
			}
			else {
				// fix user page element
				var $userCom = $('.user-page .count-com');;
				// it must visible and in main element has unreversaled node
				if( $('.count-com').is(':visible') ){
					if($userCom.hasClass('end')) return;
					if($userCom.hasClass('loading')) return
					$userCom.addClass('loading');
					var userPageParam = $('.count-com').data('param');
					userPageParam.page++;
					$('.count-com').data('param',userPageParam);
					$listLoading.css({opacity:1});
					api.ajax('recent' , userPageParam , function( result ){
						$listLoading.css({opacity:0});
						$userCom.removeClass('loading');
						if(result.data.length > 0)
						{
							nodeActions.inserNode( $userCom , result.data , true );
						}
						else {
							$userCom.addClass('end');
						}
					});
				}
			}

		}
	});

	$(document).hammer().on('dragup dragdown relase', '.com-list-inner',function(ev){

		var $dom = $(this);
		var st = $dom.parent().scrollTop();
		var docHeight = $dom.height();
		if(docHeight - st - $dom.parent().height() < 100) {
			var commentParam = $('.comment-wrap').data('param');
			getCommentList(commentParam.nid,commentParam.page + 1);
		}
	});

	// live for pic-item hover event
	$(document.body)
		.delegate('.pic-item' , 'mouseenter' , function(){
			if(isIE8) {
				$(this).find('.item-info-wrap').fadeIn(100);
			}
			$(this).find('.item-info')
				//.stop( true , false )
				.fadeIn( 500 );
		})
		.delegate('.pic-item' , 'mouseleave' , function(){
			if(isIE8) {
				$(this).find('.item-info-wrap').fadeOut(100);
			}
			$(this).find('.item-info')
				//.stop( true , false )
				.fadeOut( 500 );
		})
		.delegate('.search-ipt' , 'change' , function(ev){
			LP.triggerAction('search');
		})
//        .delegate('.menu-item' , 'mouseenter' , function(){
//            if($(this).hasClass('active')) {
//                return;
//            }
//            $(this).find('h6')
//                .delay(200).stop( true , true).fadeIn( 500 );
//            $(this).find('p')
//                .delay(200).stop( true , true).fadeOut( 500 );
//        })
//        .delegate('.menu-item' , 'mouseleave' , function(){
//            $(this).find('h6')
//                .delay(200).stop( true , true).fadeOut( 500 );
//            $(this).find('p')
//                .delay(200).stop( true , true ).fadeIn( 500 );
//        })
		// for select options
//        .delegate('.select-option p' , 'click' , function(){
//            $(this)
//                // add selected class
//                .addClass('selected')
//                // remove sibling class
//                .siblings()
//                .removeClass('selected')
//                .end()
//                .closest('.select-pop')
//                .prev()
//                .html( $(this).html() );
//
//            //TODO: loading animation
//
//            // reset status / back to homepage
//            if(!$main.is(':visible')){
//                LP.triggerAction('back');
//            }
//
//            $('.search-hd').fadeOut(100);
//
//
//            $main.fadeOut(100,function(){
//                LP.triggerAction('close_user_page');
//                LP.triggerAction('load_list');
//            });
//
//        })
//        .delegate('.editfi-country-option p' , 'click' , function(){
//            $('.editfi-country-box').html($(this).html()).data('id', $(this).data('id'));
//        })
		.delegate('.user-edit-page .edit-email' , 'blur' , function(){
			var $error = $('.user-edit-page .edit-email-error');
			var email = $(this).val();
			var exp = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\_|\.]?)*[a-zA-Z0-9]+\.(?:com|cn)$/;
			if (!exp.test(email)) {
				$error.fadeIn();
			}
			else
			{
				$error.fadeOut();
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
//        .delegate('.com-unlike','mouseenter',function(){
//            var unlikeTip = $(this).find('.com-unlike-tip');
//            if(unlikeTip) {
//                unlikeTip.fadeIn();
//            }
//        })
//        .delegate('.com-unlike','mouseleave',function(){
//            var unlikeTip = $(this).find('.com-unlike-tip');
//            if(unlikeTip) {
//                unlikeTip.fadeOut();
//            }
//        })
		.delegate('.com-ipt','keyup',function(){
			var textLength = $(this).val().length;
			if(textLength > 0 || textLength <= 140) {
				$('.comment-msg-error').fadeOut();
			}
			if(textLength > 140) {
				$('.comment-msg-error').fadeIn().html(_e.ERROR_COMMENT_LIMITED);
				$('.comment-form .submit').attr('disabled','disabled');
			}
		})
		.delegate(document,'keyup',function(ev){
			if(ev.which == 27) {
				LP.triggerAction('close_pop');
				LP.triggerAction('cancel_modal');
			}
		})
		.delegate('.editfi-condition','click',function(){
			if($(this).hasClass('checked')) {
				$(this).removeClass('checked');
			} else {
				$(this).addClass('checked');
				$('.editfi-condition-error').fadeOut();
			}
		})
		.delegate('.poptxt-check','click',function(){
			if($(this).hasClass('checked')) {
				$(this).removeClass('checked');
			} else {
				$(this).addClass('checked');
				$('.poptxt-check .error').fadeOut();
			}
		})
		.delegate('textarea, input','focus',function(){
			$(this).addClass('focus');
			var placeholder = $(this).attr('placeholder');
			if(placeholder)
			{
				if(isIE8) {
					$(this).val('');
				} else {
					$(this).data('placeholder', placeholder);
				}
				$(this).removeAttr('placeholder');
			}

		})
		.delegate('textarea, input','blur',function(){
			if($(this).val().length == 0) {
				$(this).removeClass('focus');
			}
			if(!isIE8) {
				var placeholder = $(this).data('placeholder');
				if(placeholder)
				{
					$(this).attr('placeholder', placeholder);
				}
			}
		})
		.delegate('video','click',function(){
			$(this)[0].pause();
		})


		// click to hide select options
		.click(function( ev ){
			$('.select-pop').fadeOut();
			if( $(ev.target).hasClass('select-box') ){
				$(ev.target)
					.next()
					.fadeIn();
			}

			$('.editfi-country-pop').fadeOut();
			if( $(ev.target).hasClass('editfi-country-box') ){
				$(ev.target)
					.next()
					.fadeIn();
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
                node.style = parseInt(Math.random()*3);
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

                node.style = parseInt(Math.random()*3);
                LP.compile( 'node-item-template' ,
                    node ,
                    function( html ){
                        aHtml.push( html );

                        if( index == nodes.length - 1 ){
                            // render html
                            $dom.append(aHtml.join(''));
//                            nodeActions.setItemWidth( $dom );
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
			var $nodes = $dom.find('.pic-item:not(.reversal)');
			var $imgs = $nodes.find('img');
			$imgs.hide().ensureLoad(function(){
				$(this).fadeIn().parents('.pic-item').addClass('reversal');
			});
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
//            clearTimeout( _resizeTimer );
//
//            _resizeTimer = setTimeout(function(){
//                if( !$main.hasClass('disabled') ){
//                    nodeActions.setItemWidth( $main );
//                    // run isotope after item width fixed
//                    setTimeout(function(){
//                        nodeActions.setItemIsotope( $main );
//                    } , 500);
//                }
//
//                $('body')[$(window).width() < 800 ? "addClass" : "removeClass"]('sm-width');
//            } , 200);
//
//            // immediate resize
//            // resize big image
//            resizeInnerBox();
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
    LP.action('node' , function( $obj ){
		if( _innerLock ) return;
		_innerLock = true;
		setTimeout(function(){
			_innerLock = false; // force unlock
		}, 400);
        var $dom = $obj;
		_currentNodeIndex = $obj.prevAll(':not(.time-item)').length;
		var nodes = $main.data('nodes');
		var node = nodes[ _currentNodeIndex ];
        var datetime = new Date((parseInt(node.datetime)+1*3600)*1000);
        node.year = datetime.getUTCFullYear();
        node.hour = datetime.getHours();
		if((''+node.hour).length == 1) {
			node.hour = '0' + node.hour;
		}
        node.minutes = datetime.getUTCMinutes();
		if((''+node.minutes).length == 1) {
			node.minutes = '0' + node.minutes;
		}
        node.date = datetime.getUTCDate();
		node.month = parseInt(datetime.getUTCMonth()) + 1;
        node.share = encodeURIComponent(node.description);

        if( node.type == "photo" )
            node.image = node.file.replace( node.type == "video" ? '.mp4' : '.jpg', BIG_IMG_SIZE + '.jpg');

        node.timestamp = (new Date()).getTime();
        LP.compile( 'inner-template' , node , function( html ){
            var mainWidth = WIN_WIDTH;
            var mainWrapWidth = $main.width();
            // inner animation
            $('.inner').eq(0).fadeOut(function(){
                $(this).remove();
            });
            var $inner = $(html).insertBefore( $mainWrap )
				.css({
					x: mainWidth
					//position: 'relative'
				})
				.transit({
					x: 0
				}, 500 );
            // set inner-info bottom css


            // main animation
			$main.transit({'x':-mainWidth}, 500, function(){
				_innerLock = false;
				var scrollTop = $main.parent().scrollTop();
				$main.data('scrollTop', scrollTop).hide();
			});


			// Resize Image
			var $newItem = $('.image-wrap-inner');
			var imgBoxWidth = $('.inner').width();
			var imgBoxHeight =$('.inner').height() - 154;
			var minSize = Math.min( imgBoxHeight , imgBoxWidth );
			var $img = $newItem.find('img').css('margin',0);
			$newItem.width(imgBoxWidth).height(minSize);

			if( imgBoxHeight > imgBoxWidth ){
				var marginLeft = (imgBoxHeight - imgBoxWidth) / 2;
				$newItem.height(imgBoxHeight);
				$img.width('auto').height('100%').css('margin-left', -marginLeft);
			}


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
		var mainWidth = winWidth;
		$inner
			.transit({
				x: mainWidth
			} , 500 , function(){
				$inner.remove();
			});

		$main.delay(1).transit({
			x: 0
		} , 500);

		var scrollTop = $main.data('scrollTop');
		$main.show().parent().animate({scrollTop:scrollTop},0);

//		var pageParam = $main.data('param');
//		if(pageParam.previouspage != null) {
//			$main.html('');
//			$main.data( 'nodes', [] );
//			$listLoading.css({opacity:1});
//
//			LP.triggerAction('recent' , pageParam);
//		}

		changeUrl('' , {event:'back'});

    });

	LP.action('toggle_comment', function( data ){
		if($('.com-share-pop').is(':visible')) {
			LP.triggerAction('toggle_share');
		}
		var $comMain = $('.com-main');
		if(!$comMain.is(':visible')) {
			$comMain.show()
				.css({y:1000, opacity:0})
				.transit({y:0, opacity:1}, _animateTime, _animateEasing);

			$comMain.find('.com-list').height($comMain.height() - 410);

			if($comMain.find('.comlist-item').length == 0) {
				bindCommentSubmisson();
				getCommentList(data.nid,1);
			}
		}
		else {
			$comMain.transit({y:1000, opacity:0}, _animateTime, _animateEasing, function(){
				$(this).hide();
			});
			$('.comment-wrap').removeClass('loading');
		}

	});

	LP.action('toggle_share', function( data ){
		if($('.com-main').is(':visible')) {
			LP.triggerAction('toggle_comment');
		}
		var $shareMain = $('.com-share-pop');
		if(!$shareMain.is(':visible')) {
			$shareMain.show()
				.css({y:1000, opacity:0})
				.transit({y:0, opacity:1}, _animateTime, _animateEasing);
		}
		else {
			$shareMain.transit({y:1000, opacity:0}, _animateTime, _animateEasing, function(){
				$(this).hide();
			});
		}

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



	var _draggingReleasing = false;
	function draggingNode(direction, deltaX) {
		if(_draggingReleasing) return;
		var $imageWrapInner = $('.image-wrap-inner');
		if($imageWrapInner.length == 2) {
			var wrapWidth = $imageWrapInner.eq(0).width();
			$('.image-wrap-inner')
				.eq(direction == 'right' ? 0 : 1)
				.css({x:deltaX})
				.siblings('.image-wrap-inner')
				.css({x: direction == 'right' ? (wrapWidth + deltaX) : (- wrapWidth + deltaX)  });
		}
	}

	function releaseDragNode(direction) {
		if(_draggingReleasing) return;
		_draggingReleasing = true;
//        setTimeout(function(){
//            _draggingReleasing = false; // force unlock, due to some time the transit call back will not fire.
//        },600);
		var $imageWrapInner = $('.image-wrap-inner');
		if($imageWrapInner.length >= 2) {
			var wrapWidth = $imageWrapInner.eq(0).width();

			var dom = $('.inner').data('from') || $('.main');
			var nodes = dom.data('nodes');
			var node = nodes[ _currentNodeIndex ];
			//cubeInnerNode(node, direction, false );

			$('.image-wrap-inner')
				.eq(0)
				.transit({x: direction == 'right' ? - wrapWidth : 0}, 500)
				.next()
				.transit({x: direction == 'right' ? 0 : wrapWidth}, 500);


			updateInnerNode(node, direction);

			setTimeout(function(){
                $('.image-wrap-inner:not(:' + (direction == 'right' ? 'last)' : 'first)')).remove();
                $('.image-wrap-inner')
                    .eq(0)
                    .css({x: 0});
				_draggingReleasing = false;
			}, 500);
		}
		else {
			_draggingReleasing = false;
            _innerLock = false;
		}
	}

	function updateInnerNode(node, direction) {
		if( $('.image-wrap-inner').length == 1 ) return;
		var datetime = new Date((parseInt(node.datetime)+1*3600)*1000);
		node.year = datetime.getUTCFullYear();
		node.date = datetime.getUTCDate();
		node.month = parseInt(datetime.getUTCMonth()) + 1;
		node.hour = datetime.getHours();
		if((''+node.hour).length == 1) {
			node.hour = '0' + node.hour;
		}
		node.minutes = datetime.getUTCMinutes();
		if((''+node.minutes).length == 1) {
			node.minutes = '0' + node.minutes;
		}
		LP.compile( 'inner-template' , node , function( html ){
			var $inner = $('.inner');
			var $newInner = $(html);
			var $comment = $inner.find('.comment');

			//update comment
			var $nextComment = $newInner.find('.comment');
			$comment.html($nextComment.html());

			//update info
			var $info = $inner.find('.inner-info');
			$info.transit({
				y: $info.height()
			} , 300, function(){
				$info.remove();
			})
			var $newInfo = $newInner.find('.inner-info')
				.insertAfter( $info );
			$newInfo.css({
				bottom: 88,
				y: $info.height(),
				width: $info.width(),
				left: $info.css('left')
			}).delay(300).transit({y:0}, 300);

			// update top icon
			var $top = $inner.find('.inner-top');
			var $nextTop = $newInner.find('.inner-top').insertAfter('.inner-info').css({y:-58});
			$top.transit({
				y: -58
			}, 300, function(){
				$(this).remove();
			});
			$nextTop.delay(300).transit({y:0}, 300);

			_innerLock = false;
			_draggingReleasing = false;
			changeUrl('/nid/' + node.nid , {event: direction});

		});
	}


	function cubeInnerNode( node , direction, drag ){

		var datetime = new Date((parseInt(node.datetime)+1*3600)*1000);
		node.date = datetime.getUTCDate();
		node.year = datetime.getUTCFullYear();
		node.month = parseInt(datetime.getUTCMonth()) + 1;
		node.hour = datetime.getHours();
		if((''+node.hour).length == 1) {
			node.hour = '0' + node.hour;
		}
		node.minutes = datetime.getUTCMinutes();
		if((''+node.minutes).length == 1) {
			node.minutes = '0' + node.minutes;
		}
		node.currentUser = $('.side').data('user');
		//node.image = node.file.replace( node.type == "video" ? '.mp4' : '.jpg', BIG_IMG_SIZE + '.jpg');
		node.timestamp = (new Date()).getTime();
		if(!node.user.avatar) {
			node.user.avatar = "/uploads/default_avatar.gif";
		}
		var $inner = $('.inner');
		LP.compile( 'inner-template' , node , function( html ){
//            var $comment = $inner.find('.comment');
			// comment animation
			var $newInner = $(html);

			// animate the first image's margin-left style
			var $imgWrap = $inner.find('.image-wrap');
			var wrapWidth = $imgWrap.width();

			// append dom
			var $oriItem = $imgWrap.children('.image-wrap-inner');
			// count the style
			var $newItem = $newInner.find('.image-wrap-inner');

			if(!$newItem) {
				return;
			};

			$newItem[ direction == 'left' ? 'insertBefore' : 'insertAfter' ]( $oriItem )
				.attr('style' , $oriItem.attr('style'))
				.find('img')
				.hide()
				.end();
			// Resize Image
			var imgBoxWidth = $('.inner').width();
			var imgBoxHeight =$('.inner').height() - 154;
			var minSize = Math.min( imgBoxHeight , imgBoxWidth );
			var $img = $newItem.find('img').css('margin',0);
			$newItem.width(minSize).height(minSize);

			if( imgBoxHeight > imgBoxWidth ){
				var marginLeft = (imgBoxHeight - imgBoxWidth) / 2;
				$newItem.height(imgBoxHeight);
				$img.width('auto').height('100%').css('margin-left', -marginLeft);
			}

			$imgWrap.children('.image-wrap-inner').css({
				width: wrapWidth
			})
				.eq(0)
				.css('x' , direction == 'left' ? - wrapWidth : 0 )
				.next()
				.css('x' , direction == 'left' ? 0 : wrapWidth );


			// init video
//			if( node.type == "video" ){
//				//$('.image-wrap-inner video').fadeIn(200);
//
//			}

			$newItem.find('img').ensureLoad(function(){
				$(this).fadeIn(200);
				$newItem.find('.video-poster').delay(200).fadeIn(200);
			});


			if(drag != true) {
				$imgWrap.children('.image-wrap-inner')
					.eq(0)
					.transit({
						x: direction == 'left' ? 0 : - wrapWidth
					} , 800, _animateEasing)
					.next()
					.transit({
						x: direction == 'left' ? wrapWidth : 0
					} , 800, _animateEasing, function(){
						$imgWrap.width( wrapWidth );
						// Resize Inner Box
						// resizeInnerBox();
						$newItem.css('width' , '100%');
						updateInnerNode(node,direction);
						$('.image-wrap-inner').eq(direction == 'right' ? 0 : 1).remove();
					});
			}

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
	LP.action('prev' , function( drag ){
		if(_innerDragging) return;
		if( _innerLock ) return;
		_innerLock = true;
		if(drag != true) {
			_draggingReleasing = true;
		}
		var $inner = $('.inner');
		var $dom = $inner.data('from') || $main;

		// when reach the first, if the content opened via url id, need to check if has previous page
		if( _currentNodeIndex == 0 ){
			var param = $dom.data('param');
			if(!param.previouspage || param.previouspage == 1) {
				//alert('no more nodes');
				_innerLock = false;
				return;
			} else {
				param.previouspage --;
				$dom.data('param' , param);
				param.page = param.previouspage;
				$('.inner-loading').fadeIn();

				_innerLock = true;
				api.ajax('recent' , param , function( result ){
					_innerLock = false;
					$('.inner-loading').fadeOut();
					_currentNodeIndex = param.pagenum - 1;
					nodeActions.prependNode( $dom , result.data , param.orderby == 'datetime' );
					cubeInnerNode( $dom.data('nodes')[ _currentNodeIndex ] , 'left');
					preLoadSiblings();
				});
			}
			return;
		}
		// lock the animation
//        if( $('.inner').hasClass('disabled') ) return;
//        $('.inner').addClass('disabled');

		_currentNodeIndex -= 1;
		var node = $dom.data('nodes')[ _currentNodeIndex ];
		cubeInnerNode( node , 'left', drag );
		preLoadSiblings();
	});

	//for next action
	LP.action('next' , function( drag ){
		if(_innerDragging) return;
		if( _innerLock ) return;
		_innerLock = true;
		console.log('it in');
		if(drag != true) {
			_draggingReleasing = true;
		}
		var $inner = $('.inner');
		var $dom = $inner.data('from') || $main;

		// lock the animation
//        if( $inner.hasClass('disabled') ) return;
//        $inner.addClass('disabled');

		_currentNodeIndex++;
		var nodes = $dom.data('nodes');
		var node = nodes[ _currentNodeIndex ];
		if( !node ){
			// if no more data
			if( $dom.data('end') ){
				_currentNodeIndex--;
				$inner.removeClass('disabled');
				// TODO:: tip no more nodes
				//alert('no more nodes');
				_innerLock = false;
				return;
			}
			//ajax to get more node
			var param = $dom.data('param');
			param.page++;
			$dom.data('param' , param);
			// show loading
			$('.inner-loading').fadeIn();

			_innerLock = true;
			api.ajax('recent' , param , function( result ){
				$('.inner-loading').fadeOut();
				if( result.data.length ){
					nodeActions.inserNode( $dom , result.data , param.orderby == 'datetime' );
					cubeInnerNode( $dom.data('nodes')[ _currentNodeIndex ] , 'right' );
					preLoadSiblings();
				} else {
					$inner.removeClass('disabled');
					$dom.data('end' , true);
					// TODO:: tip no more nodes
					//alert('no more nodes');
					_innerLock = false;
				}
			});
			return;
		}
		cubeInnerNode( node , 'right', drag );
		preLoadSiblings();
	});



    //for like action
    var updateLikeCount = function(nid, count , isLiked){
        $('.main-item-' + nid).find('.item-like').html(count).toggleClass('item-liked');

        if( isLiked ){
            $('.inner').find('a[data-a="like"]')
                .attr('data-a' , "unlike")
                .addClass('com-liked')
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
                LP.triggerAction(_innerLock);
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
		return;
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
                            $('.main-item-'+nid).trigger('tap');
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
			$mainWrap = $('.main-wrap');
			$listLoading = $('.loading-list');
            // hide loading 
            $('.page-loading').fadeOut();
            // load first page node list

            $(window).trigger('scroll');

			$('.main-wrap').on('scroll', (function(){
				$('.main-wrap').addClass('scrolling');
				clearTimeout(scrollTimeout);
				scrollTimeout = setTimeout(function(){
					$('.main-wrap').removeClass('scrolling');
				}, 500);
			}));
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


