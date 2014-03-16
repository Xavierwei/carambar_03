<?php

class FlagController extends Controller {

	public function actionIndex() {}

	/**
	 * Post flag
	 */
	public function actionPost() {
		$request = Yii::app()->getRequest();

		if (!Yii::app()->user->checkAccess("flagNode")) {
		  return $this->responseError(602);
		}

		if (!$request->isPostRequest) {
		  $this->responseError(101);
		}

		$nid = $request->getPost("nid");
		$cid = $request->getPost("cid");
			$comment_nid = $request->getPost("comment_nid");

		// Check flag node or comment
		if (!$nid && !$cid) {
		  $this->responseError(101);
		}

		if ($nid && !is_numeric($nid)) {
		  $this->responseError(101);
		}
		if ($cid && !is_numeric($cid)) {
		  $this->responseError(101);
		}
			if ($comment_nid && !is_numeric($comment_nid)) {
				$this->responseError(101);
			}

		$uid = Yii::app()->user->getId();

		$flagAr = new FlagAR();
		$flagAr->uid = $uid;
		if ($nid) {
		  $flagAr->nid = $nid;
		}
		if ($cid) {
		  $flagAr->cid = $cid;
		}
		if ($comment_nid) {
			$flagAr->comment_nid = $comment_nid;
		}

		// Check if already flagged
		if ($flagAr->nid) {
		  $flagold = FlagAR::model()->findByAttributes(array("uid" => $flagAr->uid, "nid" => $flagAr->nid));
		}
		else {
		  $flagold = FlagAR::model()->findByAttributes(array("uid" => $flagAr->uid, "cid" => $flagAr->cid));
		}

		if ($flagold) {
		  $this->responseError('flagged');
		}


		if ($flagAr->validate()) {
		  $flagAr->save();

		  $this->responseJSON($flagAr->attributes, "success");
		}
		else {
		  $this->responseError(current(array_shift($flagAr->getErrors())));
		}
	}


	/**
	 * Get flag setting
	 */
	public function actionGetSetting() {
		$setting = FlagAR::model()->getSetting();
		echo $setting;
	}

	/**
	 * Set flag setting
	 */
	public function actionSetSetting() {
		$request = Yii::app()->getRequest();

		if (!$request->isPostRequest) {
			$this->responseError(101);
		}

		$value = $request->getPost("value");
		if (!$value || !is_numeric($value)) {
			$this->responseError(101);
		}


		if (!Yii::app()->user->checkAccess("isAdmin")) {
			return $this->responseError(601);
		}

		$ret = FlagAR::model()->setSetting($value);

		return $this->responseJSON($ret, "success");

	}
}

