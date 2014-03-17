<?php

class LikeAR extends CActiveRecord {
  
	public $likecount = 0;


	public function tableName() {
		return "like";
	}

	public function primaryKey() {
		return "like_id";
	}

	public static function model($class = __CLASS__) {
		return parent::model($class);
	}

	public function rules() {
		return array(
		    array("nid", "NidExist"),
		    array("uid", "UidExist"),
		    array("datetime, like_id", "safe"),
		);
	}

	public function beforeSave() {
		if (!$this->getAttribute("datetime")) {
		  $this->setAttribute("datetime", time());
		}

		return true;
	}


	/**
	 * Get node like status
	 */
	public function getNodeCount($nid) {
		$query=new CDbCriteria;
		$query->condition='nid=:nid';
		$query->params=array(':nid'=>$nid);
		$res=$this->count($query);

		return $res;
	}

	/**
	 * Get like counts
	 */
	public function getUserNodeCount($nid,$uid) {
		$query=new CDbCriteria;
		$query->addCondition('nid=:nid');
		$query->params[':nid']=$nid;
		$query->addCondition('uid=:uid');
		$query->params[':uid']=$uid;
		$res=$this->count($query);

		return $res;
	}

	/**
	 * Delete like
	 */
	public function deleteLike($uid, $nid) {
		$query = new CDbCriteria();
		$query->addCondition("nid = :nid");
		$query->addCondition("uid = :uid");
		$query->params[":uid"] = $uid;
		$query->params[":nid"] = $nid;
		$this->deleteAll($query);
		$node = NodeAR::model()->findByPk($nid);
		$this->saveTopOfDay($node);
		$this->saveTopOfMonth($node);
		return;
	}

	/**
	 * Get total like count
	*/
	public function totalLikeByUser($uid) {
		$query = new CDbCriteria();
		$query->select = array("count(*) AS likecount");
		$query->addCondition("uid = :uid");
		$query->params[":uid"] = $uid;

		$res = $this->find($query);

		return $res["likecount"];
	}
}

