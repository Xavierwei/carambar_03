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
}