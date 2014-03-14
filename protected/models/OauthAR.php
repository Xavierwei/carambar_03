<?php

class OauthAR extends CActiveRecord{

	public function tableName() {
		return "oauth";
	}

	public function primaryKey() {
		return "oid";
	}

	public static function model($class = __CLASS__) {
		return parent::model($class);
	}

	// Validation rules
	public function rules() {
		return array(
			array("media, username, token", 'required'),
			array("token_secret", 'safe'),
		);
	}
}
