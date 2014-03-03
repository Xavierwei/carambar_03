<?php

class UserAR extends CActiveRecord{
	const USER_DELETED = -2;
	const USER_DISABLED = -1;
	const USER_ACTIVE = 1;
	const ROLE_ADMIN = 2;
	const ROLE_COUNTRY_MANAGER = 3;
	const ROLE_AUTHEN = 1;
	const ROLE_GUEST = 0;
  
	public function tableName() {
		return "user";
	}

  
	public static function getAllowOutputFields() {
		return array("uid", "firstname", "lastname", "avatar", "country" => array("country_id", "country_name", "flag_icon", "i18n"),
			"company_email", "personal_email", "role", "status");
	}


	public static  function getOutputRecordInArray($user) {
		$allow_fields = self::getAllowOutputFields();
		$ret_user = array();
		foreach ($allow_fields as $key => $field) {
			if (is_numeric($key)) {
				$ret_user[$field] = $user[$field];
			} else {
				if (is_array($field)) {
					$ret_user[$key] = array();
					foreach ($field as $sub_field) {
						if (isset($user[$key])) {
							$ret_user[$key][$sub_field] = $user[$key][$sub_field];
						}
					}
				}
			}
		}

		return $ret_user;
	}


	public function getPrimaryKey() {
		return "uid";
	}

  
	// Validation rules
	public function rules() {
		return array(
			array("avatar, personal_email, company_email, name, sso_id, country_id, datetime, firstname, lastname, role", 'safe'),
		);
	}


	public function relations() {
		return array(
			"country" => array(self::BELONGS_TO, "CountryAR", "country_id"),
		);
	}


	public static function model($classname = __CLASS__) {
		return parent::model($classname);
	}


	public function beforeSave() {
		return TRUE;
	}
  

	public function init() {
		parent::init();
	}


	public function dbRowUnique($attribute, $pramas = array()) {
		$value = $this->{$attribute};

		$model = self::model();
		$row = $model->findByAttributes(array("$attribute" => $value));

		if ($row) {
			$this->addError($attribute, Yii::t("strings", "$attribute duplicated"));
			return FALSE;
		}
		return  TRUE;
	}


	public function createSAMLRegisterTest($attributes) {
		$newUser = new UserAR();
		$newUser->datetime = time();
		$newUser->name = $attributes['uid'][0];
		$newUser->company_email = $attributes['eduPersonPrincipalName'][0];
		$newUser->sso_id = md5($attributes['eduPersonTargetedID'][0]);
		$newUser->firstname = $attributes['givenName'][0];
		$newUser->lastname = $attributes['sn'][0];
		$newUser->role = self::ROLE_AUTHEN;
		$newUser->country_id = 30;

		if ($newUser->validate()) {
			$newUser->save();
			return $newUser;
		}
		else {
			return FALSE;
		}
	}


	public function createSAMLRegister($attributes) {
		$newUser = new UserAR();
		$newUser->datetime = time();
		$newUser->name = $attributes['societegenerale.uid'][0];
		$newUser->company_email = $attributes['societegenerale.sggroupid'][0];
		$newUser->sso_id = md5($attributes['societegenerale.uid'][0]);
		$newUser->firstname = $attributes['societegenerale.givenName'][0];
		$newUser->lastname = $attributes['societegenerale.sn'][0];
		$newUser->role = self::ROLE_AUTHEN;
		$newUser->country_id = 30;

		if ($newUser->validate()) {
			$newUser->save();
			return $newUser;
		}
		else {
			return FALSE;
		}
	}


	public function getToken(){
		if(!isset(Yii::app()->session['token'])) {
			$token = md5(time().rand(0, 9999));
			Yii::app()->session['token'] = $token;
		}

		return Yii::app()->session['token'];
	}


	public function errorsString() {
		$errors = $this->getErrors();
		$str = "";
		foreach ($errors as $type => $error) {
		  foreach ($error as $msg) {
			$str = "\r\n$msg";
		  }
		}

		return $str;
	}
}
