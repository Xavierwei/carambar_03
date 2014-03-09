<?php

class VoteAR extends CActiveRecord{

	public $vote_count;

	public function tableName() {
		return "vote";
	}

	public function primaryKey() {
		return "vote_id";
	}

	public static function model($class = __CLASS__) {
		return parent::model($class);
	}

	// Validation rules
	public function rules() {
		return array(
			array("vid, datetime", 'required'),
		);
	}


	public function getVoteList() {
		$query = new CDbCriteria();
		$query->select = "count(*) as vote_count, vid";
		$query->group = "vid";
		$res = $this->findAll($query);

		$list = array();
		foreach($res as $item) {
			$vote['vid'] = $item->vid;
			$vote['votes'] = $item->vote_count;
			$list[] = $vote;
		}

		return $list;
	}
}
