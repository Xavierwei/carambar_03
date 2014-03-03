<?php
if (preg_match('/(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|android|bb)/i', strtolower($_SERVER['HTTP_USER_AGENT']))) {
	header("Location: m",true,303);
	die();
}
?>
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
    <title>L'ESPRIT D'EQUIPE SOCIETE GENERALE</title>
	<meta http-equiv="X-UA-Compatible" content="IE=11; IE=10; IE=9; IE=8" />
	<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1, user-scalable=no" />
    <link href="css/jsPane.css?<?php echo time();?>" rel="stylesheet" type="text/css" />
    <link href="css/layout.css?<?php echo time();?>" rel="stylesheet" type="text/css" />
    <link href="css/fonts.css?<?php echo time();?>" rel="stylesheet" type="text/css" />
    <link href="css/animation.css?<?php echo time();?>" rel="stylesheet" type="text/css" />
    <link href="css/needtocombine.css?<?php echo time();?>" rel="stylesheet" type="text/css" />
    <link href="css/video-js.css?<?php echo time();?>" rel="stylesheet" type="text/css" />
	<!--[if IE 8]>
	<link href="css/ie8.css" rel="stylesheet" type="text/css" />
	<!--<![endif]-->
	<!--[if lt IE 8]>
	<link href="css/oldie.css" rel="stylesheet" type="text/css" />
	<!--<![endif]-->
</head>
<body>

<div class="preload">
    <div class="preload1">.</div>
    <div class="preload2">.</div>
    <div class="preload3">.</div>
</div>
<div class="page-loading">
	<div class="page-loading-logo">
		<img src="img/logo.gif" />
		<div class="old-ie">You are using an outdated browser. Please upgrade your browser to improve your experience.</div>
	</div>
</div>
<img id="imgLoad" />
<?php
	include('include/tpl.php');
?>

<script type="text/javascript" src="./js/plugin/modernizr-2.5.3.min.js"></script>
<script type="text/javascript" src="./js/sea/sea-debug.js" data-config="../config.js?_2014#"></script>
<script type="text/javascript" src="./js/sea/plugin-shim.js"></script>
<script type="text/javascript" src="./js/lp.core.js"></script>
<script type="text/javascript" src="./js/lp.base.js?<?php echo time();?>"></script>
<!--[if IE 8]>
<script type="text/javascript" src="./js/ie8.js"></script>
<!--<![endif]-->
</body>
</html>