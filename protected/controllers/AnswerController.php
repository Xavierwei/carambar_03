<?php

class AnswerController extends Controller
{
    public $defaultAction="answer";
	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionView($aid)
	{
        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，未授权
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1015)); //没有权限进行此操作
        }
        else //管理员
        {
            StatusSend::_sendResponse(200, StatusSend::success('success',2023,$this->loadModel($aid))); //获取answer成功
        }
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate()
	{
        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，未授权
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1015)); //没有权限进行此操作
        }
        else //管理员
        {
            $model=new AnswerAR;
            if(isset($_POST))
            {
                $model->attributes=$_POST;
                if($model->save())
                    StatusSend::_sendResponse(200, StatusSend::success('success',2024,$model)); //创建新题目成功
                else
                    StatusSend::_sendResponse(200, StatusSend::error('end', 1029)); //创建失败
            }
        }
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($aid)
	{
        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，未授权
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1015)); //没有权限进行此操作
        }
        else //管理员
        {
		    $model=$this->loadModel($aid);
            if(isset($_POST))
            {
                $model->attributes=$_POST;
                if($model->save())
                    StatusSend::_sendResponse(200, StatusSend::success('success',2024,$model)); //创建新题目成功
                else
                    StatusSend::_sendResponse(200, StatusSend::error('end', 1029)); //创建失败
            }
        }
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDelete($aid)
	{
        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，未授权
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1015)); //没有权限进行此操作
        }
        else //管理员
        {
		    if($this->loadModel($aid)->delete())
                StatusSend::_sendResponse(200, StatusSend::success('success',2024)); //创建新题目成功
            else
                StatusSend::_sendResponse(200, StatusSend::error('end', 1029)); //创建失败
        }
	}

	/**
	 * list
	 */
	public function actionList()
	{
        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，未授权
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1015)); //没有权限进行此操作
        }
        else //管理员
        {
            if(!isset($_GET['pageSize']))		//未传入每页条数，默认条数为8
                $_GET['pageSize']=8;
            if(!isset($_GET['pages']))			//未传入页数,使用默认页数为1
                $_GET['pages']=1;

            $answerList=AnswerAR::model()->getAnswerList( $_GET['pageSize'],$_GET['pages']);
            if(empty($answerList))
            {
                StatusSend::_sendResponse(200, StatusSend::error('end', 1012)); //表中没有数据
            }
            else
            {
                StatusSend::_sendResponse(200, StatusSend::success('success',2005,$answerList)); //获取列表成功
            }
        }
	}

    /**
     * 获取问答题题目，aid
     */
    public function actionGetOne()
    {
         $randOne=AnswerAR::model()->randOne();  //获取answer 问题
        if(!$randOne)
        {
            StatusSend::_sendResponse(200,StatusSend::error('end', 1010)); //获取不到answer数据
        }
        else
        {
            $temp['aid']=$randOne->aid;
            $temp['answer']=$randOne->answer;
            StatusSend::_sendResponse(200, StatusSend::success('success',2025,$temp)); //返回问题
        }
    }

    /**
     *  验证答案
     */
    public function actionAnswer()
    {
        if(!isset($_POST['answer']))
            StatusSend::_sendResponse(200, StatusSend::error('end', 1009) ); //未传入answer答案
        if(!isset($_POST['aid']))
            StatusSend::_sendResponse(200, StatusSend::error('end', 1030) ); //未传入answer aid


        //判断是否有回答问题资格
            $voteAuth= Drtool::isCookieAuth('answeer_auth');//praise_auth cookie保存值
            if($voteAuth)
                StatusSend::_sendResponse(200,StatusSend::error('end', 1007,$voteAuth)); //已经回答过问题，时间不足3天

        $model=$this->loadModel($_POST['aid']); //获取问题数据

        if($model->answer_value!=$_POST['answer'])
            StatusSend::_sendResponse(200,StatusSend::error('end', 1011)); //answer错误
        else
        {
            $model->answer_count+=1;
            if($model->save())
                StatusSend::_sendResponse(200, StatusSend::success('success',2004,$model)); //answer校验正确
        }
    }

    /**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return AnswerAR the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=AnswerAR::model()->findByPk($id);
		if($model===null)
            StatusSend::_sendResponse(200,StatusSend::error('end', 1010)); //获取不到answer数据
		return $model;
	}

}
