<?php
class IndexController extends Controller {
	public $layout = 'index';
	public function actionIndex() {
		// get phase
		//$phase = SettingAR::model()->getValue('phase');
		$phase = isset($_GET['phase']) ? $_GET['phase'] : 1;

		// get top video
		$topVideo = VideoAR::model()->getVideoList(1,1,1,1);

		// get home video
		$homeVideosNum = 3;
		if($phase == 5) {
			$homeVideosNum = 5;
		}
		$homeVideos = VideoAR::model()->getVideoList(null,1,$homeVideosNum,1);



		$this->render('index', array(
			'topVideo'		=> $topVideo[0],
			'homeVideos'	=> $homeVideos,
			'phase'			=> $phase,
		));
	}
}