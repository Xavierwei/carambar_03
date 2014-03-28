<?php
class Drtool
{
    /**
     * 创建文件夹
     */
    public static function mkpath()
    {
        $dir = "./uploads";
        if (!is_dir($dir)) {
          mkdir($dir, 0777, TRUE);
        }
        $dir .= '/'.date("Y/n/j");
        if (!is_dir($dir)) {
          mkdir($dir, 0777, TRUE);
        }
    }
    
    /**
     * 随机函数
     */
    public static function randomNew()
    {
        return hash("sha1",time().md5(uniqid(rand(), TRUE)));
    }


    /**
     * 设置cookie
     */
    public static function setMyCookie($name,$val,$time=1)
    {
        if(empty($val))
            $val=Drtool::randomNew();

        //新建cookie
        $cookie = new CHttpCookie($name, $val);
        //定义cookie的有效期
        $cookie->expire =time()+60*60*24*$time; //有限期$time天
        //把cookie写入cookies使其生效
        Yii::app()->request->cookies[$name]=$cookie;
    }
    /**
     * 读取cookie
     */
    public static function getMyCookie($name)
    {
      $cookie =Yii::app()->request->getCookies();
      if(is_null($cookie[$name])) //先判断对象是否存在。
        return NULL;
      else
        return $cookie[$name]->value; //对象存在返回cookie数值
    }
    /**
     * 销毁cookie 
     */
    public static function cleanMyCookie($name)
    {
      $cookie =Yii::app()->request->getCookies();
      unset($cookie[$name]);
    }
    /**
     * 验证cookie时间
     * 投票验证
     */
    public static function isCookieAuth($name)
    {
        //Drtool::cleanMyCookie('vote_auth');
        $cookieTemp=Drtool::getMyCookie($name);			//获取本地保存的cookie

        if(is_null($cookieTemp))												//判断本地是否存在cookie
        {
            Drtool::setMyCookie($name,time(),1);
            return false;
        }
        else
        {
            $timeVal=time()-$cookieTemp; //获取时间差
            $oneDay=60*60*24*1; 
            if($timeVal < $oneDay)
                return $oneDay-$timeVal;
            else
                return false;
        }
    }

    /**
     * 发送邮件
     */
    public static function sendEmail($senderName,$title,$content,$sendMaliAddress)
    {
//         if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，未授权
//        {
//            StatusSend::_sendResponse(200, StatusSend::error('end', 1015)); //没有权限进行此操作
//        }
//        else //管理员
//        {
                $mail = Yii::createComponent('application.extensions.mailer.EMailer');
                $mail->IsSMTP();
                $mail->SMTPAuth         = false;                               // enable SMTP authentication
                //$mail->SMTPSecure       = "ssl";                                // sets the prefix to the servier
				$mail->Host                   = "10.200.98.1";               // sets GMAIL as the SMTP server
                $mail->Port                    = 25;                                     // set the SMTP port
                //$mail->Username           = Yii::app()->params['email']['username'];  // GMAIL username
                //$mail->Password           = Yii::app()->params['email']['password'];                         // GMAIL password
                $mail->From              = 'noreply@goodluckcarambar.com';                  //you email
                $mail->FromName     = 'Carambar';         //邮件发送人 your name
                $mail->IsHTML(true);                                  // set email format to HTML
                if(is_array($sendMaliAddress))
                {
                    foreach($sendMaliAddress as $k => $val)
                    {
                        $mail->AddAddress($val);           //收件人email recipient email
                    }
                }
                else
                {
                    $mail->AddAddress($sendMaliAddress);
                }
                $mail->Subject          =$title;                      //标题 title
                $mail->Body             = $content;                     //内容 content
                $mail->WordWrap     = 50;                                            // set word wrap

                if(!$mail->Send())
                    return false;//StatusSend::_sendResponse(200, StatusSend::error('end', 1024,$mail->ErrorInfo)); //邮件发送失败
                else
					return true;//StatusSend::_sendResponse(200, StatusSend::success('success',2008)); //邮件发送成功
//        }
    }

}

