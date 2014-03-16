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

        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，只需要校验cookie
        {
            //判断是否有点赞资格
            $voteAuth= Drtool::isCookieAuth('praise_auth');//praise_auth cookie保存值
            if($voteAuth)
                StatusSend::_sendResponse(200,StatusSend::error('end', 1007,$voteAuth)); //已经点过赞，时间不足3天

            $item=$model->setValue('praise',++$item);  //设置 value，点赞次数+1

            if($item)
                StatusSend::_sendResponse(200, StatusSend::success('success',2003,$item)); //修改数据库成功
            else
                StatusSend::_sendResponse(200, StatusSend::error('end', 1008)); //修改数据库错误，
        }
        else //管理员不检验cookie
        {
            $item=$model->setValue('praise',++$item);  //设置 value，点赞次数+1
            if($item)
                StatusSend::_sendResponse(200, StatusSend::success('success',2003,$item)); //修改数据库成功
            else
                StatusSend::_sendResponse(200, StatusSend::error('end', 1008)); //修改数据库错误，
        }
	}

    /**
     * 获取点赞数据
     */
    public function actionPraiseResult()
    {
        $model=new SettingAR;
        $item=$model->getValue('praise');      //获取value
        if(!$item)
            StatusSend::_sendResponse(200,StatusSend::error('end', 1006)); //获取不到点赞数据
        else
            StatusSend::_sendResponse(200, StatusSend::success('success',2003,$item)); //修改数据库成功
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
            StatusSend::_sendResponse(200, StatusSend::success('success',2004,$item)); //answer校验正确

    }
}