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




	/**
	 * countdown
	 */
	public function actionCountdown(){
		$timespan = strtotime('2014-3-25') - time();

		return $this->responseJSON($timespan, "success");
	}
}