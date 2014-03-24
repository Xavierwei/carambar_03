$(document).ready(function(){
    var isFirefox = navigator.userAgent.toLowerCase().indexOf('firefox') > 0;
    var useflash = false;
    if($('html').hasClass('no-video') || isFirefox) {
        useflash = true;
    }

    var source   = $("#video-template").html();
    var template = Handlebars.compile(source);
    var html    = template({useflash:useflash});
    $('body').append(html);

    if(!useflash) {
        videojs( "instagram-video" , {}, function(){

        });
    }

});