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
		$homeVideosNum = 3;
		if($phase == 5) {
			$homeVideosNum = 5;
		}
		$homeVideos = VideoAR::model()->getVideoList(null,1,$homeVideosNum,1,$phase);

		$this->render('index', array(
			'topVideo'		=> $topVideo[0],
			'homeVideos'	=> $homeVideos,
			'phase'			=> $phase,
		));
	}


//    public  function actionTestac()
//    {
//
//        $_POST['senderName']="test";
//        $_POST['title']="title";
//        $_POST['content']="var SGWallAdminServices = angular.module('SGWallAdmin.services', [])
//    .value('ROOT', '/carambar_03')<br/>
//    .value('ROOT_FOLDER', '/carambar_03/')
//	.value('ASSET_FOLDER', '/carambar_03/admin_asset/');";
//        $_POST['sendMaliAddress']='244700553@qq.com';
//        $_POST['sendMaliAddress']=explode(',',$_POST['sendMaliAddress']);
//        print_r($_POST['sendMaliAddress']);
//
//           var_dump( Drtool::sendEmail($_POST['senderName'],$_POST['title'],$_POST['content'],$_POST['sendMaliAddress']));
//    }
}