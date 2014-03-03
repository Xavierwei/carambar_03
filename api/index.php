<?php

// change the following paths if necessary
$yii=dirname(__FILE__).'/../yii/framework/yii.php';
$config=dirname(__FILE__).'/protected/config/main.php';
// remove the following lines when in production mode
defined('YII_DEBUG') or define('YII_DEBUG',true);
// specify how many levels of call stack should be shown in each log message
defined('YII_TRACE_LEVEL') or define('YII_TRACE_LEVEL',3);

define("ROOT", dirname(__FILE__));
define("DOCUMENT_ROOT", $_SERVER['DOCUMENT_ROOT']);
$simplesamlphp = ROOT."/simplesamlphp";
include_once( $simplesamlphp.'/lib/_autoload.php' );

// require instagram sdk
$instagram_sdk = dirname(__FILE__)."/instagram_sdk";
include_once( $instagram_sdk.'/config.php' );
include_once( $instagram_sdk.'/instagram.class.php' );

// require twitter sdk
$twitter_sdk = dirname(__FILE__)."/twitter_sdk";
include_once( $twitter_sdk.'/config.php' );
include_once( $twitter_sdk.'/twitteroauth.php' );

require_once($yii);
Yii::createWebApplication($config)->run();
