!(function( factory ){
    if ( typeof define != 'undefined' ) {
        define( factory );
    } else {
        window.transformMgr = factory();
    }
}) (function(){
    var $img , _wrapWidth , _wrapHeight , 
        _wrapOff ;
    var _imgLeft , _imgTop , _imgWidth , _imgHeight;

    var imgMgr = {
        move: function( mvLeft , mvTop ){
            if( _imgLeft + mvLeft < 0 && _imgLeft + mvLeft + _imgWidth > _wrapWidth ){
                _imgLeft += mvLeft;
                $img.css('left' , _imgLeft );
            }
            if( _imgTop + mvTop < 0 && _imgTop + mvTop + _imgHeight > _wrapHeight ){
                _imgTop += mvTop;
                $img.css('top' , _imgTop );
            }
        },
        scale: function( scale , scX , scY ){
            if( _imgWidth * scale < _wrapWidth
            || _imgHeight * scale < _wrapHeight ) return;

            
            var txl = scX - _imgLeft;
            _imgLeft = scX - txl * scale;
            if( _imgLeft > 0 ){
                _imgLeft = 0;
            }
            if( scX - txl * scale + _imgWidth * scale < _wrapWidth ){
                _imgLeft =  _wrapWidth - _imgWidth * scale;
            }

            var tyt = scY - _imgTop;
            _imgTop = scY - tyt * scale;
            if( _imgTop > 0 ){
                _imgTop = 0;
            }
            if( scY - tyt * scale + _imgHeight * scale < _wrapHeight ){
                _imgTop = _wrapHeight - _imgHeight * scale;
            }
            _imgWidth *= scale;
            _imgHeight *= scale;

            $img.css( {
              'top' : _imgTop ,
              'left' : _imgLeft,
              'width' : _imgWidth,
              'height' : _imgHeight
            });
        }
    }
   
    function initialize( $dom ){
        $img = $dom.find('img');

        _imgWidth = $img.width();
        _imgHeight = $img.height();
        _wrapWidth = $dom.width();
        _wrapHeight = $dom.height();
        _wrapOff = $dom.offset();
        var forExpr = 20;
        // render right width and height of image
        if( _imgWidth / _imgHeight > _wrapWidth / _wrapHeight ){
            _imgWidth   = _imgWidth / _imgHeight * ( _wrapHeight + forExpr );
            _imgHeight  = _wrapHeight + forExpr;
        } else {
            _imgHeight  = _imgHeight / _imgWidth * ( _wrapWidth + forExpr );
            _imgWidth   = _wrapWidth + forExpr;
        }
        $img.css({
            width: _imgWidth,
            height: _imgHeight
        });

        _imgLeft = ( _wrapWidth - _imgWidth ) / 2;
        _imgTop = ( _wrapHeight - _imgHeight ) / 2;
        $img.css( {
            position: 'absolute',
            left: _imgLeft,
            top: _imgTop
        } );

        var lastScale = 1 , ctx , cty , lastTx , lastTy , _isTransforming;
        var supportTouch = !$('html').hasClass('no-touch');
        // not support touch feature
        if( !supportTouch ){
          var isMousedown , startPos , isDragging;
          $(document).mouseup(function(){
              if( !isMousedown ) return;
              isDragging      = false;
              isMousedown     = false;
              startPos        = null;
          });
          $dom.mousedown( function( ev ){
            isMousedown = true;
            startPos = {
                pageX     : ev.pageX
                , pageY   : ev.pageY
            }
            lastTx = ev.pageX;
            lastTy = ev.pageY;
            return false;
          })
          .mousemove( function( ev ){
            if( !isMousedown ) return;
            if( !isDragging ){
                if( Math.abs( ev.pageX - startPos.pageX ) + Math.abs( ev.pageY - startPos.pageY ) >= 10 ){
                    isDragging = true;
                } else {
                    return false;
                }
            }
            imgMgr.move( ev.pageX - lastTx , ev.pageY - lastTy );
            lastTx = ev.pageX;
            lastTy = ev.pageY;
          })
          .bind('mousewheel' , function( ev ){
            var deltay = ev.originalEvent.wheelDeltaY || ev.originalEvent.deltaY;
            if( deltay < 0 ){
              imgMgr.scale( 1 / perScale , _wrapWidth / 2 , _wrapHeight / 2 );
            } else {
              imgMgr.scale( perScale , _wrapWidth / 2 , _wrapHeight / 2 );
            }
            return false;
          });
        } else { // support touch event
            $dom.hammer({
                transform_always_block: true,
                drag_block_vertical: true,
                drag_block_horizontal: true
            })
            .on("transformstart" , function( event ){
                lastScale = 1;
                ctx = event.gesture.center.pageX - _wrapOff.left;
                cty = event.gesture.center.pageY - _wrapOff.top;
                _isTransforming = true;
        
            })
            .on("transform", function(event) {
                var gesture = event.gesture;
                imgMgr.scale( gesture.scale / lastScale , ctx , cty );
                
                lastScale = gesture.scale;
            })
            .on('transformend' , function( event ){
                setTimeout(function(){
                    _isTransforming = false;
                } , 100);
                
            })
            .on('dragstart' , function( event ){
               lastTx = 0;
               lastTy = 0;
            })
            .on('drag' , function( event ){
                if( _isTransforming ) return;
                imgMgr.move( event.gesture.deltaX - lastTx , event.gesture.deltaY - lastTy );
                lastTx = event.gesture.deltaX;
                lastTy = event.gesture.deltaY;
            });
        }

        // for long click
        var animateTimeout = null;
        var animateScale = 1.02;
        var startAnimateScale = function( zoomout ){
            var duration = 1000 / 60 ;
            var aniFn = function(){
                if( zoomout ){
                  imgMgr.scale( animateScale , _wrapWidth / 2 , _wrapHeight / 2 );
                } else {
                  imgMgr.scale( 1/animateScale , _wrapWidth / 2 , _wrapHeight / 2 );
                }
                animateTimeout = setTimeout( aniFn , duration );
            };
            animateTimeout = setTimeout( aniFn , duration );
        }
        var stopAnimate = function(){
            clearTimeout( animateTimeout );
        }
        
        var longInterval = null;
        var longTimeout = null;
        var runAnimate = false;
        var mousedown = false;
        var perScale = 1.1;
        $('.pop-zoomout-btn,.pop-zoomin-btn').bind( supportTouch ? 'touchstart' : 'mousedown' ,function(){
            mousedown = true;
            var isZoomOut = $(this).hasClass('pop-zoomout-btn');
            longTimeout = setTimeout(function(){
                runAnimate = true;
                startAnimateScale( isZoomOut );
            } , 300);
            return false;
        })
        .bind( supportTouch ? 'touchend' : 'mouseup' , function(){
            if( !mousedown ) return;
            mousedown = false;
            clearTimeout( longTimeout );
            if( runAnimate ){
                runAnimate = false;
                stopAnimate();
            } else {
              imgMgr.scale( $(this).hasClass('pop-zoomout-btn') ? perScale : 1 / perScale , _wrapWidth / 2 , _wrapHeight / 2 );
            }
        } );
    }
    

    return {
        initialize: initialize
        , result    : function(){
            return {
                width       : $img.width(),
                height      : $img.height(),
                //src         : $picInner.find('img').attr('src'),
                //rotate      : totalRotate,
                x           : _imgLeft,
                y           : _imgTop,
                cid         : 1
            }
        }
    }
})
