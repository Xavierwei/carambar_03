/*
 * page base action
 */
LP.use(['jquery', 'api', 'easing', 'cookie', 'skrollr', 'exif'] , function( $ , api ){
    'use strict'

	var time_left;
    $(document.body)
        .delegate('#twitter-content', 'keyup', function(){
            var leftLength = 140 - 18 - $(this).val().length;
            $('#twitter-words-limit').find('span').text(leftLength);
            if(leftLength < 0) {
                $('#twitter-words-limit').addClass('out');
            }
            else {
                $('#twitter-words-limit').removeClass('out');
            }
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
                    var errorIndex = 2;
                    break;
                case 503:
                    var errorIndex = 1;
                    break;
                case 509:
                    var errorIndex = 3;
                    break;
            }
            $('.pop-inner').fadeOut(400);
            $('.pop-file').delay(800).fadeIn(400);
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
                            $('.step1-tips li').eq(2).addClass('error');
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
     * Indicator
     */
    LP.action('indicate', function(data){
        if($(this).hasClass('indicating')) return;
        if($.cookie('indicated')) return;
        alert('indicated');
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
        if($(this).hasClass('submiting')) return;
        $(this).addClass('submiting');
        var answer = $('#invitation_answer').val();
        if(answer != 1) {
            $('.pop-bar-tips').fadeIn();
        }
        //TODO AJAX
        $(this).removeClass('submiting');
    });

    /***
     * Submit Twitter
     */
	LP.action('submit_twitter', function(){
		var content = '#GOODLUCKCARAMBAR ' + $('#twitter-content').val();
		api.ajax('postTwitter', {content: content}, function( result ){
			console.log(result);
			if(result.success) {
				alert('Success Posted!');
			}
		});
	});

    /***
     * Share Twitter
     */
    $('.share-t .share-txt').on('keyup', function(){
        var content = $('#twitter-content').val() + '#GOODLUCKCARAMBAR';
        $('.share-t .share-tbtn').attr('href', 'https://twitter.com/intent/tweet?text='+content);
    });

    /***
     * Submit Facebook
     */
    LP.action('submit_facebook', function(){
        var img = $('#facebook-img').val();
        var content = '#GOODLUCKCARAMBAR ' + $('#facebook-content').val();
        api.ajax('postFacebook', {content: content, img: img}, function( result ){
            console.log(result);
            if(result.success) {
                alert('Success Posted!');
            }
        });
    });

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

				$('#countdown-days').html(days);
				$('#countdown-hours').html(hours);
				$('#countdown-minutes').html(mins);
				$('#countdown-seconds').html(secs);
				time_left--;
			},1000);
		});


		api.ajax('facebookLogin', function( result ){
            $('#facebook-login-link').fadeIn();
            if(result.data !== 'login') {
                $('#facebook-login-link').fadeIn().attr('href', result.data);
            }
            else {
                $('#facebook-login-link').attr('data-a','open_facebook');
            }
		});


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
		console.log($(window).scrollTop());
	});

	init();

});


