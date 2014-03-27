/*
 * QueryLoader v2 - A simple script to create a preloader for images
 *
 * For instructions read the original post:
 * http://www.gayadesign.com/diy/queryloader2-preload-your-images-with-ease/
 *
 * Copyright (c) 2011 - Gaya Kessler
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Version:  2.5
 * Last update: 15-09-2013
 *
 */
(function($){
    var option = {
        onLoading  : function (object) {
        },
        deepSearch : true,
        minimumTime: 500,
        onComplete : function () {
        }
    }

    var imageCache = {};
    var imageCounter = 0;
    var imageLoadedNum = 0;
    var startTime = 0;
    var imgLoadFinished = function(){

        imageLoadedNum++;
        // show loading status
        option.onLoading( ~~ ( imageLoadedNum / imageCounter * 100 ) );
        if( imageLoadedNum == imageCounter ){
            var dur = new Date() - startTime;
            // complete all iamges
            dur > option.minimumTime ? option.onComplete() :
                setTimeout( function(){ option.onComplete() } , option.minimumTime - dur );
        }
    }
    var addImageForPreload = function( url ) {
        var image = $("<img />")
            .load( imgLoadFinished )
            ["error"]( imgLoadFinished )
            .attr( "src", url );
    };
    var findImageInElement = function (element) {
        var $el = $(element);

        if( $el.closest('.noload').length ) return;
        var url ;
        var bg = $el.css("background-image");
        var src = $el.attr('src');
        var match = null;
        if( bg != "none" ){
            bg = $.trim( bg );
            match = bg.match(/^url\((['"])([^'"]+)\1\)/);
            url = match ? match[2] : null;
        } else if ( src && element.nodeName.toLowerCase() == "img" ) {
            url = src;
        }

        if( url && !imageCache[ url ] ){
            imageCounter++;
            imageCache[ url ] = url;
        }
    }



    $.fn.queryLoader2 = function( opt ) {
        $.extend( option , opt || {} );

        imageLoadedNum = 0;

        this.each(function() {
            findImageInElement(this);
            if ( option.deepSearch == true ) {
                $(this).find("*:not(script)").each(function() {
                    findImageInElement(this);
                });
            }
        });

        // set start time
        startTime = + new Date();
        // preload image
        for (var url in imageCache ) {
            addImageForPreload( imageCache[url] );
        }

        return this;
    };
})(jQuery);

//HERE COMES THE IE SHITSTORM
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (elt /*, from*/) {
        var len = this.length >>> 0;
        var from = Number(arguments[1]) || 0;
        from = (from < 0)
            ? Math.ceil(from)
            : Math.floor(from);
        if (from < 0)
            from += len;

        for (; from < len; from++) {
            if (from in this &&
                this[from] === elt)
                return from;
        }
        return -1;
    };
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