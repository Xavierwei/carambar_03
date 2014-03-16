
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
	<link href="css/index_style.css" rel="stylesheet" type="text/css" />
	<link href="css/animation.css" rel="stylesheet" type="text/css" />
	<style>
		.vote-result {color:#fff;}
		.vote_box {cursor:pointer;float: left;width:100px;height:40px;line-height:40px;background: #fff;margin:10px;text-align: center;}
		#countdown {padding-top:50px;display: block;color:#fff;clear: both;font-size:40px;}
		#countdown div {float: left;margin:0 10px;}
		.facebook-wrap {display: ;clear: both;padding:50px 0 0;}
		.facebook-wrap .content-box {display: none;}
		.twitter-wrap {display: ;clear: both;padding:50px 0 0;}
		.twitter-wrap .content-box {display: none;}
		.vote-result {clear:both;font-size:40px;clear:both;padding:50px 0 0;}
	</style>
</head>
<body>
	<div class="header">
		<div class="hdcontent">
			<a class="nav1 nav1on" href="#"></a>
			<a class="nav2" href="#"></a>
		</div>
	</div>

	<div class="page">
		<?php echo $content; ?>
	</div>

	<!-- footer -->
	<div class="footer">
		Mentions légales
	</div>

	<!--  -->
	<div class="fixed">
		<p class="fixed-1">lalalalal</p>
		<p class="fixed-2">lalalalallalalalal</p>
		<p class="fixed-3">lalalalallalalalal</p>
	</div>
	<!--  -->

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