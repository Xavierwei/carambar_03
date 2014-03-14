<?php

class VideoAR extends CActiveRecord{


	public function tableName() {
		return "video";
	}

	public function primaryKey() {
		return "vid";
	}

	public static function model($class = __CLASS__) {
		return parent::model($class);
	}

	// Validation rules
	public function rules() {
		return array(
			array("url, title, thumbnail, datetime, status", 'required'),
		);
	}

	/**
	 * Check mid is already post
	 * @param $attribute
	 * @param array $params
	 * @return bool
	 */
	public function uniqueMid($attribute, $params = array()) {
		$count = self::model()->findByAttributes(array("mid" => $attribute));
		if ($count) {
			return false;
		}
		else {
			return true;
		}
	}

	public function afterSave() {
		$name = 'video'.$this->vid;
		$ext = pathinfo($this->thumbnail, PATHINFO_EXTENSION);
		$newname = $name.'.'.$ext;
		$paths = explode("/", $this->thumbnail);
		$paths[count($paths) - 1] = $newname;
		$newpath = implode("/", $paths);
		if (file_exists(ROOT.$this->thumbnail) && $ext) {
			rename(ROOT.$this->thumbnail, ROOT. $newpath);
			$this->updateByPk($this->vid, array("thumbnail" => $newpath));
			$this->thumbnail = $newpath;
		}
		return TRUE;
	}


	/**
	 * Get youtube id from url
	 */
	public function getYoutubeId($url) {
		$params = NodeAR::model()->getUrlParams($url);
		if (isset($params) && isset($params['v'])) {
			return $params['v'];
		}
		else {
			$shoturl =  explode("/",$url);
			if(isset($shoturl[3])) {
				$id = explode('?', $shoturl[3]);
				return $id[0];
			}
		}

		return false;
	}


	public function getVideoList($position, $pagenum = 8) {
		$query = new CDbCriteria();
		$query->addCondition('status=:status');
		$query->params[':status'] = 1;
		if($position == 2) {
			$query->addInCondition('position', array(2, 3));
		}
		else {
			$query->addCondition('position=:position');
			$query->params[':position'] = $position;
		}
		$query->limit = $pagenum;
		$res = $this->findAll($query);

		return $res;
	}


}
