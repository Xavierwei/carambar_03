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

	public function afterSave() {
		$nid = $this->getAttribute("nid");
		$node = NodeAR::model()->findByPk((int)$nid);
		$this->saveTopOfDay($node);
		$this->saveTopOfMonth($node);
	}


	/**
	 * Set content of day
	 */
	public function saveTopOfDay($node) {
		$str_datetime = $node->datetime;
		$datetime = date('Y-m-d',$str_datetime);
		$start_time = strtotime($datetime);
		$end_time = strtotime($datetime) + 1*24*60*60;
		$query = new CDbCriteria();
		$query->select = array("`node`.nid". ", count(like_id) AS likecount");
		$query->addCondition("`node`.datetime>:start");
		$query->addCondition("`node`.datetime<=:end");
		$query->join = 'left join `node` '.' on '. $this->getTableAlias() .".nid = `node`.nid";
		$query->params = array(
			":start" => $start_time,
			":end" => $end_time
		);
		$query->group = "`node`.nid";
		$res = $this->find($query);
		if(!$res) {
			return Yii::app()->db->createCommand()->delete('topday', 'date=:date', array(':date'=>$start_time));
		}
		else {
			$updateRes = Yii::app()->db->createCommand()->update('topday', array(
				'nid'=>$res->nid,
			), 'date=:date', array(':date'=>$start_time));
		}

		if(!$updateRes) {
			$count = Yii::app()->db->createCommand()->select('count(*) as count')
				->from('topday')
				->where('date=:date', array('date'=>$start_time))
				->queryRow();
			if(!$count['count'])
			{
				Yii::app()->db->createCommand()->insert('topday', array(
					'nid'=>$res->nid,
					'date'=>$start_time
				));
			}
		}
	}


	/**
	 * Set content of month
	 */
	public function saveTopOfMonth($node) {
		$str_datetime = $node->datetime;
		$datetime = date('Y-m-1',$str_datetime);
		$start_time = strtotime($datetime);
		$end_time = strtotime(date("Y-m-1", $start_time) . " +1 month");
		$query = new CDbCriteria();
		$query->select = array("`node`.nid". ", count(like_id) AS likecount");
		$query->addCondition("`node`.datetime>:start");
		$query->addCondition("`node`.datetime<=:end");
		$query->join = 'left join `node` '.' on '. $this->getTableAlias() .".nid = `node`.nid";
		$query->params = array(
			":start" => $start_time,
			":end" => $end_time
		);
		$query->group = "`node`.nid";
		$res = $this->find($query);
		if(!$res) {
			return Yii::app()->db->createCommand()->delete('topmonth', 'date=:date', array(':date'=>$start_time));
		}
		$updateRes = Yii::app()->db->createCommand()->update('topmonth', array(
			'nid'=>$res->nid,
		), 'date=:date', array(':date'=>$start_time));

		if(!$updateRes) {
			$count = Yii::app()->db->createCommand()->select('count(*) as count')
				->from('topmonth')
				->where('date=:date', array('date'=>$start_time))
				->queryRow();
			if(!$count['count'])
			{
				Yii::app()->db->createCommand()->insert('topmonth', array(
					'nid'=>$res->nid,
					'date'=>$start_time
				));
			}
		}
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

