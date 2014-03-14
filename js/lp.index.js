/*
 * page base action
 */
LP.use(['jquery', 'api', 'easing'] , function( $ , api ){
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




	LP.action('vote', function(data){
		if($(this).hasClass('voting')) return;

		api.ajax('vote', {vid:data.vid}, function( result ){
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
		})


	}

	init();

});


