<?php
	$url = "http://www.goodluckcarambar.com/setting/count";
	$ret = @file_get_contents($url);
	echo $ret;
?>