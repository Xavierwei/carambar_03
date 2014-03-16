<?php
class VideoController extends Controller {


    /**
     *  获取视频列表 position 控制类型
     */
    public function actionList()
    {
        if(!isset($_POST['position']))		//未传入类型，默认显示全部
            $_POST['position']=NULL;
        if(!isset($_POST['pageSize']))		//未传入每页条数，默认条数为8
            $_POST['pageSize']=8;
        if(!isset($_POST['pages']))			//未传入页数,使用默认页数为1
            $_POST['pages']=1;
        if(!isset($_POST['status']))			//未传入状态,使用默认状态为1
            $_POST['status']=1;

        $videoList=VideoAR::model()->getVideoList($_POST['position'],$_POST['status'], $_POST['pageSize'],$_POST['pages']);

        if(empty($videoList))
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1012)); //表中没有数据
        }
        else
        {
            StatusSend::_sendResponse(200, StatusSend::success('success',2005,$videoList)); //获取列表成功
        }
    }

    /**
     * 获取单条 video数据
     */
    public  function actionView()
    {

        if(!isset($_GET['vid']))
            StatusSend::_sendResponse(200, StatusSend::error('end', 1013)); //未传入vid参数

        $item=VideoAR::model()->findByPk($_GET['vid']); //获取单条数据
        if(is_null($item))
            StatusSend::_sendResponse(200, StatusSend::error('end', 1014)); //表中没有该数据
        else
            StatusSend::_sendResponse(200, StatusSend::success('success',2006,$item)); //获取该条数据成功
    }

    /**
     * 修改video数据
     */
    public function actionUpdate()
    {
        if(!isset($_POST['vid']))
            StatusSend::_sendResponse(200, StatusSend::error('end', 1013) ); //未传入vid参数

        $model=new VideoAR; //新建对象

        $item=$model->findByPk($_POST['vid']);      //获取该数据
        if(is_null($item))
            StatusSend::_sendResponse(200,StatusSend::error('end', 1014)); //该vid不存在

        if (!Yii::app()->user->checkAccess("isAdmin")) //非管理员，未授权
        {
            StatusSend::_sendResponse(200, StatusSend::error('end', 1015)); //没有权限进行此操作
         }
        else //管理员
        {
            $item->attributes=$_POST; //赋值
            if($item->save() )
                StatusSend::_sendResponse(200, StatusSend::success('success',2007,$item)); //修改数据库成功
            else
                StatusSend::_sendResponse(200, StatusSend::error('end', 1016)); //修改数据库错误，
        }

    }


    /***
	 * Save video
	 */
	public function actionPostVideo() {
		$url = 'https://www.youtube.com/watch?v=1GuF4yoCBr8';
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


}