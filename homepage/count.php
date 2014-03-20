<?php
	$url = "http://64.207.184.106/carambar/homepage/testcount.php";
	$ret = @file_get_contents($url);
	echo $ret;
?>