<?php
class IndexController extends Controller {

	public $layout = 'index';
    public function filters(){
        return array(
            array(
                'COutputCache+index',
                'duration' => 1800,
                'cacheID' => 'FileCache',       //文件缓存形式
                'varyByParam'=>array('phase'), //根据phase 记录不同缓存页面
                'dependency' => array(              //判断数据库条件。时间不够也重建缓存
                    'class'=>'CDbCacheDependency',
                    'sql'=>'SELECT setting.setting_value FROM setting WHERE setting.setting_key = "phase"',
                ),
            ),
        );
    }

    public function actionIndex() {
		// get phase
		$phase = SettingAR::model()->getValue('phase');
		$phase = isset($phase) ? $phase : 1;

		// get top video
		$topVideo = VideoAR::model()->getVideoList(1,1,1,1,$phase);

		// get home video
		$homeVideos = VideoAR::model()->getVideoList(null,1,9,1,$phase);


		$this->render('index', array(
			'topVideo'		=> isset($topVideo[0]) ? $topVideo[0] : array(),
			'homeVideos'	=> $homeVideos,
			'phase'			=> $phase,
		));
	}


}