<?php

class FlagAR extends CActiveRecord {
  
  	public $flagcount = 0;

	const COUNT_THAT_BLOckED = 3;

	public function tableName() {
		return "flag";
	}

	public function primaryKey() {
		return "flag_id";
	}

	public static function model($class = __CLASS__) {
		return parent::model($class);
	}

	public function rules() {
		return array(
			array("nid", "NidExist"),
			array("uid", "UidExist"),
			array("cid", "CidExist"),
			array("datetime, flag_id, comment_nid", "safe"),
		);
	}


	public function relations() {
		return array(
			"node" => array(self::BELONGS_TO, "NodeAR", "nid"),
			"comment" => array(self::BELONGS_TO, "CommentAR", "cid"),
		);
	}


	public function beforeSave() {
		if (!$this->getAttribute("datetime")) {
		  $this->setAttribute("datetime", time());
		}

		return TRUE;
	}


	/**
	 * Check the flag counts, if over the counts of the flag settings then block it.
	 */
	public function afterSave() {
		$nid = $this->nid;
		$cid = $this->cid;

		// Block the node if over the counts of the flag settings
		if ($nid) {
			$command = Yii::app()->db->createCommand("SELECT count(*) as count FROM flag where nid = :nid");
			$res = $command->query(array(":nid" => (int)$nid))->read();
			if ($res["count"] >= self::COUNT_THAT_BLOckED) {
				$node = NodeAR::model()->findByPk((int)$nid);
				$node->blockIt();
			}
		}

		// Block the comment if over the counts of the flag settings
		if ($cid) {
			$command = Yii::app()->db->createCommand("SELECT count(*) as count FROM flag where cid = :cid");
			$res = $command->query(array(":cid" => (int)$cid))->read();
			if ($res["count"] >= self::COUNT_THAT_BLOckED) {
				$comment = CommentAR::model()->findByPk((int)$cid);
				$comment->blockIt();
			}
		}
	}

	/**
	 * Delete node flags
	 * @param $nid
	 */
	public function deleteNodeFlag($nid) {
		$query = new CDbCriteria();
		$query->addCondition("nid = :nid");
		$query->params[":nid"] = (int)$nid;

		return $this->deleteAll($query);
	}

	/**
	 * Delete comment flags
	 * @param $cid
	 */
	public function deleteCommentFlag($cid) {
		$query = new CDbCriteria();
		$query->addCondition("cid = :cid");
		$query->params[":cid"] = (int)$cid;

		return $this->deleteAll($query);
	}

	/**
	 * Get the flag counts by node id
	 * @param $nid
	 */
	public function flagCountInNode($nid) {
		$query = new CDbCriteria();
		$query->select = "count(*) as flagcount";
		$query->addCondition("nid=:nid");
		$query->params[":nid"] = (int)$nid;
		$res = $this->find($query);

		return $res->flagcount;
	}

	/**
	 * Get the flag counts by comment id
	 * @param $cid
	 */
	public function flagCountInComment($cid) {
		$query = new CDbCriteria();
		$query->select = "count(*) as flagcount";
		$query->addCondition("cid=:cid");
		$query->params[":cid"] = (int)$cid;
		$res = $this->find($query);

		return $res->flagcount;
	}

	/**
	 * Get the flag count settings
	 * @param $cid
	 */
	public function getSetting() {
		$setting = Yii::app()->db->createCommand()
			->select('value')
			->from('settings')
			->where('`key`="flag"')
			->queryRow();
		return $setting['value'];
	}

	/**
	 * Set the flag count settings
	 * @param $cid
	 */
	public function setSetting($value) {
		$ret = Yii::app()->db->createCommand()
			->update('settings', array('value'=>$value));

		return $ret;
	}
}

