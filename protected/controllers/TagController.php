<?php

class TagController extends Controller {

	public function actionIndex() {
		$this->responseError("not support yet");
	}

	/**
	 * Get tag list
	 */
	public function actionList() {
		$request = Yii::app()->getRequest();
		$term = $request->getParam("term");
		$retdata = TagAR::model()->searchTag($term);
		$this->responseJSON($retdata, "success");
	}

	/**
	 * Add new tag
	 */
	public function actionAdd() {
		$request = Yii::app()->getRequest();
		$term = $request->getParam("term");
		$retdata = TagAR::model()->saveTag($term);
		$this->responseJSON($retdata, "success");
	}

	/**
	 * Get top three
	 */
	public function actionTopThree() {
		$retdata = TagAR::model()->topThree();
		$this->responseJSON($retdata, "success");
	}
}

