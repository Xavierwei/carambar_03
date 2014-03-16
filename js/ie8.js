var API_FOLDER = "./api";

var closeUploadPop = function() {
    LP.triggerAction('get_fresh_nodes');
    $('.pop-inner').fadeOut(400);
    $('.pop-success').delay(400).fadeIn(400);
    setTimeout(function() {
        LP.triggerAction('close_pop');
    },1500);
}

var uploadPopError = function(code) {
    switch(code){
        case 502:
            var errorIndex = 0;
            break;
        case 501:
            var errorIndex = 2;
            break;
        case 503:
            var errorIndex = 1;
            break;
    }
    $('.pop-inner').fadeOut(400);
    $('.pop-file').delay(800).fadeIn(400);
    $('.step1-tips li').removeClass('error');
    $('.step1-tips li').eq(errorIndex).addClass('error');
}

var close_pop = function() {
    LP.triggerAction('get_fresh_nodes');
    $('#node_post_flash object').fadeOut(400);
    $('.pop-success').delay(400).fadeIn(400);
    setTimeout(function() {
        LP.triggerAction('close_pop');
    },1500);
}

var closeAvatarPop = function(url) {
    LP.triggerAction('close_pop');
    $('.user-pho , .count-userpho').find('img')
        .attr('src' , './api' + url+'?'+ new Date().getTime() );
}


var fileDialogComplete = function(numFilesSelected, numFilesQueued) {
    if (numFilesQueued > 0) {
        this.startUpload(this.getFile(0).id);
    }
}

var uploadStart = function(file) {
    //$('.pop-file').fadeOut(400);
    $('.pop-load').fadeIn(400);
}

var uploadProgress = function(file, bytesLoaded, bytesTotal) {
    var rate = bytesLoaded / bytesTotal * 100;
    $('.popload-percent p').css({width:rate + '%'});
}

var uploadSuccess = function(file, serverData) {
    var data = JSON.parse(serverData);
    if(!data.success) {
        switch(data.message){
            case 502:
                var errorIndex = 0;
                break;
            case 501:
                var errorIndex = 2;
                break;
            case 503:
                var errorIndex = 1;
                break;
        }
        $('.pop-load').fadeOut(400);
        $('.pop-txt').fadeOut(400);
        $('.pop-file').fadeIn(400);
        $('.step1-tips li').removeClass('error');
        $('.step1-tips li').eq(errorIndex).addClass('error');
    }
    else {
		$('.poptxt-pic-inner').fadeIn();
        $('.poptxt-pic img').attr('src', API_FOLDER + data.data.file.replace('.mp4', '.jpg'));
        $('.poptxt-submit').attr('data-d','file='+ data.data.file +'&type=' + data.data.type);
    }
    //$('.pop-load').fadeOut(400);
    $('.pop-txt').fadeIn(400);
}

var uploadError = function(object, error, message){
    $('.pop-load').fadeOut(400);
    //$('.pop-file').delay(800).fadeIn(400);
}
