<?php
class VideoController extends Controller {



	/***
	 * Vote video
	 */
	public function actionVote() {
		$request = Yii::app()->getRequest();

		if (!$request->isPostRequest) {
			$this->responseError(101);
		}

		$vid = $request->getPost("vid");
		if(!$vid) {
			$this->responseError(101);
		}

		$cookie_voted = (string)Yii::app()->request->cookies['voted'];
		if(!$cookie_voted) {
			$vote = new VoteAR();
			$vote->vid = $vid;
			$vote->datetime = time();
			if($vote->validate()) {
				$vote->save();

				$cookie = new CHttpCookie('voted', md5(rand(0,999).time()));
				$cookie->expire = time() + (60*60*24); // 24 hours
				Yii::app()->request->cookies['voted'] = $cookie;

				$list = VoteAR::model()->getVoteList();

				return $this->responseJSON($list, "success");
			}
		}
		else {
			return $this->responseError(902);
		}
	}


	/**
	 * Get vote list
	 */
	public function actionVoteList() {
		$list = VoteAR::model()->getVoteList();
		return $this->responseJSON($list, "success");
	}


	/**
	 * countdown
	 */
	public function actionCountdown(){
		$timespan = strtotime('2014-3-9') - time();

		return $this->responseJSON($timespan, "success");
	}
}