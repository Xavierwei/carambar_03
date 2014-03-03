<?php

class UploadsController extends Controller {

  private $_photo_mime = array(
		"image/gif", "image/png", "image/jpeg", "image/jpg", "image/pjpeg", "image/x-png"
	);
  private $_video_mime = array(
		"video/mov","video/quicktime", "video/x-msvideo", "video/x-ms-wmv", "video/wmv", "video/mp4", "video/avi", "video/3gp", "video/3gpp", "video/mpeg", "video/mpg", "application/octet-stream", "video/x-ms-asf"
	);

  public function init() {
    Yii::import("application.vendor.*");
  }
  
  // 生成
  public function missingAction($actionID) {
    
    $files = explode("/", substr($_SERVER["REQUEST_URI"], 1));
    $filename = $files[count($files) - 1];
    // 先确定是视频的截图压缩图还是普通的图片
    //  如果是视频
    if ($filename[0]== "v") {
      $output;
      exec("which ffmpeg", $output);
      if (!empty($output)) {
        $ffmpeg = array_shift($output);
        if ($ffmpeg) {
          $matches = array();
          preg_match("/_([0-9]+_[0-9]+)/", $filename, $matches);
          if (!empty($matches)) {
            list($width, $height) = explode("_", $matches[1]);
            $source_filename = str_replace("_{$width}_{$height}", "", $filename);
            $basepath = implode("/",array_splice($files, 0, count($files) - 1));
            $source_path = DOCUMENT_ROOT.'/'.$basepath.'/'.$source_filename;//增加了DOCUMENT_ROOT，否则在子目录下路径不对了
//						echo $source_path;
//            if (!is_file($source_path)) {
//              return ;
//            }
            NodeAR::model()->makeVideoThumbnail($source_path, DOCUMENT_ROOT.'/'.$basepath .'/' .$filename, $width, $height, true);
          }
        }
      }
    }
    else {
      $matches = array();
      $request_file_path = $_SERVER["REQUEST_URI"];
      preg_match("/_([0-9]+_[0-9]+)/", $request_file_path, $matches);
      if (!empty($matches)) {
        list($width, $height) = explode("_", $matches[1]);
        $filename = str_replace("_{$width}_{$height}", "", $request_file_path);
        $source_path = DOCUMENT_ROOT.'/'.substr($filename, 1);
        if (!is_file($source_path)) {
          return;
        }
				$request_file_path = DOCUMENT_ROOT.$request_file_path; //增加了DOCUMENT_ROOT，否则在子目录下路径不对了
				NodeAR::model()->makeImageThumbnail($source_path, $request_file_path, $width, $height, true);
      }
    }

    die();
  }


	public function actionUpload() {
		$fileUpload = CUploadedFile::getInstanceByName("file");

		$request = Yii::app()->getRequest();
		$type = $request->getPost("type");
		$device = $request->getPost("device");
		if(!isset($type)) {
			$mime = $fileUpload->getType();
			if( in_array($mime, $this->_photo_mime ) ){
				$type = "photo";

			} else if ( in_array($mime, $this->_video_mime ) ){
				$type = "video";
			} else {
				return $this->responseError(502); //photo media type is not allowed
			}
		}
		$nodeAr = new NodeAR();
		$validateUpload = $nodeAr->validateUpload($fileUpload, $type);
		if($validateUpload !== true) {
			if(!($validateUpload == 501 && $device == 'android')) {
				return $this->responseError($validateUpload);
			}
		}

		// save file to dir
		$file = $nodeAr->saveUploadedFile($fileUpload, $device);
		if($file) {
			// make preview thumbnail
			if($type == 'video') {
				$paths = explode(".",$file);
				$basename = array_shift($paths);
				$nodeAr->makeVideoThumbnail(ROOT.$basename.'.jpg', ROOT.$basename.'.jpg', 175, 175, false);
			}

			// return result
			$retdata = array( "type"=> $type , "file" => $file );
			$this->responseJSON($retdata, "success");
		}
	}

  

}

