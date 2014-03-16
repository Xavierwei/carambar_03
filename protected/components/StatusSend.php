<?php
class StatusSend {

	//返回响应的方法
	public static function _sendResponse($status = 200, $body = '', $content_type = 'text/html')
	{

	  $status_header = 'HTTP/1.1 ' . $status . ' ' . self::_getStatusCodeMessage($status);
	  header($status_header);
	  header('Content-type: ' . $content_type);
	  echo CJSON::encode($body);
	  Yii::app()->end();
	}

	//返回错误的方法
	public static  function error($msg, $code,$arr=NULL)
	{
      return array(
          "data" => $arr,
          "error" => array(
              "code" => $code,
              "message" => $msg,
          ),
      );
  	}

  	//返回正确的方法
  	public static  function success($msg, $code,$arr=NULL)
	{
      return array(
          "data" => $arr,
          "success" => array(
              "code" => $code,
              "message" => $msg,
          ),
      );
  	}

	//获取 http 状态码的方法
	public static function _getStatusCodeMessage($status)
	{
	  $codes = Array(
	    200 => 'OK',
	    400 => 'Bad Request',
	    401 => 'Unauthorized',
	    402 => 'Payment Required',
	    403 => 'Forbidden',
	    404 => 'Not Found',
	    500 => 'Internal Server Error',
	    501 => 'Not Implemented',
	  );
	  return (isset($codes[$status])) ? $codes[$status] : '';
	}
}
