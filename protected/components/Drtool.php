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
            Drtool::setMyCookie($name,time(),3);	//写入客户端cookie
            return false;
        }
        else
        {
            $timeVal=time()-$cookieTemp; //获取时间差
            $oneDay=60*60*24*3; //3天时间
            if($timeVal < $oneDay)
                return $oneDay-$timeVal;
            else
                return false;
        }
    }

}

