<?php
	$video = $_GET['file'];
  // Get video thumbnail ratio, use to resize the wmv video
	$cover = str_replace('wmv','jpg',$video);
  $size = getimagesize("./api/".$cover);
  $ratio = $size[0] / $size[1];
?>
<!DOCTYPE>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>SG WALL</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/animation.css" rel="stylesheet" type="text/css" />
    <link href="css/fonts.css" rel="stylesheet" type="text/css" />
    <style>
        html,body {height:100%;width:100%;text-align: center;}
	    #wmp {z-index:1;position: relative;}
    </style>

</head>
<body class="wmp">
<object id="wmp" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" standby="Loading Microsoft® Windows® Media Player components..." width="100%" height="100%" type="application/x-oleobject" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsm p2inf.cab#Version=6,4,7,1112">
    <param name="URL" value="./api<?php echo $video;?>">
    <param name="AutoStart" value="true">
    <param name="showcontrols" value="false">
	<param name="controls" value="false">
	<param name="windowlessVideo" value="true">
	<param name="ShowDisplay" value="false">
	<param name="showstatusbar" value="false">
    <param name="enablepositioncontrols" value="true">
    <param name="showpositioncontrols" value="true">
    <param name="StretchToFit" value="true">
    <param name="showaudiocontrols" value="false">
    <param name="enablecontextmenu" value="true">
	<param name="uiMode" value="none">
</object>
<div class="loading"></div>
<div class="bar-wrap">
	<div class="bar-percent"></div>
</div>

<div class="playbtn">
	<div class="icon"></div>
</div>

<div class="fullscreen"></div>
<script src="js/jquery/jquery-1.102.js"></script>
<script>
<!--  var _resizeTimer = null;-->
<!--  $(window).resize(function(){-->
<!--    clearTimeout( _resizeTimer );-->
<!--    _resizeTimer = setTimeout(function(){-->
<!--      var ratio = --><?php //echo $ratio;?><!--;-->
<!--			var windowRatio = $(window).width()/$(window).height();-->
<!--			if(ratio > windowRatio) {-->
<!--				var width = $(window).width();-->
<!--				var height = parseInt(width / ratio);-->
<!--				var marginTop = ($(window).height() - height)/2;-->
<!--			}-->
<!--			else {-->
<!--				var height = $(window).height();-->
<!--				var width = parseInt(height * ratio);-->
<!--				var marginTop = 0;-->
<!--			}-->
<!--      $('#player').width(width).height(height).css({'margin-top':marginTop});-->
<!--    }, 500);-->
<!--  }).trigger('resize');-->



</script>


<script>

	var playInterval;
	var player = document.getElementById("wmp");
	$('.playbtn').click(function(){
		if($(this).hasClass('paused')){
			$(this).removeClass('paused');
			player.controls.play();
			$('.bar-wrap').fadeIn();
		}
		else {
			$(this).addClass('paused');
			player.controls.pause();
			$('.bar-wrap').fadeOut();
		}
	});

	$('.fullscreen').click(function(){
		player.fullScreen=true;
	});


	function handler(type) {
		// http://msdn.microsoft.com/en-us/library/bb249361(VS.85).aspx
		var a = arguments;
		if(a[1] == 3) {
			if(!playInterval) {
				var duration = player.currentMedia.duration;
				playInterval = setInterval(function(){
					var currentPos = player.controls.currentPosition;
					var percent = currentPos / duration;
					if(percent > 0) {
						$('.bar-wrap').fadeIn();
						$('.loading').hide();
					}
					$('.bar-percent').css({width: percent*100 + '%'});
				}, 300);
			}
		}

		if(a[1] == 1) {
			$('.bar-percent').css({width: 0});
			$('.bar-wrap').fadeOut();
			$('.playbtn').addClass('paused');
			clearInterval(playInterval);
			playInterval = null;
		}
	};



</script>
<script for="wmp" event="playstatechange(newState)">
	handler.call(this, "playstatechange", newState);
</script>
</body>
</html>


