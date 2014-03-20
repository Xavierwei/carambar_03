<?php

class AdminController extends Controller {

	public function actionIndex(){
		$this->layout = 'admin';
		$uid = Yii::app()->user->getId();

		if($uid) {
			if (!Yii::app()->user->checkAccess("isAdmin")) {
				$this->render('login');
			}
			else {
				$token = UserAR::model()->getToken();
				$this->render('index', array('token'=>$token));
			}
		}
		else {
			$this->render('login');
		}
	}

    public function  actionSendMail()
    {

        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，未授权
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1015)); //没有权限进行此操作
        }
        else //管理员
        {
            if(!isset($_POST['senderName']))
                StatusSend::_sendResponse(200, StatusSend::error('end', 1020)); //未传入邮件发送人的姓名
            if(!isset($_POST['title']))
                StatusSend::_sendResponse(200, StatusSend::error('end', 1021)); //未传入邮件标题
            if(!isset($_POST['content']))
                StatusSend::_sendResponse(200, StatusSend::error('end', 1022)); //未传入邮件内容
            if(!isset($_POST['sendMaliAddress']))
                StatusSend::_sendResponse(200, StatusSend::error('end', 1023)); //未传入邮件收件人的邮箱

            //转换数组
            $_POST['sendMaliAddress']=explode(',',$_POST['sendMaliAddress']);

            Drtool::sendEmail($_POST['senderName'],$_POST['title'],$_POST['content'],$_POST['sendMaliAddress']);
        }
    }


    /**
     * 清理FileCache
     */
    public function actionCleanFileCache()
    {
        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，未授权
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1015)); //没有权限进行此操作
        }
        else //管理员
        {
           if(Yii::app()->FileCache->flush()) //清理缓存
               StatusSend::_sendResponse(200, StatusSend::success('success',2022)); //修改数据库成功
           else
               StatusSend::_sendResponse(200, StatusSend::error('end', 1028)); //缓存清除失败
        }
    }
}