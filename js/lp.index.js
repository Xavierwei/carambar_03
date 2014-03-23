/*
 * page base action
 */
LP.use(['jquery', 'api', 'easing', 'cookie', 'skrollr', 'exif', 'queryloader'] , function( $ , api ){
    'use strict'

    var API_FOLDER = "./api";
	var time_left;
    $(document.body)
        .delegate('#twitter-content', 'keyup', function(){
            var leftLength = 140 - 18 - $(this).val().length;
            $('#twitter-words-limit').find('span').text(leftLength);
            if(leftLength < 0) {
                $('#twitter-words-limit').addClass('out');
				$('.share-tbtn').addClass('disabled');
            }
            else {
                $('#twitter-words-limit').removeClass('out');
				$('.share-tbtn').removeClass('disabled');
            }
			if($(this).val().length == 0) {
				$('.share-tbtn').addClass('disabled');
			}
			var content = $('#twitter-content').val() + ' %23TESTHASHTAG';
			$('.share-t .share-tbtn').attr('href', 'https://twitter.com/intent/tweet?text='+content);
        })
        .delegate('.sec4-right-txt', 'click', function(){
            if(!$(this).hasClass('opened')) {
                $(this).addClass('opened').next().animate({height:203}, 500, 'easeInOutQuart');
                $(this).siblings('.sec4-right-txt').removeClass('opened').next().animate({height:0}, 500, 'easeInOutQuart');
            }
        })

    /**
     * Popup open Youtube Video
     */
    LP.action('open_video', function(data) {
        LP.compile( 'youtube-player-template' , data , function( html ){
            $('.overlay').fadeIn();
            $('body').append(html);
			$(window).trigger('resize');
            $('.pop').css({opacity:0, top:'-50%'}).animate({opacity:1, top:'50%'}, 800, 'easeInOutQuart');
        });
    });

    /**
     * Popup open Facebook
     */
    //-----------------------------------------------------------------------
    // init drag event for image upload
    // after image upload, init it's size to fix the window
    // use raephael js to rotate, scale , and drag the image photo
    var transformMgr;
    LP.use('imgUtil' , function( imgUtil ){
        transformMgr = imgUtil;
    });

    var fileUploadDone = function(data){
        if(!data.result.success) {
            switch(data.result.message){
                case 502:
                    var errorIndex = 0;
                    break;
                case 501:
                    var errorIndex = 1;
                    break;
                case 509:
                    var errorIndex = 2;
                    break;
            }
            $('.facebook-post-load').fadeOut(400);
            $('#fileupload').delay(800).fadeIn(400);
            $('.step1-tips li').removeClass('error');
            $('.step1-tips li').eq(errorIndex).addClass('error');
        } else {
            $('.facebook-post-load').fadeOut(400);
            $('.poptxt-pic-inner').css({opacity:0});
            var rdata = data.result.data;
            if (data.files && data.files[0] && window.FileReader ) {
                //..create loading
                var reader = new FileReader();
                reader.onload = function (e) {
                    // change checkpage img
                    $('.poptxt-pic img')
                        .unbind('load.forinnershow')
                        .bind('load.forinnershow' , function(){
                            if($('.poptxt-pic-inner').hasClass('loaded')) return;
                            $('.poptxt-pic-inner').addClass('loaded');
                            $('.pop-inner').delay(400).fadeOut(400);
                            $('.pop-txt').delay(1200).fadeIn(400);
                            setTimeout(function(){
                                $('.poptxt-pic').fadeIn();
                                transformMgr.initialize( $('.poptxt-pic-inner') );
                                var b64 = $('.poptxt-pic-inner img').attr('src');
                                var bin = atob(b64.split(',')[1]);
                                var exif = EXIF.readFromBinaryFile(new BinaryFile(bin));
                                if(exif.Orientation != undefined && exif.Orientation != 1){
                                    var oldWidth = $('.poptxt-pic-inner img').width();
                                    var oldHeight = $('.poptxt-pic-inner img').height();
                                    $('.poptxt-pic-inner img').addClass('fromserver').height(oldWidth).width(oldHeight).attr('src', API_FOLDER + data.result.data.file).css('opacity',0);
                                    setTimeout(function(){
                                        $('.poptxt-pic-inner img.fromserver').ensureLoad(function(){
                                            if($(this).attr('src').indexOf('api')) {
                                                $(this).animate({'opacity':1});
                                            }
                                        });
                                        transformMgr.initialize( $('.poptxt-pic-inner') );
                                    },500);
                                }

                            } , 1700 );
                        })
                        .attr('src', e.target.result/*.replace('.jpg', THUMBNAIL_IMG_SIZE + '.jpg')*/);
                    //$('.poptxt-submit').attr('data-d','file='+ rdata.file +'&type=' + rdata.type);
                    $('#facebook-img').val(rdata.file);
                };
                reader.readAsDataURL(data.files[0]);
                $('.poptxt-pic-inner').delay(3000).animate({opacity:1});
            } else {
                $('.poptxt-pic img')
                    .unbind('load.forinnershow')
                    .bind('load.forinnershow' , function(){
                        $('.pop-inner').delay(400).fadeOut(400);
                        $('.pop-txt').delay(1200).fadeIn(400);
                        setTimeout(function(){
                            transformMgr.initialize( $('.poptxt-pic-inner') );
                        } , 1700 );
                    })
                    .attr('src', API_FOLDER + rdata.file/*.replace('.jpg', THUMBNAIL_IMG_SIZE + '.jpg')*/);
                $('.poptxt-submit').attr('data-d','file='+ rdata.file +'&type=' + rdata.type);
            }
        }
    }

    LP.action('open_facebook', function(data) {
        LP.compile( 'facebook-post-template' , data , function( html ){
            $('.overlay').fadeIn();
            $('body').append(html);
            $('.pop').css({opacity:0, top:'-50%'}).animate({opacity:1, top:'50%'}, 800, 'easeInOutQuart');
            var $fileupload = $('#fileupload');
            var acceptFileTypes = /(\.|\/)(gif|jpe?g|png)$/i;
            var maxFileSize = 5 * 1024000;
            LP.use('fileupload' , function(){
                $fileupload.fileupload({
                    url: './index.php/uploads/upload',
                    datatype:"json",
                    autoUpload:false,
                    dropZone: $fileupload
                })
                    .bind('fileuploadadd', function (e, data) {
                        $('.step1-tips li').removeClass('error');
                        if(!acceptFileTypes.test(data.files[0].name.toLowerCase())) {
                            $('.step1-tips li').eq(0).addClass('error');
                        }
                        else if(data.files[0].size > maxFileSize) {
                            $('.step1-tips li').eq(1).addClass('error');
                        }
                        else {
                            data.submit();
                        }
                    })
                    .bind('fileuploadstart', function (e, data) {
                        $('.facebook-post-img').fadeOut(400);
                        $('.facebook-post-load').delay(400).fadeIn(400);
                    })
                    .bind('fileuploadprogress', function (e, data) {
                        var rate = data._progress.loaded / data._progress.total * 100;
                        var $bar = $('.popload-percent p');
                        var currentRate = $bar.data('rate');
                        if(!currentRate) {
                            currentRate = 0;
                        }
                        if(rate > currentRate) {
                            $bar.data('rate',rate).css({width:rate + '%'});
                        }
                    })
                    .bind('fileuploadfail', function() {
                        $('.pop-inner').fadeOut(400);
                        $('.pop-file').delay(400).fadeIn(400);
                    })
                    .bind('fileuploaddone', function (e, data) {
                        fileUploadDone(data);
                    });
            });
        });
    });

    /**
     * Close popup
     */
    LP.action('close_popup', function() {
        $('.overlay').fadeOut();
        $('.pop').fadeOut(function(){
            $(this).remove();
        });
    });

	/**
	 * goto_support
	 */
	LP.action('goto_support', function(){
		var top = $('.yellow-wrap').position().top + $('#support-carambar').position().top;
		$('body,html').animate({'scrollTop':top});
	});

    /**
     * Indicator
     */
    LP.action('indicate', function(data){
        if($(this).hasClass('indicating')) return;
        if($.cookie('praise_auth')) return;
        api.ajax('indicate', {cid:data.cid}, function( result ){
            var prevNum = $.trim($('.indicator-count-num').html());
            var offset = result.data - prevNum;
            digitHelper.plus(offset);
            $('.indicator-count-num').html(result.data);
        });
    });

    /**
     * Vote Challenge
     */
	LP.action('vote', function(data){
		if($(this).hasClass('voting')) return;
        if($.cookie('cid')) return;

        $('.vote-btn').not(this).addClass('disabled');
        $(this).addClass('voted');

		api.ajax('vote', {cid:data.cid}, function( result ){
			$(this).addClass('voting');
			if(result.success) {

//				$(this).removeClass('voting');
//
//				LP.compile( 'vote-result-template' , result , function( html ){
//					$('.votes').html(html);
//				});
			}
			else {
				if(result.message == 902) {
					alert('You have voted today!');
				}
				else {
					alert('Too busy, please try again');
				}
			}
		});
	});

    /***
     * Open Invitation Dialog
     */
    LP.action('open_invitation', function(){
        LP.compile( 'send-invitation-template' , {} , function( html ){
            $('.overlay').fadeIn();
            $('body').append(html);
            $('.pop').css({opacity:0, top:'-50%'}).animate({opacity:1, top:'50%'}, 800, 'easeInOutQuart');
        });
    });

    /***
     * Send Invitation
     */
    LP.action('send_invitation', function(){
        if($(this).hasClass('submitting')) return;
        $(this).addClass('submiting');
        var answer = $('#invitation_answer').val();
        api.ajax('answer', {answer: answer}, function( result ){
            $(this).removeClass('submitting');
            if(result.error && result.error.code == 1011) {
                $('.pop-bar-tips').fadeIn();
                return;
            }
            if(result.success) {
                LP.triggerAction('close_popup');
            }
        });
    });

    /***
     * Submit Twitter
     */
//	LP.action('submit_twitter', function(){
//		var content = ' #HASHTAGTEST ' + $('#twitter-content').val();
//		api.ajax('postTwitter', {content: content}, function( result ){
//			console.log(result);
//			if(result.success) {
//				alert('Success Posted!');
//			}
//		});
//	});

	$('.share-tbtn').click(function(e){
		if($(this).hasClass('disabled')) {
			e.preventDefault();
		}
	});




    /***
     * Submit Facebook
     */
    LP.action('submit_facebook', function(){
        if($(this).hasClass('submitting')) return;
        if($('.facebook-post-load').is(':visible')) return;
        $(this).addClass('submitting');
        var checkbox = $('.pop-ft-check').hasClass('checked');
        var wordCount = $('#facebook-content').val().length;
        if(!checkbox) {
            return;
        }
        if(wordCount == 0) {
            return;
        }
        if(wordCount > 140) {
            return;
        }
        var img = $('#facebook-img').val();
        var content = $('#facebook-content').val() + ' #TESTHASHTAG';
        var trsdata = transformMgr.result();
        delete trsdata.src;
        $('.pop-ft-submitting').fadeIn();
        api.ajax('postFacebook', {content: content, img: img, x:trsdata.x, y:trsdata.y, width:trsdata.width, size: 185}, function( result ){
            $('.pop-ft-submitting').fadeOut();
            $(this).removeClass('submitting');
            if(result.success) {
                $('.facebook-post-form').fadeOut();
                $('.facebook-post-success').delay(500).fadeIn(function(){
                    setTimeout(function(){
                        LP.triggerAction('close_popup');
                    }, 1000);
                });

            }
        });
    });

    /***
     * Flash Facebook
     */
    LP.action('flash_submit_facebook', function(data){
        $('.pop-ft-submitting').fadeIn();
        api.ajax('postFacebook', {content: data.content, img: data.img}, function( result ){
            $('.pop-ft-submitting').fadeOut();
            if(result.success) {
                $('.facebook-post-form').fadeOut();
                $('.facebook-post-success').delay(500).fadeIn(function(){
                    setTimeout(function(){
                        LP.triggerAction('close_popup');
                    }, 1000);
                });
            }
        });
    });

    LP.action('facebook_check', function(){
        if($('.pop-ft-check').hasClass('checked')) {
            $('.pop-ft-check').removeClass('checked');
            $('.pop-ft-btn').addClass('disabled');
        }
        else {
            $('.pop-ft-check').addClass('checked');
            $('.pop-ft-btn').removeClass('disabled');
        }

    })

    function indicateResult(){
        api.ajax('indicateResult', function( result ){
            var prevNum = $.trim($('.indicator-count-num').html());
            var offset = result.data - prevNum;
            if(offset) {
                digitHelper.plus(offset);
                $('.indicator-count-num').html(result.data);
            }
        });
    }

	function init() {

		api.ajax('countdown', function( result ){
			time_left = result.data;
			var timeInterval = setInterval(function(){
				if(time_left < 0) {
					clearInterval(timeInterval);
					return;
				}
				//var time_left = (theevent - now)/1000;
				var days = Math.floor(time_left / 86400);
				var hours = Math.floor(((time_left / 86400)-days) * 24);
				var mins = Math.floor(((((time_left / 86400)-days) * 24)-hours)* 60);
				var secs = Math.round(((((((time_left / 86400)-days) * 24)-hours)* 60)-mins) * 60);
                days = ('' + days).length > 1 ? days : '0' + days;
                hours = ('' + hours).length > 1 ? hours : '0' + hours;
                mins = ('' + mins).length > 1 ? mins : '0' + mins;
                secs = ('' + secs).length > 1 ? secs : '0' + secs;
				$('#countdown-days').html(days);
				$('#countdown-hours').html(hours);
				$('#countdown-minutes').html(mins);
				$('#countdown-seconds').html(secs);
				time_left--;
			},1000);
		});

        setInterval(function(){
            indicateResult();
        }, 1000*60);

        api.ajax('indicateResult', function( result ){
            digitHelper.init(result.data);
            $('.indicator-count-num').html(result.data);
        });



		api.ajax('facebookLogin', function( result ){
            $('#facebook-login-link').fadeIn();
            if(result.data !== 'login') {
                $('#facebook-login-link').fadeIn().attr('href', result.data);
            }
            else {
                $('#facebook-login-link').attr('data-a','open_facebook');
                // open facebook dialog
                var hash = window.location.hash;
                if(hash == '#support-carambar') {
                    LP.triggerAction('open_facebook');
                    window.location.hash = '#main';
                }
            }
		});

		// loading photowall
		api.ajax('recent', {type:'photo', pagenum:5, orderby:'datetime'}, function( result ){
			$.each(result.data,function(index,node){
				node.thumbnail = node.file.replace('.jpg','_126_126.jpg');
				LP.compile( 'photowall-item-template' , node , function( html ){
					$('.pholist').append(html);
				});
			});
		});

		// get twitter text list
		if($('.videotxt')) {
			api.ajax('recent', {type:'text', pagenum:3, orderby:'datetime'}, function( result ){
				$.each(result.data,function(index,node){
                    var desc = node.description.replace('#GOODLUCKCARAMBAR','');
                    if(desc.length > 60) {
                        desc = desc.substr(0,60)+'...';
                    }
					node.description = desc;
					LP.compile( 'videotxt-item-template' , node , function( html ){
						$('.videotxt').append(html);
					});
				});
			});
		}


//		api.ajax('twitterLogin', function( result ){
//			if(result.data !== 'login') {
//				$('#twitter-login-link').fadeIn().attr('href', result.data);
//			}
//			else {
//				$('#twitter-content-wrap').fadeIn();
//                if($('.sec4-right-txt').hasClass('opened')) {
//                    $('#twitter-content-wrap').height(0);
//                }
//                else {
//                    $('#twitter-content-wrap').prev().addClass('opened')
//                }
//			}
//		});
        $('.loading-logo').hide().css('top','40%');
        $('.loading-logo img').ensureLoad(function(){
            $('.loading-logo').fadeIn().dequeue().animate({top:'50%'},800,'easeOutQuart');
        });

        //check vote status
        var votedId = $.cookie('cid');
        if(votedId) {
            $('.vote-btn').not('.vote-btn'+votedId).addClass('disabled');
            $('.vote-btn'+votedId).addClass('voted');
        }


		$(document.body).queryLoader2({
			onLoading : function( percentage ){
				var per = parseInt(percentage);
				$('.loading-percentage').html(per+'%');
				$('.loading-line').css({'width':per+'%'});
			},
			onComplete : function(){
				$('.loading-overlay').fadeOut(function(){
					$(this).remove();
				});
				/* for animation */
				var isUglyIe = false; //TODO
				var ANIMATE_NAME = "data-animate";
				$('[' + ANIMATE_NAME + ']')
					.each(function(){
						var $dom = $(this);
						var tar = $dom.data('animate');
						var browser = $dom.data('browser');
						var style = $dom.data('style');
						var time = parseInt( $dom.data('time') );
						var delay = $dom.data('delay') || 0;
						var easing = $dom.data('easing');
						var begin = $dom.data('begin');
						tar = tar.split(';');
						var tarCss = {} , tmp;
						if(browser == 'uglyie' && isUglyIe) {
							return;
						}
						for (var i = tar.length - 1; i >= 0; i--) {
							tmp = tar[i].split(':');
							if( tmp.length == 2 )
								tarCss[ tmp[0] ] = $.trim(tmp[1]);
						}
						if( isUglyIe && tarCss.opacity !== undefined ){
							delete tarCss.opacity;
						}


						style = style.split(';');
						var styleCss = {} , tmp;
						for (var i = style.length - 1; i >= 0; i--) {
							tmp = style[i].split(':');
							if( tmp.length == 2 )
								styleCss[ tmp[0] ] = $.trim(tmp[1]);
						}
						if( isUglyIe && styleCss.opacity !== undefined ){
							delete styleCss.opacity;
						}
						$dom.css(styleCss).delay( delay )
							.animate( tarCss , time , easing );
						if( begin ){
							setTimeout(function(){
								animation_begins[begin].call( $dom );
							} , delay);
						}
					});

				if($('html').hasClass('touch')) return;
				var timeoffset = isUglyIe?0:1600;
				setTimeout(function(){
					var s = skrollr.init({
						smoothScrollingDuration:0,
						smoothScrolling:true,
						easing:'outCubic',
						forceHeight: false
					});
				},timeoffset);
			}
		});




	}

    $(document).bind('dragover', function (e) {
        var dropZone = $('#fileupload'),
            timeout = window.dropZoneTimeout;
        if (!timeout) {
            dropZone.addClass('in');
        } else {
            clearTimeout(timeout);
        }
        var found = false,
            node = e.target;
        do {
            if (node === dropZone[0]) {
                found = true;
                break;
            }
            node = node.parentNode;
        } while (node != null);
        if (found) {
            dropZone.addClass('hover');
        } else {
            dropZone.removeClass('hover');
        }
        window.dropZoneTimeout = setTimeout(function () {
            window.dropZoneTimeout = null;
            dropZone.removeClass('in hover');
        }, 100);
    });


    // digit counter
    var digitHelper = (function(){
        var $count = $('.indicator-count');
        var digitHeight = 54;
        var init = function( num ){
            // init digit count
            num = num + '';
            num = "000000".substr(num.length) + num;
            var aHtml = [];
            $.each( num.split('') , function( i , n ){
                aHtml.push( '<span class="digit digit' + n + '" data-num="' + n + '" ></span>' );
            } );
            $count.html( aHtml.join('') );
        }


        var plusNum = function( $dom , total ){
            var index = 0;
            var times = 4;
            var countTimes = 0;
            var time = 300;
            var num = $dom.data('num') % 10;
            setTimeout(function timer(){
                if( num == 9  && index == 0 ){
                    plusNum( $dom.prev() , 1 );
                }
                if( ++index > times ) {
                    $dom.data('num' , num + 1 );
                    if( ++countTimes < total )
                        plusNum( $dom , total-1 );
                    return;
                }
                $dom.css( 'background-position' , '0 -' + ( ( num * 4 ) + index ) * digitHeight + 'px'  );
                setTimeout( timer , time / 4);
            } , time / 4);

        }
        return {
            init: function( num ){
                init( num );
            },
            plus: function( num ){
                plusNum( $count.children().last() , num );
            }
        }
    })();


    window.digitHelper = digitHelper;


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


	$(window).scroll(function(){
		//console.log($(window).scrollTop());
	});

	$(window).resize(function(){
		if($('.video-popup')){
			var ratio = 1.3;
			var winHeight = $(window).height();
			var videoBoxHeight = winHeight - 100;
			var winWidth = $(window).width();
			var videoBoxWidth = winWidth - 100;
			if(videoBoxWidth > 840) {
				videoBoxWidth = 840;
			}
			var videoBoxHeight = videoBoxHeight / ratio;
			$('.video-popup').height(videoBoxHeight).width(videoBoxWidth).css({marginTop:-videoBoxHeight/2, marginLeft:-videoBoxWidth/2});
			$('.video-popup iframe').height(videoBoxHeight - 20).width(videoBoxWidth - 20);
		}
	});

	init();

});


function upload(Photo,Msg){
    LP.triggerAction('flash_submit_facebook',{content:Msg, img: Photo});
}
function uploadComplete(){
    var flash=document.getElementById("flash");
    if(flash){
        if(flash.js2flashUploadComplete){
        }else{
            flash=null;
        }
    }
    if(flash){
    }else{
        flash=document.getElementsByName("flash");
        if(flash){
            flash=flash[0];
            if(flash){
                if(flash.js2flashUploadComplete){
                }else{
                    flash=null;
                }
            }
        }
    }
    if(flash){
        flash.js2flashUploadComplete();
    }//else{
    //	alert("找不到flash");
    //}
}
function reset_flash(){
    var flash=document.getElementById("flash");
    if(flash){
        if(flash.js2flashUploadComplete){
        }else{
            flash=null;
        }
    }
    if(flash){
    }else{
        flash=document.getElementsByName("flash");
        if(flash){
            flash=flash[0];
            if(flash){
                if(flash.js2flashUploadComplete){
                }else{
                    flash=null;
                }
            }
        }
    }
    if(flash){
        flash.reset();
    }//else{
    //	alert("找不到flash");
    //}
}

function onLoaded(){
    alert("onLoaded");
}
function onGetImg(){
    alert("onGetImg");
}
function onReset(){
    alert("onReset");
}