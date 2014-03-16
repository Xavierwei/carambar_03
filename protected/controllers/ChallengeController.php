<?php

class ChallengeController extends Controller
{
    /**
     * 返回投票对象信息
     */
	public function actionList()
	{
		$ChallengeList=ChallengeAR::model()->getChallengeList();
        if(empty($ChallengeList))
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1001)); //表中没有数据
        }
        else
        {
            StatusSend::_sendResponse(200, StatusSend::success('success',2001,$ChallengeList)); //获取列表成功
        }
	}

    /**
     * 投票信息修改
     */
    public function actionUpdate()
    {
        //$_POST['cid']=2;
        if(!isset($_POST['cid']))
            StatusSend::_sendResponse(200, StatusSend::error('end', 1002) ); //未传入cid参数

        $model=new ChallengeAR; //新建对象

        $item=$model->findByPk($_POST['cid']);      //获取该数据
        if(is_null($item))
            StatusSend::_sendResponse(200,StatusSend::error('end', 1003)); //该cid不存在

        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，只需要校验cookie和投票cid是否存在
        {
            //判断是否有投票资格
            $voteAuth= Drtool::isCookieAuth('vote_auth');//vote_auth cookie保存值
            if($voteAuth)
                StatusSend::_sendResponse(200,StatusSend::error('end', 1004,$voteAuth)); //已经投过票，时间不足3天

            $item->vote_counts= $item->vote_counts+1; //投票次数+1

            if($item->save())
            {
                Drtool::setMyCookie("cid",$_POST['cid'],3);//3天
                $mtemp['vote_counts']=$item->vote_counts;
                $mtemp['cid']=$item->cid;
                StatusSend::_sendResponse(200, StatusSend::success('success',2002,$mtemp)); //修改数据库成功
            }
            else
                StatusSend::_sendResponse(200, StatusSend::error('end', 1005)); //修改数据库错误，
        }
        else //管理员只做简单校验
        {
            $item->attributes=$_POST; //赋值
            if($item->save())
                StatusSend::_sendResponse(200, StatusSend::success('success',2002,$item)); //修改数据库成功
            else
                StatusSend::_sendResponse(200, StatusSend::error('end', 1005)); //修改数据库错误，
        }
    }

}