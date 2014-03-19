<?php

class SettingController extends Controller
{
    /**
     * 点赞功能
     * 管理员随便点，普通游客三天一次
     */
    public function actionPraise()
	{
        $model=new SettingAR;
        $item=$model->getValue('praise');      //获取value
        if(!$item)
            StatusSend::_sendResponse(200,StatusSend::error('end', 1006)); //获取不到点赞数据
        $item2=NodeAR::model()->countByStatus();


        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，只需要校验cookie
        {
            //判断是否有点赞资格
            $voteAuth= Drtool::isCookieAuth('praise_auth');//praise_auth cookie保存值
            if($voteAuth)
                StatusSend::_sendResponse(200,StatusSend::error('end', 1007,$voteAuth)); //已经点过赞，时间不足3天

            $item=$model->setValue('praise',++$item);  //设置 value，点赞次数+1

            if($item)
                StatusSend::_sendResponse(200, StatusSend::success('success',2003,$item+$item2)); //修改数据库成功
            else
                StatusSend::_sendResponse(200, StatusSend::error('end', 1008)); //修改数据库错误，
        }
        else //管理员不检验cookie
        {
            $item=$model->setValue('praise',++$item);  //设置 value，点赞次数+1
            if($item)
                StatusSend::_sendResponse(200, StatusSend::success('success',2003,$item+$item2)); //修改数据库成功
            else
                StatusSend::_sendResponse(200, StatusSend::error('end', 1008)); //修改数据库错误，
        }
	}

    /**
     * 获取点赞数据
     */
    public function actionCount()
    {
        $item2=NodeAR::model()->countByStatus();
        $model=new SettingAR;
        $item=$model->getValue('praise');      //获取value
        if(!$item)
            StatusSend::_sendResponse(200,StatusSend::error('end', 1006)); //获取不到点赞数据
        else
            StatusSend::_sendResponse(200, StatusSend::success('success',2003,$item+$item2)); //修改数据库成功
    }

    /**
     * 问答题
     */
    public function actionAnswer()
    {
        if(!isset($_POST['answer']))
            StatusSend::_sendResponse(200, StatusSend::error('end', 1009) ); //未传入answer答案

        $model=new SettingAR;
        $item=$model->getValue('answer');      //获取answer value
        if(!$item)
            StatusSend::_sendResponse(200,StatusSend::error('end', 1010)); //获取不到answer数据

        if($item!=$_POST['answer'])
            StatusSend::_sendResponse(200,StatusSend::error('end', 1011)); //answer错误
        else
        {
            $count=$model->getValue('answer_count');      //获取answer_count 答对人数
            $model->setValue('answer_count',++$count);  //设置 value，答对次数+1
            StatusSend::_sendResponse(200, StatusSend::success('success',2004,$count)); //answer校验正确
        }

    }


	/**
	 * countdown 倒计时
	 */
	public function actionCountdown(){
        $model=new SettingAR;
        $item=$model->getValue('countdown');      //获取countdown 倒计时时间
        if(!$item)
            StatusSend::_sendResponse(200,StatusSend::error('end', 1025)); //获取不到answer数据
        else
            StatusSend::_sendResponse(200, StatusSend::success('success',2009,$item - time())); //answer校验正确
	}



	/**
	 * 管理员获取setting
	 */
	public function actionGetSetting()
	{
		if (Yii::app()->user->checkAccess("isAdmin"))
		{
			$key = $_GET['key'];
			$model=new SettingAR;
			$item=$model->getValue($key);      //获取value
            if(!$item)
                StatusSend::_sendResponse(200,StatusSend::error('end', 1026)); //获取不到val数据
            else
                StatusSend::_sendResponse(200, StatusSend::success('success',2010,$item)); //获取val数据成功
		}
	}

	/**
	 * 管理员设置setting
	 */
	public function actionSetSetting()
	{
		if (Yii::app()->user->checkAccess("isAdmin"))
		{
			$key = $_POST['key'];
			$value = $_POST['value'];
			$model=new SettingAR;
			$item=$model->setValue($key, $value);
            if(!$item)
                StatusSend::_sendResponse(200,StatusSend::error('end', 1027)); //设置val数据失败
            else
                StatusSend::_sendResponse(200, StatusSend::success('success',2011,$item)); //设置val数据成功
		}
	}
}