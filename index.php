
<!DOCTYPE html>
<!--[if IE 6]>
<html class="ie6"><![endif]-->
<!--[if IE 7]>
<html class="ie7"><![endif]-->
<!--[if IE 8]>
<html class="ie8"><![endif]-->
<!--[if IE 9]>
<html class="ie9"><![endif]-->
<!--[if IE 10]>
<html class="ie10"><![endif]-->
<!--[if (gte IE 11)|(gt IEMobile 7)]><!-->
<html>
<!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>Carambar</title>
	<meta http-equiv="X-UA-Compatible" content="IE=11; IE=10; IE=9; IE=8" />
	<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1, user-scalable=no" />
    <link href="css/jsPane.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/fonts.css" rel="stylesheet" type="text/css" />
    <link href="css/animation.css" rel="stylesheet" type="text/css" />
    <link href="css/needtocombine.css" rel="stylesheet" type="text/css" />
    <link href="css/video-js.css" rel="stylesheet" type="text/css" />
	<!--[if IE 8]>
	<link href="css/ie8.css" rel="stylesheet" type="text/css" />
	<!--<![endif]-->
	<!--[if lt IE 8]>
	<link href="css/oldie.css" rel="stylesheet" type="text/css" />
	<!--<![endif]-->
	<style>
		.vote-result {color:#fff;}
		.vote_box {cursor:pointer;float: left;width:100px;height:40px;line-height:40px;background: #fff;margin:10px;text-align: center;}
		#countdown {padding-top:50px;display: block;color:#fff;clear: both;font-size:40px;}
		#countdown div {float: left;margin:0 10px;}
		.facebook-wrap {display: ;clear: both;padding:50px 0 0;}
		.facebook-wrap .content-box {display: none;}
		.twitter-wrap {display: ;clear: both;padding:50px 0 0;}
		.twitter-wrap .content-box {display: none;}
	</style>
</head>
<body>

	<div class="votes">
		<div class="vote_box" data-a="vote" data-d="vid=1">Vote Video1</div>
		<div class="vote_box" data-a="vote" data-d="vid=2">Vote Video2</div>
		<div class="vote_box" data-a="vote" data-d="vid=3">Vote Video3</div>
	</div>

	<div id="countdown">
		<div id="countdown-days"></div>
		<div id="countdown-hours"></div>
		<div id="countdown-minutes"></div>
		<div id="countdown-seconds"></div>
	</div>

<!--	<div class="facebook-wrap">-->
<!--		<div class="login-btn"><a href="#">Login Facebook</a></div>-->
<!--		<div class="content-box">-->
<!--			<textarea id="facebook-content"></textarea>-->
<!--			<input type="submit" data-a="submit-facebook" />-->
<!--		</div>-->
<!--	</div>-->

	<div class="twitter-wrap">
		<div class="login-btn"><a href="#">Login twitter</a></div>
		<div class="content-box">
			<textarea id="twitter-content"></textarea>
			<input type="submit" data-a="submit-twitter" />
		</div>
	</div>

	<!-- vote-result-tpl -->
	<script type="text/tpl" id="vote-result-template">
		<div class="vote-result">
			{{#each data}}
				<div>{{votes}} votes</div>
			{{/each}}
		</div>
	</script>

	<script type="text/javascript" src="./js/plugin/modernizr-2.5.3.min.js"></script>
	<script type="text/javascript" src="./js/sea/sea-debug.js" data-config="../config.js"></script>
	<script type="text/javascript" src="./js/sea/plugin-shim.js"></script>
	<script type="text/javascript" src="./js/lp.core.js"></script>
	<script type="text/javascript" src="./js/lp.index.js"></script>

</body>
</html>