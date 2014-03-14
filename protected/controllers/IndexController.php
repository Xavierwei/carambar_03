<?php
class IndexController extends Controller {
	public $layout = 'index';
	public function actionIndex() {
		// get phase
		//$phase = SettingAR::model()->getValue('phase');
		$phase = isset($_GET['phase']) ? $_GET['phase'] : 1;

		// get top video
		$topVideo = VideoAR::model()->getVideoList(1, 1);
		$topVideo = $topVideo[0]->mid;

		// get vote video
		$voteVideos = VideoAR::model()->getVideoList(3, 3);

		// get home video
		$homeVideos = VideoAR::model()->getVideoList(2, 6);

		// get vote results
		$_voteResults = VoteAR::model()->getVoteList();
		$voteResults = array();
		$voteTotal = 0;
		foreach($voteVideos as $video){
			if(isset($_voteResults[$video->vid])) {
				$voteResults[$video->vid] = $_voteResults[$video->vid]['votes'];
				$voteTotal += $_voteResults[$video->vid]['votes'];
			}
			else {
				$voteResults[$video->vid] = 0;
			}
		}

		$this->render('index', array(
			'topVideo'		=> $topVideo,
			'homeVideos'	=> $homeVideos,
			'voteVideos'	=> $voteVideos,
			'voteResults'	=> $voteResults,
			'voteTotal'		=> $voteTotal,
			'phase'			=> $phase,
		));
	}
}