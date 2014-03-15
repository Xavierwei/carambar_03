/*
 * page base action
 */
LP.use(['jquery', 'api', 'easing', 'skrollr'] , function( $ , api ){
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
        });
    });

    /**
     * Close popup
     */
    LP.action('close_popup', function() {
        $('.overlay').fadeOut();
        $('.popup').fadeOut();
    });


    /**
     * Vote Challenge
     */
	LP.action('vote', function(data){
		if($(this).hasClass('voting')) return;

		api.ajax('vote', {cid:data.cid}, function( result ){
			$(this).addClass('voting');
			if(result.success) {
				$(this).removeClass('voting');

				LP.compile( 'vote-result-template' , result , function( html ){
					$('.votes').html(html);
				});
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

	LP.action('submit-twitter', function(){
		var content = '#GOODLUCKCARAMBAR ' + $('#twitter-content').val();
		api.ajax('postTwitter', {content: content}, function( result ){
			console.log(result);
			if(result.success) {
				alert('Success Posted!');
			}
		});
	});

    LP.action('submit-facebook', function(){
        var content = '#GOODLUCKCARAMBAR ' + $('#facebook-content').val();
        api.ajax('postFacebook', {content: content}, function( result ){
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
            if(result.data !== 'login') {
                $('#facebook-login-link').fadeIn().attr('href', result.data);
            }
            else {
                $('#facebook-content-wrap').fadeIn();
                if($('.sec4-right-txt').hasClass('opened')) {
                    $('#facebook-content-wrap').height(0);
                }
                else {
                    $('#facebook-content-wrap').prev().addClass('opened')
                }
            }
		});


		api.ajax('twitterLogin', function( result ){
			if(result.data !== 'login') {
				$('#twitter-login-link').fadeIn().attr('href', result.data);
			}
			else {
				$('#twitter-content-wrap').fadeIn();
                if($('.sec4-right-txt').hasClass('opened')) {
                    $('#twitter-content-wrap').height(0);
                }
                else {
                    $('#twitter-content-wrap').prev().addClass('opened')
                }
			}
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

		var timeoffset = isUglyIe?0:1600;
		setTimeout(function(){
			var s = skrollr.init({
				smoothScrollingDuration:0,
				smoothScrolling:true,
				easing:'outCubic'
			});
		},timeoffset);


        var $fileupload = $('#fileupload');
        LP.use('fileupload' , function(){
            $fileupload.fileupload({
                url: './api/index.php/uploads/upload',
                datatype:"json",
                autoUpload:false
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
                    $('.pop-inner').fadeOut(400);
                    $('.pop-load').delay(400).fadeIn(400);
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
	}

	$(window).scroll(function(){
		console.log($(window).scrollTop());
	});

	init();

});


