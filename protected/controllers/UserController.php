<?php

class UserController extends Controller {

	public function actionIndex() {
		//return $this->responseError(101);
	}

	/**
	 * Login
	 */
	public function actionLogin() {
		// Identity local site user data
		$request = Yii::app()->getRequest();
		$username = $request->getPost('username');
		$password = $request->getPost('password');
		$userIdentify = new UserIdentity($username, md5($password));
		// Save user status in session
		if (!$userIdentify->authenticate()) {
		}
		else {
			Yii::app()->user->login($userIdentify);
			$this->redirect('../admin/index');
		}
	}

	/**
	 * Logout
	 */
	public function actionLogout() {
		$uid = Yii::app()->user->getId();
		$user = UserAR::model()->findByPk($uid);
		if ($user) {
			// Clean session
			Yii::app()->user->logout();
			$this->redirect('../index');
		}
		else {
			$this->redirect('../index');
		}
	}

}
