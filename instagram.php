<!DOCTYPE>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>Carambar</title>
	<style>
		html,body {height:100%;width:100%;text-align: center;background: #000;padding:0;margin:0;}
		#wmp {z-index:1;position: relative;}
		video {width:100%;height:100%;}
		.vjs-big-play-button {display: none!important;}
		.vjs-control-bar {opacity:1!important;}
		.vjs-control-bar>div.vjs-mute-control {display: block;font-size:0;position:absolute;top:10px;left:10px;background: url(images/volume.png) no-repeat;width:40px;height:40px;}
		.vjs-control-bar>div.vjs-mute-control.vjs-vol-3 {background-position:top right;}
	</style>

	<link href="css/video-js.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="./js/plugin/modernizr-2.5.3.min.js"></script>
	<script type="text/javascript" src="./js/jquery/jquery-1.102.js"></script>
	<script type="text/javascript" src="./js/video-js/video.js"></script>
	<script type="text/javascript" src="./js/handlebars/handlebars-v1.1.2.js"></script>
	<script type="text/javascript" src="./js/instagram.js"></script>
</head>
<body>

<script type="text/tpl" id="video-template">
	{{#if useflash}}
	<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="100%" height="100%">
		<param name="allowScriptAccess" value="always"/>
		<param name="movie" value="flash/player.swf"/>
		<param name="flashVars" value="source=<?php echo $_GET['url'];?>&skinMode=show&autoplay=true&onPlay=play()&onPlayComplete=playComplete()"/>
		<param name="quality" value="high"/>
		<param name="allowFullScreen" value="true"/>
		<embed name="player" src="flash/player.swf" flashVars="source=<?php echo $_GET['url'];?>&skinMode=show&autoplay=true&onPlay=play()&onPlayComplete=playComplete()" quality="high" allowFullScreen="true" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="100%" height="100%" allowScriptAccess="always"></embed>
	</object>
	{{else}}
	<video id="instagram-video" autoplay="autoplay" loop="true" muted width="100%" height="100%" controls><source src="<?php echo $_GET['url'];?>" type="video/mp4" /></video>
	{{/if}}
</script>

</body>
</html>


