<?php

class TagAR extends CActiveRecord {
	public function tableName() {
		return "tag";
	}

	public function primaryKey() {
		return "tag_id";
	}

	public static function model($class = __CLASS__) {
		return parent::model($class);
	}

	public function rules() {
		return array(
			array("tag,count,tag_id", "safe")
		);
	}

	/**
	 * Get hash by keyword
	 * @param $term
	 * @return $tags
	 */
	public function searchTag($term) {
		$query=new CDbCriteria;
		$query->addSearchCondition('tag',$term);
		$query->limit = 5;
		$tags = $this->findAll($query);
		return $tags;
	}

	/**
	 * Get top three hashtags
	 * @return $tags
	 */
	public function topThree() {
		$query=new CDbCriteria;
		$query->limit = 3;
		$query->order = 'count DESC';
		$tags = $this->findAll($query);
		return $tags;
	}

	/**
	 * Save tag
	 * If the tag isn't in the database, create a new row, otherwise increase the count.
	 * @param $term
	 * @return CActiveRecord
	 */
	public function saveTag($term) {
		$query = new CDbCriteria;
		$query->addCondition('tag=:tag');
		$query->params[':tag']=$term;
		$res = $this->find($query);
		if($res) {
			$res->count = $res->attributes['count'] + 1;
			$res->date = time();
			$res->updateByPk($res->tag_id, $res->attributes);
		}
		else {
			$tag = new TagAR();
			$tag->attributes = array(
				"tag" => $term,
				"date" => time()
			);
			$tag->save();
		}

		return $res;
	}


	/**
	 * Minus tag count when remove the node
	 * @param $term
	 */
	public function minusTagCount($term) {
		$query=new CDbCriteria;
		$query->addCondition('tag=:tag');
		$query->params[':tag']=$term;
		$res=$this->find($query);
		if($res) {
			$res->count = $res->attributes['count'] - 1;
			$res->date = time();
			$res->updateByPk($res->tag_id, $res->attributes);
		}
	}
}

