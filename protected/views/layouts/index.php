<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title>Carambar</title>
	<link href="./css/style.css" rel="stylesheet" type="text/css" />
	<style>
		#stats {z-index: 99999;position: fixed;}
	</style>
</head>
<body>
<?php echo $content;?>

<script type="text/javascript" src="./js/plugin/modernizr-2.5.3.min.js"></script>
<script type="text/javascript" src="./js/sea/sea-debug.js" data-config="../config.js"></script>
<script type="text/javascript" src="./js/sea/plugin-shim.js"></script>
<script type="text/javascript" src="./js/lp.core.js"></script>
<script type="text/javascript" src="./js/lp.index.js"></script>
<script type="text/javascript" src="./js/plugin/state.js"></script>
<script type="text/javascript">
	var stats = new Stats();
	stats.setMode(0); // 0: fps, 1: ms

	// Align top-left
	stats.domElement.style.position = 'fixed';
	stats.domElement.style.left = '0px';
	stats.domElement.style.top = '0px';

	document.body.appendChild( stats.domElement );

	setInterval( function () {

		stats.begin();

		// your code goes here

		stats.end();

	}, 1000 / 60 );
</script>
</body>
</html>