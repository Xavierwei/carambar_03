/*
 * page base action
 */
LP.use(['jquery', 'api', 'easing'] , function( $ , api ){
    'use strict'

	var time_left;

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
		var content = $('#twitter-content').val();
		api.ajax('postTwitter', {content: content}, function( result ){
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
				$('.facebook-wrap .login-btn a').attr('href', result.data);
			}
		});

		api.ajax('twitterLogin', function( result ){
			if(result.data !== 'login') {
				$('.twitter-wrap .login-btn a').attr('href', result.data);
			}
			else {
				$('.twitter-wrap .content-box').fadeIn();
			}
		})


	}

	init();

});


