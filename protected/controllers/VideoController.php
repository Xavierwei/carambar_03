<?php
class VideoController extends Controller {

	/***
	 * Save video
	 */
	public function actionPostVideo() {
		$url = 'http://www.youtube.com/watch?v=zv3AoFFDWGs';
		$mid = VideoAR::model()->getYoutubeId($url);
		if(!$mid) {
			return $this->responseError(101);
		}

		if(!VideoAR::model()->uniqueMid($mid)) {
			return $this->responseError(702);
		}

		$thumbnail = NodeAR::model()->getVideoThumbnail($url, 'youtube');
		if($thumbnail) {
			$imagePath = NodeAR::model()->saveRemoteImage($thumbnail);
			$video = new VideoAR();
			$video->mid = $mid;
			$video->url = $url;
			$video->thumbnail = $imagePath;
			$video->datetime = time();
			$video->status = 0;
			if($video->validate()) {
				$video->save();
				return $this->responseJSON($video, "success");
			}
		}
	}


	/**
	 * Get video list
	 */
	public function actionVideoList() {
		$request = Yii::app()->getRequest();
		$position = (int)$request->getParam('position');
		if(!$position) {
			return $this->responseError(101);
		}

		$result = VideoAR::model()->getVideoList($position);

		return $this->responseJSON($result, "success");
	}


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
		$timespan = strtotime('2014-3-25') - time();

		return $this->responseJSON($timespan, "success");
	}
}