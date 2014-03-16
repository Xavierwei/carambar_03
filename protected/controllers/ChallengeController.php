<?php

class ChallengeController extends Controller
{
    /*
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
        if(!isset($_POST['cid']))
            StatusSend::_sendResponse(200, StatusSend::error('end', 1002) ); //未传入cid参数

        $model=new ChallengeAR; //新建对象

        $item=$model->findByPk($_POST['cid']);      //获取该数据
        if(is_null($item))
            StatusSend::_sendResponse(200,StatusSend::error('end', 1003)); //该cid不存在

        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，只需要校验cookie和投票cid是否存在
        {
            //判断是否有投票资格
            $voteAuth= $model->isCookieCreate();
            if($voteAuth)
                StatusSend::_sendResponse(200,StatusSend::error('end', 1004,$voteAuth)); //已经投过票，时间不足一天

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

	// Uncomment the following methods and override them if needed
	/*
	public function filters()
	{
		// return the filter configuration for this controller, e.g.:
		return array(
			'inlineFilterName',
			array(
				'class'=>'path.to.FilterClass',
				'propertyName'=>'propertyValue',
			),
		);
	}

	public function actions()
	{
		// return external action classes, e.g.:
		return array(
			'action1'=>'path.to.ActionClass',
			'action2'=>array(
				'class'=>'path.to.AnotherActionClass',
				'propertyName'=>'propertyValue',
			),
		);
	}
	*/
}