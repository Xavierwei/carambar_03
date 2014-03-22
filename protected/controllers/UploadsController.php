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
		$request_file_path = DOCUMENT_ROOT.$request_file_path;
		NodeAR::model()->makeImageThumbnail($source_path, $request_file_path, $width, $height, true);
	}
  }


	public function actionUpload() {
		$fileUpload = CUploadedFile::getInstanceByName("file");

		$request = Yii::app()->getRequest();
		$type = "photo";
		$nodeAr = new NodeAR();
		$validateUpload = $nodeAr->validateUpload($fileUpload, $type);
		if($validateUpload !== true) {
			if(!($validateUpload == 501)) {
				return $this->responseError($validateUpload);
			}
		}

		// save file to dir
		$file = $nodeAr->saveUploadedFile($fileUpload);
		if($file) {
			// return result
			$retdata = array( "type"=> $type , "file" => $file );
			$this->responseJSON($retdata, "success");
		}
		else {
			return $this->responseError(509); //photo media type is not allowed
		}
	}

  

}

